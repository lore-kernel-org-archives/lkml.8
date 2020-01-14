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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F99FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C58207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opEDwTzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgANPla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:41:30 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46378 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgANPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:41:29 -0500
Received: by mail-qv1-f67.google.com with SMTP id u1so5835371qvk.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P59jRCDGTRQM8lcWebpz2wdqrwDd4OE2eBI8Vvuuxtg=;
        b=opEDwTzqmMiB6bGLtgoQvEbhTL63VQqL5aCXW0t3Qj8gGlUhORLjt6FqUF362Hlp3k
         mK6ROkwlhwdgR8JobGbdJYoJJM7Txaj0s7cwGZCkO8ffP42t6QwHGOxkcw/X+74/QdfU
         midUEgX8KaN4mSCa43hm2SsV4rDVHqUlEZf0qZais7ocTj2cSmeF9bWP32vYJoKMlvqB
         CH7ZwPPbmVeOdr10VHTiZxJDWMAa7i8Zp+t95Sjw988JF9FulryB1uPRxLgXiTAvI2l6
         vyfZX8ianTBHGfAdgzjXko3Sw0J54ZRU5TM3cZVabd95wDtOTLjFpib8J4EwxNVaRtXb
         jJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P59jRCDGTRQM8lcWebpz2wdqrwDd4OE2eBI8Vvuuxtg=;
        b=Ws9oGke/a+QWL149YhsJx4Cb6ONoWUdHp1LdJrIRAz0HVwslBDr2qv2A2XUUM25eO7
         2IcrgLRNqIJ8y4pbWsgYrGbOSQlw9LDVSNA8K6MqG2RixjFZjAr6Z023QblXTJaLlIbh
         ZgRlRQZ7tNVFol82eZYYQHET51AVJrqwq9ZL3/vb4dBVJggiIJL411Zx5XmaUy1Frp5M
         GtiUdNbVRt2WzQoQH5DS4AwYAoa18vQeivJLMX6Et/RXlGrx6o7h6sxwEkh6SHgcWezD
         hKH+6VWq6gTC8xBHLKAFMZttkVjN+yjaWV/e7fP+txF/h3b9Z8lHETYEZecDAkcjFqwP
         ZO+A==
X-Gm-Message-State: APjAAAXngA0Gh1zwY/pcvcbC32hD8hph138F/35bKUbR2x1HNU5wDh9Z
        VLKxa9ylE7S/NI/FNqcHCmI=
X-Google-Smtp-Source: APXvYqyM+nKDfjR4L9mgBzCGfrLcdnZ+j6elbDQGhq7A/UGxyPaaJ/HengV3qhvH/1rCME4O6OXt1g==
X-Received: by 2002:a0c:cdc4:: with SMTP id a4mr17533272qvn.21.1579016488816;
        Tue, 14 Jan 2020 07:41:28 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f19sm6766624qkk.69.2020.01.14.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:41:28 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FB2540DFD; Tue, 14 Jan 2020 12:41:25 -0300 (-03)
Date:   Tue, 14 Jan 2020 12:41:25 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: Re: [PATCH 2/2] perf/ui/gtk: Fix gtk2 build
Message-ID: <20200114154125.GB20569@kernel.org>
References: <20200113104358.123511-1-jolsa@kernel.org>
 <20200113104358.123511-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113104358.123511-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 13, 2020 at 11:43:58AM +0100, Jiri Olsa escreveu:
> Ravi Bangoria reported issue when detecting gtk2 on Fedora 31,
> where some types got deprecated:
> 
>   /usr/include/gtk-2.0/gtk/gtktypeutils.h:236:1: error: ‘GTypeDebugFlags’ is deprecated [-Werror=deprecated-declarations]
>     236 | void            gtk_type_init   (GTypeDebugFlags    debug_flags);
> 
> Fixing this for perf by allowing the compile to pass
> with deprecated symbols via -Wno-deprecated-declarations.

Thanks, applied.

- Arnaldo
 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Link: https://lkml.kernel.org/n/tip-kg8fqsa0bgq3suc9ubonh4xu@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/build/feature/Makefile | 2 +-
>  tools/perf/ui/gtk/Build      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index f30a89046aa3..7ac0d8088565 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -197,7 +197,7 @@ $(OUTPUT)test-libcrypto.bin:
>  	$(BUILD) -lcrypto
>  
>  $(OUTPUT)test-gtk2.bin:
> -	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
> +	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
>  
>  $(OUTPUT)test-gtk2-infobar.bin:
>  	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
> diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
> index 9b5d5cbb7af7..eef708c502f4 100644
> --- a/tools/perf/ui/gtk/Build
> +++ b/tools/perf/ui/gtk/Build
> @@ -1,4 +1,4 @@
> -CFLAGS_gtk += -fPIC $(GTK_CFLAGS)
> +CFLAGS_gtk += -fPIC $(GTK_CFLAGS) -Wno-deprecated-declarations
>  
>  gtk-y += browser.o
>  gtk-y += hists.o
> -- 
> 2.24.1
> 

-- 

- Arnaldo
