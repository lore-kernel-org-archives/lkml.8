Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BC3C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3925F206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TkbTZ3im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgDHP1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:27:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40858 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDHP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:27:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so2615725plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O7WfNhI8f1lb6PW5kXHujbQHVLkGUotMPukmCgQtvWY=;
        b=TkbTZ3imLDeHFL3w/n+tfMNRMwjwa9tuBACNwAjcNUWZMbOLPIyh7bEByUqixcSOXC
         xkZpVv5LVlFb7bI8auY0NpFtQ82qWf6Y5Zm19IQMAk22dNFw09zwOGJS7J03vbbTIP3E
         FYsi8YR2gA18/wCGK34SabV2govLlWbwYmf1xK0NpZ4Jaai3nYmumE5PeCeWs6knoE5y
         n45xkh2LgxK4toUsFztNtAqfmApl04H5V8U2dKOHI/GdL1BQ9jM8dle4UgVBvHSBRn5u
         wdYZKqIBhSLrS5POZknxoFrhC5/oCI5l2NrCEKnbmI2JyEgLvCdqv+RNIrysz+9W15bo
         MNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O7WfNhI8f1lb6PW5kXHujbQHVLkGUotMPukmCgQtvWY=;
        b=ADaj+J4jP2cx+AOpKBN2NGOuyZ8Q3U5FOF+CWhOXfkb8o7edmIM2k2kS7qfQ9RENu+
         F/f4UCVX8amraqJZzr1nGSpks8kDU83tL1eLZAT/1B/oLdb1Xw197kG8Y+Ep+OYkX+Hf
         TotN9YGdBbWvnyXuNjRAQkPBZ849HrmLJyD2w5bJGnvQym/Ibi5hfIibmk4ZCKr6Qecf
         5SsjIeP3eRspbCtTJ4HDsLDFgcT+bQD6jllArFGTCq2brF+RuAKxGmRIAaf9r/6wWhzb
         TsL2z4WPSiYrzJ5j4L060IDnbuLcJtg7bMcyjGcXfxBaodw8GLBJgDPf6zBkeAAoeMA+
         qc1Q==
X-Gm-Message-State: AGi0Pubra0n6fV8y5fq+eUK47ZpCy2smLZR6ow05j6+ZuBNHrIpS1ynP
        uX7E6GqiPaqTSLKhGbWagznbSdngR4Thqw==
X-Google-Smtp-Source: APiQypJUFFNkq129tV80J9L/1WuNm/ssIiTfXEAk1yXAaUS/SUq8LNfYq7xWZ4+kPLlPTgl+51rlFw==
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr6013366pjb.71.1586359638209;
        Wed, 08 Apr 2020 08:27:18 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4466:6b33:f85b:7770? ([2605:e000:100e:8c61:4466:6b33:f85b:7770])
        by smtp.gmail.com with ESMTPSA id b68sm1314338pfb.134.2020.04.08.08.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 08:27:17 -0700 (PDT)
Subject: Re: [PATCH 0/4] clean early submission path
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1586325467.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0dffba9d-d320-0412-f17d-cc6a19f39772@kernel.dk>
Date:   Wed, 8 Apr 2020 08:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1586325467.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 10:58 PM, Pavel Begunkov wrote:
> This is mainly in preparation for future changes, but looks nice
> by itself. The last patch fixes a mild vulnerability.
> 
> Pavel Begunkov (4):
>   io_uring: simplify io_get_sqring
>   io_uring: alloc req only after getting sqe
>   io_uring: remove req init from io_get_req()
>   io_uring: don't read user-shared sqe flags twice
> 
>  fs/io_uring.c | 113 ++++++++++++++++++++++++--------------------------
>  1 file changed, 54 insertions(+), 59 deletions(-)

Looks good to me, applied. Thanks!

-- 
Jens Axboe

