Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507CC20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m8ZuJPL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFEDPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:15:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65887C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 20:15:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so4499695pgh.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 20:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b2T7XhYSryAEc5C73HTikh6JfPX2CSo5YZsv2xAJOAc=;
        b=m8ZuJPL4hH+Zl+LbrSUSYubngpf9hEQ+Vg2eabcE8lJIzKtDdAik9kp1wfpyI0e37x
         xBihIwpx4yIO/5OQIVkeZgrpm4Sl5AcNeiRCih1fdrGRlzVU8CEo2WUJe09UomgeETb+
         +J5t8x0eONF9d3EwZOXQgjxEPoTQuOLdZWF4Lm1Sz0653IWE7iFo8lPjo5NYWg/fv3wi
         L5IY05TiKBAO0ihYOOYbOCye6ANnANlFcc5ELsbpwJ7srDaGR0vCzL3RXVsyU85LYUAS
         O7sQvlrUM+6zbh1Yn3yXLYuRaGMCFPOXrHrt0qSN1xEklHdRxNxYYvYRNQrZFsbTFUD/
         bCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2T7XhYSryAEc5C73HTikh6JfPX2CSo5YZsv2xAJOAc=;
        b=TZu6h5zP632fNhRGgjx98zeEHBX3BnpQAKE8ojjvcziMQoI16EcWDOZhPhuv+CpNZM
         NYBdSTtksU+iXrf2bTid+yeo+iQAzRJD079JDLoQxwJIlQPVkWGjobRBjqDoK2g0fdRe
         mHdWfZ+VJRjJnBscLyFKIVRdFPdm7s2M47kA4lD9UGGFBUFuW5dB/pZOZ4Cd4em1kle7
         CABWw9wuZ5TbUTR727cXGW3FK0LqIMglN/TMkA7IcxO+v5PoZG/VKhUSfAzCMeq2Bc6C
         jfhkx8ghywqz0kXzyHth2kBsaKWiv5XlGXsZJ2TeA/hHLb2QvKOtQxwJiObtnVTLrhc8
         uQjg==
X-Gm-Message-State: AOAM533AcovCIszgQlIr7uwF22e8oMjzHBKcfPmUzwKsZ2xgYgELbLUo
        djHzYWyfLYDRuYAJt7YbVTa+ww==
X-Google-Smtp-Source: ABdhPJwcbM1l6smIgjX2kzTLvIDF2eqTvwkNMEdStryOyXdG/oOwIQDuSjE0GILOtktp8Ow533bU8g==
X-Received: by 2002:a62:1b01:: with SMTP id b1mr7646208pfb.14.1591326908844;
        Thu, 04 Jun 2020 20:15:08 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e1sm5342198pgj.0.2020.06.04.20.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:15:08 -0700 (PDT)
Subject: Re: [PATCH] sata_rcar: handle pm_runtime_get_sync failure cases
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
References: <20200605030643.91801-1-navid.emamdoost@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83988f4c-330b-e317-367a-2d18ef617738@kernel.dk>
Date:   Thu, 4 Jun 2020 21:15:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605030643.91801-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 9:06 PM, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.

Applied, thanks.

-- 
Jens Axboe

