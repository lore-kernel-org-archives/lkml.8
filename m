Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABF8C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600A624672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="udinrWQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgBSJLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:11:45 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:48735 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgBSJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:11:45 -0500
Received: from [192.168.2.10] ([46.9.235.248])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 4LONjze0uP9a94LOQjnfLP; Wed, 19 Feb 2020 10:11:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582103503; bh=xsN8vhfHa7tW/G+6aX+0P4BNgzapyUwsBGOb49UIpYU=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=udinrWQOgb62fcBFlTUaRKjgx4/5BXVbXBc0URjtyG0AazxHRKsVcmiXkrJYHWsAd
         sd1iA8eHUhHmh0huM+aJGJ6gFNUp/sWnBvhjC7aXVImmnvoRGVP9huDG+1ujiU53QU
         NzZEyDtSIfQW/5UTrfxOQXppJ8vi4/JkoAPxKDb9Gbb+YWtTD/Ovta0KSulMYbHJ0a
         sqsO9NHhQGscck6tlVgaGMRxuQtiYwLBw5zU1icY8ltrM/ncbyxQsOlYwYAUFnWRgT
         GqRbQI5wMkCdRZ8BvRkl25v0WQGLhvC734MIYLk4U8EQhln4I7xLLed/INo8jYOiWD
         9XBO3t0xa0iUw==
Subject: Re: [RFC][PATCHv2 05/12] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <20200204025641.218376-6-senozhatsky@chromium.org>
 <83147032-25a4-9450-d455-437e82e09dc8@xs4all.nl>
 <20200219090547.GF122464@google.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9bd88d23-9c4f-05dd-2514-b7c46f03a578@xs4all.nl>
Date:   Wed, 19 Feb 2020 10:11:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219090547.GF122464@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNLD2qyH4WWBgDvGKIxeVc0YKijOhw/xXNM0IXvd+FD9r53kiC1OnbaA/pniGBduWa7/ZNwXVVZMK3ohTj75fe2FP/wA89cPd7km2yn79QqCRumHXpRS
 6PGtrwWptkDkSVqmuTfUeWLWOhmAmsqK6QaGRKFcgQcgmZAFuuwLLBBTo4RYC+xrWLAsIKHkhzzhFaFpyUOAXBDr4OPUAvpcW/haVl+EWfziSVXpSJdUO2+W
 fQbRDpVq3N5tK3tm/g/0Cby0wY6yTvja2B4L6R8RpRDMbqMbvOfhzbq72N6mllfXUp6tG4aqoS+k3AZG4vB12m5dBBbnaqbJJtX5/stnqxYf/tg7Sk6QLmgt
 eiRW+/dZ7W+0x22vr7FxEzkl4Fg/SENWrSCQoKKZ+YKzyTNQDYVcr0SQiPmh6fxZJNHxQYAX8wA0r2a0a5BBh7kZbZA+26UUyNGmbjXPWj1OuPZDd9St/8z2
 NBm0hmc+c+bgSTdaw7QNL/nLyoLHEFDqrqCN4s6ISfKEz+0eFosRNva2zuImI7/4XoMdIdxBFpR9PAnN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 10:05 AM, Sergey Senozhatsky wrote:
> On (20/02/19 09:48), Hans Verkuil wrote:
> [..]
>>>  int vb2_reqbufs(struct vb2_queue *q, struct v4l2_requestbuffers *req)
>>>  {
>>>  	int ret = vb2_verify_memory_type(q, req->memory, req->type);
>>> +	bool consistent = true;
>>> +
>>> +	if (req->flags & V4L2_FLAG_MEMORY_NON_CONSISTENT)
>>> +		consistent = false;
>>
>> There is no check against allow_cache_hints: if that's 0, then
>> the V4L2_FLAG_MEMORY_NON_CONSISTENT flag should be cleared since it is
>> not supported.
> 
> The check is in set_queue_consistency()

That's the check against the functionality. I'm talking about the API level:
if !q->allow_cache_hints, then clear V4L2_FLAG_MEMORY_NON_CONSISTENT from
req->flags so that, when the ioctl returns to userspace, the application can
tell that that flag was rejected.

Regards,

	Hans

> 
> static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
> {
> 	if (!q->allow_cache_hints)
> 		return;
> 
> 	if (consistent_mem)
> 		q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> 	else
> 		q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
> }
> 
> I don't explicitly clear DMA_ATTR_NON_CONSISTENT attr for
> !->allow_cache_hints queues just in case if the driver for
> some reason sets that flag. ->allow_cache_hints is, thus,
> only for cases when user-space asks us to set or clear it.
> 
> 	-ss
> 

