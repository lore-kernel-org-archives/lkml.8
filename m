Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA85C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B193206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="m9mQvPo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDEMMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 08:12:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6601 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgDEMMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 08:12:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wCGx6Qbbz9vDCS;
        Sun,  5 Apr 2020 14:12:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=m9mQvPo4; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BU4CdYy38176; Sun,  5 Apr 2020 14:12:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wCGx4WMXz9vDCR;
        Sun,  5 Apr 2020 14:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586088761; bh=dks+FmlcH1P0YzNPFG6XPDO+hAdcRqA2bwD1oWlUYLk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m9mQvPo4A9GDs7TwKbqCH2m5UFG2NLc/d7/M4So9D/O8vSy0xbYaXSfXXnOdjXq0E
         /C4P8egghAKNalNY8rHYJzt6PxtT2MsVaI1I/Y913IwMMqzQAg9ADOWz49E/tEulm4
         BtByQADIpjrQie/1nkjs+GuEQAkxtmzh6+1zUpIE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C82EB8B774;
        Sun,  5 Apr 2020 14:12:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NHXes6cY9x8N; Sun,  5 Apr 2020 14:12:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE0298B764;
        Sun,  5 Apr 2020 14:12:43 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/powernv: add NULL check after kzalloc in
 opal_add_one_export
To:     Qiujun Huang <hqjagain@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, tglx@linutronix.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200405103059.30769-1-hqjagain@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <46e9dd45-c590-36c3-a60e-55750cde8935@c-s.fr>
Date:   Sun, 5 Apr 2020 14:12:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405103059.30769-1-hqjagain@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/04/2020 à 12:30, Qiujun Huang a écrit :
> Here needs a NULL check.
> 
> Issue found by coccinelle.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>   arch/powerpc/platforms/powernv/opal.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2b3dfd0b6cdd..5b98c98817aa 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -808,9 +808,12 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
>   
>   	rc = of_property_read_u64_array(np, prop_name, &vals[0], 2);
>   	if (rc)
> -		goto out;
> +		return rc;

Nice you changed that too.

Then there is no need the initialise attr and name to NULL in their 
declaration, as they won't be used before they are assigned.

>   
>   	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
>   	name = kstrdup(export_name, GFP_KERNEL);
>   	if (!name) {
>   		rc = -ENOMEM;
> 

Christophe
