Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F6C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954C24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mrY+7Knz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgB1Iu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:50:26 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:53905 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbgB1Iu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:50:26 -0500
Received: from [192.168.2.10] ([46.9.234.233])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 7bLgjJlrFjmHT7bLjjmd50; Fri, 28 Feb 2020 09:50:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582879824; bh=Xv6fRxW1D6N2tzhBGhpeBgICfc/EY8yz2dHEhHt/LDw=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=mrY+7Knz/H3ujkVHpz6ay+QOKJWgKfpXzQ0/4ALMh95gg3GabhfGL3qrbFdG4rAEq
         jy6hhQaiVjIGFnqTlJHlumVnBjMwgBegz46ziarr4nwohTqDFGI6w035xYKxeIEHVc
         JhS0Hc1jew8lY2gXWwp8VyezxxbCI9mYwOew7SYctTPFwklTRUXOv4kxKGLLZuZMtW
         Tbe24zrxqOJ+iY018UUbDXc2h+YqbyZ5oNFVU+zuMsLSTGUloFR/1070OwT7RPuA4d
         Ehxs8wx2+5gdmxK1SMchZA+8sqF6d1ZoKs9/LSXQMdfOOALl8SoQWA+2wx6/WawL3O
         6Dh48dtHdbGIQ==
Subject: Re: [PATCHv3 05/11] videobuf2: handle V4L2_FLAG_MEMORY_NON_CONSISTENT
 flag
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
References: <20200226111529.180197-1-senozhatsky@chromium.org>
 <20200226111529.180197-6-senozhatsky@chromium.org>
 <8ea79a02-8346-2b1d-c2d8-3a3b36480320@xs4all.nl>
 <20200228035759.GP122464@google.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7c936a58-7ad9-60a5-1f4a-e86ee358752a@xs4all.nl>
Date:   Fri, 28 Feb 2020 09:50:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228035759.GP122464@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLTNGbK+gMrzKdnJS2vJJQ9w1zjBkvmVCo3zZD0tkJQJl8h0wzKqNQ0niDnICURtyOu4GNoN+ZC4HCh4EH2yjR/+3ZgiU5DMSpKbu+wxgzL3Ak7KWUgc
 v1CfCyBf+tQphHRWkgotjq66YNw18g+vo6Jlc4Nd8s1mHNT4LYfOS6Rcti7Ra3LIi9zjXOyP/XeBeCGzZ6HofcuKbDR5xyeym1jJaDoXvikFGzZadIVSlksy
 Ih+CpuNRWgtChceVBAFCfRgBuSf36S/YSsYYNykRlq6FmuRgFPWRBBp032Uododp2VdD/vbn8zn/3/ly74QSE9xFBdaID94DXwQIiBvvWu9OQHJ+Hsh1NIwL
 fyZY+P3fdFaoMHBWcMMyHdwhdORFEVNJHNSP5fG6OIh0M8A1sjHZbAdsqU2SFsrXy3YYzpCFsw4pd7blLNdAkO/IGiwA42KcG2vcbJODevQIm+9bBCX72qaC
 doFadKw3/n09MmCqetSF5hGbFRmibk0IVyRRQk68iOrlmgRsCD2D2oXrOKfsRMJAro3JGsIAwqbOxWHJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 4:57 AM, Sergey Senozhatsky wrote:
> On (20/02/27 13:36), Hans Verkuil wrote:
> [..]
>>>  	other changes, then set ``count`` to 0, ``memory`` to
>>>  	``V4L2_MEMORY_MMAP`` and ``format.type`` to the buffer type.
>>>      * - __u32
>>> -      - ``reserved``\ [7]
>>> +      - ``flags``
>>> +      - Specifies additional buffer management attributes.
>>> +	See :ref:`memory-flags`. Old drivers and applications must set it to
>>> +	zero.
>>
>> Drop the last sentence, it's not relevant.
>>
>>> +
>>> +    * - __u32
>>> +      - ``reserved``\ [6]
>>>        - A place holder for future extensions. Drivers and applications
>>>  	must set the array to zero.
>>
>> Old drivers and applications still think reserved is [7] and will zero this.
> 
> Just to make sure, does this mean that you also want me to drop the
> "Drivers and applications must set the array to zero" sentence?

Not for the reserved field, only for the flags field.

Regards,

	Hans

> 
> 	-ss
> 

