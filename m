Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3075C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 02:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11302075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 02:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2Iwy7CuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRCgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRCgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 22:36:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C44C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 19:36:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so9208456pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xzu/lWarYHbqFLHl7le7ckCloeErcPzER3JbhzwwMzI=;
        b=2Iwy7CuYQGY9skcm3kHSKZV2PQKY6cOwQzZPg9GOA/a+BpAJzDQyM97flX4wlY/p0u
         vRqWyUD+ElEssJIYPSzbSN0uUl3nSZvun2VXfdBr6RGU+MfuPyt9y5j7cBl/bTqrugGS
         ahjmFzPg7n0kd5lBg4MQgY953Kf8+tOypRhFbTH+I48AkGMZnq62k9EpOmwMrMDWAC8m
         tEhS4Bc1XvWQj+SaeLPo78tONGZ0TsXTIypcecbIfY0FKU5xOYzQaDf7wswBb68AgYTZ
         9H5ro8hhL7ZyVHoMygG2lj7O9oD/VEx/Rimd+yRicgA/axsLg3hjK8RgAgy6jSoJReV8
         fTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xzu/lWarYHbqFLHl7le7ckCloeErcPzER3JbhzwwMzI=;
        b=bT7u7BXfMp+4Pvbs7ugoM1qgeJ0cv05BQ1sMHM7XfgbaTjnKJNhgEVxAX2/1jdZMNG
         Qb0WyZRj3Gzte9so362vjh1efvnZwVFZo77v4glxu2syZKLTnCuApm6WiF3V7ekM3jK4
         rs8nmFy8Al1IU96oyJVI2JY3xUJjYbxoHiVhtQkhReiuoRQFIUmNgCjEgyGsUFwWRhWK
         z4R1WRBFNX9rI0wXDJlXHDj4czR1I35bl+bdNMgCP+3iGSgqy1esEZtDDR0NKizjeZXm
         fAr0mPTtxSljiwOziFhXwYFn/I/8F4bdUiVn4AAfuOnchMZw6FR6R41HWhiUjKKxyPkh
         aypw==
X-Gm-Message-State: AOAM530kGN9a7Tywmbi6jSlzxNFTqPFHyHHQmGTEZtesCzCp6lYsxg+W
        3Ul2UzI96O0hQuJtcpmIF/IpjxG5UIY5kRrleF8=
X-Google-Smtp-Source: ABdhPJw3wozJw6r2a5xG/OIHP/XLOrwnKvgNfhQQI2xsh1x7UyG1hGYp6XYlivr0T2S+wgDSa7eX5Q==
X-Received: by 2002:a63:705b:: with SMTP id a27mr10120221pgn.405.1597718177914;
        Mon, 17 Aug 2020 19:36:17 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:cef9:e56c:5fb2:d956? ([2605:e000:100e:8c61:cef9:e56c:5fb2:d956])
        by smtp.gmail.com with ESMTPSA id f63sm20056973pjk.53.2020.08.17.19.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 19:36:17 -0700 (PDT)
Subject: Re: [PATCH] block: Fix page_is_mergeable() for compound pages
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20200817195206.15172-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79eec1be-c01f-e4d0-20c8-b4c31da97e5b@kernel.dk>
Date:   Mon, 17 Aug 2020 19:36:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817195206.15172-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 12:52 PM, Matthew Wilcox (Oracle) wrote:
> If we pass in an offset which is larger than PAGE_SIZE, then
> page_is_mergeable() thinks it's not mergeable with the previous bio_vec,
> leading to a large number of bio_vecs being used.  Use a slightly more
> obvious test that the two pages are compatible with each other.

Applied, thanks.

-- 
Jens Axboe

