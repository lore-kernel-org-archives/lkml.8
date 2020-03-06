Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892B208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgCFHww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:52:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39286 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:52:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id r16so1670058oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1T5Kg4BfST0zSVIMUeTS56E1O4MCeoBW6kALqxA1HK8=;
        b=tvmakSgvxiMbrkn6QlnJqxIx5nG6DTOJsviAJrfB0w/YYeRzwoBl6xfWGB6JJb8OF2
         /wNHxn9KHthOJ2BXXg/BTiOzdH+QvV2HYKdZPLUpihj/uKZ3KfizVzbtInVHaKik92IQ
         GZ7WHxwaoibf4ET3gHosGKcacNryD9syDFzuek0eJPOlASSyJsuR+S1XFyVqhGn+yz/o
         eRh085kf4dZfBt7d7WMxHmguXvTLn8Szjv2MWTDn45FzsEDVVqsAFPpaOhZmnR5X96qR
         a0b8U6xVoq9KNDSXWRfIKU2paW5MLRTzJQahW3KuQ63budgRF51O5ATqVocz1rRtNaiB
         XE8g==
X-Gm-Message-State: ANhLgQ3ZrEJL3KkZntefsb5HZTKYkeog4myhCqPsF6WLtQRR4brCc73T
        qN1pcmPJG6ub+fPlXiMObwU8wEQk1lnNh/kwJSQ=
X-Google-Smtp-Source: ADFU+vu659YQtLePZ07p37HFyrM/DDcWDOkphwBjlnwGymbix5RIPqdXWxxmtWWFPO72Eq4yJb7aF/R5hKHncFkBwpA=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr1640463oia.148.1583481171255;
 Thu, 05 Mar 2020 23:52:51 -0800 (PST)
MIME-Version: 1.0
References: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org> <158338818292.25448.7161196505598269976.stgit@devnote2>
In-Reply-To: <158338818292.25448.7161196505598269976.stgit@devnote2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Mar 2020 08:52:40 +0100
Message-ID: <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with -C option
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC +kbuild, -stable

On Thu, Mar 5, 2020 at 7:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> When I compiled tools/bootconfig from top directory with
> -C option, the O= option didn't work correctly if I passed
> a relative path.
>
>   $ make O=./builddir/ -C tools/bootconfig/
>   make: Entering directory '/home/mhiramat/ksrc/linux/tools/bootconfig'
>   ../scripts/Makefile.include:4: *** O=./builddir/ does not exist.  Stop.
>   make: Leaving directory '/home/mhiramat/ksrc/linux/tools/bootconfig'
>
> The O= directory existence check failed because the check
> script ran in the build target directory instead of the
> directory where I ran the make command.
>
> To fix that, once change directory to $(PWD) and check O=
> directory, since the PWD is set to where the make command
> runs.
>
> Fixes: c883122acc0d ("perf tools: Let O= makes handle relative paths")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/scripts/Makefile.include |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index ded7a950dc40..6d2f3a1b2249 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  ifneq ($(O),)
>  ifeq ($(origin O), command line)
> -       dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> -       ABSOLUTE_O := $(shell cd $(O) ; pwd)
> +       dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> +       ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
>         OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
>         COMMAND_O := O=$(ABSOLUTE_O)
>  ifeq ($(objtree),)
>
