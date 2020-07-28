Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB06F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595948985;
	bh=o4PxJIJ/FzeUDgKZzu6hiLEO1JMy66beRdJPSWHapb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxIieYCB94DjBW63SEn4HyX5aelF8cO5amFUfyZBtVR2lCJN3FJWlv9tTE739h++V
	 H5lr9sKIiOPyCznB2cD/L+pMGB4WWq9CvDuo7u5rTc0tly4+QN4+JNn/9iR5820RCq
	 NlWxEcZ5bCtrJfPblS/dZoCVIR54GUf5MNKd4MQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgG1PJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgG1PJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:09:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19704204EA;
        Tue, 28 Jul 2020 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595948983;
        bh=o4PxJIJ/FzeUDgKZzu6hiLEO1JMy66beRdJPSWHapb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX3U9LaDx69vPYLKumAoX9vZF4XZfJhrIq7JoKewePTpr7wdXS82ZKvhCdShhevbU
         unzFU12TO3vrB3vbet5v1vVQMy8JysMYXv6JMPJHXitG+H4TJGIZbaTyXn5cFvOWWo
         GkyOFVGB30SIndd+H/fXIEMhNAjHS39+MtCGPKBQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3550940E57; Tue, 28 Jul 2020 12:09:41 -0300 (-03)
Date:   Tue, 28 Jul 2020 12:09:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Ian Rogers <irogers@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] tools build feature: Use CC and CXX from parent
Message-ID: <20200728150941.GA374564@kernel.org>
References: <0a6e69d1736b0fa231a648f50b0cce5d8a6734ef.1595822871.git.tommyhebb@gmail.com>
 <20200728144202.GA1319041@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728144202.GA1319041@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 28, 2020 at 04:42:02PM +0200, Jiri Olsa escreveu:
> On Sun, Jul 26, 2020 at 09:08:14PM -0700, Thomas Hebb wrote:
> > commit c8c188679ccf ("tools build: Use the same CC for feature detection
> > and actual build") changed these assignments from unconditional (:=) to
> > conditional (?=) so that they wouldn't clobber values from the
> > environment. However, conditional assignment does not work properly for
> > variables that Make implicitly sets, among which are CC and CXX. To
> > quote tools/scripts/Makefile.include, which handles this properly:
> > 
> >   # Makefiles suck: This macro sets a default value of $(2) for the
> >   # variable named by $(1), unless the variable has been set by
> >   # environment or command line. This is necessary for CC and AR
> >   # because make sets default values, so the simpler ?= approach
> >   # won't work as expected.
> > 
> > In other words, the conditional assignments will not run even if the
> > variables are not overridden in the environment; Make will set CC to
> > "cc" and CXX to "g++" when it starts[1], meaning the variables are not
> > empty by the time the conditional assignments are evaluated. This breaks
> > cross-compilation when CROSS_COMPILE is set but CC isn't, since "cc"
> > gets used for feature detection instead of the cross compiler (and
> > likewise for CXX).
> > 
> > To fix the issue, just pass down the values of CC and CXX computed by
> > the parent Makefile, which gets included by the Makefile that actually
> > builds whatever we're detecting features for and so is guaranteed to
> > have good values. This is a better solution anyway, since it means we
> > aren't trying to replicate the logic of the parent build system and so
> > don't risk it getting out of sync.
> > 
> > Leave PKG_CONFIG alone, since 1) there's no common logic to compute it
> > in Makefile.include, and 2) it's not an implicit variable, so
> > conditional assignment works properly.
> 
> looks good, I wonder we might need it also for CLANG in the future
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks for checking, I'll add it to the mix and see how it goes with the
container tests.

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > [1] https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
> > 
> > Fixes: c8c188679ccf ("tools build: Use the same CC for feature detection and actual build")
> > Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> > ---
> > 
> >  tools/build/Makefile.feature | 2 +-
> >  tools/build/feature/Makefile | 2 --
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > index cb152370fdef..774f0b0ca28a 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -8,7 +8,7 @@ endif
> >  
> >  feature_check = $(eval $(feature_check_code))
> >  define feature_check_code
> > -  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> > +  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC=$(CC) CXX=$(CXX) CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> >  endef
> >  
> >  feature_set = $(eval $(feature_set_code))
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index b1f0321180f5..93b590d81209 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -74,8 +74,6 @@ FILES=                                          \
> >  
> >  FILES := $(addprefix $(OUTPUT),$(FILES))
> >  
> > -CC ?= $(CROSS_COMPILE)gcc
> > -CXX ?= $(CROSS_COMPILE)g++
> >  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> >  LLVM_CONFIG ?= llvm-config
> >  CLANG ?= clang
> > -- 
> > 2.27.0
> > 
> 

-- 

- Arnaldo
