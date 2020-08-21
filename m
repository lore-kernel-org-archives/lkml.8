Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AFEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D60F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZlV/bMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgHUKvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHUKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:51:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C26C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:51:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so1509493wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zHmahM4WlAU5TkrnZ9qUadrG7WkBXC8LyNKGjyFPPtA=;
        b=JZlV/bMFi3bja47qPW846zX9+5ZcUjXqZEUqi6aDKdZcnXdbDYLeAeEQt/MAPXm/ye
         /t8CTNSmIJdEkA1GQEHfXVdG1AvitZZtz7yp9N2WRiYFeQV365HDFCP+G4UT+rfOiVLo
         kJpE3L0T1OH8XvXmMrBPc/6NOlO4N0ENRAbC3FLerLvK6q5J5V/yBYxc/SdK36MeeeYn
         C0Z7tuEzIcpSZmeIerWrbvrZrzFn9zvHOFEFKUXQCC83mjFLLpILW+/Qe50m+GsrJr5a
         +8kv4f+wz5/uf3rMTnBOSG2l2+MVT4P5qJ9nM29Ti2uLcVcywA1ZHEjx8SZ24Mso1S7M
         654A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHmahM4WlAU5TkrnZ9qUadrG7WkBXC8LyNKGjyFPPtA=;
        b=Gdy31xRzIzYDzdUyOPCRqbvmfX7qB9RBXbhLfxBh0A3HQOAfRE1Uu37wGYCXtcscYx
         /U+QhJhjjcgaJskII0NdBXlTXbRhkoWSzWvR4++TwgEbAxzvKLKbOHELN8DWJytSiv2e
         F4wEhXeGK9RkzX0ZsaDX1IVOjoYM3vfqhkwIvnoV7MsNLkgH4oDIc3bzDrUeA8oYCtag
         50Z0YJrE/5Da0oyFwxeSkkMA3dc0ptoBrozhslleJ9pihVCLCeqqGDF5Yuho8aCf+mcL
         wHzO0GOS9u0/fyyLjUhNTKrCVLP81E6wi6HMRwamNRd/AXhXkf9QmyK5+PCUS6FyIuB2
         OVwg==
X-Gm-Message-State: AOAM531m5uYiCjbbKHii2f18Xr6r/avPPmP1bbhbk2UYOliphOBat/HJ
        1RwHPH9YO6U16ChkokeKDPPySQ==
X-Google-Smtp-Source: ABdhPJzmKaDTcZfXCKyhcewuR1bQYiG2AundNu1zlG5E8k4jdRUOni8PGM5/AKGLL6Ql07oNTh7RJg==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr472373wru.176.1598007073221;
        Fri, 21 Aug 2020 03:51:13 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id d11sm3363460wrw.77.2020.08.21.03.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 03:51:12 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] Venus dynamic debug
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     jim.cromie@gmail.com, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200730095350.13925-1-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <eb96ce39-4a2e-aa94-be69-6018f4c7da33@linaro.org>
Date:   Fri, 21 Aug 2020 13:51:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730095350.13925-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If no objections I'm going to queue 1/3 and 3/3 for v5.10. 2/3 will be
postponed because of Stephen's comment.

On 7/30/20 12:53 PM, Stanimir Varbanov wrote:
> Hello,
> 
> Changes in v5:
>  * 1/3 - dropped dev_warn when set FW debug level - Greg KH
>  * 3/3 - dropped pr_debug, and now group levels by prefix in dev_dbg
> 
> v4 can be fount at [1].
> 
> regards,
> Stan
> 
> [1] https://www.spinics.net/lists/kernel/msg3550106.html
> 
> Stanimir Varbanov (3):
>   venus: Add debugfs interface to set firmware log level
>   venus: Add a debugfs file for SSR trigger
>   venus: Make debug infrastructure more flexible
> 
>  drivers/media/platform/qcom/venus/Makefile    |  2 +-
>  drivers/media/platform/qcom/venus/core.c      |  3 ++
>  drivers/media/platform/qcom/venus/core.h      |  8 +++
>  drivers/media/platform/qcom/venus/dbgfs.c     | 51 +++++++++++++++++++
>  drivers/media/platform/qcom/venus/dbgfs.h     | 12 +++++
>  drivers/media/platform/qcom/venus/helpers.c   |  2 +-
>  drivers/media/platform/qcom/venus/hfi_msgs.c  | 18 +++----
>  drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++--
>  .../media/platform/qcom/venus/pm_helpers.c    |  2 +-
>  drivers/media/platform/qcom/venus/vdec.c      |  6 +--
>  10 files changed, 96 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/media/platform/qcom/venus/dbgfs.c
>  create mode 100644 drivers/media/platform/qcom/venus/dbgfs.h
> 

-- 
regards,
Stan
