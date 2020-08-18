Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03540C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09E920786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QjKJC3iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHRSNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHRSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:13:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB12C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:13:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so23217692ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RQfII6OqeocrTsbvngYvMEa5UN4ejkr0mhyGFMVV2I8=;
        b=QjKJC3iySsR8dz9ujNbGV5R10NnYiIbC/ryuhLdDQ9lgembtRbnqd4a0rdupEFVNlO
         yRwVn/5c82oryEoP9IEFcAg2+OObKL4tpoCfLlbSvPsQSi9V3W+gYd3n22c7aeTWqUZE
         tRn061KbpJ0SCBNooN8wut1QHG5cL3tbUe6Pt3QP+VqoScwBCLld3dsgWBuvXcRk/Zno
         8ajUIavPu7lx0uCaekPWbGEFzIjUPZGNBK0W/azNUVe4a0RwbjdN/SaDRP8Lb5srL6yI
         cpeIjqzOwz4vsjTC677/uzbksSNx4G56hZao9qJC5bQWU6CwMNYCo1w37BAfITjdzW/1
         Sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQfII6OqeocrTsbvngYvMEa5UN4ejkr0mhyGFMVV2I8=;
        b=hX3qfZSYfEXMhI5YzdNYeRN3K40VTZsvUDDI8Wwtc6gG0xSUgSeWEHkmal8eCkvTmB
         XqQ58zCNsTMagF972+vIQtu6V/tpBn+cqZS2BcpwXlA6UMQ9qlW1qjZem9z0eMk18Qvy
         diMAQalYxZK1U7sdHM4+HqVjPoQxDdMXILVKHMcOXq+mhQNfxo5prAeLu181DgtKevgk
         Ibfa516ADOFiHTZOrgYRidFSL+2neoh3GSllZ2oNEBdALKU9x5zrFmqVQlE3GzzBjGyj
         P6fmPWfb8U6WMZyy4isCfmyMoKFOKuU7b5B4XluzlIla0TeVO0y8PAQBQSYwX4v2Lbor
         csVw==
X-Gm-Message-State: AOAM531A/XkBc1SDu/GzI3S6/kvnGWQc67Z2Ru/9O5QiLyR6BViOMUIs
        TnsYHNyMJHmnYhDd02M+RUkTQA==
X-Google-Smtp-Source: ABdhPJyYTxGFLxcDuRDg/n92S6zWZuddbv3ZZNTVHZ8bxifAUCxXKO7s2DdTeLc9TBdj2q5NzpZHLg==
X-Received: by 2002:a17:906:bccf:: with SMTP id lw15mr22472412ejb.415.1597774390879;
        Tue, 18 Aug 2020 11:13:10 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id w18sm16870282ejf.37.2020.08.18.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 11:13:10 -0700 (PDT)
Date:   Tue, 18 Aug 2020 20:13:08 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818181308.7g3xom4lxwuoogev@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
 <20200818173936.GA3097355@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818173936.GA3097355@dhcp-10-100-145-180.wdl.wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2020 10:39, Keith Busch wrote:
>On Tue, Aug 18, 2020 at 07:29:12PM +0200, Javier Gonzalez wrote:
>> On 18.08.2020 09:58, Keith Busch wrote:
>> > On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
>> > > a number of customers are requiring the use of normal writes, which we
>> > > want to support.
>> >
>> > A device that supports append is completely usable for those customers,
>> > too. There's no need to create divergence in this driver.
>>
>> Not really. You know as well as I do that some features are disabled for
>> a particular SSD model on customer requirements. Generic models
>> implementing append can submit both I/Os, but those that remove append
>> are left out.
>
>You are only supporting my point: if your device supports append, you
>get to work in every ZNS use case, otherwise you only get to work in a
>subset.

There are several devices. Some of them enable append and some do not. I
would like to support the later too.

