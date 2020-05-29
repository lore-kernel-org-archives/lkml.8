Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B5CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACA0206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLXIzivL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgE2PK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:10:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49917 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgE2PKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590765053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnxeFp14RexqGGZFW/okYZsmuiiHX01BwazxUAV4lLA=;
        b=fLXIzivL+Jr8DTCQK+SjfaLX5vTjD0pPkB/Qk8EqlGpngCns5bHoIV1Rs81kvdoiZMGBgj
        yV70lwQ302DlK+dLRjES8WJ07KT4SwEjD2n9avsdSN9Whm+QH2xffQBFZYvDQU7gkjVGYq
        FbIscXhVPlJSDZTij5TShv/n06fgbOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-3JPMQyU_OterHkBhflL76g-1; Fri, 29 May 2020 11:10:39 -0400
X-MC-Unique: 3JPMQyU_OterHkBhflL76g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF80EC1A8;
        Fri, 29 May 2020 15:10:38 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-73.ams2.redhat.com [10.36.113.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F379B768B1;
        Fri, 29 May 2020 15:10:31 +0000 (UTC)
Date:   Fri, 29 May 2020 17:10:29 +0200
From:   Adrian Reber <areber@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200529151029.GF254677@dcbz.redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAKgNAkip8nuFHCHEL2NUZXo91+8Q4w1zXKz4aFjj=TwXMuBxcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkip8nuFHCHEL2NUZXo91+8Q4w1zXKz4aFjj=TwXMuBxcA@mail.gmail.com>
X-Operating-System: Linux (5.6.11-300.fc32.x86_64)
X-Load-Average: 3.16 2.44 1.80
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 02:26:13PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Adrian,
> 
> If there was a revision to this patch, I missed it. Is there still a
> plan to bring CLONE_NEWTIME to clone3()?

Good that you ask. The discussion ended at the point that we do not have
a way to figure out what a syscall supports from user-space.  I talked a
bit with Christian about it and he mentioned that there were some ideas
floating around how to do that. At that point it made more sense to me
to wait for such a solution to appear before continuing the clone3()
time namespace work.

		Adrian

> On Tue, 17 Mar 2020 at 09:32, Adrian Reber <areber@redhat.com> wrote:
> >
> > This is an attempt to add time namespace support to clone3(). I am not
> > really sure which way clone3() should handle time namespaces. The time
> > namespace through /proc cannot be used with clone3() because the offsets
> > for the time namespace need to be written before a process has been
> > created in that time namespace. This means it is necessary to somehow
> > tell clone3() the offsets for the clocks.
> >
> > The time namespace offers the possibility to set offsets for
> > CLOCK_MONOTONIC and CLOCK_BOOTTIME. My first approach was to extend
> > 'struct clone_args` with '__aligned_u64 monotonic_offset' and
> > '__aligned_u64 boottime_offset'. The problem with this approach was that
> > it was not possible to set nanoseconds for the clocks in the time
> > namespace.
> >
> > One of the motivations for clone3() with CLONE_NEWTIME was to enable
> > CRIU to restore a process in a time namespace with the corresponding
> > offsets. And although the nanosecond value can probably never be
> > restored to the same value it had during checkpointing, because the
> > clock keeps on running between CRIU pausing all processes and CRIU
> > actually reading the value of the clocks, the nanosecond value is still
> > necessary for CRIU to not restore a process where the clock jumps back
> > due to CRIU restoring it with a nanonsecond value that is too small.
> >
> > Requiring nanoseconds as well as seconds for two clocks during clone3()
> > means that it would require 4 additional members to 'struct clone_args':
> >
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 boottime_offset_seconds;
> > +       __aligned_u64 boottime_offset_nanoseconds;
> > +       __aligned_u64 monotonic_offset_seconds;
> > +       __aligned_u64 monotonic_offset_nanoseconds;
> >  };
> >
> > To avoid four additional members to 'struct clone_args' this patchset
> > uses another approach:
> >
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 timens_offset;
> > +       __aligned_u64 timens_offset_size;
> >  };
> >
> > timens_offset is a pointer to an array just as previously done with
> > set_tid and timens_offset_size is the size of the array.
> >
> > The timens_offset array is expected to contain a struct like this:
> >
> > struct set_timens_offset {
> >        int clockid;
> >        struct timespec val;
> > };
> >
> > This way it is possible to pass the information of multiple clocks with
> > seconds and nanonseconds to clone3().
> >
> > To me this seems the better approach, but I am not totally convinced
> > that it is the right thing. If there are other ideas how to pass two
> > clock offsets with seconds and nanonseconds to clone3() I would be happy
> > to hear other ideas.
> >
> >                 Adrian
> >
> >
> 
> 
> -- 
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
> 

