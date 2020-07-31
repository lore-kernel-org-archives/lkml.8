Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D858C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD2C207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OihQDb9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgGaDwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGaDwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:52:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF937C061574;
        Thu, 30 Jul 2020 20:52:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so6658354plr.7;
        Thu, 30 Jul 2020 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i91PStIHGdpSg/hrZKabALiR5l+8TCc0jNirJjRqQCY=;
        b=OihQDb9SG/Nmy46pP/bdhWFkINVR/x1COCv40lR7nr/yZ4r+tgFdgZXL1YkfaXts2z
         Ne0C2v27k+bC+8/pdMQ+iGHxyeKN6zFsjN2nbYgVHAySpHhKhKJSx0ZXrIicJNd0I8fN
         eToGassd0zeNpZuV7ljB+M9vf8WCNl+CyoAwAUoKsAeylbMBUHL8BAr4m771Mi4j2GYg
         T6gPvZcGjxf/F0Zl3xxxfFMAnTfZllQO4iPQuWdR3d8hq1zMY901Ix7y0kUzdd9vMlRb
         JxzXMPqWx4O746hK86Cjzts/emJSSqS7GXnXFsTxyyWp19GDQ1JKjvymzRujv4tqTq4S
         h3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i91PStIHGdpSg/hrZKabALiR5l+8TCc0jNirJjRqQCY=;
        b=BiVrCEylaGZ+NywVFmEN3T5MTZphBvpz9YIZNBunqrm5Hg0CoRs0pBvNCsGHRw6njw
         3J5nALMYRZTdmFWtniSHkRj206jMCxE1xvad6iZxkmGiz+97KvW6W4fUpBSPfJEbLIbS
         1nXF+pBKy8yS82LBq/d8J/Qdmf8MUFrF/PntE2HxyMgt3XuQ4FShfgoZkRKso7hwmwDd
         DyqQYMmBOtU6ex+fFTRKQ4DyE+yIyzxopvxHL8/QTrDJywP/v4PS0wqOHG0EbGV3Cb+b
         i36idzmlWZ6ufOMk/zvhyYZ/RHvnqqRdsLNyZm3Z2QDEYMuzO9Y/FTIieH1p20Cb6c4m
         CrfA==
X-Gm-Message-State: AOAM53126YkdCz9/fLwMW+E+ItTQi8Bhg6/w9xIkUH1ZW+Vs3U6uWf4/
        mwzAi45NqFV5qKnPg9T1k2MkF5E/
X-Google-Smtp-Source: ABdhPJz+qoPB6wkl5+vyxQ0881JdYpSBZLGPc5QaR/2/91qbj091cjxP60tFgnhpJOYLgXwItZPMZQ==
X-Received: by 2002:a17:902:7c8b:: with SMTP id y11mr1999380pll.142.1596167522728;
        Thu, 30 Jul 2020 20:52:02 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id n26sm4061830pgl.42.2020.07.30.20.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 20:52:01 -0700 (PDT)
Subject: Re: [PATCH v2] clk: bcm2835: Do not use prediv with bcm2711's PLLs
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     pbrobinson@gmail.com, kernel-list@raspberrypi.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200730182619.23246-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e49faaf7-405d-c54e-ac7d-85296fef284e@gmail.com>
Date:   Thu, 30 Jul 2020 20:51:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730182619.23246-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2020 11:26 AM, Nicolas Saenz Julienne wrote:
> Contrary to previous SoCs, bcm2711 doesn't have a prescaler in the PLL
> feedback loop. Bypass it by zeroing fb_prediv_mask when running on
> bcm2711.
> 
> Note that, since the prediv configuration bits were re-purposed, this
> was triggering miscalculations on all clocks hanging from the VPU clock,
> notably the aux UART, making its output unintelligible.
> 
> Fixes: 42de9ad400af ("clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
