Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CDA21582
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="GgswrjSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgIGUTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgIGUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:19:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD621C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 13:19:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so14917104ioa.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6SpnhZsf85q4UgRCG3Vo1DStgFyYS4tfVeyEumkN/w=;
        b=GgswrjSOmPdUZ/BwDCdcWalN4y5WoQPbMec/SdCWEVJcYKNu64D9s8oHItvqe5USmk
         9DzBKzjfZOYqkrFvd6uDgVBqFvLBcAp47ZAw2Gj9EBRXq4IYQ8JUK1GLjOo/E7oSVx/O
         VKNWeMREdjMFPxlkxzHpkQGznhdwAw2yq006+gGaYPeW7M8JmCFrH1Ja3sTOnkVYMYMl
         oJJ5Hxuz82AiRLoFxOJuRTyoERq0vzrpvKHe4mhB/oAwd4qJyrGo/Ie4XZrMjCFsb+Gz
         +YX46uxsLhKyjMfnYvlZ7dlL4eBmh2LnQCxNxzzQSAZANFCzqDmoNh71XxL/lx44mEYD
         XfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6SpnhZsf85q4UgRCG3Vo1DStgFyYS4tfVeyEumkN/w=;
        b=Y8hvXs2vFHKqBmQCai9GksFLOwHY5KeXC8GZSu8ANeLQb0/ubAFQveFuc1M221f2EE
         rEIewgIW8V/kEPE2JgOsSUbL+Tl0+LMrvViYnaU4ZdeQIhfAMM4eBNIFgYKMQfcVfcFX
         G0MzBXzuQxvk6uwui0elsVDGWErXVorONjVSwfjeFubZgYhdN/A5AhrFJ+1bG/Til9hz
         iA8wM00D5R28LOuaNX9UgHu3RGdps6AOnTTAndIL5HU3OYbd4JRn9KAV7l7LoEw7pg4i
         LSx5IRNZOQm4OsqWIVDEgEBoqayvjTIbL9F0UwGR4L410Bhrmx9AKIBBGWeXn2AJcHLI
         C15g==
X-Gm-Message-State: AOAM532IvfaoVlBzPcBmqWUxUPqAzBSMGqAhMm1R8Nicj/YbdAGq9Ysm
        il47w7yPRwDcJYbo+yU7ByfQBD1Xw2KXsaPQBnp/Ln/OPJsJgA==
X-Google-Smtp-Source: ABdhPJzwhdIL/3axB52LwFoeoHQzxXf0VSwxulEuEKbcmU9BKXPq4QXupZG6DlbYmrUcNskmfspcKM2Ls6KufI/R4cc=
X-Received: by 2002:a02:4b07:: with SMTP id q7mr6204438jaa.84.1599509940899;
 Mon, 07 Sep 2020 13:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200903201839.7327-1-murphyt7@tcd.ie> <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
In-Reply-To: <20200907070035.GA25114@infradead.org>
From:   Tom Murphy <murphyt7@tcd.ie>
Date:   Mon, 7 Sep 2020 21:18:50 +0100
Message-ID: <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in dma-iommu
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 at 08:00, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 03, 2020 at 09:18:37PM +0100, Tom Murphy wrote:
> > Disable combining sg segments in the dma-iommu api.
> > Combining the sg segments exposes a bug in the intel i915 driver which
> > causes visual artifacts and the screen to freeze. This is most likely
> > because of how the i915 handles the returned list. It probably doesn't
> > respect the returned value specifying the number of elements in the list
> > and instead depends on the previous behaviour of the intel iommu driver
> > which would return the same number of elements in the output list as in
> > the input list.
>
> So what is the state of addressing this properly in i915?  IF we can't

I think this is the latest on addressing this issue:
https://patchwork.kernel.org/cover/11306999/

tl;dr: some people seem to be looking at it but I'm not sure if it's
being actively worked on

> get it done ASAP I wonder if we need a runtime quirk to disable
> merging instead of blocking this conversion..

Yeah we talked about passing an attr to map_sg to disable merging at
the following microconfernce:
https://linuxplumbersconf.org/event/7/contributions/846/
As far as I can remember everyone seemed happy with that solution. I
won't be working on this though as I don't have any more time to
dedicate to this. It seems Lu Baolu will take over this.
