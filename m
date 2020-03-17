Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D319C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CD7205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAOJLuNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQIcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:32:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35987 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584433950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AcfMjcsPQAFD6Au7uoeCbRqgv3nmQ/azjAS1sT5vd30=;
        b=LAOJLuNWq59GliKmiIxsHOjWjyZrLF7JHYGFfiAjUPh6BAbmDPMQ+kFNzhDnZnWdCHjsUX
        CLtq4BejLfY/ogfC9JS+F8TKX2Z/urMOTmKXnKsP/YgDcLZ0yBoWWpGBWA0cqqFX8XcZ7N
        D5ImOlNkp8mnFBpXr1h2rPvoxgA+8hE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-Juz-to9cM_KfatupFhU66Q-1; Tue, 17 Mar 2020 04:32:26 -0400
X-MC-Unique: Juz-to9cM_KfatupFhU66Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1FFF107B277;
        Tue, 17 Mar 2020 08:32:24 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-179.ams2.redhat.com [10.36.112.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B543060BF3;
        Tue, 17 Mar 2020 08:32:18 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: clone3: allow creation of time namespace with offset
Date:   Tue, 17 Mar 2020 09:30:40 +0100
Message-Id: <20200317083043.226593-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to add time namespace support to clone3(). I am not
really sure which way clone3() should handle time namespaces. The time
namespace through /proc cannot be used with clone3() because the offsets
for the time namespace need to be written before a process has been
created in that time namespace. This means it is necessary to somehow
tell clone3() the offsets for the clocks.

The time namespace offers the possibility to set offsets for
CLOCK_MONOTONIC and CLOCK_BOOTTIME. My first approach was to extend
'struct clone_args` with '__aligned_u64 monotonic_offset' and
'__aligned_u64 boottime_offset'. The problem with this approach was that
it was not possible to set nanoseconds for the clocks in the time
namespace.

One of the motivations for clone3() with CLONE_NEWTIME was to enable
CRIU to restore a process in a time namespace with the corresponding
offsets. And although the nanosecond value can probably never be
restored to the same value it had during checkpointing, because the
clock keeps on running between CRIU pausing all processes and CRIU
actually reading the value of the clocks, the nanosecond value is still
necessary for CRIU to not restore a process where the clock jumps back
due to CRIU restoring it with a nanonsecond value that is too small.

Requiring nanoseconds as well as seconds for two clocks during clone3()
means that it would require 4 additional members to 'struct clone_args':

        __aligned_u64 tls;
        __aligned_u64 set_tid;
        __aligned_u64 set_tid_size;
+       __aligned_u64 boottime_offset_seconds;
+       __aligned_u64 boottime_offset_nanoseconds;
+       __aligned_u64 monotonic_offset_seconds;
+       __aligned_u64 monotonic_offset_nanoseconds;
 };

To avoid four additional members to 'struct clone_args' this patchset
uses another approach:

        __aligned_u64 tls;
        __aligned_u64 set_tid;
        __aligned_u64 set_tid_size;
+       __aligned_u64 timens_offset;
+       __aligned_u64 timens_offset_size;
 };

timens_offset is a pointer to an array just as previously done with
set_tid and timens_offset_size is the size of the array.

The timens_offset array is expected to contain a struct like this:

struct set_timens_offset {
       int clockid;
       struct timespec val;
};

This way it is possible to pass the information of multiple clocks with
seconds and nanonseconds to clone3().

To me this seems the better approach, but I am not totally convinced
that it is the right thing. If there are other ideas how to pass two
clock offsets with seconds and nanonseconds to clone3() I would be happy
to hear other ideas.

		Adrian


