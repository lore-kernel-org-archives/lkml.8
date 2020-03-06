Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC36C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98735206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db+3zOrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCFUMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:12:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFUMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:12:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id z12so3505759qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t1P5CaXZGX44NIbc1H3JiUzBX3moK1or8CNxCi90IHI=;
        b=Db+3zOrjuPO7CroPt6HVL5cSDRHqw0QGz+ldfzSLt0pzejtVVgWOqkJFrKZpPqT2zh
         Vg7O75XAQG8PQ+60HdAxlrFZuXSpgxUdr5sgLA7MLclrs1WnXYHhSGWRtOLYYF7V3+qC
         t2R4CkPWRSFL9F9qEQnLXSPra383ImTZWknblASUmowiEQRB2hfY4m9n6pfsAP9A4ncv
         xmx2DBCVTXo9pX2kJIAayTVFXqvoaczg6oIGDuoqKf9hCIFf7gD2fPSsSwPCSz2FbyeM
         DgLMq1mVAwX+qytDDtFSgkw+Ewdhu7sPcGrbqkPqITlOXhPtkSygeFGGsfPldrba2zri
         f3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t1P5CaXZGX44NIbc1H3JiUzBX3moK1or8CNxCi90IHI=;
        b=iJf9ntAyhXFn1k6Z1HVOJETfNML7NYy1raVl2EyeBA+86IN30FX3tTie258NaiNtGw
         gso5JfFKo/1hVhgK+i9cNqIRTijlIUGLZq4+yTcrcturiT2EzUOPdB7CfP+5Ug8YEQeI
         pFR0HAmhhb1MvbIJGHAp55nU7UJtR7q+a1ll+zeBDEG8OdGAnoHcofH8h3a23D9SZRAf
         lzywOKNnNAcfGAvzkX6i7mClMAtURtG59jc4UHWBqHfp87CjSrJPEK81wo943SfONnrs
         zTNLPZOto7arHxxP2TdnmYwz9NbmgxdoSK7YDCCcRLUanFNGj3BjOAPuKQwoeyK/+BBP
         lHJQ==
X-Gm-Message-State: ANhLgQ0He1VWWdHw4ZEvKi+Mmd3aH+14ESR0Ms5sNbTSySe+c9TWEp1O
        s9ZTk3pyz161cxQhN7UgPfc=
X-Google-Smtp-Source: ADFU+vuGWuCJRquwwbfKkV7CBp0yIcZIEcbwTT4P9ck4PlZOp1y0CWo9ZDZMLKTDdt5dI51HU5STvg==
X-Received: by 2002:a37:9f92:: with SMTP id i140mr4699140qke.353.1583525526247;
        Fri, 06 Mar 2020 12:12:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n46sm2653336qtb.48.2020.03.06.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:12:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4388E403AD; Fri,  6 Mar 2020 17:12:03 -0300 (-03)
Date:   Fri, 6 Mar 2020 17:12:03 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [BUGFIX PATCH v2] tools: Let O= makes handle a relative path
 with -C option
Message-ID: <20200306201203.GB13774@kernel.org>
References: <158351957799.3363.15269768530697526765.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158351957799.3363.15269768530697526765.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 07, 2020 at 03:32:58AM +0900, Masami Hiramatsu escreveu:
> When I compiled tools/perf from top directory with the -C option,
> the O= option didn't work correctly if I passed a relative path.
> 
>   $ make O=BUILD -C tools/perf/
>   make: Entering directory '/home/mhiramat/ksrc/linux/tools/perf'
>     BUILD:   Doing 'make -j8' parallel build
>   ../scripts/Makefile.include:4: *** O=/home/mhiramat/ksrc/linux/tools/perf/BUILD does not exist.  Stop.
>   make: *** [Makefile:70: all] Error 2
>   make: Leaving directory '/home/mhiramat/ksrc/linux/tools/perf'
> 
> The O= directory existence check failed because the check
> script ran in the build target directory instead of the
> directory where I ran the make command.
> 
> To fix that, once change directory to $(PWD) and check O=
> directory, since the PWD is set to where the make command
> runs.

Tested with O=/non/relative/paths, as I always use, not to polute the
checked out kerneo sources, and with a relative path, as fixed in this
patch, now both works, thanks, will be in my next perf/urgent pull req
to Ingo.

- Arnaldo
 
> Fixes: c883122acc0d ("perf tools: Let O= makes handle relative paths")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> 
> ---
>  Changes in V2:
>  - Fix tools/perf/Makefile because it has own O= pre-process.
>  - Use tools/perf for example.
>  - Add explicit Cc: stable@vger.kernel.org tag.
> ---
>  tools/perf/Makefile            |    2 +-
>  tools/scripts/Makefile.include |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index 7902a5681fc8..b8fc7d972be9 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -35,7 +35,7 @@ endif
>  # Only pass canonical directory names as the output directory:
>  #
>  ifneq ($(O),)
> -  FULL_O := $(shell readlink -f $(O) || echo $(O))
> +  FULL_O := $(shell cd $(PWD); readlink -f $(O) || echo $(O))
>  endif
>  
>  #
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index ded7a950dc40..6d2f3a1b2249 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  ifneq ($(O),)
>  ifeq ($(origin O), command line)
> -	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> -	ABSOLUTE_O := $(shell cd $(O) ; pwd)
> +	dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> +	ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
>  	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
>  	COMMAND_O := O=$(ABSOLUTE_O)
>  ifeq ($(objtree),)
> 

-- 

- Arnaldo
