Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE58C55196
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1C82078E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk08lOod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgDZFEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 01:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgDZFEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 01:04:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378A5C061A0C;
        Sat, 25 Apr 2020 22:04:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so487485ljg.12;
        Sat, 25 Apr 2020 22:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jpl7xDzEjZpRj4OeC+RLSFTb9t6nhtmzKhq/lP/2QzY=;
        b=lk08lOodHLUX2qR4dGDrsvCaOqDfedNREeSDPRItglaV92NhElgD/A2zAX4SzXb8w/
         xzOXP0/C04kYdQy9jZd82ztnS72u6n2/Wrs47cKNmj8KBMgJ8tP3KqQ3BHXhE/tQVxI8
         UafzQXZvqqR7I51ba1x8xUAwGgQK8WDn0qiLtf7F8tWdvV/mUG/WYEv4NXNvHLr2ma5Y
         8JfJqJrFVNbm/t5S0FqE3uEj/yWC+NK0sK9Tk9+iaZA9dCM4CICNqG0wMdgNNl2rmzU3
         JGuIj+6E42j3LfV7EO72eMKjH73d3geNX23eshLE7prJbTpFeu6jFEJ5hmqNSylkqSo7
         0soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jpl7xDzEjZpRj4OeC+RLSFTb9t6nhtmzKhq/lP/2QzY=;
        b=Nvfmrc4JUbzNJo9fKqAKpVNy63cWaOwjhqnB9adK35Z9Hjuq7NHIbrWMRQriMkZJLh
         VxSiE+lLsKWz/CCnAh9TlET0C/tJMZIJD6QgCHvwOJkUr8BvV9Ro+WQMYAiY6svEuunz
         TmDzKSjN63MEnJcOX/EkAhGZCTWxstC//Mta4YXuIN1/Sfiu2eaz5ycMkcytldxLRnkS
         MIzw9ml5D1Bfcjmtto0I2RaiRT/t4Q7tDxfJDMIMRCaepDDpMMOMt9XAm7fzw67TK11m
         qY9MjAUljOopEo9viBC5r99hgl0OpJsRMLK6+KYf1JYASnBiQOdH+rMibL/wxiZ2VRAi
         +lsw==
X-Gm-Message-State: AGi0PuZa+m/U7lzXbdp25zyQA50+hIZXHbjisXjKFj1bbzy6Svodkk6O
        9IK58lX5uCLvnsknussnrUVLz2RS
X-Google-Smtp-Source: APiQypL3MAcM9ATk9Fo4jFjpYaJVQbuE2SQ+G8mN3carEqxIAwiTogLzwe/Y9mW5Ihm05s37bE4b5Q==
X-Received: by 2002:a2e:3208:: with SMTP id y8mr10602007ljy.282.1587877474324;
        Sat, 25 Apr 2020 22:04:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id p2sm7679321lji.40.2020.04.25.22.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 22:04:33 -0700 (PDT)
Subject: Re: [RFC PATCH v10 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, frankc@nvidia.com, sakari.ailus@iki.fi,
        helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1587700513-28449-1-git-send-email-skomatineni@nvidia.com>
 <1587700513-28449-7-git-send-email-skomatineni@nvidia.com>
 <6ca93ff9-ca59-544f-767c-4355d01a5c20@gmail.com>
 <62546d1f-eca5-06be-2bc2-e45ccd53830a@xs4all.nl>
 <50fd1016-ca8b-ec5d-e5a8-f257138b152e@gmail.com>
 <658c4232-94d9-3051-8c93-bff7046cf5f2@nvidia.com>
 <03426915-25ea-69b4-bc64-f87f3046d33f@nvidia.com>
 <aabaecc4-3494-0137-7d2b-853304bfa68b@gmail.com>
 <09f20441-fec6-7496-2edc-c69db535e441@nvidia.com>
 <61799fab-858c-8b0d-ba7d-846cd041e044@gmail.com>
 <7dfca778-e402-3a6f-617c-dd8448187a13@gmail.com>
 <be48a991-3047-6ee3-8d6f-85979752d86f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5410cdf5-6379-36f5-21c1-028097e9e9d7@gmail.com>
Date:   Sun, 26 Apr 2020 08:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be48a991-3047-6ee3-8d6f-85979752d86f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2020 07:47, Sowjanya Komatineni пишет:
...
>> Although, you're right that tegra_drm is compiled as a single module.
>> That's not good, I'm actually not sure now whether it is possible to
>> modularize host1x drivers properly without changing the whole host1x bus.
> 
> We already went thru driver structure changes during earlier versions
> and internal feedbacks.
> 
> Not sure of restructuring again now. Also reg wastage of space, tegra
> specific implementation is not huge also for T186 and later we have
> RTCPU firmware that driver communicates with and it light weight. Based
> on internal discussion, no upstream support for prior Tegra210.

NVIDIA doesn't support older SoCs in downstream, but this doesn't apply
to the upstream where anyone could write a driver.

> So, probably what we have regarding structure is ok except video formats
> I will move to Tegra210 and change defines to use Tegra210 prefix.

Seems so.
