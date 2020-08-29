Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F84C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D1F2065F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LYRa4gG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgH2Oc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgH2Oc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:32:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D0C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:32:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q93so791405pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJl+h2g8wNM8Nwnv6/nuRkC/VnUuDXl3sJpZ9c9XY2A=;
        b=LYRa4gG08W3F40Jbv5mfiUBNp+SW2M7MNBcDNl4NQpgW2Fs6qQiybElsYytIID2jer
         y7bZD2wsTC6XgTltJiHtiavmipiLYyGlboFJlHY9mSo/d5RwGawqUh6RjWapqJcz6guS
         FHlrykCs4hl6gTfOaXxDe5HFxKXxy6JX2YULYenpbSeuonCml9jqBnh1TCzTxjMowtTI
         zdmp04ea5JqHnKqv/DBNW8+TDQ4ROqyXOYzQjlvNVs16yZV4puVMp0ZN3wZF3lAEwIdy
         6IwPSIvt1zjwW79JExIMkTugxhIiCA+2a31dODN34N8Gfe+AAP8X6pnK5LgLCka9UF1H
         6jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XJl+h2g8wNM8Nwnv6/nuRkC/VnUuDXl3sJpZ9c9XY2A=;
        b=jw2/QSkApNXexRKHfCat2o1e9gnUMCGMQp/f2RLOEte47Z+C8lAJajzxZvH+GG4xGp
         yk8Cpq1KEAvjKJaBntwD7HfK246wQoTEjUdSgLN3GM5usMKX9OGZD5g1rxCdUyrz5bXf
         cwZlvSMEeBBUo+5q7Z8kPjJoN1mQxY/QHG/QCcX4kDKBxdbw+Eto3AEcQI6jT00DzVuv
         2fWOF/0XnX5x7NdZLZad8Y64tW0jjMxoTQXNI/OKw7nO1RmHlXTqc4H4oGNcpb/QNBTK
         MdXzr0lSHrMe9EM1K8TvdS7rzJRtFxDPZJJ86rKOLi3IqwA3LczZRZEyvDAJY3uCQgqX
         exJA==
X-Gm-Message-State: AOAM5324w/Av7mf2Vavll9R0NLD8z/d4swgS8FKAscEbrwC11uLtz/eV
        eU5IwqPjiynQjkzkqlzSWu1OOEGwepVpXY50
X-Google-Smtp-Source: ABdhPJwGBaF0Q5jf7HUJAsnOSM9AqrmkSShh9o9xANs5+p01fBHPmWm1q6PipC8NaZ84bgMFwv1s5A==
X-Received: by 2002:a17:90a:8418:: with SMTP id j24mr3336598pjn.212.1598711543446;
        Sat, 29 Aug 2020 07:32:23 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t10sm2609212pgp.15.2020.08.29.07.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 07:32:22 -0700 (PDT)
Subject: Re: [PATCH] block: bio: Trim bio to sensible size in bio_trim()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200829093733.45833-1-linmiaohe@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19788ba3-31bb-c0fd-0577-842dca519f8c@kernel.dk>
Date:   Sat, 29 Aug 2020 08:32:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829093733.45833-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/20 3:37 AM, Miaohe Lin wrote:
> Trim bio to sensible size in bio_trim() or something bad may happen.

This really needs a LOT more detail. What is "something bad"? How does
this condition trigger to begin with?

-- 
Jens Axboe

