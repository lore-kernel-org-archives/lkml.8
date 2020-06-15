Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B66FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BAF206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgFOIGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:06:31 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:06:30 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:2191:9276:807:82c1])
        by laurent.telenet-ops.be with bizsmtp
        id rL6V2200E4zira501L6VoG; Mon, 15 Jun 2020 10:06:29 +0200
Received: from geert (helo=localhost)
        by ramsan with local-esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jkk8T-0002jL-4B; Mon, 15 Jun 2020 10:06:29 +0200
Date:   Mon, 15 Jun 2020 10:06:29 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: treewide: replace '---help---' in Kconfig files with 'help'
In-Reply-To: <git-mailbomb-linux-master-a7f7f6248d9740d710fd6bd190293fe5e16410ac@kernel.org>
Message-ID: <alpine.DEB.2.21.2006151004180.10003@ramsan.of.borg>
References: <git-mailbomb-linux-master-a7f7f6248d9740d710fd6bd190293fe5e16410ac@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Yamada-san,

On Sat, 13 Jun 2020, Linux Kernel Mailing List wrote:
> Commit:     a7f7f6248d9740d710fd6bd190293fe5e16410ac
> Parent:     e4a42c82e943b97ce124539fcd7a47445b43fa0d
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/a7f7f6248d9740d710fd6bd190293fe5e16410ac
> Author:     Masahiro Yamada <masahiroy@kernel.org>
> AuthorDate: Sun Jun 14 01:50:22 2020 +0900
> Committer:  Masahiro Yamada <masahiroy@kernel.org>
> CommitDate: Sun Jun 14 01:57:21 2020 +0900
>
>    treewide: replace '---help---' in Kconfig files with 'help'
>
>    Since commit 84af7a6194e4 ("checkpatch: kconfig: prefer 'help' over
>    '---help---'"), the number of '---help---' has been gradually
>    decreasing, but there are still more than 2400 instances.
>
>    This commit finishes the conversion. While I touched the lines,
>    I also fixed the indentation.
>
>    There are a variety of indentation styles found.
>
>      a) 4 spaces + '---help---'
>      b) 7 spaces + '---help---'
>      c) 8 spaces + '---help---'
>      d) 1 space + 1 tab + '---help---'
>      e) 1 tab + '---help---'    (correct indentation)
>      f) 1 tab + 1 space + '---help---'
>      g) 1 tab + 2 spaces + '---help---'
>
>    In order to convert all of them to 1 tab + 'help', I ran the
>    following commend:
>
>      $ find . -name 'Kconfig*' | xargs sed -i 's/^[[:space:]]*---help---/\thelp/'
>
>    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 88b05b5256a9..1fa2fe2ef053 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -266,7 +266,7 @@ config PERMIT_BSP_REMOVE
> 	bool "Support removal of Bootstrap Processor"
> 	depends on HOTPLUG_CPU
> 	default n
> -	---help---
> +	help
> 	Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
> 	support.
>
> @@ -274,7 +274,7 @@ config FORCE_CPEI_RETARGET
> 	bool "Force assumption that CPEI can be re-targeted"
> 	depends on PERMIT_BSP_REMOVE
> 	default n
> -	---help---
> +	help
> 	Say Y if you need to force the assumption that CPEI can be re-targeted to
> 	any cpu in the system. This hint is available via ACPI 3.0 specifications.
> 	Tiger4 systems are capable of re-directing CPEI to any CPU other than BSP.

I guess help text blocks like the above should be indented?
Unfortunately there are many of them.

Thanks!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
