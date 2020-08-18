Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A025C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08198206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="VGG8e8rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRSEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:04:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E32C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:04:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so23179250ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9QKHAAhm+KHbU8GvfwEcJcQk8+bGHLCS9A3L1Qovm7A=;
        b=VGG8e8rBUgq+wusx/5EpYei3LvUG/TzyKXGTkFmQlZox64SQJpa8yzW6cABSCc8tl9
         Xj10mwbxIwfc7qhjaZEjJv80G9y72NzVloYSjUtIBWsCZhfZLnVYyqjAL8/L0/ATptea
         IsGtx7Kuu5bfYicNTN5Zqm5mB9fJS1lE0L66KvlTsp+kGshLB92uyJCVAYm1ybPSui1G
         GinoO7B/egjpxEKzsYG7w6f/HY62ksQdhNtJr4lcIrQKRJdte+9EfyKY2yIbZPvVG2Tm
         hdFCB3bZd0MBnuvtkEWS6rRx+WRSFZ/UX6BiJJu0EL//1et+Rwz1T6upGLLOsclBlq2M
         Ixaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QKHAAhm+KHbU8GvfwEcJcQk8+bGHLCS9A3L1Qovm7A=;
        b=CqaHNvF8imhnk3awRkdZWmxvByhxciDgvMVBZmlrueAE+5Jo0WK6IVxWRtUu7ONCOg
         5KNQpJirJKzxPLs7W02xmigsYtsZg48djqCJ7arWlz+WP1oL3H3LrCqxMovvPakIX9LP
         3+eCub+Yl9RsVrgzO5lN2+usH8uezcles1mImnGc6Mnhfom2OQgF6WYg/vZc2EhAPXCt
         o1y2A35WMqiuYP/s01H7FbzP0vL3Nf7PkSs662voRPPoahrqggwVNmB1W2knqrzX7A4f
         9Dm95t7XPEC4CSOTqtD/FvQxC0nRj4DonY4HADoJt4LZtxN/26thIWr6xSebH+bIUSny
         c/SA==
X-Gm-Message-State: AOAM531+jLTS12F5wpVC1e9vem5TnuCEygLUMc8cxbJPGGoBK2dLUkvw
        Beg16x8WK+MmXqohU1dV/QfrtA==
X-Google-Smtp-Source: ABdhPJwO6PKA3P3xfj7/VKQ3x1v6vyAybcvAhV4ThQFQ5n+UhteH3ABWbvLTiFrMZIsbOxdBmTd0LA==
X-Received: by 2002:a17:906:b082:: with SMTP id x2mr22293779ejy.349.1597773870344;
        Tue, 18 Aug 2020 11:04:30 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id pj19sm16819555ejb.66.2020.08.18.11.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 11:04:29 -0700 (PDT)
Date:   Tue, 18 Aug 2020 20:04:28 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818155004.GA26688@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2020 17:50, Christoph Hellwig wrote:
>On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
>> I understand that the NVMe process was agitated and that the current ZNS
>> implementation in Linux relies in append support from the device
>> perspective. However, the current TP does allow for not implementing
>> append, and a number of customers are requiring the use of normal
>> writes, which we want to support.
>
>The NVMe TPs allow for lots of things, but that doesn't mean we have
>to support it.

Agree. As I replied to Keith, I am just interested in enabling the ZNS
models that come with append disabled.

>
>> Do you have any early suggestion on how you this patch should look like
>> to be upstreamable?
>
>My position is that at this point in time we should not consider it.
>Zone Append is the major feature in ZNS that solves the issue in ZAC/ZBC.
>I want to see broad industry support for it instead of having to add more
>code just for zone append emulation than actual current ZNS support.  If
>in a few years the market place has decided and has lots of drives
>available in the consuer market or OEM channels we'll have to reconsider
>and potentially merge Zone Append emulation.  But my deep hope is that
>this does not happen, as it sets us back 10 years in the standards of
>zoned storage support again.

I understand that you want vendor alignment in the NVMe driver and I
agree. We are not pushing for a non-append model - you can see that we
are investing effort in implementing the append path in thee block layer
and io_uring and we will continue doing so as patches get merged.

This said, we do have some OEM models that do not implement append and I
would like them to be supported in Linux. As you know, new TPs are being
standardized now and the append emulation is the based for adding
support for this. I do not believe it is unreasonable to find a way to
add support for this SSDs.

If you completely close the door this approach, the alternative is
carrying off-tree patches to the several OEMs that use these devices.
This is not good for the zoned ecosystem nor for the future of Zone
Append.

Are you open to us doing some characterization and if the impact
to the fast path is not significant, moving ahead to a Zone Append
emulation like in SCSI? I will promise that we will remove this path if
requests for these devices terminate.

