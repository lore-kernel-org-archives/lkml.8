Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6107C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E320722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W3Wyw/BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgEKPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729439AbgEKPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:04:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:04:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so4867527pfx.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHJUJ17/FC2dTwIgyVRhAvuaLoEHHB7DiP06YRCuurY=;
        b=W3Wyw/BUOFmcN5z76mdD+d+AeYX5Q0cmBijeoqCywy8tYJ3IBFQaqDiQ0DBOeAMKw7
         1P/0/r46pvYDxyvlYRqxrVxdypSk3TOTiwTbHstWNTuX5UB5ytnVMGF88fosyXZfi+kP
         eGqJEFO32NTM9OVlqFPg5UJAKjrpQsScFR+27sPkHu1WEPclfyOVdBvnC834jRM9ODQP
         qiUHnzvdDY4p6IZhunNByn5DzR8foi2gwsALibAOd4xVUhdRJjNId94vOx4L2ceDBK6I
         uTSWBJmP9KC3YASV6qXD1a4J7gmCAtxrvOIKaPKrGW6ok6f4OP7DeJMj2i0oTW0Y+SeD
         J6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHJUJ17/FC2dTwIgyVRhAvuaLoEHHB7DiP06YRCuurY=;
        b=OszuuIbvC6PetsiDqt5PDaTqkwOp+LDjyp4R3F5oz1J6TSlOlmpzdM2bozI3z/yrPY
         c6CO0xWabTymCH4Rp7tQj45m8El4YGPsyku4Z+N+SZ5H2sjiYgUl/kFtMzkjm6s3f8cO
         zDvbsLy/GNHLTvxwWoMf0jgvhdPPM1tXFDWZcmReAOssCFs3OFxv80hdofBI+Xcgxcqg
         gi8UvKyTs3aUPqk0wR6W9P7teJlGmy9a8JSViqHY94qWhhhoeoF/xxJ+n+ZndIS2w05s
         feBtWAq4gyoJh0JwiRc+SfKgIm8MBAnSQYfzooCIkvDRHi1+RgTjzvoULPMUHcW1HXlj
         exFQ==
X-Gm-Message-State: AGi0PubWAbBoJCz0wmkdfLzIKRABlhS8Z2piGBkDOmJrKEHINMFbla3L
        QlX+ZsP0B4wV1cTCjH8Ovl1vSA==
X-Google-Smtp-Source: APiQypJP/+pPEqvkAfi8g+IHjolppYyg14pV7OIOuz2+kkHrLUoxUsD6RhBmqj/GotdKeMJPQVmcsA==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr15097130pgc.431.1589209455711;
        Mon, 11 May 2020 08:04:15 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2dd6:4c58:486d:263e? ([2605:e000:100e:8c61:2dd6:4c58:486d:263e])
        by smtp.gmail.com with ESMTPSA id h13sm8108267pgm.69.2020.05.11.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 08:04:14 -0700 (PDT)
Subject: Re: [PATCH] fs:io_uring:Remove duplicate semicolons at the end of
 line
To:     Xiaoming Ni <nixiaoming@huawei.com>, viro@zeniv.linux.org.uk
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com
References: <1589196343-84741-1-git-send-email-nixiaoming@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4dda3bd2-595f-9cdb-a22f-3b56d6ba16c2@kernel.dk>
Date:   Mon, 11 May 2020 09:04:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589196343-84741-1-git-send-email-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 5:25 AM, Xiaoming Ni wrote:
> Remove duplicate semicolons at the end of line in fs/io_uring.c

Applied, thanks.

-- 
Jens Axboe

