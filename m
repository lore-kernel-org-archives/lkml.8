Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5017320786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MqABaEdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHRSL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:11:27 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:11:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba10so16001251edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UJn2JSokJqI3bZ4orYuEJrjW3L7HkGjOPI8uUsExMI0=;
        b=MqABaEddV5U7jNhWTNamW1+A8wcSXlLpQCJNnUuoQKGjYyrWrzW8LTsHUFA7RT+bSH
         DF7X8MWOtpMq7uXTQw04MxtDSMVh1SxRfo0KdwfjvY2gt6YobioaGJ2neqr7IAI6SqGQ
         NTNcD8L6vHWV7uEyH7kTiXBK7wBnMD+tvi2cPupLPWRA+8QO0DtZ0LiZGfjG7cHwNBRN
         a/sT69GmrMRL2uecX2mSNBp/JYG8QCzg6mRIAwHn7xF+k1E7BhtgZhcKGE8gc9IuzMAy
         129vfn8fxai1e8/i6u0mxY9iNo2O+EwQrGXqqdpDOQzHVFxMkdBE2NMRO2kUS1Sl78jY
         aDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UJn2JSokJqI3bZ4orYuEJrjW3L7HkGjOPI8uUsExMI0=;
        b=AhgFEB8VdYUKYfdLbDH83VGSrbxQkrGpy9q/OxICDp7Qez9mdvv6TqzT2TTUScUxmh
         N5qpruryUsvGJUQvGYNrh1Ig87NoNGeVKyJ1xMr9ZTSCK2nLlQjjslKLruXoj1V99mpm
         Y+Ju3VkuVN1QLsWckk1lAIW1kMVINBUYY/oHJ/8AscNzEqQNS4kv/JnuuqJSo3QB0Ly4
         buOUan5q0Iol54GTrO0iFVBilplFHzwc2fIRRIrMc0Pqsi9+gM21EQq53tQ0XiV8CRuo
         j+eHRQQ4KgWZt2LbvVKd0HxYX1AF2YRq3VrFYNXZw7Ohxd/WHVgqQMNKab/funsc6GuI
         c//A==
X-Gm-Message-State: AOAM533IerRXeG/Xw7XLjWHKxXhClWASi7zAMMHJwXN1mgCG5tlp5zxR
        OqAY8G4MXZhzmpZMj30vcw4AzOpps95pJsFA
X-Google-Smtp-Source: ABdhPJwmIpf0nigHCByv+fTuHCc4oxGRcbWfdXEg1x6hKKHOSCoLdKN/KTR7FfEZpqrl5cijFAL4nQ==
X-Received: by 2002:aa7:c358:: with SMTP id j24mr20163939edr.377.1597774285947;
        Tue, 18 Aug 2020 11:11:25 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id v23sm11594092ejh.84.2020.08.18.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 11:11:24 -0700 (PDT)
Date:   Tue, 18 Aug 2020 20:11:24 +0200
From:   Javier Gonzalez <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        Damien.LeMoal@wdc.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        sagi@grimberg.me, Kanchan Joshi <joshi.k@samsung.com>,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kbusch@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818181124.2ys5urtkodpkamsr@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <4ae89443-d8ae-4efb-581e-b635c21b27de@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ae89443-d8ae-4efb-581e-b635c21b27de@lightnvm.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2020 12:51, Matias Bjørling wrote:
>On 18/08/2020 11.50, Javier Gonzalez wrote:
>>On 18.08.2020 09:12, Christoph Hellwig wrote:
>>>On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>>>>If drive does not support zone-append natively, enable emulation using
>>>>regular write.
>>>>Make emulated zone-append cmd write-lock the zone, preventing
>>>>concurrent append/write on the same zone.
>>>
>>>I really don't think we should add this.  ZNS and the Linux support
>>>were all designed with Zone Append in mind, and then your company did
>>>the nastiest possible move violating the normal NVMe procedures to make
>>>it optional.  But that doesn't change the fact the Linux should keep
>>>requiring it, especially with the amount of code added here and how it
>>>hooks in the fast path.
>>
>>I understand that the NVMe process was agitated and that the current ZNS
>>implementation in Linux relies in append support from the device
>>perspective. However, the current TP does allow for not implementing
>>append, and a number of customers are requiring the use of normal
>>writes, which we want to support.
>
>There is a lot of things that is specified in NVMe, but not 
>implemented in the Linux kernel. That your company is not able to 
>efficiently implement the Zone Append command (this is the only reason 
>I can think of that make you and your company cause such a fuss), 

This comment is out of place and I will choose to ignore it.

>shouldn't mean that everyone else has to suffer.

This is not a quirk, nor a software work-around, This is a design
decision affecting the storage stack of several OEMs. As such, I would
like to find a way to implement this functionality.

Last time we discussed this in the mailing list, you among others
pointed to append emulation as the best way to enable this path and here
we are. Can you explained what changed?

>
>In any case, SPDK offers adequate support and can be used today.

We take the SPDK discussion in the appropriate mailing lists and slack
channels.

