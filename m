Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA012074A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lEBn1695"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgE3Nuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Nul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:50:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF75C08C5CB
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 06:50:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v24so328747plo.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ubhL8BFn+yo4pHtTd6U6Xpnq8CDrnGMLha9n6Te9Nlo=;
        b=lEBn1695cvRsGzNS4ix8zG4MkKm5RfjPwRK117vs2jLE+2dvkmo5lv4QTAE6f0JEUY
         oNg4bLeiNqcCIzTEn8imuptjV/CAR4WSmUJR/7NAzfCmP0JE51mJ2t2yplZoHrUE+t3c
         yJ9ZogkItkTr+/fI4hZcVwlvquRP/HAPFlp/wftMQU1xv4bulk97oFRwwC4USo/QRWke
         Cn1CupH6o+UnKPLkXzy4zE88eAHBS3OzcNtls+ArL/Yk2g7wKk96ze0ALIX13yUapL6Y
         YtANtmnVYKgR3qE794Yb1PWHp4B1jOTmO+5wuKqlmq1iIqkb0xEezo6op0Tb9jvW8FSF
         iKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ubhL8BFn+yo4pHtTd6U6Xpnq8CDrnGMLha9n6Te9Nlo=;
        b=SVz0bJFBTxOBEUsLY/lA2P3LBg3Rq1pymEV3vyCL3XvrmerWE/7jkmR2TTSRVomd1w
         a/bEC4qJedYhlKS+eVvwzHLayPhSbjRDUMmbPmZS3P5wWZ/c40wf1sAyRyevbghazPoD
         jmSQ2H3XilQx8jyNLCnHJ+k8yaJWGMj3PMN989SQ0+ErPOnW3q8Fd73qD7pX2Hp0Nwmd
         ad+bf0zj7K4sfdwlUz5Hxjr61UbNr8Nr3hNpI95ssp0+ml6H7hC/WTLCWFQqJ85RjN3l
         L3lbcuOjIVgYwqXilSbCVP/ouVQbHuTFpMBWmlA6GkOvRiGHOgT8TiJoiThgPN94vfee
         obNw==
X-Gm-Message-State: AOAM533dw2C9ml9CxdC1IzzzgVRteo2W8jjYHkgUS1Bl9F6d3OAsgsea
        DtDT5Z9tEc6/ASA4oeFZuBQwJ2xf5nlgvQ==
X-Google-Smtp-Source: ABdhPJwvCsAMuoQC1TsuE65TV/BnLzTRO41b/Hqb4BTIHGlrgvM5jc98itr2hioUcRziSjAZzvIzuw==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr14467276pji.207.1590846640542;
        Sat, 30 May 2020 06:50:40 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l11sm2630172pjj.33.2020.05.30.06.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 06:50:40 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: fix overflowed reqs cancellation
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <955c64413e6f3883646d8fdaefbf97438f56acca.1590832472.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4eed451-8671-6620-75e1-522785a4154b@kernel.dk>
Date:   Sat, 30 May 2020 07:50:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <955c64413e6f3883646d8fdaefbf97438f56acca.1590832472.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/20 5:19 AM, Pavel Begunkov wrote:
> Overflowed requests in io_uring_cancel_files() should be shed only of
> inflight and overflowed refs. All other left references are owned by
> someone else.
> 
> If refcount_sub_and_test() fails, it will go further and put put extra
> ref, don't do that. Also, don't need to do io_wq_cancel_work()
> for overflowed reqs, they will be let go shortly anyway.

Applied, thanks.

-- 
Jens Axboe

