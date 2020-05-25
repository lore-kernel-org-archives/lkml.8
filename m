Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCEAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930C620723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=footclan-ninja.20150623.gappssmtp.com header.i=@footclan-ninja.20150623.gappssmtp.com header.b="0CisCT68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbgEYKdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbgEYKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:33:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6DC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:33:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so443056plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=footclan-ninja.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bcIsWmmEkRWoaOrX+BaWGDzqoQqiuKveo/AD/DMmyLs=;
        b=0CisCT68V7ucr2HapFKzya24WVrp+iCTX2mnNGSV7JVfHbSNPfE5UgX9XFcvhC3YeK
         lzwT19u8/X2J7Gl6lbQIw4N65c+l+3gD8aSY4/RsPeIHlYAYJvZPHPdbWIZXcg49iTbQ
         vzKwFSPxNE/Q120KjNrTQM3hd5nP+W+BybSFXzZ2+fQsVeQoqcdHlI3H+dowRiFZKoIO
         2XCCOkB0IzkW4usH0DBj1vaiyYC66MWzYshUmvTm2eZtrJrIWFp151EeWd/HTg//tZy0
         II4FZXgKMQyMxa18Snt+SqCb/qf9TRJJlL6MIFurKt6cp7S7vWzi7it+ZgxYg+wfcBWv
         fekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bcIsWmmEkRWoaOrX+BaWGDzqoQqiuKveo/AD/DMmyLs=;
        b=gJxHHw/BlVOUTJmazupAfwk5DUhxbrRPtTz0WEHBzCnwgpjXZBec/x08Sk1ajs+dUA
         /6F6nGdxARjoD6+mEmrtYoCHGbndh/F5MlSXcXBj7f+WH4Z6LXNx0gSJkCxNcO6MK5TC
         IflNzqdruECOZJuUDF9YIAc120zVKYT7COe6Qg8xZ2A3Qe5NK2GtPBK8iZ8KU1C+xq6y
         tqSlXMmn2j+gByNo0+rc9M2kevwuzGml68Ujryxt1qEnztEK2FjNFqqhAL+uWaMmoZMG
         U5+ulD2emMq1PEQLd0N7dBTo7Z+GJ/VTyYA00axjCjAqiNufcZA2xn844JB81ycpu/Sc
         BFVw==
X-Gm-Message-State: AOAM532ZZk4/MVfX+BFRp5lOgLnfALZ2rtYwEter9woR4uErTIo+vvD1
        cG/M8TTDdMSPljk9vm8As0n0HrjmsUWZCZ5oOD0sr4iNSbsdHQcZSZVdiOnwet3nfxZqEGFJToj
        S4kizMNq4P2Bg+dxtO7dhoSqByB2WP/iKysS8OZh15CSBCjfMDUrIu8JN4r+ZRryI4+bDu91KIi
        u3rlb9
X-Google-Smtp-Source: ABdhPJzuzGH3bJR0NQc8zAEdKDEVVW4wg4JbVUGvXIq+RctefMv5/XpHLGjgmdCT3aJ+yevCUearCg==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr19715320pjb.103.1590402816108;
        Mon, 25 May 2020 03:33:36 -0700 (PDT)
Received: from [192.168.8.100] (pa49-195-155-227.pa.nsw.optusnet.com.au. [49.195.155.227])
        by smtp.gmail.com with ESMTPSA id x2sm12521503pfc.106.2020.05.25.03.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 03:33:35 -0700 (PDT)
From:   Matt Jolly <kangie@footclan.ninja>
X-Google-Original-From: Matt Jolly <Kangie@footclan.ninja>
Subject: Re: [PATCH v2] USB: serial: qcserial: Add DW5816e QDL support
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200521004358.8949-1-Kangie@footclan.ninja>
 <20200525093951.GC5276@localhost>
Message-ID: <d0535328-6773-4565-82b9-1975cf875a8d@footclan.ninja>
Date:   Mon, 25 May 2020 20:33:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525093951.GC5276@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 25/5/20 7:39 pm, Johan Hovold wrote:
>> Hmm. I'd a call a build breakage a bit more than just a "typo" as it
>> indicates this patch was never tested at all before being submitted.
I applied, built, and tested it against the sources for the kernel I run 
on my machine, but made several silly mistakes: both manually applying 
the patch to my copy of the repo (which is not my running kernel), and 
not build testing that change before submission. Not good indeed.

I could definitely have been more descriptive in the change notes.

Consider me appropriately chastised!

