Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ECAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5EA20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZPuronN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgC3N0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:26:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59037 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728473AbgC3N0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585574760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ugp2HRp3lcQwN4n2hL8+1I8ef2LKyIF2WpsyNRPbEIA=;
        b=YZPuronNZpoPGO8DxRRjSLDxE52IKbNm1t5+GcdXJA1ztAeLnO8WVLay7V8O6cALFrsvfq
        qUI4bH0E0HdyBkO4c+fArGreXYuWA4FdV4PoJ1n29DkwSSVC9uDDdWgeChToZvhkmryUNv
        e8CZbm0VxA5BZEOuRKbs6ILHJkd1ges=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-2kXzmerpP6qCvd16kQUSWQ-1; Mon, 30 Mar 2020 09:25:58 -0400
X-MC-Unique: 2kXzmerpP6qCvd16kQUSWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B6B107ACC4;
        Mon, 30 Mar 2020 13:25:57 +0000 (UTC)
Received: from krava (unknown [10.40.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAD165C1B5;
        Mon, 30 Mar 2020 13:25:54 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:25:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools api fs: make xxx__mountpoint() more scalable
Message-ID: <20200330132551.GE2361248@krava>
References: <20200328014221.168130-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328014221.168130-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:42:21PM -0700, Ian Rogers wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> The xxx_mountpoint() interface provided by fs.c finds
> mount points for common pseudo filesystems. The first
> time xxx_mountpoint() is invoked, it scans the mount
> table (/proc/mounts) looking for a match. If found, it
> is cached. The price to scan /proc/mounts is paid once
> if the mount is found.
> 
> When the mount point is not found, subsequent calls to
> xxx_mountpoint() scan /proc/mounts over and over again.
> There is no caching.
> 
> This causes a scaling issue in perf record with hugeltbfs__mountpoint().
> The function is called for each process found in synthesize__mmap_events().
> If the machine has thousands of processes and if the /proc/mounts has many
> entries this could cause major overhead in perf record. We have observed
> multi-second slowdowns on some configurations.
> 
> As an example on a laptop:
> 
> Before:
> $ sudo umount /dev/hugepages
> $ strace -e trace=openat -o /tmp/tt perf record -a ls
> $ fgrep mounts /tmp/tt
> 285
> 
> After:
> $ sudo umount /dev/hugepages
> $ strace -e trace=openat -o /tmp/tt perf record -a ls
> $ fgrep mounts /tmp/tt
> 1
> 
> One could argue that the non-caching in case the moint point is not found
> is intentional. That way subsequent calls may discover a moint point if
> the sysadmin mounts the filesystem. But the same argument could be made
> against caching the mount point. It could be unmounted causing errors.
> It all depends on the intent of the interface. This patch assumes it
> is expected to scan /proc/mounts once. The patch documents the caching
> behavior in the fs.h header file.

I agree, I don't think we have a code that would intentionaly
make use of the later discovery.. if that's ever needed we
could add function that invalidates the cache

Acked-by:  Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

