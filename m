Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ACBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAA92076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kgyHKYH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgFWQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:12:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47920 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728916AbgFWQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:12:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592928732; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=tpu3koTLioptT4rbuRuixAw5FvFwl/Ar2ZGPQtaJuds=; b=kgyHKYH+dbE973OMmJOgxjlEYM46qO8kiD+2UznxXkvdjFYV32X+6NkvL96ktlltwhx8a/tm
 pnFSVUByeSzRjDxabF1SaNGXQP/bJnW38nHwRElx1JsDG2K4RUxrbTlK2sN/a3B5ycoQQz9K
 Z9kmeR+QRn9MWqiEy31eTu4bgD4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ef229bb3a8a8b20b8e2f66e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 16:11:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B052C43391; Tue, 23 Jun 2020 16:11:39 +0000 (UTC)
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DBDEC433C6;
        Tue, 23 Jun 2020 16:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DBDEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Christian Brauner'" <christian.brauner@ubuntu.com>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        <linux-hexagon@vger.kernel.org>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com> <20200622234326.906346-12-christian.brauner@ubuntu.com>
In-Reply-To: <20200622234326.906346-12-christian.brauner@ubuntu.com>
Subject: RE: [PATCH 11/17] hexagon: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 11:11:37 -0500
Message-ID: <14e701d64978$f9a2af60$ece80e20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHblW6eodCfbmmuDWKuTMw/1BiW7AJ/OGz0qMfM2cA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  arch/hexagon/Kconfig          | 1 +
>  arch/hexagon/kernel/process.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig index
> 667cfc511cf9..19bc2f2ee331 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -31,6 +31,7 @@ config HEXAGON
>  	select GENERIC_CLOCKEVENTS_BROADCAST
>  	select MODULES_USE_ELF_RELA
>  	select GENERIC_CPU_DEVICES
> +	select HAVE_COPY_THREAD_TLS
>  	help
>  	  Qualcomm Hexagon is a processor architecture designed for high
>  	  performance and low power across a wide variety of applications.
> diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
> index ac07f5f4b76b..d756f9556dd7 100644
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -50,8 +50,8 @@ void arch_cpu_idle(void)
>  /*
>   * Copy architecture-specific thread state
>   */
> -int copy_thread(unsigned long clone_flags, unsigned long usp,
> -		unsigned long arg, struct task_struct *p)
> +int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> +		    unsigned long arg, struct task_struct *p, unsigned long
tls)
>  {
>  	struct thread_info *ti = task_thread_info(p);
>  	struct hexagon_switch_stack *ss;
> @@ -100,7 +100,7 @@ int copy_thread(unsigned long clone_flags, unsigned
> long usp,
>  	 * ugp is used to provide TLS support.
>  	 */
>  	if (clone_flags & CLONE_SETTLS)
> -		childregs->ugp = childregs->r04;
> +		childregs->ugp = tls;
> 
>  	/*
>  	 * Parent sees new pid -- not necessary, not even possible at
> --
> 2.27.0

Acked-by: Brian Cain <bcain@codeaurora.org>


