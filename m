Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CBDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7312076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jdu0KZuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHKNNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgHKNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:13:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FCC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 06:13:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i92so1508433pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xHu6dqtx6dKHdWpQM9ecfqF6ipS8+Ftc0J6RvgUhGFo=;
        b=jdu0KZuJGN7BSi/GvbU8wDgSr5m6NHgobmXY0Qa1UBkL9hhJdh1tM2Mx4P2/3dVILb
         JoF/CaxgNxTO5fYriU7q2WXbHY81dQTzL3qkVbxu9CSNR9bTc3h3CZBdIoJCholq/cPJ
         JbLEmEqnnFP8eK740tBfhUFK/G1xlAAvI9pXJNVS5UJaOQ6I7cqkvOmXmlEIVBvJWVuV
         ASLxte1F5dhJdr+bjcvf3xh1jNQh2tRI7rhlFZg/jeqZ9DdjDtQaZm7I9uQ63uy+tpyL
         oOiiywQjZbLvS4l79qQLLu7Ty6KBAZHSaxxhh+1CmwEfdTtaQeHpNV6MQ7toYOR2kOli
         Y8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xHu6dqtx6dKHdWpQM9ecfqF6ipS8+Ftc0J6RvgUhGFo=;
        b=RbMClCgVxWiA9vfzEiAwzmWHDb/HnEKRup/Xhl/FVDpgDwPkyy4eJ+PSoL8CsNZxAk
         iraeefi0Yb7YYjwSCEiKCtq1pL9A+8reTWkgZzTN9NlARBDTleo1GlpmbMOfVcUwCBwx
         Ovm97L251t8QrwzMGB97IVLo+1A9SUBt0cxVly6EgABbPMtlTOR5jKM9AaRgmBdH9lGy
         tpgawMgtXMP24Cze9E4GuO5bSOHrHrKEasujrmLOUGkH8HBXjhZsgc2LQyRZvK70Y625
         iY1foV6GeXTp3rtQ7q29IRDQAWLNam73yXnAsCI+XJvkdxbfvdseOE5lGKGA/j4IqCkr
         Fbxw==
X-Gm-Message-State: AOAM532IfPADgqNzV6KDzz7HhgbDqOSZSmRJPXDEz7xZtkVzWelTu4K7
        52gesEilvB10DpU7gnZYQF4rgg==
X-Google-Smtp-Source: ABdhPJyU3533URMKEqcSoptMV2jIwg9UZB5n6VGkbS3uedpDRui2yjCE/cx+ISI1udiICS8cHioC6g==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr944279pjs.149.1597151616039;
        Tue, 11 Aug 2020 06:13:36 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s125sm17541177pfb.125.2020.08.11.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 06:13:35 -0700 (PDT)
Subject: Re: [PATCH v2] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
To:     Martijn Coenen <maco@android.com>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200810171632.GA226564@gardel-login>
 <CAB0TPYE-_ErKTqveFW-3Gpb8=ayoy3okyhkeScKi7r5rmLzp8A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9679c065-85c5-ad06-ddf0-a4c81158ebe5@kernel.dk>
Date:   Tue, 11 Aug 2020 07:13:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAB0TPYE-_ErKTqveFW-3Gpb8=ayoy3okyhkeScKi7r5rmLzp8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 12:49 AM, Martijn Coenen wrote:
> On Mon, Aug 10, 2020 at 7:16 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>>
>> When LOOP_CONFIGURE is used with LO_FLAGS_PARTSCAN we need to propagate
>> this into the GENHD_FL_NO_PART_SCAN. LOOP_SETSTATUS does this,
>> LOOP_CONFIGURE doesn't so far. Effect is that setting up a loopback
>> device with partition scanning doesn't actually work when LOOP_CONFIGURE
>> is issued, though it works fine with LOOP_SETSTATUS.
>>
>> Let's correct that and propagate the flag in LOOP_CONFIGURE too.
>>
>> Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")
>>
>> Signed-off-by: Lennart Poettering <lennart@poettering.net>
>> Acked-by: Martijn Coenen <maco@android.com>
> 
> Thanks, still looks good to me.

Applied.

-- 
Jens Axboe

