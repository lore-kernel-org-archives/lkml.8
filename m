Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B4AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0DB20787
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lrQ8W86t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgEWSuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387587AbgEWSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:50:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B041C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:50:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so4381750pju.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b1mMhxUUXy+J5qvG4lrRGiQpsIcLlIbc98MeN4fSSBs=;
        b=lrQ8W86t2BzC3p5tK16tu4MyclRomNJ8LUm/DKdmWlSUSP97lTFTpS6eK8zkYiVUlB
         mOrSnVOFeD0QK+qjS32+811BNDbI1oP668sv7p5ZB6aGDqTaxygTBD8W2F6MRHMk+5te
         EpsQBjGNaOzcY41VxhGjqQXnik7aEhtUBIOh3fO6bOzEYV51rtT3fRHag/qoZhqhhHMo
         1DZXn3COfGxanTs5Y2GAy4mIS7chOe1/hSMqB/Z2VeCoov9mR7NeGL+zN67WP2Zp0Sjj
         9tLfw/Rhpx7kW4Ioh5ZDrFUcydqBMZj48j6NHEBJTzkO+e9Ijtq5IIugEKHw7fpRbtNH
         7Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b1mMhxUUXy+J5qvG4lrRGiQpsIcLlIbc98MeN4fSSBs=;
        b=Tv6F2Y8avaTt00AdVte3bCc1ccvcqh4psNi6HoIV4y1DPmYekU0Fly6hmWH/pev/Ip
         RFhvxZAQ/M08iqZ9jkJgpkLx9TLZNBesWR5nygez+eGhrHNHWrLhEO6K33fccxjmbjPr
         RCemljVdeH8LCXAWz40g/HWQ7X7KL4ktd55LuVfbToCJU44JCep+olrZkqjPiqo5c9ME
         rnsZilUnxkvCMkKfIaoo+t7TxOPk88DPSPcUsGr/6/SrKeJPkF5nrjBdlbbkQLN3juoZ
         qqR7oBquWuAn1HCTB842fRNFk3GqYm/nMIa9hsItap2rnDmpBZO0eRmQtyCHcVo5stP1
         U7rg==
X-Gm-Message-State: AOAM532/538TY1gzNj6Tghr/joMUZqtl7TUyxRIC7BEp9LPK4fT7yT+6
        X8/vt2xh9cpseURxlHER7WMRqw==
X-Google-Smtp-Source: ABdhPJwPZ6c2Ma+fKM8Fkz87aKpDhVKm2umsk4CEsp2hRwjlLyY4JvK8puI9Z8bW5chTEwJklHJe1A==
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr11884967pjg.32.1590259805666;
        Sat, 23 May 2020 11:50:05 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:c94:a67a:9209:cf5f? ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id e5sm9587517pfe.121.2020.05.23.11.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 11:50:05 -0700 (PDT)
Subject: Re: [PATCH] linux/blkdev.h: Use ilog2() directly in blksize_bits()
To:     Bart Van Assche <bvanassche@acm.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     damien.lemoal@wdc.com, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20200523155048.29369-1-pilgrimtao@gmail.com>
 <714861ac-50aa-465c-c28f-dce7e16d0313@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd3b8124-d62b-ca73-5af2-0d2ee2c58f92@kernel.dk>
Date:   Sat, 23 May 2020 12:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <714861ac-50aa-465c-c28f-dce7e16d0313@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/20 12:33 PM, Bart Van Assche wrote:
> On 2020-05-23 08:50, Kaitao Cheng wrote:
>> blksize_bits() can be achieved through ilog2(), and ilog2() is
>> more efficient.
> 
> If Jens agrees, how about removing the blksize_bits() function entirely
> and to make all callers use ilog2() instead of blksize_bits()?

Yeah, if we are going this path, then let's just kill the function
completely.

-- 
Jens Axboe

