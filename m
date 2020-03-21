Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D298C43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502720777
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 20:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HcVr5i9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCUUEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:04:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43778 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgCUUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:04:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so4907616pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0yWNdhbNqUfEkD37i7L/ncMrdRQ29Z5bEYy+5u8eoYQ=;
        b=HcVr5i9o5oCW01QPAvbEDNG324LociUR+9LKohOJ5IKS1mrjn1j5M8cHO2sySOpA20
         cx/Xn1TiutVOcrf85KmgfBjSXAp27Fd/hunCt8peBjZMBJjg542xv3DUvoaOjxMlk3FR
         Qd2jxLXqR6mgN47VRgD0Q8xTjHkMHbwoBrA/ScdrJXVKGLylwNEJGOeaG68rWx21UCFa
         jj68KvNncqmh1mLHZjT6xvHqaHH7tT5LrW2rOSwodapSb/cF+e19A7CWXtIGtpAmFdXm
         Fe6LRHS9z9j8pc3XreILTWTjPwDg/2K1gPB1VATzPR/1t9/Im7Svqv4w31ZRA7+BY1SM
         iwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yWNdhbNqUfEkD37i7L/ncMrdRQ29Z5bEYy+5u8eoYQ=;
        b=QOPK1qm3JbiRkYZDafUChOLsb1rsOeaj2C7KsI8acqBsNGMIBvll8LoFrA9SG237P/
         ub3+TfcIadmxk2atzKdXs/ofxUji4f5jnIn4PDKs5Z5QEzUlIAvzJHoHsaRUT0Nr21uQ
         al81IZO2Lwgvj0iCKiNZMIVBDgHRBAnUgmANuYAv735rSt52ogSmYYGmVknu+fXz4n+z
         OXe92WroaKgg+jAMWJWOW06tPIHgFvoyfkCQwO+F7zbMgVZg3X74J5DTK0lfuxdKGoIS
         XyaQUSjs4xIO0SE9cH9sSjNPydu0ZVfIaSYemFCJMITePh7SVk1I5vUzpElMncM+tPtd
         gTWg==
X-Gm-Message-State: ANhLgQ2raB0Rf8WjO0aEPGMLzkQyGbaFE9zSb/VUZmOlBzn3jmZkIzoi
        gVHfyY16/dbWD+3M9uPokyvQ7gMO7OR6JA==
X-Google-Smtp-Source: ADFU+vs74gsoENPjoVn6vbEMdqHzLNWCa20HEGJHf1sJUt1BCtuYcetvcTFyAOMetLNufk0xP7ENXg==
X-Received: by 2002:a63:1c4a:: with SMTP id c10mr15119782pgm.252.1584821063790;
        Sat, 21 Mar 2020 13:04:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u3sm8023157pjv.32.2020.03.21.13.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 13:04:23 -0700 (PDT)
Subject: Re: [PATCH] io_uring: make spdxcheck.py happy
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200321111907.6917-1-lukas.bulwahn@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa248c14-8e3d-50e8-0b54-8e807965f771@kernel.dk>
Date:   Sat, 21 Mar 2020 14:04:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200321111907.6917-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/20 5:19 AM, Lukas Bulwahn wrote:
> Commit bbbdeb4720a0 ("io_uring: dual license io_uring.h uapi header")
> uses a nested SPDX-License-Identifier to dual license the header.
> 
> Since then, ./scripts/spdxcheck.py complains:
> 
>   include/uapi/linux/io_uring.h: 1:60 Missing parentheses: OR
> 
> Add parentheses to make spdxcheck.py happy.

Thanks, applied.

-- 
Jens Axboe

