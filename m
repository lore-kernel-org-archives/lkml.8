Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3871EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1126920733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLImoFJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJLpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:45:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbgBJLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581335100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xB01AmvIMP2zlBp52cydjafDP6p81GAeFrzC/ZqXhLM=;
        b=SLImoFJto6Pr7r3EJ6H6jSTIxWmHutbUBOPKzPZxrRpSwyWRNvRdTHreFs/BRPtka9PE27
        ooxWg7nmUBtqSmzXxZoxBZnaJFiAL7CMip5Yf5gYsXxuq6RA+t1a0BZoSGoZWTeEy3Rmni
        89FikhWSwvrNggVo6nlWsfZlkQTslgQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-UyWVeXFiOGiiXmqcUdephQ-1; Mon, 10 Feb 2020 06:44:57 -0500
X-MC-Unique: UyWVeXFiOGiiXmqcUdephQ-1
Received: by mail-qt1-f198.google.com with SMTP id b13so990763qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 03:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xB01AmvIMP2zlBp52cydjafDP6p81GAeFrzC/ZqXhLM=;
        b=R/SVmi7xndWtv7MMF66VbQNakj5QfJ1DAGmeSKnH4Q0QRIHRlGqzrX9xdDV/pbp+LB
         2ncqgeWgPZhKq1uy89bPZLH1Ivzgc/a4XLxtvm72tNxN6Xe5A8j+JzlG0BaGPBi0WW/v
         hj1AglaBQ5yZGHY0KNhnKGrHycAYNMGLCys1QkRg2QDrQnGannxlUQbLSQSkJqxarWTB
         JkK6OYqKPnQ6gWTvc3rH8K84OCVHV5hroii9l24xUSuC/nmByleKk/8NTwZHGYXyyzSi
         W+ll4aYz7fIQ9RF6z/DeTellviTQIfh+F1lynt2crFkCKcvoZVCJ0flIcIbkZrFepCOH
         fefA==
X-Gm-Message-State: APjAAAWGv1gGEbMs+uR7/Nz6FuoylyceLWg6fbYD83e77B3NxgXaVTpz
        SGrveaG9UTmE84MbpHzuGtge2U5I3avhIcOb+J0bPj1VH0dyQLyhcqmTsa3EmmS8jgIGBzZanAM
        T+RIaTMh8zko6e7KEuU9k5zLO
X-Received: by 2002:ac8:163c:: with SMTP id p57mr9672537qtj.106.1581335096825;
        Mon, 10 Feb 2020 03:44:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzo8F+ijddyWNCzlSRkdjCazFKYIFluf/ruZv69nOCH6erG+yjXCdvK7xLg46qRCeaKu8pXbA==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr9672524qtj.106.1581335096584;
        Mon, 10 Feb 2020 03:44:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id 12sm12808qkv.29.2020.02.10.03.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 03:44:55 -0800 (PST)
Date:   Mon, 10 Feb 2020 06:44:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200210062938-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> We have compared the number of files and the lines of code between
> virtio-mmio and virio-pci.
> 
> 				Virtio-PCI	    Virtio-MMIO	
> 	number of files(Linux)	    161			1
> 	lines of code(Linux)	    78237		538



Something's very wrong here. virtio PCI is 161 files?
Are you counting the whole PCI subsystem?
Sure enough:

$ find drivers/pci -name '*c' |wc -l
150

That's not reasonable, this includes a bunch of drivers that
never run on a typical hypervisor.

MMIO is also not as small as you are trying to show:

$ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
       2 text files.
       2 unique files.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (230.7 files/s, 106126.5 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C                                1            144            100            535
C/C++ Header                     1             39             66             36
-------------------------------------------------------------------------------
SUM:                             2            183            166            571
-------------------------------------------------------------------------------


I don't doubt MMIO is smaller than PCI. Of course that's because it has
no features to speak of - just this patch already doubles it's size. If
we keep doing that because we want the features then they will reach
the same size in about 4 iterations.


-- 
MST

