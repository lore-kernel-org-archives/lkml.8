Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EE020780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qv7/vSqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgF3Wls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3Wlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:41:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB2C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:41:47 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so22797030iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aTl/gckYDlLWqH62J4ajGT+IM29RPEjqV42JPxw63mM=;
        b=qv7/vSqxGHUwOu7TJrWsPaizr+2FSUm2mGCMrutc0LUh8G6PCZcmqAKBcsgzcnHYEa
         6q9CZX35EvGBT0rW2vYMZNYnKZZLgdozmgzotIz1X0JUyVqe2kK4Cd2jSha4s2NWX0Pp
         Dxpv/mKXhkTJWHB9QJ2S4iakTZnhLt6mpA0XgXZTMe23DCFPhXHElTKTSujueVgDXcjm
         bGHdCZXf14Z86ZYKvvkmT6zzDVEyalVA9mAE1mxoS1PNS9plJibH271RblQE+uyN7Q5c
         wzEHQvqODvPWXFTI23pFuT5R/QqANHSMZLM1fe/mhzaYZJbYjLDIQXIEvY3dPzX9iF0H
         4psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aTl/gckYDlLWqH62J4ajGT+IM29RPEjqV42JPxw63mM=;
        b=qOJkfEEUjbRuXm6TOnVPG2kgm75GBt7DLkX7+P7KW9sbwujDThFCAmvYswLbsumAk/
         1qP/X+wV7oCwrHC/KyqsZE58pauyuzjxZWv4wrSLpiEO22U2mGE1yX4hHNzNW7uy2K6Y
         IjYocBqefQCYUmyMpxEa8UnFO/4mXCYwHwpiAc695kUh7qVjdVRZ4BwFU9wSwN3Mo0zg
         FYv5pxV/81xldtcYMAp29KhzTVIH6SeiWShiezw2+6kGdENGjgOK/fRTFf9+sZ4ivjVc
         GDR/HrGjWv0k+FZunYz7+Etwfv97XFKaHpJVXTGRo0k8Uovpyt6IPZBcdmITLSkQGy7q
         PEBg==
X-Gm-Message-State: AOAM530kJ2ZuxUdHJA7Cbbbpcc2LUpP250VNGY8X/l0SLyc5zLTav4XZ
        xSgPkzlzoZjAIhYvXni6CrYvleShaBpJ0g==
X-Google-Smtp-Source: ABdhPJxxtxUwmyIyJhSqVQ4leUsBKKe1E3XKZIaNv3gC3sU5TfYLrV4S4+CIh3G1H5EteOQXxb47qw==
X-Received: by 2002:a5e:8d15:: with SMTP id m21mr24306228ioj.60.1593556906429;
        Tue, 30 Jun 2020 15:41:46 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a24sm2117999ioe.46.2020.06.30.15.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 15:41:45 -0700 (PDT)
Subject: Re: [PATCH net-next 1/5] net: ipa: head-of-line block registers are
 RX only
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7c438ee3-8ff0-0ee1-2a0a-fa458d982e11@linaro.org>
 <20200629.180305.1550276438848153234.davem@davemloft.net>
 <825816f3-5797-bbcf-571b-c6a7a6821397@linaro.org>
 <20200630.122114.69420116631257185.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <95f96c77-6dce-8626-9951-124610cf4c31@linaro.org>
Date:   Tue, 30 Jun 2020 17:41:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630.122114.69420116631257185.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 2:21 PM, David Miller wrote:
> From: Alex Elder <elder@linaro.org>
> Date: Mon, 29 Jun 2020 20:09:58 -0500
> 
>> But the reason I was
>> considering it conditional on a config option is that Qualcomm
>> has a crash analysis tool that expects a BUG() call to stop the
>> system so its instant state can be captured.  I don't use this
>> tool, and I might be mistaken about what's required.
> 
> A Qualcomm debugging tool with poorly choosen expectations does not
> determine how we do things in the kernel.

Of course.  I have no problem saying "that can't be done
upstream."  But I wasn't as sure (before now) that the use
of BUG() even in this way would be a "hard no."  I won't
waste any time trying to implement it.

>> What I would *really* like to do is have a way to gracefully
>> shut down just the IPA driver when an unexpected condition occurs,
>> so I can stop everything without crashing the system.  But doing
>> that in a way that works in all cases is Hard.
> 
> Users would like their system and the IPA device to continue, even
> if in a reduced functionality manner, if possible.

Here too, I completely agree, though I might have done a poor
job of conveying that.  My intention is to recover from any
error if possible, even if it means being only partially
functional.

The only conditions I'd ever treat in this way would be those
that mean "we must not go on," basically along the lines of
what you described for BUG_ON() calls.  My point was to try
to isolate the damage done to the IPA device and driver,
rather than killing the system.

					-Alex

> Doing things to make that less likely to be possible is undesirable.
