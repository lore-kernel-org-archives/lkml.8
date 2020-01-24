Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB1C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DB22464
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hr8PJq/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgAXCEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 21:04:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41414 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbgAXCEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 21:04:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so193977pgk.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 18:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1S858MoZsQGyrUrhXzTxskYBOqX81/i8AYv61kLGHt4=;
        b=Hr8PJq/mLayZKn0DoW3jkuLZ15PRLg9AA1roz320zvf9S7X3P8WlctxYnzZF9/64L2
         Xk1wPSP+Rt6dwC1jD2oCiQ7tegiUB8UrPUZzYwhQq6XenFZcijGxbFFgg/um2NKhdHxA
         gUzM2b4C0IhZcR0Q8J4ysEim5QZaTLUG1vwiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1S858MoZsQGyrUrhXzTxskYBOqX81/i8AYv61kLGHt4=;
        b=csidNZilT1IyNtQtPcxL6I2ujHYMfyQ6RZjubaa0m2XECmVfBsk6Jtayh0+S3knMR6
         oAb8x36XMpZQAE4XPaQZukwt5v88DEckJX4t4cC7AG3jdcVI5v9+/leqdyKXFJYn0MEO
         OPnJF+HCcOA2I2JYgV5qm1jN0LcRiskLt7gYLD/DOBzpUZfB6IwBVXVkQqFbDSlkoH0T
         NzdX1W0fW6QpFCbmkRrx24xRITNnEQ7DBieBGVG5+gX4TWSVvhorb0MvD9aVU9oAP4/a
         X5p0NwsXg8HI5YLk3vzTfQbVSdj+EH2tJfb5/d9O7qrjY83DWgKgVfql6C5Ib3m3MEJ4
         cDpA==
X-Gm-Message-State: APjAAAWmZUQryexPaNKC6sRIPkn3f9o9cjuNO43efdtS6CqzE2JEPqfw
        ToVbKSHOGoXQeuP/iDmDguOFmw==
X-Google-Smtp-Source: APXvYqx5diurX3Jh52Gn0AHqShTKpZmEwrnkj13TOuX7hTvJwFtpkyk3RGqax2EkexqAnYoT2UG0KQ==
X-Received: by 2002:a62:b418:: with SMTP id h24mr1181412pfn.192.1579831443389;
        Thu, 23 Jan 2020 18:04:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id a6sm4145702pgg.25.2020.01.23.18.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 18:04:02 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:04:00 +0900
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
Subject: Re: [RFC][PATCH 04/15] videobuf2: add queue memory consistency
 parameter
Message-ID: <20200124020400.GC158382@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-5-senozhatsky@chromium.org>
 <77ddd5cd-affc-ad0f-829d-d624f9798055@xs4all.nl>
 <20200122020555.GD149602@google.com>
 <8d61a2b6-4540-2dd1-309c-93d4cfa8cbcd@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d61a2b6-4540-2dd1-309c-93d4cfa8cbcd@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/23 12:02), Hans Verkuil wrote:
> On 1/22/20 3:05 AM, Sergey Senozhatsky wrote:
> > On (20/01/10 10:47), Hans Verkuil wrote:
> >> On 12/17/19 4:20 AM, Sergey Senozhatsky wrote:
> >>> Preparations for future V4L2_FLAG_MEMORY_NON_CONSISTENT support.
> >>>
> >>> Extend vb2_core_reqbufs() with queue memory consistency flag.
> >>> API permits queue's consistency attribute adjustment only if
> >>> the queue has no allocated buffers, not busy, and does not have
> >>> buffers waiting to be de-queued.
> >>
> >> Actually, you can call vb2_core_reqbufs() when buffers are allocated:
> >> it will free the old buffers, then allocate the new ones.
> >> So drop the 'has no allocated buffers' bit.
> > 
> > Well, the wording, basically, follows the existing vb2_core_reqbufs()
> > behavior "queue memory type"-wise. What I'm trying to say:
> 
> How about this commit log replacement of the first paragraph:
> 
> "Extend vb2_core_reqbufs() with queue memory consistency flag that is
> applied to the newly allocated buffers."

Looks good.

> The bits about 'only if the queue has no allocated buffers, not busy, and does
> not have buffers waiting to be de-queued.' is really irrelevant and confusing
> (at least to me!).

Agreed, those bits describe implementation details which can change.
Better get rid of them.

	-ss
