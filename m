Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95860C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489B6206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598970070;
	bh=Syza0QjBGgPIriGEU3VpgNuhG+Ks2HlPQEx4xe3m7YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g3fwnFC4WVvS+CVqNo/vSI4Lt6LgH8pThYo+Pim0IqzODDIVwDkbun0mJ1JdKKhce
	 pugXPu/dqcxiw4GznixYFwFyWyeQWIUzxgiaCcDk+4zAk5wgfYHP5UWm7nvVdBKjgY
	 Z7qqRav061YDRCUn4JtK27LXfx0VyIdEXek0EvJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgIAOVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgIAOP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:15:27 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CBA20684;
        Tue,  1 Sep 2020 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598969142;
        bh=Syza0QjBGgPIriGEU3VpgNuhG+Ks2HlPQEx4xe3m7YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqyaZLt3GJqPFvUNSm3kEgCo12hW6iavpob7NR8+jZb3Wq1SDgtWFiDwv9Rf1YpeV
         +RAJSblpYg/45miZEvgGoNNCgH7oWC/pd5gs8+d3eAnFcmKUIGL2O/zOkpaOEBnY4e
         GSwLj8n4dsjiBgqIHu8FJYT94bKA7W8WzjVLfSG4=
Date:   Tue, 1 Sep 2020 16:05:38 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-kernel@vger.kernel.org, jeyu@suse.de
Subject: Re: [PATCH] module: Add more error message for failed kernel module
 loading
Message-ID: <20200901140538.GA9643@linux-8ccs>
References: <20200831083705.20807-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200831083705.20807-1-wqu@suse.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Qu Wenruo [31/08/20 16:37 +0800]:
>When kernel module loading failed, user space only get one of the
>following error messages:
>- -ENOEXEC
>  This is the most confusing one. From corrupted ELF header to bad
>  WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
>  all returns this error number.
>
>- -EPERM
>  This is for blacklisted modules. But mod doesn't do extra explain
>  on this error either.
>
>- -ENOMEM
>  The only error which needs no explain.
>
>This means, if a user got "Exec format error" from modprobe, it provides
>no meaningful way for the user to debug, and will take extra time
>communicating to get extra info.
>
>So this patch will add extra error messages for -ENOEXEC and -EPERM
>errors, allowing user to do better debugging and reporting.
>
>Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for your patch, agreed that there should be more descriptive
error messages to help debug module loading issues.

>---
> kernel/module.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 8fa2600bde6a..204bf29437b8 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2068,8 +2068,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> 	int i;
>
> 	for (i = 0; i < hdr->e_shnum; i++) {
>-		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
>+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
>+			pr_err(
>+			"Module %s section %d has invalid WRITE|EXEC flags\n",
>+				mod->name, i);

I think it's OK to put pr_err and the format string on the same line.
IMO the line break doesn't add much readability value in this case.

Also, we have access to secstrings in this function. We can print out
the section name with secstrings + sechdrs[i].sh_name in addition to
the section number, I think that would be helpful.

And can we reformat the message to start with the module name, similar
to other pr_err() sites? i.e.,

pr_err("%s: section %s (index %d) has invalid WRITE|EXEC flags",
		mod->name, secstrings + sechdrs[i].sh_name, i)

The rest looks fine to me. Thanks!

Jessica

