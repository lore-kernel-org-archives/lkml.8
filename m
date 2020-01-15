Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C5C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF452467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl3HcE7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:28:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbgAOI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579076883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=adl4YTtGwDsGU3mcOyNEDPoRcVEGa1oR2kpCSJ2EC6U=;
        b=Pl3HcE7Hrvu75Zc0j77XI1BUYpRVHzchDfJEiTSx7LgNSEN840opV3qp/BpBaW8oMZbAH6
        IlVIrWgQVKgkVMC2LVae7wtuhIAc/LWsOlD7ze6A3PxlhO3//7Kl9j6iEFe5S9K3KDb719
        ZDG3/GKLT/unCTs+cFUMe2sGGNxu1y8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-p9ScF3kkMnadRwXNd1Le3w-1; Wed, 15 Jan 2020 03:28:01 -0500
X-MC-Unique: p9ScF3kkMnadRwXNd1Le3w-1
Received: by mail-qv1-f72.google.com with SMTP id dw11so10457714qvb.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=adl4YTtGwDsGU3mcOyNEDPoRcVEGa1oR2kpCSJ2EC6U=;
        b=I7lgP0avZsS+T2/UeKs8fL10liSqYUpId+gPo9D6GJO1gTkEiiDdMwkIso4gFyfxQC
         75OdvxyqX+kqXXvZkNdFyVHHSxrbew/WLlN5jTiMFtVE2dOjiPl9qq6S/ADUaxun2RPh
         epYBh9nTXuRtYhXqawA9Qb1S1O6vhpDJ0GYkno1bmDMBLRbFWvA4u1UktxGNN7xtKiC6
         7O5NA2CajUbdVLWq3HYT0oEWsKJf6YUdbcOgRG4R0AIRygRkr4H2jU3zbda1m2FBLiKS
         oc0L1XObQtmb9D80JkN/J690IEhCoRn9Pnjxf4YyBP9VDxQncQm5mtN1k//pco2v/6Tz
         MLoA==
X-Gm-Message-State: APjAAAUFxJEUXj7i739hP/4sdwALffxyuUX76WDW0KhUevfKl60Y+SMD
        hK1SZ9W2K73xv/Zfb1WYv4jV8cLhOLTBAxKn1/CcqenZ+endikN3hkRkoa+jn98B3MkMgoXf5YT
        T9JteHtkNqtFgN32GxhZBBdc01a3ZVDLgV9tJxHOR
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr20837535qvg.197.1579076881139;
        Wed, 15 Jan 2020 00:28:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqynnIvI5Tdl1vtJm+JFA4/fXl3/u2hfPlTaOuV5Y0yec93AWwALsaiQEu+kRVo1l9SynVVGsOGBz9NPoVfX9pQ=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr20837524qvg.197.1579076880853;
 Wed, 15 Jan 2020 00:28:00 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Holy <oholy@redhat.com>
Date:   Wed, 15 Jan 2020 09:27:24 +0100
Message-ID: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
Subject: Weird fuse_operations.read calls with Linux 5.4
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been directed here from https://github.com/libfuse/libfuse/issues/488.

My issue is that with Linux Kernel 5.4, one read kernel call (e.g.
made by cat tool) triggers two fuse_operations.read executions and in
both cases with 0 offset even though that first read successfully
returned some bytes.

For gvfs, it leads to redundant I/O operations, or to "Operation not
supported" errors if seeking is not supported. This doesn't happen
with Linux 5.3. Any idea what is wrong here?

$ strace cat /run/user/1000/gvfs/ftp\:host\=server\,user\=user/foo
...
openat(AT_FDCWD, "/run/user/1000/gvfs/ftp:host=server,user=user/foo",
O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=20, ...}) = 0
fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x7fbc42b92000
read(3, 0x7fbc42b93000, 131072)         = -1 EOPNOTSUPP (Operation not
supported)
...

$ /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -d
...
open flags: 0x8000 /ftp:host=server,user=user/foo
   open[139679517117488] flags: 0x8000 /ftp:host=server,user=user/foo
   unique: 8, success, outsize: 32
unique: 10, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
read[139679517117488] 4096 bytes from 0 flags: 0x8000
   read[139679517117488] 20 bytes from 0
   unique: 10, success, outsize: 36
unique: 12, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
read[139679517117488] 4096 bytes from 0 flags: 0x8000
   unique: 12, error: -95 (Operation not supported), outsize: 16
...

See for other information: https://gitlab.gnome.org/GNOME/gvfs/issues/441

Regards

Ondrej
--
Ondrej Holy
Software Engineer, Core Desktop Development
Red Hat Czech s.r.o

