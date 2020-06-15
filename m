Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5E220739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UV0mod8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgFOPFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgFOPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:04:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA153C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:04:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so7922750pfx.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vbfKhiMK9FyLJ1R4wzHm2mLCW6oCsbN/2Vi0OJTPAQo=;
        b=UV0mod8bg56pi0FyFJpgtMlX23de2Qm5wpkixqrt/9rDVU8HADl5f3aptV1rzGXfOc
         pdvaO1DPQw/7ZN2yh1ipYAxvd4STNxMN40fG6yYJjYYciSOWbbK2xQh43Sme7Bfh+0dH
         gH8kOHv7RSrwH7tVO8IdxgjKLzQNji9ociZNigE12wE/ZOjwhHaELO4xGjKlIkrkUYDF
         LWMMZW1dQT2alUOz/xDDBxSE98NHQ1W4jGIm2ZLc2VCNpTjzzK89m0oSUfByWMXvEaMA
         2mPQPJE+ZJTMGqO1PcUvZZZXmRFNbXYJKIo++8x5u6P+7OLhQ+5H86ksYFaBwEQnd8Vp
         U4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbfKhiMK9FyLJ1R4wzHm2mLCW6oCsbN/2Vi0OJTPAQo=;
        b=CMt3vS8VdAAyy8cO/0J19e3Iq1b2Aej2n0oWIZpSZLhLtWGWC24sBDEU12qMulXVeU
         VItq1viifPXh8olDbKHXN+r5F+bdraRdgnRFgIMUr6LnM8k00FuNa9ecT8rptRxnZ2eW
         B/TUa7qxP+NrnsM1B3BCiDlXfqWCgf4wq5k/o3STECjZPugQLaxWUYSbQqyJT+nL55YB
         M7UhrQAR/yraPj6r2geAaWPKytq+lndvJx5WHz3PTFA2qcGq4hGqKaQzZ9v0JMRSTGIA
         onwObR76NWagH8Nlkkanzl0qz+x15SaOzYAsOjsEwkz6lp5nrGZYGu5/PxnyzXSmIfcW
         XlMw==
X-Gm-Message-State: AOAM530xuw+zVwN4tzrKNS9F7/ofwj0kwweRYOWq63ZgVRhAb9x0Yd84
        LcPCnFsolY4fURaNqJ5aSI/gAw==
X-Google-Smtp-Source: ABdhPJzkLU5Mcmvc37UJQiY2VC0UwaTdz+1le9AnlfiahfbjtwzkcjdaekcYs22ELcQo+GXOxRaqsQ==
X-Received: by 2002:a63:5c55:: with SMTP id n21mr20644016pgm.27.1592233498289;
        Mon, 15 Jun 2020 08:04:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b10sm11376026pfb.110.2020.06.15.08.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:04:57 -0700 (PDT)
Subject: Re: [PATCH 0/2] don't use pid for request cancellation
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com
References: <cover.1592206077.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b90fd1d-c60d-523a-b6b5-6c960ae52cc6@kernel.dk>
Date:   Mon, 15 Jun 2020 09:04:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1592206077.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 1:33 AM, Pavel Begunkov wrote:
> Cancel requests of an extiting task based on ->task address. As
> reported by Eric W. Biederman, using pid for this purpose is not
> right.
> 
> note: rebased on top of "cancel all" patches

Looks good, and I had the same thought of not grabbing a ref to the
task for the cancel case where we don't need to dereference it.

-- 
Jens Axboe

