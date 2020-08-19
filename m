Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C007C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6412420772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0jLXOFs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHSId6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHSId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:33:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:33:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so1233342wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xasR+X+UEQtR9u6qcm8KE/Y6iy5pfp5FFfxCYCX1do=;
        b=0jLXOFs6tYNjlMnwyLPvf7bjt2J75bLyh/fu26NBy6toCtHvAo5zecLkOQkVPdu/Uj
         b2wJw645AJGu1rCM15cMo1uoeOUG/hFFtTL8eR5oZ8Tj6sb7mkI9HSxaz2TLhOCvEsMp
         GI6UjI/WnasfSTcatQ7786KY81sl8xcdk7FkGMkXxhgCL2m6/4LDyz2mTumkqm8Bq71L
         e8nk+0w9pzPhsN1lE0QRrkdTrM7R4dwtniylspCSJpcugB+CV8QPOireyGBbVmes3bmL
         iQKEEt7qNCSTQs7hSHCOXGO7UJPRIM0TcfDC2Vgv+CLqzaDMtVHnyNYgTZa+XP9E7hzf
         IcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xasR+X+UEQtR9u6qcm8KE/Y6iy5pfp5FFfxCYCX1do=;
        b=DaFbaxOxE39R2twZd23TApWimWHklukjkjy428Byr2KBL2D62r06+G5cHzbuwWWXkq
         PuI7rNF2VTwy4E9ObSHvw3YrDcQ8D337yZ1/hlGoWRpmZ9IKmPlpwEWdeQSjzUgbuMS8
         fQcjWugUb1W9BpYjyZP765pJa2inzLI5jHrJxuRSdugDOZm+JzxesM7p5EFHnKh0tYuS
         FC57tuSH/t58QZ/KBFu9bNRlNxiMYAur32Y5Im5DEtoXTvH6QZzGkYY9RGRz3Dh9g4OU
         bztBuPzo7JTWZc5udrrSn4rfh7i6mHWocscFD5gsseP32t92tsDzjh4DZWJbZ/RFAS4X
         aiag==
X-Gm-Message-State: AOAM5311Quum5n3486n6wOv4HY+nx/2A1xHSTOi6P93NXt6trzj6rNNf
        YE7eVxCyqciRq54TM2r2jey2hA==
X-Google-Smtp-Source: ABdhPJymHDpawgsT57RrkKK+R5UwTu/3ozzwA2cjMzvyw/HybeFPB5Gl8lnIb3WaylDaezP8/fNn5g==
X-Received: by 2002:a1c:a446:: with SMTP id n67mr3724574wme.174.1597826035879;
        Wed, 19 Aug 2020 01:33:55 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id 68sm39096068wra.39.2020.08.19.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 01:33:55 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:33:53 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819083353.rwblagiesocfcq7i@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200819074035.GA21991@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.2020 09:40, Christoph Hellwig wrote:
>On Tue, Aug 18, 2020 at 08:04:28PM +0200, Javier Gonzalez wrote:
>> I understand that you want vendor alignment in the NVMe driver and I
>> agree. We are not pushing for a non-append model - you can see that we
>> are investing effort in implementing the append path in thee block layer
>> and io_uring and we will continue doing so as patches get merged.
>>
>> This said, we do have some OEM models that do not implement append and I
>> would like them to be supported in Linux. As you know, new TPs are being
>> standardized now and the append emulation is the based for adding
>> support for this. I do not believe it is unreasonable to find a way to
>> add support for this SSDs.
>
>I do not think we should support anything but Zone Append, especially not
>the new TP, which is going to add even more horrible code for absolutely
>no good reason.

I must admit that this is a bit frustrating. The new TP adds
functionality beyond operating as an Append alternative that I would
very much like to see upstream (do want to discuss details here).

I understand the concerns about deviating from the Append model, but I
believe we should find a way to add these new features. We are hiding
all the logic in the NVMe driver and not touching the interface with the
block layer, so the overall model is really not changed.

>
>> If you completely close the door this approach, the alternative is
>> carrying off-tree patches to the several OEMs that use these devices.
>> This is not good for the zoned ecosystem nor for the future of Zone
>> Append.
>
>I really don't have a problem with that.  If these OEMs want to use
>an inferior access model only, they have to pay the price for it.
>I also don't think that proxy arguments are very useful.  If you OEMs
>are troubled by carrying patches becomes they decided to buy inferior
>drivers they are perfectly happy to argue their cause here on the list.

I am not arguing as a proxy, I am stating the trouble we see from our
perspective in having to diverge from mainline when our approach is
being upstream first.

Whether the I/O mode is inferior or superior, they can answer that
themselves if they read this list.
>
>> Are you open to us doing some characterization and if the impact
>> to the fast path is not significant, moving ahead to a Zone Append
>> emulation like in SCSI? I will promise that we will remove this path if
>> requests for these devices terminate.
>
>As said I do not think implementing zone append emulation or the TP that
>shall not be named are a good idea for Linux.

I would ask you to reconsider this position. I have a hard time
understanding how zone append emulation is a good idea in SCSI and not
in NVMe, when there is no performance penalty.
