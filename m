Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBDE2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596118359;
	bh=hwxLMbLU9oOOzBEmH/uvXVBKXbhllKWHIHTEJrSSZ+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XVH399IiOinfkYyYbrr9KcIXEY9HYT2m2tY61VkmdxVs8zZ3KuYuJbDjh/jXYyChC
	 /WIKyrDOE0ubOZRTD1oDBqalT1SoznHIBEnJiFsVvMU1yo99pm+haVrbORz60JoiJi
	 LvhnMDovaCjyZc0MFPryZCl/TkYTOixx3Dd/sbLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgG3OMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgG3OMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:12:37 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42952070B;
        Thu, 30 Jul 2020 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596118356;
        bh=hwxLMbLU9oOOzBEmH/uvXVBKXbhllKWHIHTEJrSSZ+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2HfeLes47KOa567jky5Q5EYyaoJLaozSP+3MGPBMhD6gqFkVV+wP3fvWRGha0Q/G
         tEreBgXZ1u4/cAHoue1xneAIxkcG7LrKlX+68Xs3fYKo1ZuxPZ7Z1EdXM0v6KLKAHd
         CeConsS6JrTtG7Qd6LpdTPrKA4bgURUZ26/xrt/Q=
Date:   Thu, 30 Jul 2020 16:12:32 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] modules: inherit TAINT_PROPRIETARY_MODULE
Message-ID: <20200730141232.GA31539@linux-8ccs>
References: <20200730061027.29472-1-hch@lst.de>
 <20200730061027.29472-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200730061027.29472-9-hch@lst.de>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Christoph Hellwig [30/07/20 08:10 +0200]:
>If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the taint flag
>for all modules importing these symbols, and don't allow loading
>symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
>imported gplonly symbols.  Add a anti-circumvention devices so people
>don't accidentally get themselves into trouble this way.
>
>Comment from Greg:
> Ah, the proven-to-be-illegal "GPL Condom" defense :)
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
> include/linux/module.h |  1 +
> kernel/module.c        | 12 ++++++++++++
> 2 files changed, 13 insertions(+)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 30b0f5fcdb3c37..e30ed5fa33a738 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -389,6 +389,7 @@ struct module {
> 	unsigned int num_gpl_syms;
> 	const struct kernel_symbol *gpl_syms;
> 	const s32 *gpl_crcs;
>+	bool using_gplonly_symbols;
>
> #ifdef CONFIG_UNUSED_SYMBOLS
> 	/* unused exported symbols. */
>diff --git a/kernel/module.c b/kernel/module.c
>index afb2bfdd5134b3..04f993863ae417 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1456,6 +1456,18 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
> 	if (!sym)
> 		goto unlock;
>
>+	if (license == GPL_ONLY)
>+		mod->using_gplonly_symbols = true;
>+
>+	if (owner && test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints)) {
>+		if (mod->using_gplonly_symbols) {
>+			sym = NULL;
>+			goto getname;
>+		}
>+		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
>+				 LOCKDEP_NOW_UNRELIABLE);
>+	}

Sorry that I didn't think of this yesterday, but I'm wondering if we
should print a warning before add_taint_module(). Maybe something
along the lines of, "%s: module uses symbols from proprietary module
%s, inheriting taint.", with %s being mod->name, owner->name. We can
check mod->taints for TAINT_PROPRIETARY_MODULE and print the warning once.

Additionally, maybe it's a good idea to print an error before goto
getname (e.g., "%s: module using GPL-only symbols uses symbols from
proprietary module %s."), so one would know why the module load
failed, right now this manifests itself as an unknown symbol error.

Otherwise, this patchset looks good to me and I agree with it in
principle. Thanks Christoph!
