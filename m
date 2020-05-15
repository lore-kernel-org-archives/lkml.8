Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32632C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096A420728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp47erzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEON5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEON5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:57:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:57:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so1983680qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eKQtd+PExqfwVh7oIUYEDD5YPRlmqgWt+8umPUJubrM=;
        b=fp47erznnMEnSRf2ZpWDY5rVkCmNtX63Qr45SuD0ezHaCS0EaCwQf/xRKhclBkPwju
         XblDKh/GPKMz8hxVtY+QZ1cyl3blV1qSRmaYd6Mt30pjuWRWKzXEzdc1+SHWPT3/6rRv
         IgSDbIN6J4Y4snbySpldHPyLfLtHFc1q401HaY1yUnN64UCxrN/DhGYDT2kJ233XE1Yd
         +IDOacose6yByNRl0R/zUDmDhfHaHTLSl36ZO/zInemhwwx995VraoWHkBE46xcS8uYe
         AdyQeZrTIQ5OJLgrf79TbLb+Ais7HAPh9l+u3RYXJN5VxeFUSgmD9oGvTKT5XPeWSJgE
         4dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKQtd+PExqfwVh7oIUYEDD5YPRlmqgWt+8umPUJubrM=;
        b=NTiosD9vK57tgPYoLutthZ+rYUp62E8Sh267atzzchaQFA12cS1J1lJ2Q9pjErb8DX
         nf30AilZprBIM/8R4PZ02dW8nyNAtcC9oJbZ0+gTWvq+ILTDjdoP1eppMfKXq1zRr8ag
         KJQFPiTT9Dq0GasiVThIoQc2VrVNYjKrFMR6sisFJsWjj0iO0s7Hq1nRgwNVWiyD/Ne8
         5ktB4YuHD2cCBYArBBNRh1k2tYY3N6A2+0cfqMlpNlZYGZq50L+7gbtiONLTQeaEf/Wa
         1c1NjYHaIRd9tITVJMu+hKPD6ZbeRmQuFvktq9agZAygVwglwfP7k6f8JRc/B2wLeyKD
         gmNw==
X-Gm-Message-State: AOAM532V8fXbL/0y0bZTkmOTdhK2k9niFHWyz/WxOpALXZMD37H7Eg26
        qkZOf0z2qYtGQjynd8yiWbA=
X-Google-Smtp-Source: ABdhPJzyKVGQKPsek1G9LoCLcqc3Y6xfxWn6piK6I4euhZsUD1HhqPKc/tRWDKCPIp1WO9M1cBIAOA==
X-Received: by 2002:ac8:2dbc:: with SMTP id p57mr3562332qta.280.1589551058631;
        Fri, 15 May 2020 06:57:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q7sm1612490qki.56.2020.05.15.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:57:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF54640AFD; Fri, 15 May 2020 10:50:36 -0300 (-03)
Date:   Fri, 15 May 2020 10:50:36 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] tools/perf: build fixes for arch_errno_names.sh
Message-ID: <20200515135036.GR5583@kernel.org>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-4-irogers@google.com>
 <20200514150447.GA29968@kernel.org>
 <CAP-5=fU+RYa3GF_xfjCPFGRKi5-zNuY7bm+9wqAnrAo2NqJ+oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU+RYa3GF_xfjCPFGRKi5-zNuY7bm+9wqAnrAo2NqJ+oQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 14, 2020 at 10:54:49AM -0700, Ian Rogers escreveu:
> On Thu, May 14, 2020 at 8:04 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Mar 05, 2020 at 11:11:10PM -0800, Ian Rogers escreveu:
> > > Allow the CC compiler to accept a CFLAGS environment variable.
> > > Make the architecture test directory agree with the code comment.
> > > This doesn't change the code generated but makes it easier to integrate
> > > running the shell script in build systems like bazel.
> >
> > I've looked at this and split this part in a separate patch, and applied
> > it locally, please take a look, now looking at the other bit of the
> > patch.
> 
> 
> This bit looks good. The CFLAGS change is something I need to deal
> with a directory layout change in our build system.

I added that one as well, as a separate patch, this one:

commit 6e136ceba23c087b1e1b846914e425706d492a3a
Author: Ian Rogers <irogers@google.com>
Date:   Thu Mar 5 23:11:10 2020 -0800

    perf beauty: Allow the CC used in the arch errno names script to acccept CFLAGS
    
    Allow the CC compiler to accept a CFLAGS environment variable.  This
    doesn't change the code generated but makes it easier to integrate
    running the shell script in build systems like bazel.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Alexios Zavras <alexios.zavras@intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Igor Lubashev <ilubashe@akamai.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Wei Li <liwei391@huawei.com>
    Link: http://lore.kernel.org/lkml/20200306071110.130202-4-irogers@google.com
    [ split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index f8c44a85650b..9f9ea45cddc4 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,7 +57,7 @@ process_arch()
 	local arch="$1"
 	local asm_errno=$(asm_errno_file "$arch")
 
-	$gcc $include_path -E -dM -x c $asm_errno \
+	$gcc $CFLAGS $include_path -E -dM -x c $asm_errno \
 		|grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
 		|awk '{ print $2","$3; }' \
 		|sort -t, -k2 -nu \
