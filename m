Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19574C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1ED8206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="puflVITD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgBMRI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:08:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbgBMRI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:08:26 -0500
Received: from zn.tnic (p200300EC2F07F6001C43AF432C3E1E0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:1c43:af43:2c3e:1e0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C04111EC0C81;
        Thu, 13 Feb 2020 18:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581613704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1BPgN+sk6s2ZQJhFXskXNttt4micajntadGLkl07ql8=;
        b=puflVITDX1NPI0l8A7Gzqbwn9biihszCUAO8vDYVDWmpZz21D/tpWU3UP23n2gokNn/oaH
        bIWOCXxhvNhoeqXYk924KRq64yobZm3PiF4bIKGfj2NNoRJCNlr4XAXIauaHYTWQOYU3VE
        kzUCSST2RxS7B3AlkpHLePf9eE+Lq68=
Date:   Thu, 13 Feb 2020 18:08:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/mce: Change default mce logger to check
 mce->handled
Message-ID: <20200213170820.GN31799@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212204652.1489-6-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:46:52PM -0800, Tony Luck wrote:
> Instead of keeping count of how many handlers are registered on the
> mce chain and printing if we are below some magic value. Look at the
> mce->handled to see if anyone claims to have handled/logged this error.
> 
> [debug to always print in this version]
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index ce7a78872f8f..5b73df383300 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -156,29 +156,17 @@ void mce_log(struct mce *m)
>  }
>  EXPORT_SYMBOL_GPL(mce_log);
>  
> -/*
> - * We run the default notifier if we have only the UC, the first and the
> - * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
> - * notifiers registered on the chain.
> - */
> -#define NUM_DEFAULT_NOTIFIERS	3
> -static atomic_t num_notifiers;
> -

I definitely like where this is going.

Another thing: what do we do if we have to deviate from that sequantial
path through the notifiers? What if notifier A gets to look at an error,
then another notifier B needs to look at it and then the information
obtained from the second notifier B, is needed by the first notifier A
again to inspect the error a *second* time.

I don't think there's a case like that now but I'm just playing the
devil's advocate here. Because a use case like that would break our
simplistic, sequential assembly line of MCE decoding.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
