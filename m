Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF88C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681D8206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="1dqfVxQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHRJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:50:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061C4C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:50:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so16376357wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i5vDKEZg30AIs6a0nWYqfPKaiEsU3ewP/cuwaplcd5Y=;
        b=1dqfVxQFClI+zfejIh1qTvSsngHFLaKqPtzKLGLjelw3bC2aQD6QKBit3dijblXqri
         4qIVwFR71xk25st/eAJvzncev4uETStFXHoVK9U48yYtee49fWBR/bl4kYMNejbhNhQ4
         epGdb7Ih3XcfLxQKGu5WwJK6MitmuZtqC+aF/TbPUuLbq9//Flfs148+xhXZ0ONP6UdI
         4e2WW1d28D7iKP6tqaCTR+bku4ZUdrbOt9+wFwU02wM4f7QcWnU3mPSBsCB2qKR1kcaB
         La+Em2GybOQoR5kWGO4FflyNc/VDvPuM98HdRfBPIOBwY+JA4XqOzOIsUmI0/G9wMLzs
         kMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i5vDKEZg30AIs6a0nWYqfPKaiEsU3ewP/cuwaplcd5Y=;
        b=Tat7i6ZlbWmkIZyvgjSOr2w1vMqJldfSEAmMPlKGP46xeH6UhIpbcxskrHaf6/W/9B
         x8FRjgyj/T5vLEqcDkORcJexmehduLrniRUzIhSOKyuMp0/TCUoyde0tUMFmo/zylELm
         4SXP4P97ktieKifAD9qTLcDqk90JqbhFPw1zf+hM9e8vSMl1LJrgBWqAZ8I3NtFx+Uy5
         pp4FHsa3RuaeYA+g4/NFEdPPJrxUvjcTWkrIGMZVi4hPOnOufwjQx4V35fdSl9CuN165
         4Yw74cxGc1THvqutH7OpHwmLTucH7zSGIQ8CzydHlAMUDAjpIZayu1wt9aYVeyB7mEUR
         ITtw==
X-Gm-Message-State: AOAM5335VCSIiXMcjxA8GrWzvchQqoUk0pK50pZA9xS3e1kv3FXHl2bx
        X2CcSIyb5dN7kN8Q9Of9l7PVgw==
X-Google-Smtp-Source: ABdhPJwXe/4xueqeRf0J9LQvvAsnSGSbxMv4RuMbhh6K4fVUIj613NFz/q+cokvNq9g37PMJmlJj9A==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr19576673wmf.49.1597744235584;
        Tue, 18 Aug 2020 02:50:35 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id p3sm31479709wma.44.2020.08.18.02.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:50:34 -0700 (PDT)
From:   Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date:   Tue, 18 Aug 2020 11:50:33 +0200
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818071249.GB2544@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2020 09:12, Christoph Hellwig wrote:
>On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>> If drive does not support zone-append natively, enable emulation using
>> regular write.
>> Make emulated zone-append cmd write-lock the zone, preventing
>> concurrent append/write on the same zone.
>
>I really don't think we should add this.  ZNS and the Linux support
>were all designed with Zone Append in mind, and then your company did
>the nastiest possible move violating the normal NVMe procedures to make
>it optional.  But that doesn't change the fact the Linux should keep
>requiring it, especially with the amount of code added here and how it
>hooks in the fast path.

I understand that the NVMe process was agitated and that the current ZNS
implementation in Linux relies in append support from the device
perspective. However, the current TP does allow for not implementing
append, and a number of customers are requiring the use of normal
writes, which we want to support.

During the initial patch review we discussed this and we agreed that the
block layer is designed for append on zone devices, and that for the
foreseeable future this was not going to change. We therefore took the
feedback and followed a similar approach as in the SCSI driver for
implementing append emulation.

We are happy to do more characterization on the impact of these hooks in
the non-zoned hast path and eventually changing the approach if this
proves to be a problem. Our thought is to isolate any potential
performance degradation to the zoned path using the emulation (we do not
see any ATM).

Do you have any early suggestion on how you this patch should look like
to be upstreamable?

Javier
