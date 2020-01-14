Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E60C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20392072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJXpGk41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgANPZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:25:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42792 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:25:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so12420791qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBjoCRu7uUKmejf+dsP2DbLyq5JyEG027qfZAREh+Us=;
        b=lJXpGk41ZlnjCb4zxNNA7CgoGkaGC3CBrvByBLMO9CSf3cAZTMc30kYcwhHNz/2Jef
         8vNe4naR3E/LqK7h1x+jTMom5yNOhsCWVSIUnXAmgFHOA2bICRDDSvVBKEfHYG8XQqRo
         lizBi3zGScuy14Tq8YNlvSccJLXBr7WJKDKsnmcoerCzGqEK24LCYAr7xtqhFugV89AI
         qUp9SJhdmJqEGYeX3HksYW56HlR+rZVsjmrUIqFqy2E188/iWfCKKQzo5OTeypZyobpT
         i+PHKneJvb2lahIY/lcTYqC3gMdOaiIYUwkAIVfI06xDbxfqIC2sKUry9UByV1I68u/Q
         aMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBjoCRu7uUKmejf+dsP2DbLyq5JyEG027qfZAREh+Us=;
        b=IbD+k2mimkNwDq0hfWNQzWwThKI/6Od0RJWJNv9Z8wIF9R+6g+CK9/BWZnAEJbHxyx
         g/8Svxsj8BYi6nwAIcCBL4UD+S17ncAbVj0+JrqO5NW9zvDySAAPsUBHrNZ7m69hW/8+
         FDxJoQ9bDRBRty0NfndEDOti88ofSxIY2bmqnjWFs7sN3ulg/Ktp6ufMdlPJwGmjzUVr
         Qb8Nr+gB1aj4RRiElSmSy5JdrH2ABwU8LRrKQFGgXRvZxw5RdAUd45wwf5yaRrZ+TluP
         zk0YKBv251OOSiDyml++ogSaG9B9PwacFy44Jydz5tAz0d0EhPVNuUp+FpofDi+guLz7
         k80w==
X-Gm-Message-State: APjAAAXKZzP2OU9rsgS5Aa+1DQy4sqesCOagFdAmJy8lOWV7h8R1jkLw
        Bv94wYoB3ePUDyhtvhFcTGQ=
X-Google-Smtp-Source: APXvYqzBTFGD4KI/R02Pcehtl+2Y4eDRGIIkSA6RcxlyOhjMT0ZmWXKO8aVUzy8tw0OY8W1wDFBJqQ==
X-Received: by 2002:a37:b402:: with SMTP id d2mr21522100qkf.195.1579015533401;
        Tue, 14 Jan 2020 07:25:33 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v2sm6794227qkj.29.2020.01.14.07.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:25:32 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7436A40DFD; Tue, 14 Jan 2020 12:25:30 -0300 (-03)
Date:   Tue, 14 Jan 2020 12:25:30 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: Re: [PATCH 1/2] perf/ui/gtk: Add missing zalloc object
Message-ID: <20200114152530.GA20569@kernel.org>
References: <20200113104358.123511-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113104358.123511-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 13, 2020 at 11:43:57AM +0100, Jiri Olsa escreveu:
> When we moved zalloc.o to the library we missed gtk library
> which needs it compiled in, otherwise the missing __zfree
> symbol will cause the library to fail to load.
> 
> Adding the zalloc object to the gtk library build.

Thanks, applied.

- Arnaldo
 
> Fixes: 7f7c536f23e6 ("tools lib: Adopt zalloc()/zfree() from tools/perf")
> Link: https://lkml.kernel.org/n/tip-nuu3lyzzmi2t9zdvlg0i0bh0@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/ui/gtk/Build | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
> index ec22e899a224..9b5d5cbb7af7 100644
> --- a/tools/perf/ui/gtk/Build
> +++ b/tools/perf/ui/gtk/Build
> @@ -7,3 +7,8 @@ gtk-y += util.o
>  gtk-y += helpline.o
>  gtk-y += progress.o
>  gtk-y += annotate.o
> +gtk-y += zalloc.o
> +
> +$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,cc_o_c)
> -- 
> 2.24.1
> 

-- 

- Arnaldo
