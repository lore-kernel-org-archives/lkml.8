Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E1FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A14E206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593509881;
	bh=r6ySbBBH6JX5F+m+piVB8CEQhJDEWaoNh+6yuwgGlZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RGpr3dyBwiz3HagZhRABy9LLITlYXxTUgAXAqPEGItWwfd6diA79HTRmOb/AorpIr
	 O4AJo2qHA+DNPQKCP6OL+hHgWW4PfcYDsKvPh6uAePfygTEgTO5A7b808WMaq55ibA
	 8VPlzJlNWlzpELFPA4fWUjoELSdyCNqX06RmK/TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbgF3JiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgF3Jh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:37:59 -0400
Received: from linux-8ccs.fritz.box (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804C0206A1;
        Tue, 30 Jun 2020 09:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593509878;
        bh=r6ySbBBH6JX5F+m+piVB8CEQhJDEWaoNh+6yuwgGlZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yq82SEN3Xsghbqdpt/wIolcC1yVYA3uH7fTDChhOidiV1Y9x5Q0e2gcokD8iFSH7G
         KfCS64//Bvb+Kx/nxNdkVz6eul6j7vZjp7qdEKhg4SzWy6hfGQcSnjNUPherjkE0eZ
         r8DjkxawL3HCfWoWaVIqOdZDbaYUAolP73pAdIX4=
Date:   Tue, 30 Jun 2020 11:37:54 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     tobyboy0@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module:  add name size info to pr_debug() calls
Message-ID: <20200630093754.GA13271@linux-8ccs.fritz.box>
References: <20200611142009.1098058-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200611142009.1098058-1-jim.cromie@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jim Cromie [11/06/20 08:20 -0600]:
>when booted with arg: module.dyndbg=+p
>dmesg gets volumes of info about loaded modules.
>This adds module & symbol names, and sizes where pertinent.
>Now I can know which module's info Im looking at.

Hi,

Could you please fix the changelog formatting according to
Documentation/process/submitting-patches.rst? More specifically,
complete sentences, line wrapped at 75 columns, and a Signed-off-by:
line at the end. There are plenty of examples if you look through the
lkml mailing list.

>---
> kernel/module.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index e8a198588f26..d871d9cee9eb 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2294,8 +2294,8 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>
> 		case SHN_ABS:
> 			/* Don't need to do anything */
>-			pr_debug("Absolute symbol: 0x%08lx\n",
>-			       (long)sym[i].st_value);
>+			pr_debug("Absolute symbol: 0x%08lx %s\n",
>+				 (long)sym[i].st_value, name);

I would prefer "Absolute symbol %s:" rather than putting the symbol
name at the end.

> 			break;
>
> 		case SHN_LIVEPATCH:
>@@ -2409,7 +2409,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
> 	for (i = 0; i < info->hdr->e_shnum; i++)
> 		info->sechdrs[i].sh_entsize = ~0UL;
>
>-	pr_debug("Core section allocation order:\n");
>+	pr_debug("Core section allocation order for: %s\n", mod->name);

I would slightly prefer "Core section allocation order for %s:", but
it's a matter of taste.

> 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
> 		for (i = 0; i < info->hdr->e_shnum; ++i) {
> 			Elf_Shdr *s = &info->sechdrs[i];
>@@ -2442,7 +2442,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
> 		}
> 	}
>
>-	pr_debug("Init section allocation order:\n");
>+	pr_debug("Init section allocation order for: %s\n", mod->name);

Same here.

> 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
> 		for (i = 0; i < info->hdr->e_shnum; ++i) {
> 			Elf_Shdr *s = &info->sechdrs[i];
>@@ -3276,7 +3276,7 @@ static int move_module(struct module *mod, struct load_info *info)
> 		mod->init_layout.base = NULL;
>
> 	/* Transfer each section which specifies SHF_ALLOC */
>-	pr_debug("final section addresses:\n");
>+	pr_debug("final section addresses for: %s\n", mod->name);

Let's capitalize the "f" in "final section addresses" to be consistent
with the other two above.

> 	for (i = 0; i < info->hdr->e_shnum; i++) {
> 		void *dest;
> 		Elf_Shdr *shdr = &info->sechdrs[i];
>@@ -3294,8 +3294,8 @@ static int move_module(struct module *mod, struct load_info *info)
> 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> 		/* Update sh_addr to point to copy in image. */
> 		shdr->sh_addr = (unsigned long)dest;
>-		pr_debug("\t0x%lx %s\n",
>-			 (long)shdr->sh_addr, info->secstrings + shdr->sh_name);
>+		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
>+			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);

Any reason why you added sh_size here? Is it really needed? You can
usually deduce how much space a section is taking up in a module by
looking at the final section address printout. Plus the elf section
size is not entirely accurate here as each module section is aligned
to page boundaries when the module loader allocates memory for each
section. I would prefer to just leave it out.

Thanks,

Jessica
