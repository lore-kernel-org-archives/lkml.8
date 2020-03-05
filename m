Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329EFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D01720728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583443796;
	bh=v2iFH1Fw5dTeFMG4sgU6m9/HDzLaUlaJ+raRvGtawsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o2SkEeSJw8Frvs11/lVsyw+KJGMQrInx6HQsKQYg1DnhS/sfx/PIf6IKxDaAOZ7pd
	 YKPGjwjsHA/XFLlVeIC14sQxMrbncs99J+fnGlcJjtO4DeC9o6S9d5egExRdb1H1mW
	 P1LLVe7OkgtwF8g5nTKQ3M7Mp5JS9zow45SMN4d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCEV3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:29:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45534 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:29:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id z12so291470qkg.12;
        Thu, 05 Mar 2020 13:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=taqxkAd9KSqqsnqsVO4vphOdrnwUWE1s8h519VLBzRY=;
        b=Ow7W0A+DzutgvYOilCzJXAS7oZ3T4PpybnQ2iEzcVAcJXrVdlogb9GyqWu4wVRN3Rt
         ahgsQUI0oD2PFRuLCq5GSWZYGMhwA3FKiVoo9AP4WcXLOkWao8zE9mfukeKtdehgcSn3
         MGA4au2QWHULx7KoZMqXZAKmcWF1g+FtOtLLqkbDVHqtZl6gdcW2ZFzX+Yj5KhZdZ2UO
         hSWYUQymtPaJwwV9Dpcv8yMtWOU+SdrDc+hJIhAejBodIYUH74MOScV5ezlgcj1C/zcK
         yhTFf09bM0CEeg8B/kK1iEHT4BMSD/QZcjTDx835HT0I1MbPxutR30llJE4AFfXwsC5h
         P5DA==
X-Gm-Message-State: ANhLgQ2vHeJfZ77WyUVjkC/i6KFLKsE/YOBsZEtbe8Vjd8uhexB3KMLi
        QoGOthYTjt20+QV90FNOn1nLB8jnyqS16A==
X-Google-Smtp-Source: ADFU+vskikSZHHYvbAscCaOicyxnYx1Kv/OhS0khsZ1pruAOvEj2dNpx5iNVRzwg0ED9oOvwZ6QNAQ==
X-Received: by 2002:a05:620a:16cb:: with SMTP id a11mr20339qkn.281.1583443793212;
        Thu, 05 Mar 2020 13:29:53 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::b9df])
        by smtp.gmail.com with ESMTPSA id j4sm9042444qtv.45.2020.03.05.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 13:29:52 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:29:50 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-doc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH 0/2] include/bitmap.h: updates to docs
Message-ID: <20200305212950.GA79796@dennisz-mbp.dhcp.thefacebook.com>
References: <20200304140920.6109-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304140920.6109-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:09:18PM +0100, Wolfram Sang wrote:
> While looking for functions to handle region of bits, I stumbled over
> two issues in the documentation part of bitmap.h. These two patches
> address them.
> 
> My guess is that this could go in via Jon's documentation tree, but I
> am CCing Andrew nonetheless.
> 
> Based on v5.6-rc1.
> 
> Looking forward to comments!
> 
>    Wolfram
> 
> 
> Wolfram Sang (2):
>   include/bitmap.h: add missing parameter in docs
>   include/bitmap.h: add new functions to documentation
> 
>  include/linux/bitmap.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> -- 
> 2.20.1
> 
> 

I've applied this to percpu for-5.7.

Thanks,
Dennis
