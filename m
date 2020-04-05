Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D8C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2835C206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="A7u+wZ4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDEKNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:13:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61055 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgDEKNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:13:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48w8dp3QWyz9txJW;
        Sun,  5 Apr 2020 12:13:50 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=A7u+wZ4v; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dMABDtHwrNiZ; Sun,  5 Apr 2020 12:13:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48w8dp26Cfz9txJV;
        Sun,  5 Apr 2020 12:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586081630; bh=U/MW7ws8EhYmPKvRgeUjzUL9RHH90FUjn6jmBMga+ic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A7u+wZ4veJE+AdBa08nnR4R/k6UEP099TNMMRFz+5wFoPC7AkPwCho4iqGEeJYkFK
         JYPC7Veq2mDbUFdgbABi9BQr7r2Ypy5wr68RDrvZejdfpZIFW1k2F5Nh9szmWkzr8b
         sg+uRYLWJupcKh61f2FjQ54XGumD1aHKWUO7USwU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 53C028B774;
        Sun,  5 Apr 2020 12:13:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RzGBOCQrIJq2; Sun,  5 Apr 2020 12:13:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FB798B764;
        Sun,  5 Apr 2020 12:13:52 +0200 (CEST)
Subject: Re: [PATCH] powerpc/powernv: add NULL check after kzalloc in
 opal_add_one_export
To:     Qiujun Huang <hqjagain@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.a, tglx@linutronix.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200405075123.28756-1-hqjagain@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <99de2220-5a64-e81e-6886-447296431548@c-s.fr>
Date:   Sun, 5 Apr 2020 12:13:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405075123.28756-1-hqjagain@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/04/2020 à 09:51, Qiujun Huang a écrit :
> Here needs a NULL check.
> 
> Issue found by coccinelle.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>   arch/powerpc/platforms/powernv/opal.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2b3dfd0b6cdd..09443ae3a86e 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -811,6 +811,11 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
>   		goto out;
>   
>   	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr) {
> +		rc = -ENOMEM;
> +		goto out;

You don't need to go to out:, there is nothing to do. You should do:

	if (!attr)
		return -ENOMEM;

> +	}
> +
>   	name = kstrdup(export_name, GFP_KERNEL);
>   	if (!name) {
>   		rc = -ENOMEM;
> 

Christophe
