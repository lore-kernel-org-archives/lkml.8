Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59460C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385C22080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DkguBcsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD0IKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgD0IKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:10:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA2C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so19401787wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BWFYX7PX5iVsUcqkRSw86/RtX5f51iD1D27rAVa9S5k=;
        b=DkguBcsFj0EPiLpABgT8rwKhoHGfXC4HqjrDIcxCzC0+0m4BwZCxFQWPAH2FMMagvZ
         aBW6P30XZ6aOwyOfyNiBuJ7klTHDbgZo8XUdPiCMQf08pnwW8WgAGS6sKgGw6RiSsJqX
         jP4WPcJrV/j5+q7L6P/pePj7dr7fBhuHh5CC5DMrnzpJGYyDg6p5mDLUOLfCbWYD6kiw
         kdIyZGN+TyFSjeycyhRg1ED+cIQBxHf6W1AhotvuyBgRCd38UmFZ+QCggJccxRAKZny+
         eAz0t+8XaVoJPSl/S+rW+PpOe1/QP7/5db7dNeD3y2hn1+T6yl9oKrzmhdYwnRdEkbb1
         99Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BWFYX7PX5iVsUcqkRSw86/RtX5f51iD1D27rAVa9S5k=;
        b=bivfv2s4dBVq7xwlw/s2QeN2r/dzVQVd7bCSrTnnMszU3H3zz8kTKRttAazYuGjMnI
         +1lEC+EbhKcYcXZHmCXwnlOeFyjGZXtCZAGeP7RI4S1sZWlZsJFWNHaa0lKPvzEmUABS
         i6H6Dz2KaSH+OSDXAcFOaCGGyLkW5Z5E7ZIaVFkZhtzJ0X6Lcyzvgs0MsWDO8fMZFiD1
         /9BlKp049Jx3wt+aA/dZMlfVYXurp98QUNfm12HcuZZ4vgMlOnPW8guR0wBau7PB1xG8
         8yRViwV2UdxrLK8Dxoacyml4Bhede1UGkoT+X/FeqtB7IPgXtSrJiq1HpsR1lgIa14Uw
         gy8Q==
X-Gm-Message-State: AGi0PuaO39xPxE/fpB8DTZMi8Sse3F4kUqNwOAgfMXcq5uA+6g7NmrlA
        HTOwwhYU4DABFvfIurRxhtQB8w==
X-Google-Smtp-Source: APiQypI47heGwKaekAfcdCP9TA3J1BjECdG45lBsaUSpphpeLIcAoPbP2SxOxrxltJF2SerXzSR0ew==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr26528432wrn.18.1587975052322;
        Mon, 27 Apr 2020 01:10:52 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:8400:6d4b:554:cd7c:6b19? ([2001:16b8:4886:8400:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id r20sm13918576wmh.26.2020.04.27.01.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:10:51 -0700 (PDT)
Subject: Re: [RFC PATCH 5/9] f2fs: use set/clear_fs_page_private
To:     Chao Yu <yuchao0@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-6-guoqing.jiang@cloud.ionos.com>
 <fc48f93d-b705-4770-0fd0-8807b3a74403@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <665e77ac-2476-ea75-5c61-eb8c2507d1cd@cloud.ionos.com>
Date:   Mon, 27 Apr 2020 10:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fc48f93d-b705-4770-0fd0-8807b3a74403@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 4:22 AM, Chao Yu wrote:
> On 2020/4/27 5:49, Guoqing Jiang wrote:
>> Since the new pair function is introduced, we can call them to clean the
>> code in f2fs.h.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Chao Yu <chao@kernel.org>
>> Cc: linux-f2fs-devel@lists.sourceforge.net
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Acked-by: Chao Yu <yuchao0@huawei.com>
>

Thanks for your review.

Guoqing
