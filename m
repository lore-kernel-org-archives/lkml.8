Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7168FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC5E20722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ke2ZIOIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgF3BKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgF3BKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:10:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADAC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:10:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w73so4369511ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUjeWh/gnv7SsSmyLjAY3l5nUPUBHNsyTtmhdqkaD88=;
        b=ke2ZIOIWH+veJU83MCRtimartTjxTMMQ7ssNfBQTBE0nYNCs34C2CGZBIQ5oYiTIuM
         1NPZJTPyefZhNA2BwCNjVIHOQ0bnqy3XaYx+HPU0HUotSFcx4C+QT9i2gIdC045w78KZ
         Y+IuxZUWzznlaa5qTO6WYtQBws082Pajjk1GozsCl1RQqq2Pl5gRzL7edHo6hxDF6TAN
         4+SUQs5KrBMWbu4KxiaLzKyqXKD+A0jeMYCS6V3nulKsHAENNVDk+oRhTXGTSSQE17kH
         kgDWkEfDkHYzlMQoEgV0IFTuKXRbC48oq9b2uHEcH/9wH/2wMUGCaUh/HJhfdhmBuR32
         gmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUjeWh/gnv7SsSmyLjAY3l5nUPUBHNsyTtmhdqkaD88=;
        b=aRUX1JAPujf4dQmvCDzUtYnfLWnO5ONQbSacgHbp0vKaMLw6ZIgHikhdW+VDWxkrxv
         aHs3A5vB2Y0MYbJ7pg3WH7T05xpHVrNZOMRwAt+9vPF0zCrTHjTBzr+6UCLFg2VFrVSH
         w2rRl9blMKiYPNA8s7d8fAjTgsR5JO26qZg9tHe0sKm+yLpkAVsIAsUQIo1fBfPPZ/18
         roCbsoGiPTbtRSNom9o1smkPpSpf1wKw+hODSCbzk+jlWGudiL8FmEM8kra/9U5yNbGC
         yY0xd8MJtV5NDy2bRRMaH9dYMbebEl2UXLxtvS3RTUCgJGIZ1jcJaBrQcj+volcAV7uk
         +RMw==
X-Gm-Message-State: AOAM531yf9AMbvqpbHM+bciPb8NiTQxIb3D+aoUOA14ne84uAeFAadfg
        XwR2FhWS1wSIKpma2UnDurqPq5Qkc7Q=
X-Google-Smtp-Source: ABdhPJwwJng843waUYdG70JKRjW/vvvCqyWW4BPiJUqCaqyW31WOH015fo5edjCQjfhloVEZLR7iUg==
X-Received: by 2002:a92:9914:: with SMTP id p20mr238232ili.273.1593479399781;
        Mon, 29 Jun 2020 18:09:59 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z9sm838964ilb.41.2020.06.29.18.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 18:09:59 -0700 (PDT)
Subject: Re: [PATCH net-next 1/5] net: ipa: head-of-line block registers are
 RX only
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200629214919.1196017-2-elder@linaro.org>
 <20200629173517.40716282@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7c438ee3-8ff0-0ee1-2a0a-fa458d982e11@linaro.org>
 <20200629.180305.1550276438848153234.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <825816f3-5797-bbcf-571b-c6a7a6821397@linaro.org>
Date:   Mon, 29 Jun 2020 20:09:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629.180305.1550276438848153234.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/20 8:03 PM, David Miller wrote:
> Never BUG_ON() unless you absolutely cannot continue executing kernel
> without corrupting memory or similar.

Yes, that's basically why I don't use it.  But the reason I was
considering it conditional on a config option is that Qualcomm
has a crash analysis tool that expects a BUG() call to stop the
system so its instant state can be captured.  I don't use this
tool, and I might be mistaken about what's required.

What I would *really* like to do is have a way to gracefully
shut down just the IPA driver when an unexpected condition occurs,
so I can stop everything without crashing the system.  But doing
that in a way that works in all cases is Hard.

Do you have any suggestions?

					-Alex
