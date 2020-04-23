Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25109C5518B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048C82077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="os394JnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgDWCGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgDWCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:06:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD2C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 19:06:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k13so4925594wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 19:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/9Q0gDEQk7SNMN/b68r58ICpmz+7X03N2hr6NiaoH8=;
        b=os394JnEZiB7hZzjCkNFjqIx1gf9N5AYKFKocDI3OSFTkfodOiJXYFYsfKLKpmaf4S
         JY6Lput0qZK8yke6lcP8CulzTaxZ6njBHxf6bbfXmwGDVjtmkLy4kABeMzrcIwTlyJH6
         Vf5RRHfJb1/uBnLE/jbKajIikW3ncK70q+zpBO8nzVPZTu3aVc33D1CGr6A+rGcV4YG1
         z1T/Xo6jKmkhmmXhBmz6UDm2dQYOZtLwI6YgQCZQrZiZzbb+92Q/H1Zg1Z+nb1ntJFaE
         A7KwHZCRz8UWwc63yPK9Qh9kiA1fMIfPNCltQiCmzFWPq9PdYf1iCJe6otPkPNbnCkK5
         OCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/9Q0gDEQk7SNMN/b68r58ICpmz+7X03N2hr6NiaoH8=;
        b=Wsgbh+OHvktl3++0A8u3auUrDV3sZDwfIGYHiiaUs3uyE9ex3IV9kCHyJnPBN8coaG
         4vFpR7cALJqHnlZcIl0zSS94vK52qPIpuAqVHJNvB+d6pA8utSVUV+UvRMKjVEgDoTjM
         aroHgyN3Gw6FEw9QPSECId1h6zvPHnba6VFgQytv1YrMnsWm9ZbYFKaP9degZQUfV4B/
         YWGPODOgDaUfsqFnCmXkfLbTr/V/Grat2z2oiRIpi3CQcnyq/5MuYmIidSI73+4HwvkP
         BSE4dyMo1CCoTmZ3Qo/h4DLdKRUv7r+YzmF4E1Eb/Kfl2U/GcO5TgRsoh+EUL3Bp38n8
         UURQ==
X-Gm-Message-State: AGi0Puag1N1foE/a1lsl+jrn2+ew4x/crybn78xo532THuNSrcmw6mry
        ooxyhjj0j53Ly42cuY3fOK0gmA==
X-Google-Smtp-Source: APiQypLAiRsG0qCINhLGe1EpQJ0HHWcgW2S1wxioVrDAsZWOl/hXi+QT6wmWP4U2nP4U4P4Nmx6KeQ==
X-Received: by 2002:a5d:690a:: with SMTP id t10mr2096175wru.225.1587607566043;
        Wed, 22 Apr 2020 19:06:06 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c10sm1340584wru.48.2020.04.22.19.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 19:06:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] clk: qcom: gcc-msm8939: Make silicon specific updates
 for msm8939
To:     Stephen Boyd <sboyd@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de
References: <20200419121808.440780-1-bryan.odonoghue@linaro.org>
 <20200419121808.440780-4-bryan.odonoghue@linaro.org>
 <158752417863.132238.13958544237045504884@swboyd.mtv.corp.google.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <11c762c5-0dea-2696-a063-335387e25d1f@nexus-software.ie>
Date:   Thu, 23 Apr 2020 03:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158752417863.132238.13958544237045504884@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

I think I've captured and implemented, all of what you said.

---
bod
