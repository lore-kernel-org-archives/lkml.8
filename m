Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C62071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ry0C9MNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgAXB2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:28:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42465 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgAXB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:28:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so86443plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 17:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nr61gQ1ppZdRJbeAMVu/qwhaTijctoY7d/X25Vrjrzs=;
        b=Ry0C9MNdGGagS34hyLAGWtc/JBYepuUdGyw7jncF/rfcmeMXOvKNbxwZPQKVfauwC8
         1w1lbCS8CGMePZqOBNWjGkncrcz3qw2EXU0p2TKCtRNwGq6nulwXA/G+tNQJio++Mm3Y
         LMYUtqPac/lXcumGZiPBMv8nTCYtf13v8nIsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nr61gQ1ppZdRJbeAMVu/qwhaTijctoY7d/X25Vrjrzs=;
        b=Q6942OFcDtPtNbZuAdT3e+kM+A84X9WEs6YoVpAF5/AEOf2SDAl5WLcsa5xj3NsP6i
         JF89yn/YpuKvBw7vDZLubiMUW4GDX6DBGqOWzKbljkWLiZEst5zTTWRB+Y/j9WV9QU/v
         LITzDH5T3qT7bC2JN/ByzXFd8+Ki+7lRdtqRqeCvu1j25F6v6weRYtfs6sAagr8PG+93
         KBfE1RS5GnEj47v9NfQRyV0p0xYSYAwalbwQhoaqH0q8SxUAnZMsJSPY/dUluZgmrZRn
         zwFhzRb/9AJo7J6EoxJl5EwE9W94wXCES5W/akxaldRMXNxUJ8ModjOOF3k69amltuu6
         bSJA==
X-Gm-Message-State: APjAAAV+0ircQ8xzbcnAgpp2mrSNBuiNkwHps1sej2MJ1o9aO5WnN67a
        MpXBgejxzo4gPfLm0yehju6lMg==
X-Google-Smtp-Source: APXvYqwtqnnUnsMKhgIE64PIOEKlIj/OuEAdslNerJOfsaaLgtPhdLjXMAtWtIcRXnyfqyTbWXRWwg==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr1000791plb.202.1579829286931;
        Thu, 23 Jan 2020 17:28:06 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id t30sm4147588pgl.75.2020.01.23.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 17:28:06 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:28:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 06/15] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT in CREATE_BUFS
Message-ID: <20200124012803.GB158382@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-7-senozhatsky@chromium.org>
 <1fedab8f-e9a1-36b1-3dd0-8f1ed782ec4d@xs4all.nl>
 <20200123034118.GA158382@google.com>
 <d9498772-d9f5-7b25-72af-04249619ce07@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9498772-d9f5-7b25-72af-04249619ce07@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/23 12:41), Hans Verkuil wrote:
[..]
> >>>  
> >>>  	fill_buf_caps(q, &create->capabilities);
> >>> @@ -775,7 +776,11 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
> >>>  	for (i = 0; i < requested_planes; i++)
> >>>  		if (requested_sizes[i] == 0)
> >>>  			return -EINVAL;
> >>> -	return ret ? ret : vb2_core_create_bufs(q, create->memory,
> >>> +
> >>> +	if (create->flags & V4L2_FLAG_MEMORY_NON_CONSISTENT)
> >>> +		consistent = false;
> >>> +
> >>> +	return ret ? ret : vb2_core_create_bufs(q, create->memory, consistent,
> >>>  		&create->count, requested_planes, requested_sizes);
> >>
> >> As mentioned before: we need a V4L2_BUF_CAP capability.
> > 
> > I can add V4L2_BUF_CAP for memory consistency. Isn't it just q->memory
> > property though? User space may request MMAP consistent memory or MMAP
> > inconsistent memory.
> 
> So instead of adding a flag we add a V4L2_MEMORY_MMAP_NON_CONSISTENT memory
> type and add a V4L2_BUF_CAP_SUPPORTS_MMAP_NON_CONSISTENT to signal support
> for this?
> 
> I like that better than a flag. It also automatically enforces that all
> buffers must be of that type.

Yes, we had this idea as well. The conclusion was it makes the patch
set bigger and harder to verify and review. Passing memory consistency
attribute via ->flags was the shortest path at the end. Namely due to all
those numerous places that test q->memory:

 455                 if (q->memory == VB2_MEMORY_MMAP)
 456                         __vb2_buf_mem_free(vb);
 457                 else if (q->memory == VB2_MEMORY_DMABUF)
 458                         __vb2_buf_dmabuf_put(vb);
 459                 else
 460                         __vb2_buf_userptr_put(vb);

[..]

 737                 mutex_lock(&q->mmap_lock);
 738                 if (debug && q->memory == VB2_MEMORY_MMAP &&
 739                     __buffers_in_use(q))
 740                         dprintk(1, "memory in use, orphaning buffers\n");

[..]

etc.

As a workaround we looked at the idea that V4L2_MEMORY_MMAP_NON_CONSISTENT
flag might make sense only on the very high level - when user space requests
V4L2_MEMORY_MMAP_NON_CONSISTENT then we simply set DMA attribute and then
"downgrade" requested V4L2_MEMORY_MMAP_NON_CONSISTENT memory type to
V4L2_MEMORY_MMAP.


Something like this.

---

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 4489744fbbd9..60afbfcca995 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -803,6 +803,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 }
 EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
 
+static void __set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
+{
+	if (consistent_mem)
+		q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
+	else
+		q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
+}
+
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		unsigned int *count, unsigned requested_planes,
 		const unsigned requested_sizes[])
@@ -810,6 +818,10 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned int num_planes = 0, num_buffers, allocated_buffers;
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	int ret;
+	bool consistent_mem = (memory == V4L2_MEMORY_MMAP_NON_CONSISTENT);
+
+	if (consistent_mem)
+		memory = V4L2_MEMORY_MMAP;
 
 	if (q->num_buffers == VB2_MAX_FRAME) {
 		dprintk(1, "maximum number of buffers already allocated\n");
@@ -822,6 +834,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			return -EBUSY;
 		}
 		memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
+		__set_queue_consistency(q, consistent_mem);
 		q->memory = memory;
 		q->waiting_for_buffers = !q->is_output;
 	} else if (q->memory != memory) {
