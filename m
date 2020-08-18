Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB9DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C74520658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0e9Zniyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgHRR3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:29:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6FFC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:29:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs17so15907769edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3/0UrSCWdiUFQjlCmwTT+sDLdgmMCbkkvjiVvm/Zb4Q=;
        b=0e9ZniydNVaI5+0HNp4JTj3vU9pqBMNjVOiGh3ElOE5Ouu6Ediz5A/BEtJaR8Yvadb
         C4WYUsAkrOXygNOwvi5dDs9VkD0FWK2suynMdogo87lgbhuPrF/lx8iymwJ/dkP0ZdPT
         bYrooWf1aJmO6wNkqGTI0tLWXJhyg/lh2lp3I39BrVspTnnihjy0E3Fi1rSF9F2smTSP
         tQcLx+EAsEWbVzaOiMsflFvTE74JcTRj6UETYLxS4QhgIf8dlDRdAd4Du4bokDZJuvDv
         naDhBGIim5OWIpqv/ztnr7J/BT2RHKRabHTRXBw076UJhXZoS0Uf3BPhWuX4h7oQg84x
         NvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3/0UrSCWdiUFQjlCmwTT+sDLdgmMCbkkvjiVvm/Zb4Q=;
        b=gJ1uL2WPQC05hfxuriMH/RBNY+wGnUi/fvJ3CA9NZUrudoXWO80XOvlKRen6PQcZJd
         G0nZN1lX96y4LY42Z96XJ75Oemv7YP9IBsuaSxMy0BQ4Y1e2+mA72hKtm0t4hhvT+VlI
         M/KdrUvIbNHunwPS5V5juEd++SSDSUKCVr17WGZZ5CojrE/BpNApXOsSyuR9Q3b8URcU
         E8QlRsmQJC/CDfita87Nis88GjBiA91GNNOw92kDzWBZrr3osqyRGoILX+GgSoz2N22P
         ik2OHKg1QKa4VElTruAZBIG2iXwQFm1HMELAjNEyjX1Vql8nHKpOFRmlfe5gLqPw8xUH
         /4Xg==
X-Gm-Message-State: AOAM530rCGmXa4HxZ/eQeTFxlD6bKFS/WxJYroKQQHXKUUnmVvliV+uW
        IGkAERGippvYirNPYq+yke/NjQ==
X-Google-Smtp-Source: ABdhPJzlBOCe1lDdHrtT3awmcFNNz4BOC3NXuiv9YMW6pUkc5e3zSKPkQFenrYEnw9XSdDgkG1B4Vg==
X-Received: by 2002:aa7:db10:: with SMTP id t16mr20427706eds.196.1597771753518;
        Tue, 18 Aug 2020 10:29:13 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id l23sm16763331eje.46.2020.08.18.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 10:29:12 -0700 (PDT)
Date:   Tue, 18 Aug 2020 19:29:12 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2020 09:58, Keith Busch wrote:
>On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
>> a number of customers are requiring the use of normal writes, which we
>> want to support.
>
>A device that supports append is completely usable for those customers,
>too. There's no need to create divergence in this driver.

Not really. You know as well as I do that some features are disabled for
a particular SSD model on customer requirements. Generic models
implementing append can submit both I/Os, but those that remove append
are left out.

I would like to understand how we can enable these NVMe-compatible
models in Linux. If it is a performance concern, we will address it.

