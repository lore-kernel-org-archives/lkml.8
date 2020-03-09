Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C41C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ED421775
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3WN25EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCII7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:59:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33280 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCII7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:59:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so5153579ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MG0G5ZM/wX8CaZyeU/fpD8KUA94fOQlRfkktDxmU/VY=;
        b=U3WN25EUkAWvSE7VElZWdqDN1xMk931nL+jwh0Mxcx7ZGNsLo1O5NJnEK1z/saX/rF
         bz/nkRI4IXFZ//hrWk3qJepb99x37E1NoKKNl4gGRVIVYWxKF3iSpDy8XcJZXetfkuOm
         2SdDtBgZydtf4zE950KJH13R3NbSb2ncv1qkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MG0G5ZM/wX8CaZyeU/fpD8KUA94fOQlRfkktDxmU/VY=;
        b=aib4WdmXPcqYO8xnq34s9X0TGsiXne426L2YRlT8IIjLoVmjOQXsEDWUiRpQygUHTa
         YiD2Vl/sM+RlxjVtT5m3rMu9U0uFcgZ23w9o0LvN0jRyc8KS+B9vn3o2EgR3MUDeQTnh
         /YbcLMDaAoBeCDIkT4T3jeGL0gBwFC3lPA9OVd3kQitWv4G860BWHEk9Uv07Q9S2FUZx
         ku7APqHQNLXwJiS6UcvbefeN5XEkGFdM1AsNbtVqYqVSvUd7OFc+HitHC2oNNW8GFo/W
         sEznWN+O52vPopQJSLY/z18JVp9m80yaR6E8XvQpdP0waO8QarrNSWfT4mi1DGyVHYm5
         LYCQ==
X-Gm-Message-State: ANhLgQ0pb4IDMtFbtQFcEmu6pvn170WLZOymsv0w7kgSLqkMS6NEFsFL
        gosoZiwUQ/vJPC/YjLdSpoJMmiyccvQ=
X-Google-Smtp-Source: ADFU+vs8RSO2K9Wladnkc8NTJgwJeppDH8t8tnU0rxqrZo7Ad6rszqLLm6fJWcZkITDIfrWiWLqNWA==
X-Received: by 2002:a17:906:724a:: with SMTP id n10mr14142474ejk.35.1583744348998;
        Mon, 09 Mar 2020 01:59:08 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id f4sm2820595edr.39.2020.03.09.01.59.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 01:59:07 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id n2so2192333wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:59:07 -0700 (PDT)
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr3188338wmj.183.1583744346889;
 Mon, 09 Mar 2020 01:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-2-senozhatsky@chromium.org> <17060663-9c30-de5e-da58-0c847b93e4d3@xs4all.nl>
 <20200307094634.GB29464@google.com> <6f5916dd-63f6-5d19-13f4-edd523205a1f@xs4all.nl>
 <20200307112838.GA125961@google.com> <a4d85ac3-0eea-bc19-cd44-0c8f5b71f6bc@xs4all.nl>
 <20200309032707.GA9460@google.com> <40cd09d9-49a6-2159-3c50-825732151221@xs4all.nl>
 <20200309072526.GC46830@google.com> <e31197b6-5d22-0c3a-cc77-e9506136ada5@xs4all.nl>
In-Reply-To: <e31197b6-5d22-0c3a-cc77-e9506136ada5@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 9 Mar 2020 17:58:54 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ajopb019HZmtNJfDZmZbssDHfztmT0BvAD07QttXmZ1g@mail.gmail.com>
Message-ID: <CAAFQd5Ajopb019HZmtNJfDZmZbssDHfztmT0BvAD07QttXmZ1g@mail.gmail.com>
Subject: Re: [PATCHv4 01/11] videobuf2: add cache management members
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 4:28 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 3/9/20 8:25 AM, Sergey Senozhatsky wrote:
> > On (20/03/09 08:21), Hans Verkuil wrote:
> >> On 3/9/20 4:27 AM, Sergey Senozhatsky wrote:
> >>> On (20/03/07 12:47), Hans Verkuil wrote:
> >>>>
> >>>> Create those tests in v4l2-compliance: that's where they belong.
> >>>>
> >>>> You need these tests:
> >>>>
> >>>> For non-MMAP modes:
> >>>>
> >>>> 1) test that V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS is never set.
> >>>>
> >>>> If V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS is not set, then:
> >>>>
> >>>> 1) attempting to use V4L2_FLAG_MEMORY_NON_CONSISTENT will clear the flag
> >>>>    upon return (test with both reqbufs and create_bufs).
> >>>> 2) attempting to use V4L2_BUF_FLAG_NO_CACHE_INVALIDATE or V4L2_BUF_FLAG_NO_CACHE_CLEAN
> >>>>    will clear those flags upon return (do we actually do that in the patch series?).
> >
> > [..]
> >
> >>> I'm looking into it. Will it work if I patch the vivid test driver to
> >>> enable/disable ->allow_cache_hints bit per-node and include the patch
> >>> into the series. So then v4l2 tests can create some nodes with
> >>> ->allow_cache_hints.  Something like this:
> >>
> >> I would add a 'cache_hints' module parameter (array of bool) to tell vivid
> >> whether cache hints should be set or not for each instance. It would be useful
> >> to have this in vivid. Don't forget to update Documentation/media/v4l-drivers/vivid.rst
> >> as well.
> >
> > I see. Hmm, how do I do "test that V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS
> > is never set" then?
>
> Not sure I understand your question. When requesting buffers for non-MMAP memory,
> this capability must never be returned. That has nothing to do with a cache_hints
> module option.

Have we decided that we explicitly don't want to support this for
USERPTR memory, even though technically possible and without much
extra code needed?

Best regards,
Tomasz
