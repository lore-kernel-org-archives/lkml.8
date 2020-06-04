Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27FF206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wh4JB+s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgFDRGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgFDRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:06:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30042C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:06:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so2442684plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=95SNrnsfRSHsznN/EFmiPvkkvvFTuZxB91UovD24N3U=;
        b=Wh4JB+s+UWpwgz43Erpmr47eJrSAsMChpQGKJLR01ZKWKDOyCrTzL5NmDU75LWSHYQ
         YFiNNiaoMQDUTtyjgmsLAO2CX5up8tEccCo6C+0hr7/sRZ0osxBjUaWpzQFruyfx/zWI
         8L+WAinsUxaYs+Z3mHobRp+6hACmPIi4nFMKnS/+2Bgn2Ut7b4pEdkhMT3lWI/SNLz6N
         2LQBBlZPZbwgLeiJnVJrVDzqdJNapAc2SvuI6DiemAJhpjt9W4qmxpakNL6xQQpSBqoN
         7EnY0KjYfyQYVVwLIWHVJleJ2NMpRI65U81ghpoh3vStshg68CjtfmGAAFB4eIp4isbz
         3M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95SNrnsfRSHsznN/EFmiPvkkvvFTuZxB91UovD24N3U=;
        b=NrG5kf198A+wpNR8qSzyUvoA/PLuB+CCvkI5xBpmu1m0h809vxFXWE0iIhZtgeW4Je
         A7169ZhwwbnCDOPiVr3BuLh/jFc8Ki6XZ5lYUNnXc7jhZ6r0vN+zxZ/SMTZzRE+Hmq+H
         R+SrZGzkGDYiKxP6Ot5GmTgvRxvdVuODGvDRzarNTJkSaVVt/RJcF2UFznEnLscHqhKm
         TZdaIeDOfczs7kyXltP77GwpijKTXTxnKvEX/EhEpXKb50jAl91oFhch1No8Zfy/UXWS
         90fRQZeceP879SdBYVMGM95MrA0gAqnqs1lu9vyMiJ2EAsHD47K/QJ6dpE5ZE9WdHMww
         YTHw==
X-Gm-Message-State: AOAM530h+Nkui1gKbX8sgLAwANLasbuv3VlBTT8WlxCOxbLN4af+1xKB
        sD7TBJfP6tcdoItIb+Pgmmzx7IR2WsosRQ==
X-Google-Smtp-Source: ABdhPJzk5oqt/KdfFMDSXKFwdx1EavUj9ZZIioj2/unpYFcKmD6kQWB5+rd0smPPxnuqVj65N8Vfng==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr5567125pla.311.1591290372276;
        Thu, 04 Jun 2020 10:06:12 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t64sm4590475pgd.24.2020.06.04.10.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:06:11 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] forbid fix {SQ,IO}POLL
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1591196426.git.asml.silence@gmail.com>
 <414b9a24-2e70-3637-0b98-10adf3636c37@kernel.dk>
Message-ID: <f5370eb3-af80-5481-3589-675befa41009@kernel.dk>
Date:   Thu, 4 Jun 2020 11:06:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <414b9a24-2e70-3637-0b98-10adf3636c37@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 12:51 PM, Jens Axboe wrote:
> On 6/3/20 9:03 AM, Pavel Begunkov wrote:
>> The first one adds checks {SQPOLL,IOPOLL}. IOPOLL check can be
>> moved in the common path later, or rethinked entirely, e.g.
>> not io_iopoll_req_issued()'ed for unsupported opcodes.
>>
>> 3 others are just cleanups on top.
>>
>>
>> v2: add IOPOLL to the whole bunch of opcodes in [1/4].
>>     dirty and effective.
>> v3: sent wrong set in v2, re-sending right one 
>>
>> Pavel Begunkov (4):
>>   io_uring: fix {SQ,IO}POLL with unsupported opcodes
>>   io_uring: do build_open_how() only once
>>   io_uring: deduplicate io_openat{,2}_prep()
>>   io_uring: move send/recv IOPOLL check into prep
>>
>>  fs/io_uring.c | 94 ++++++++++++++++++++++++++-------------------------
>>  1 file changed, 48 insertions(+), 46 deletions(-)
> 
> Thanks, applied.

#1 goes too far, provide/remove buffers is fine with iopoll. I'll
going to edit the patch.

-- 
Jens Axboe

