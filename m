Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D7C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C447206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdSzanK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgCGHuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:50:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCGHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:50:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id o24so2261697pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 23:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzhcSxhRoYq25n80YF1EtESa7xdST5h+El3OqWYt5Hg=;
        b=cdSzanK2cycSUIeu/UXqBeI2m6EEqm+kGhZ0/OwVDliTAxokaHvteVBDOLxoP8XeLc
         tqBNEY+Gep7ynltQwNMZ9o4vy3yNhUJWt2bgcg6eYmWto9x1e5xnTN/jcrHqXc5ioNai
         7XYqz+mvxPOH5aLFK0d7xkVsk9stdNVWRIN+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzhcSxhRoYq25n80YF1EtESa7xdST5h+El3OqWYt5Hg=;
        b=s9qlW0xb7hzkrqKWnED5ZeQtw1egQOhzW78G95gDivpClcb0sIgoBeUnPsZZ/W2f+A
         E3XDFGtdD8yjAtX8p8qcDS147eNqkvbHKHcSC3X2Cvp06rWdx7cNb6ZuKKJxy/qGKsva
         sD3BR4GUucf81Zaqouc1lTb6HAHbE7QNlzAFWR2a2MPZFiUQsbNLCl2+5fub+y5Jou3W
         xF/BtA4GOV8wUQcbmmKNUx01EeFFiLkV+w/5O3oK9SmAxXmNsAJl9DBN5LLs+nr4A81G
         SEjoIkngC2dCQXNzO75Eql92uDziPhxXMdzzfM8xlixaUPux8Hu6IvGSsKEyk3hj0XFF
         vSGA==
X-Gm-Message-State: ANhLgQ1JVHfYpKQrOGPIH+bbuveJJB+hxXAwVa8LpI+ZJ+z2F48vFdny
        Ogf+w9ROI/FfNsxNUo2f9su/Yg==
X-Google-Smtp-Source: ADFU+vuClVSW/XG31xmrGAXKpohpkFTIz6ipoCyGnff9XH2Tpx55nA/tOvI2WtBvP3Xd4JmwZMK8Ow==
X-Received: by 2002:a63:745c:: with SMTP id e28mr6715988pgn.231.1583567449271;
        Fri, 06 Mar 2020 23:50:49 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id b4sm39496450pfd.18.2020.03.06.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 23:50:48 -0800 (PST)
Date:   Sat, 7 Mar 2020 16:50:46 +0900
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
Subject: Re: [PATCHv4 04/11] videobuf2: add queue memory consistency parameter
Message-ID: <20200307075046.GC176460@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-5-senozhatsky@chromium.org>
 <7ab74b32-441d-1a1a-0112-6c4d0c0b900c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab74b32-441d-1a1a-0112-6c4d0c0b900c@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/06 15:04), Hans Verkuil wrote:
[..]
> > +static bool verify_consistency_attr(struct vb2_queue *q, bool consistent_mem)
> > +{
> > +	bool queue_attr = q->dma_attrs & DMA_ATTR_NON_CONSISTENT;
> > +
> > +	if (consistent_mem != queue_attr) {
> 
> This is the wrong way around!
> 
> It's much better to write it like this:
> 
>        bool queue_is_consistent = !(q->dma_attrs & DMA_ATTR_NON_CONSISTENT);
> 
>        if (consistent_mem != queue_is_consistent) {

Hmm... That's a great catch. Thanks for spotting this.
Puzzled, how come I've never seen problems.

> What concerns me more is that this means that this series has not been
> tested properly. I found this when testing with v4l2-compliance and vivid.

I fully understand your concerns. Give me a moment to figure
out what's going on...


OK.

Apparently, the user-space I'm using for tests, utilizes different
call path. vb2_core_create_bufs() is never even invoked. Hence queue
consistency vs. request consistency checks are not performed.

What happens, instead, is v4l_reqbufs()->vb2_core_reqbufs() path.
It orphans existing buffers (if any), sets queue memory model, sets
queue consistency model (DMA attr), then allocates buffers.

On my test environment, I see that vb2_core_reqbufs() orphans the
buffers, but it's always due to "*count == 0 || q->num_buffers != 0"
conditions. The user-space I'm using does not twist queue ->memory
or consistency attr, so the tests I'm running are limited in scenarios.

verify_consistency_attr() is not on the list of reasons to orphan
allocated buffer. It probably should be, tho.

===
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index afb3c21a5902..d6b1d32bef3f 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -730,7 +730,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	if (*count == 0 || q->num_buffers != 0 ||
-	    (q->memory != VB2_MEMORY_UNKNOWN && q->memory != memory)) {
+	    (q->memory != VB2_MEMORY_UNKNOWN && q->memory != memory) ||
+	    !verify_consistency_attr(q, consistent_mem)) {
 		/*
 		 * We already have buffers allocated, so first check if they
 		 * are not in use and can be freed.
===

> > +		dprintk(1, "memory consistency model mismatch\n");
> > +		return false;
> > +	}
> > +	return true;
> > +}
> > +
> >  int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
> > -		unsigned int *count, unsigned requested_planes,
> > -		const unsigned requested_sizes[])
> > +			 bool consistent_mem, unsigned int *count,
> > +			 unsigned requested_planes,
> > +			 const unsigned requested_sizes[])
> 
> Use 'unsigned int' in the two lines above, as per checkpatch suggestion.

OK, will do.

This comes from the original code. There are 'unsigned'-s in the
existing code, I saw it and didn't want to modify, in order to keep
diffstats shorter.

	-ss
