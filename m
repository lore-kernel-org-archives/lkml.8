Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A08D2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590781520;
	bh=acs00l2CxpN6gBKZCGABWs10ajucvZhKCCCwHx8Hw6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QaPwgnElLEpoAqD/W8qBmiw3RiDlQ2apQB6WlZcYylVeDSodsKXXibys++x0xr5tp
	 NQhgMe2u7mwnXn2uLBcJkycivXmFPRgnd0HVl+D4UQ/uyyXJ9vwf9kSJejIQY+PogA
	 2XHSJKS9z/EuU+bZM8tAdAl6ZrLcacJ6IEAvkY08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgE2TpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgE2TpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:45:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E3802067B;
        Fri, 29 May 2020 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590781517;
        bh=acs00l2CxpN6gBKZCGABWs10ajucvZhKCCCwHx8Hw6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJazvp5rrUA5BRrL1ojHzPIbwxaEM1P+is3Ttw08yRivW9MtdtyHN/fNUVk+n5mfo
         6W0p8FJspPHdZiy808F0ic29drQzzeMeabHQMSLR4u/gVbuTuiOeVL4ue/lriGMfgX
         TodlQ4CcHifYpJNg2OZYn0vkiDbS3FTLoNGnXSEE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 496C740AFD; Fri, 29 May 2020 16:45:15 -0300 (-03)
Date:   Fri, 29 May 2020 16:45:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf build: Allow explicitely disabling the
 NO_SYSCALL_TABLE variable
Message-ID: <20200529194515.GB31795@kernel.org>
References: <20200529155552.463-1-acme@kernel.org>
 <20200529155552.463-3-acme@kernel.org>
 <20200529180717.GF506785@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529180717.GF506785@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 29, 2020 at 08:07:17PM +0200, Jiri Olsa escreveu:
> On Fri, May 29, 2020 at 12:55:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > This is useful to see if, on x86, the legacy libaudit still works, as it
> > is used in architectures that don't have the SYSCALL_TABLE logic and we
> > want to have it tested in 'make -C tools/perf/ build-test'.
> > 
> > E.g.:
> > 
> > Without having audit-libs-devel installed:
> > 
> >   $ make NO_SYSCALL_TABLE=1 O=/tmp/build/perf -C tools/perf install-bin
> >   make: Entering directory '/home/acme/git/perf/tools/perf'
> >     BUILD:   Doing 'make -j12' parallel build
> >   <SNIP>
> >   Auto-detecting system features:
> >   <SNIP>
> >   ...                      libaudit: [ OFF ]
> >   ...                        libbfd: [ on  ]
> >   ...                        libcap: [ on  ]
> >   <SNIP>
> >   Makefile.config:664: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
> >   <SNIP>
> > 
> > After installing it:
> > 
> >   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> >   $ time make NO_SYSCALL_TABLE=1 O=/tmp/build/perf  -C tools/perf install-bin ; perf test python
> 
> heya,
> seems ok, perhaps also put it in comment to Makefile.perf
> among other NO_* stuff and to tests/make


Added this and your Acked-by (from the "seems ok") :-) Ok?

- Arnaldo

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 30e41dcd4095..e3a34af38130 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -118,6 +118,9 @@ include ../scripts/utilities.mak
 #
 # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
 #
+# Define NO_SYSCALL_TABLE=1 to disable the use of syscall id to/from name tables
+# generated from the kernel .tbl or unistd.h files and use, if available, libaudit
+# for doing the conversions to/from strings/id.
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
