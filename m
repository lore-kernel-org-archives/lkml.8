Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24494C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F268C206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAvytVLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHNT5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:57:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8969C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:57:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t7so8530116otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/HUkdNM84ljYVpfdQwsu/yQY6q4YRBxXm3BX9/rPigE=;
        b=GAvytVLoP1qHrSPjrY7AvPriL14EDS2LCXNorZdppdkMv6K/LZxo1h/EuzLi3SXVNi
         M6CS7DnFvAbtqX+J63O3C1V6T9+yKxrKLzx/qaF9zojFvtZ8gB2P5UK68H33Hph3w1cP
         dr0yOx7Q3ZzaJoXZYJrk8JcCCA9mJ1SGOKUITcQlZtslndFbmIqY5xDddbNqu0KwQmHn
         g7lYfVLtQMLwcrAPGlizolRKf6l8oAHACQ+K7IqCHagXujF9UeIYMDCY+YvAWGTADUPH
         YDzE5+swXhEtYXl2xOwaJ2MLIJ1aXEFutNfWQSZTIwGLAoDuMWsi8fyNc7BLEg2HknkV
         xG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/HUkdNM84ljYVpfdQwsu/yQY6q4YRBxXm3BX9/rPigE=;
        b=Btv8WeHlV49f35LAUZfBQID+L4YJQQdMrpK1vfwXsLT2yK5Wn2/GF5yMcGE9PdCNv2
         374IoQYdXBRJrQ1Pn/nx3UakkLuED06uC6iFuqwtBMu55AW9fDzZJNGDm+hGVKvq6Xik
         fGVT6K2KXoHkhCd1SFKKDb2KWKTX4HvUgn9y68iDX0FcZj+r1XmLq3Brb7OhtWZXlWQ0
         0GmX3eVOtjxb3xfpNFjwxAIa5VCdxwHUiGwfjJ9+lorWIFT3RZbZ+6eAWUMtd1TPoCeT
         LFbXbVmZzptVTtTkAsdotBdCPREOPn3EYXqYzBTDJGTF1G0taF8krWR3+tguhPG076Fp
         0yXA==
X-Gm-Message-State: AOAM533zSAtoz655RcMEAiU1v5ZCzsPRqt1TGADDwNih/XntSrcj7qr4
        yWizJv3SOdev4+QUwhbGHi9hTjfLOzHDMwAtAqgR/A==
X-Google-Smtp-Source: ABdhPJzaxdfMlB6Bm1WN+v5lpzzD5kVu7pW83mo4jMtukonjI/VP7GLaCaH0UsUwHhBd8Q1OWNYhXdAlBVPuN5eETs4=
X-Received: by 2002:a05:6830:3196:: with SMTP id p22mr3306479ots.102.1597435054060;
 Fri, 14 Aug 2020 12:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200814062458.53049-1-john.stultz@linaro.org>
 <20200814062458.53049-2-john.stultz@linaro.org> <20200814091713.GO2352366@phenom.ffwll.local>
In-Reply-To: <20200814091713.GO2352366@phenom.ffwll.local>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 14 Aug 2020 12:57:22 -0700
Message-ID: <CALAqxLV6pRJRrZOZm0iMxNxCua2+_YQM9YC91UkQboRagRb98g@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 2/2] dma-heap: Add a system-uncached heap
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>, Laura Abbott <labbott@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 2:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Aug 14, 2020 at 06:24:58AM +0000, John Stultz wrote:
> > This adds a heap that allocates non-contiguous buffers that are
> > marked as writecombined, so they are not cached by the CPU.
> >
> > This is useful, as most graphics buffers are usually not touched
> > by the CPU or only written into once by the CPU. So when mapping
> > the buffer over and over between devices, we can skip the CPU
> > syncing, which saves a lot of cache management overhead, greatly
> > improving performance.
> >
> > For folk using ION, there was a ION_FLAG_CACHED flag, which
> > signaled if the returned buffer should be CPU cacheable or not.
> > With DMA-BUF heaps, we have no such flag, and by default the
> > current heaps (system and cma) produce CPU cachable buffers.
> > So for folks transitioning from ION to DMA-BUF Heaps, this fills
> > in some of that missing functionality.
> >
> > This does have a few "ugly" bits that were required to get
> > the buffer properly flushed out initially which I'd like to
> > improve. So feedback would be very welcome!
> >
> > Many thanks to Liam Mark for his help to get this working.
> >
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Andrew F. Davis <afd@ti.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Laura Abbott <labbott@kernel.org>
> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > Cc: Hridya Valsaraju <hridya@google.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Fix build issue on sh reported-by: kernel test robot <lkp@intel.com>
> > * Rework to use for_each_sgtable_sg(), dma_map_sgtable(), and
> >   for_each_sg_page() along with numerous other cleanups suggested
> >   by Robin Murphy
>
> Mildly annoying me, but where's the userspace for this? Do we have a
> gralloc somewhere that works with open driver stacks and uses this?

So this is still early RFC, but I've added support to the HiKey960
gralloc, and have pending patches (following DRM rules) I pushed here:
  https://android-review.googlesource.com/c/device/linaro/hikey/+/1399519

And avoiding the cache syncing overhead improves performance nicely on
that board.

There is also work in progress to change the codec2 implementation in
AOSP (which uses ion directly), to move over to DMA BUF heaps and as
it used the !ION_FLAG_CACHED case there this heap would be useful to
match ION's functionality.

The latest patches for that are here:
https://android-review.googlesource.com/c/platform/frameworks/av/+/1360640
(though I'm expecting a deeper rework on those)

thanks
-john
