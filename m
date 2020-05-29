Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FB42075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/n2IkvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgE2Udh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:33:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgE2Ude (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590784412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8PbJoOH9aDezxgmzJ1TZq5s7Zncxp4A2MUMvmD67D8=;
        b=I/n2IkvAYIzdg2J7SbBhClEWW3mk4yHHamREQBP1o8vahFL3WcdW93BPn36+KAlCDQAOca
        Jm77ViuAitgMlc+eha8/lbnA3YwFoD603nZyuAntzFZhbc6/NUss5yiy9H8Vx1xbr6x13M
        hQ5Y85PJpuHrfm9ef66YwIjd9zzuzyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-Dj63E_4GPCGmXu4XWuPxwA-1; Fri, 29 May 2020 16:33:28 -0400
X-MC-Unique: Dj63E_4GPCGmXu4XWuPxwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD902460;
        Fri, 29 May 2020 20:33:26 +0000 (UTC)
Received: from krava (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14C2E5C1B5;
        Fri, 29 May 2020 20:33:21 +0000 (UTC)
Date:   Fri, 29 May 2020 22:33:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf build: Allow explicitely disabling the
 NO_SYSCALL_TABLE variable
Message-ID: <20200529203320.GG506785@krava>
References: <20200529155552.463-1-acme@kernel.org>
 <20200529155552.463-3-acme@kernel.org>
 <20200529180717.GF506785@krava>
 <20200529194515.GB31795@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529194515.GB31795@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:45:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 29, 2020 at 08:07:17PM +0200, Jiri Olsa escreveu:
> > On Fri, May 29, 2020 at 12:55:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > This is useful to see if, on x86, the legacy libaudit still works, as it
> > > is used in architectures that don't have the SYSCALL_TABLE logic and we
> > > want to have it tested in 'make -C tools/perf/ build-test'.
> > > 
> > > E.g.:
> > > 
> > > Without having audit-libs-devel installed:
> > > 
> > >   $ make NO_SYSCALL_TABLE=1 O=/tmp/build/perf -C tools/perf install-bin
> > >   make: Entering directory '/home/acme/git/perf/tools/perf'
> > >     BUILD:   Doing 'make -j12' parallel build
> > >   <SNIP>
> > >   Auto-detecting system features:
> > >   <SNIP>
> > >   ...                      libaudit: [ OFF ]
> > >   ...                        libbfd: [ on  ]
> > >   ...                        libcap: [ on  ]
> > >   <SNIP>
> > >   Makefile.config:664: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
> > >   <SNIP>
> > > 
> > > After installing it:
> > > 
> > >   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> > >   $ time make NO_SYSCALL_TABLE=1 O=/tmp/build/perf  -C tools/perf install-bin ; perf test python
> > 
> > heya,
> > seems ok, perhaps also put it in comment to Makefile.perf
> > among other NO_* stuff and to tests/make
> 
> 
> Added this and your Acked-by (from the "seems ok") :-) Ok?

yep ;-)

jirka

> 
> - Arnaldo
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 30e41dcd4095..e3a34af38130 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -118,6 +118,9 @@ include ../scripts/utilities.mak
>  #
>  # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
>  #
> +# Define NO_SYSCALL_TABLE=1 to disable the use of syscall id to/from name tables
> +# generated from the kernel .tbl or unistd.h files and use, if available, libaudit
> +# for doing the conversions to/from strings/id.
>  
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> 

