Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF943C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F462075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4lzXVrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbgAXSgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:36:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44945 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390042AbgAXSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:36:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id 62so1510279pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=es1HFNP6d6J1y5y/BvGmobJ434uBsiCpqm6vXNISPn0=;
        b=F4lzXVrgB4GLH0Wx65kAQwaCgiW6sjXdx58Iy++TzFNPCqcEeBHxdTdycsDj96gd2e
         ODtZa+0B7jHpEmmC9rOWzRAmaoYXQUaluaDLPrSYdvRt6twmx+aFANssaYFX8USJ8O1q
         jHqMICwCBm6KrxdpHgmqPb+s4+cW/AKZfN3lpVeb0aQ30fldmbIgRPxAcM8oGc8fUKtc
         5VYhs3fe9TT/lcv4a+1UHWTwPa1tgEURdpsM0Rmnp/37LMuBP4iJ0LXYwOC/8NIR7esZ
         btfiTdB81qwL5SMZ15aB0lOBuNyOw2iw/Mqg4t61s3dY3+1T7rjwpsMD0z+SuE8I0/Zo
         IKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=es1HFNP6d6J1y5y/BvGmobJ434uBsiCpqm6vXNISPn0=;
        b=i3cFuPUOmUj7J7v4O+QS5BIVEsalq97ZXqrxvB8DsU9fGqVYGSKhHyKuPOfD5VOPlg
         +Nr8Bfo1Aojq4AKEAnoHf3ioUVeUaXCCAxJ0kF51Cz4gzrZDcxQTaapYvxTTn/lXX2xB
         31DQl58p4WCyGB+t56Z3B7/zTfw27Y3v1XCtbDpsb5Jhvu7/kYdV0zK+Bw388WBot7Bt
         2nRjT49nelJEMQ9Jvvf70ygKy2vcYHwAEfQzKxQiP5JS9ZXGnlmVERKLqhSxxjNncmNq
         JiGerG9IFO3npbl+yA8+LXVRlmQVxnV/iNJaVdB513HReR/4b7KFqlOZYNrHusXnp0o/
         6VRg==
X-Gm-Message-State: APjAAAWHLR5QgONx4J+0AQE45bgf1MHeAwXo3yJxIy/y52vJ2UfBLLMG
        w/CKi+pjhOT2nmhD5uvUvrJm4A==
X-Google-Smtp-Source: APXvYqzMOQHT09l7caq1Rvn0weEhJy6amGhPNutUjMkBLG23pZB1sA/YLN84wwJicpAW62xfe81APA==
X-Received: by 2002:a63:5924:: with SMTP id n36mr5569946pgb.43.1579890960126;
        Fri, 24 Jan 2020 10:36:00 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b1sm7162421pjw.4.2020.01.24.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:35:59 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:35:25 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, vinod.koul@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] clk: qcom: gcc: Add global clock controller driver
 for SM8250
Message-ID: <20200124183525.GW1908628@ripper>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
 <1579217994-22219-7-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579217994-22219-7-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jan 15:39 PST 2020, Venkata Narendra Kumar Gutta wrote:

> From: Taniya Das <tdas@codeaurora.org>
> 
> Add the clocks supported in global clock controller, which clock the
> peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
> to the clock framework for the clients to be able to request for them.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
