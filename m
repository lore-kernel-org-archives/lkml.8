Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C572D2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UkPdi2l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHRKvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRKvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:51:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF516C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 03:51:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so21470319ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Rkmsih4pLhvW6xMZVPj0/Cg05RYVqnHRSrB5uFL0c4=;
        b=UkPdi2l/3+P1oL8XcRlscqOvKuAIbvxk/47ouGJIkvS5WXKAw3ejDijlQv/PKSdTlo
         3Hv372O99LzLkeh5ZB1ZWEs9vvCHLlhX5WcQPqaRxA8Ih6naFsa+8pj84jBdnq5/sCht
         tKLX2HG9g2Cyu4YVjAFt0618GwCMwZAfJB6Xwhzf5Ls460R7nFWPQg+OzhxwIBzFEgfe
         2XNzm4l9XQMx9WkSeGl6uF09cRwtMvyMbuueuVCPvsgM/1vbk2FlGnONaPoRFTGxAbPQ
         PWyafb3/nBb2CpiWHDaoZTrzfgnF4MS6LVfPZHzt3ASNfITY5qzwUTiORMwmAxYXRDjk
         Mseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Rkmsih4pLhvW6xMZVPj0/Cg05RYVqnHRSrB5uFL0c4=;
        b=YSvJ2Z5FWbg7T9ua3Xu+PE8/eEsYy2T2xId27Na8rw+cEoWpAp2kJs687kjKygF6y3
         2ny7ZrdahfSne3nW0QKUT3tnv5bfnsnFBN8z9XlZp2sfnGIyjQcJk13pogYpnT16omXZ
         g6q3umU6P0XomuhGMvwFlpouHX6Vs1neIEQ0Wxv3cmobqe76j3WuAWp1hYeqfTV99xtd
         v20B6HL0VrhiRNeiO1beYBxSiU+5NqPC3gSOeXYXeEDkOiLk8mcEAX5gvBB4Qm+sqn9z
         il7qPawft8g3VNIqs4Qm9qPOUbBxz6PVU+Mh9vn+h6i7a+Clc2eg9uLPk1Y7G3vIkm0S
         zl8A==
X-Gm-Message-State: AOAM530SQZUGsGScMn6UL082U8aQbMZivNY+2NnsccnZ5MtjNcxjmbZW
        JBit1ezgvNNTvT7yBRG5t/Lh8w==
X-Google-Smtp-Source: ABdhPJxgdv6Ng+C9x3oVRi01Nim6IwyhcsnE6wz14aeTHuS/RZlEiu5yNvRUQjVVNJRPQjx/NXzkWA==
X-Received: by 2002:a17:906:3715:: with SMTP id d21mr18969146ejc.281.1597747898486;
        Tue, 18 Aug 2020 03:51:38 -0700 (PDT)
Received: from [192.168.1.11] ([87.116.37.42])
        by smtp.gmail.com with ESMTPSA id y13sm15321730eds.64.2020.08.18.03.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 03:51:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
To:     Javier Gonzalez <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, Damien.LeMoal@wdc.com,
        SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
        Kanchan Joshi <joshi.k@samsung.com>,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kbusch@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4ae89443-d8ae-4efb-581e-b635c21b27de@lightnvm.io>
Date:   Tue, 18 Aug 2020 12:51:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2020 11.50, Javier Gonzalez wrote:
> On 18.08.2020 09:12, Christoph Hellwig wrote:
>> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>>> If drive does not support zone-append natively, enable emulation using
>>> regular write.
>>> Make emulated zone-append cmd write-lock the zone, preventing
>>> concurrent append/write on the same zone.
>>
>> I really don't think we should add this.  ZNS and the Linux support
>> were all designed with Zone Append in mind, and then your company did
>> the nastiest possible move violating the normal NVMe procedures to make
>> it optional.  But that doesn't change the fact the Linux should keep
>> requiring it, especially with the amount of code added here and how it
>> hooks in the fast path.
> 
> I understand that the NVMe process was agitated and that the current ZNS
> implementation in Linux relies in append support from the device
> perspective. However, the current TP does allow for not implementing
> append, and a number of customers are requiring the use of normal
> writes, which we want to support.

There is a lot of things that is specified in NVMe, but not implemented 
in the Linux kernel. That your company is not able to efficiently 
implement the Zone Append command (this is the only reason I can think 
of that make you and your company cause such a fuss), shouldn't mean 
that everyone else has to suffer.

In any case, SPDK offers adequate support and can be used today.
