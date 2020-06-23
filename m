Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E0520720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0k8t0i4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgFWCHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbgFWCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:07:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72BFC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:07:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so9332059pfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QOm5EabQil79oRIDyKLFUlCceVcbXjoYyZLpqvTcrjY=;
        b=0k8t0i4RvIrBtM3Mt4Yr1bNh2TVQcxKikDQz2GdlyuTA1VOTnNt5XAFyGMcSI5uR6k
         n0uIPouIzW5HYMzkNdics+757VMBE5uPliYM8WgGq88yThdkuvyQRmCElcrxoO77GCq4
         2FLfiT255DJQUvWmdcnNJizv1VQCgJwJtGjv4A8MpW9FnhLIKbx04z/rQt0ht2gI52dF
         lvvA/3FTJWUt65LbFg9e9qUs6qZ4W0KjYtcLQUU7AXxiKr61OW05zpaonAHT2t7J7KG8
         yPpaSK1UOFD00EK7BU8ASUZA59xw6e+tA773ckc8kbeu8ifvW7D/bYlZk2Io8AEYBaBN
         RAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QOm5EabQil79oRIDyKLFUlCceVcbXjoYyZLpqvTcrjY=;
        b=Sw82v6kk0Qz/mpXZ0RvUbV9ASOHEQjxqNBVlD0CZIxon/M3Zb9cHp0J37QJYJ2PIM2
         nv+WxCcnGJ9ySYF5jADgab3eOAbNpBb5sPieZAfJdFh3LcgF8Igk00sodkPj0b1qXnu9
         LH2ENpRcPNvJJoiQcMTnrXZ64GmzF1tpd0397EkzsEb0lyowSoqMODbretvi48tBqtHc
         ZNlTBQD37bhHuuaayFY/7kxCGJLdN7mJtp5M5nLptpJEi99GdPgzqAOhIucJnfp/Y50N
         kctgCUaxCoji93ck+v8pf7jKZnfUDFqzxpEzz5IpQ9tU09vvIwOjx5p4WArLunbXAMi2
         iqhA==
X-Gm-Message-State: AOAM530VoPZtGyzH30TZ8cDMI2dnK/6YYQSAanq3G6rNjnvOr0xP/7Ko
        4VomA3RKeKWsA3x/oV85mysS+FgeKkQ=
X-Google-Smtp-Source: ABdhPJw94uoq/K9Iipm65Xe0Q66mVD78trrCzAi227lmGlTt329brjR6l7a0Vyww+n+kXhULniizvA==
X-Received: by 2002:a63:b956:: with SMTP id v22mr12208931pgo.242.1592878051945;
        Mon, 22 Jun 2020 19:07:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y12sm15273461pfm.158.2020.06.22.19.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 19:07:31 -0700 (PDT)
Subject: Re: [PATCH 1/4] io_uring: fix hanging iopoll in case of -EAGAIN
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1592863245.git.asml.silence@gmail.com>
 <0301f35644823a01cbae87e440df7d58ebcf2279.1592863245.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95b720a6-926c-a208-e929-1d0203fa8701@kernel.dk>
Date:   Mon, 22 Jun 2020 20:07:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0301f35644823a01cbae87e440df7d58ebcf2279.1592863245.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 4:16 PM, Pavel Begunkov wrote:
> io_do_iopoll() won't do anything with a request unless
> req->iopoll_completed is set. So io_complete_rw_iopoll() has to set
> it, otherwise io_do_iopoll() will poll a file again and again even
> though the request of interest was completed long ago.

I need to look at this again, because with this change, I previously
got various use-after-free. I haven't seen any issues with it, but
I agree, from a quick look that I'm not quite sure how it's currently
not causing hangs. Yet I haven't seen any, with targeted -EAGAIN
testing.

-- 
Jens Axboe

