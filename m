Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E981F22B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="clNWgc9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGaWaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGaWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:30:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66006C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 15:30:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so18067076pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FfGcQLJ2Sqok69x5gxVVylS7Wr5RIydzmx+YHan3CjY=;
        b=clNWgc9JYnJ/mdLKMm0jCogLKTi6QPwtDDLQ7nO9XM0gy60vqHfPvkGo5adsJWf85g
         v1RXWEstwuJRTrqcdZTaX9VF0HID8e3tYLh5vw7ZbXzR/xPGROTatn4Owe/ChAC/63iv
         XeanwCDh9aR/oQ4Q5m8x2ANSCu1Sr8MkfntAL+toQjwYCtrE/esjCQ6vM52o6sxm28Rf
         6S2X6SD3fm+ZkBRZXiLvd25yEWAZv4MjINw8GKCNemzp2wWagM4bUYrPkYvdp7VO8YMC
         DFdP0t/KXIYQuF/C6bfe6PLaUs59C6l8E8dh26DP7RPUNecPN9g67gisEdt5hYzv6Ml7
         a6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FfGcQLJ2Sqok69x5gxVVylS7Wr5RIydzmx+YHan3CjY=;
        b=prw/N4rnsKWDRenwJEdtQ9BEVzxGVru5Px0iyEnqWb/7Intp9hxiXo6VLB9AdaA07d
         kRp39jpLVBck4FMKl19E77su9tQ/MwwOaT0ux/MpVuqI3MWTg5lg1rgGxpO71jtVzEXG
         zV3Q/l76urwM5bwtm/c6BIBb3ujWeIWBuEQMB9Z9PNjkmWxrYh8hPSa7YhEd0T7MjIoq
         fAS/4uy8b80A2rM2ZGSteHkHhsvUUwto4ibla4Y61u561IQd2Enzlf+Lkrxj+mAGSltZ
         CjtqgBim6oPNs4PiqDEV5vXFxmfn/AVV2aZTOYkA8rftk30y7iPxczJQv3Ks6/JYM9gY
         F9gQ==
X-Gm-Message-State: AOAM53395iuC3y1fD+vuRd658JmeCBBR9IzG+9pR4IOP1bdZvnWXe2Ax
        SPslOZ6IWr0Rjn8x5AWRarOJWw==
X-Google-Smtp-Source: ABdhPJx8h43XHQwZb/u+7yBWVDr9w4tR1l34TlrkDEf9wM1n4rfAQvRgyYZ+O2ksdNCCOOfFKdTrUQ==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr5404583plo.301.1596234615699;
        Fri, 31 Jul 2020 15:30:15 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::1a3a? ([2620:10d:c090:400::5:f6ff])
        by smtp.gmail.com with ESMTPSA id w82sm10973686pff.7.2020.07.31.15.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 15:30:15 -0700 (PDT)
Subject: Re: [PATCH 0/7] block: delete or fix duplicated words
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20200731014233.6418-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2029fc3b-f068-ed2e-7bd1-4d66ad4e47c2@kernel.dk>
Date:   Fri, 31 Jul 2020 16:30:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 7:42 PM, Randy Dunlap wrote:
> Drop doubled words or fix them to what they should be.
> Also fix a few typos and kernel-doc notation.

Applied, thanks.

-- 
Jens Axboe

