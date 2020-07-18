Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E170FC433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF39120684
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q2pKauGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGROhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGROhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:37:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE3C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:37:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so7888748pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OBxVyEg3bdADV2OFLorxOQYOlQLEYNXuUZHrmed//Yw=;
        b=q2pKauGPutsq7X/osxzAdP5R7jcR5hBKTkgNFUITBMeyRr7tGwBmdGB9kN2OFkPtVo
         gC4XGaD+1zUxruSNgagkQNlrOkj0vn70BB/iKFO0RKgU3zU3jPVdgOnviczuueRHXohG
         Y+6GFTAcJRjMeoZFOGGfkUpD8sAsx6enVEwELdO4zoPNdjxGCr6Ad0z4DxarEjMBlwBM
         n9/vveTB0K+Dn4nbCUTi07m+MAQC3gMss5Iaa+sx/RA6IrYz9HBoiX7WAcj3lLQ6IJzi
         QBpKtiGi/Lma/Vqhkkl/DUhrKgTFI188Ed2YhkainYCc8LisQ6magBWtWF/HAw+3loww
         rKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBxVyEg3bdADV2OFLorxOQYOlQLEYNXuUZHrmed//Yw=;
        b=L8F/CXI7V7p33NSAd1kO4LSbHRBgNr5gafbwCTqlqck1Eknb2rmmSJ3Dzkb+o6O0gL
         63PhcGuJ25bv/Y+1Ww86YWP12D4/wnv8YtFEpRupR4G/RAIRt2XNa+0Exvqlw0B4haPT
         3eck+mv/y5xKF7aJaZZ+S/S5+WaL2bbMjuHQzEckSIoNEAlmsRMceU4Si100HFn0gGUg
         8jiq4n1g4U+yHHUMJnGgnunW2W0bBA2G3K9mPOtyyHuX2pvkI9qOVCdk3AoIu0Lr1cGM
         PAr4ttRdQnJhQc4FQnYobNqQ6JaRaVMTz4rQ7q02G9QzUCGkxPsYG7nCB5ieD8s0U7Ne
         LKZw==
X-Gm-Message-State: AOAM5302ifnauOA/WYM69ebtd37Gp1LuLJs6mXikWG8kMt9SqDCFMMx7
        FHeHn+x16Zzn5vRpQgaIWnAr60+Kr9q75Q==
X-Google-Smtp-Source: ABdhPJwXzTRqkExLgXXpeJ9pKSnTxCd2wGCBsaRl6vw30r3m2wm8UvlbYoxwS/CEUBpUgKiBOWi6WA==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr14758483pjy.175.1595083026148;
        Sat, 18 Jul 2020 07:37:06 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y18sm10841886pff.10.2020.07.18.07.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 07:37:05 -0700 (PDT)
Subject: Re: [PATCH 0/2] task_put batching
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1595021626.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf209c59-547e-0a69-244d-7c1fec00a978@kernel.dk>
Date:   Sat, 18 Jul 2020 08:37:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1595021626.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/20 2:32 AM, Pavel Begunkov wrote:
> For my a bit exaggerated test case perf continues to show high CPU
> cosumption by io_dismantle(), and so calling it io_iopoll_complete().
> Even though the patch doesn't yield throughput increase for my setup,
> probably because the effect is hidden behind polling, but it definitely
> improves relative percentage. And the difference should only grow with
> increasing number of CPUs. Another reason to have this is that atomics
> may affect other parallel tasks (e.g. which doesn't use io_uring)
> 
> before:
> io_iopoll_complete: 5.29%
> io_dismantle_req:   2.16%
> 
> after:
> io_iopoll_complete: 3.39%
> io_dismantle_req:   0.465%

Still not seeing a win here, but it's clean and it _should_ work. For
some reason I end up getting the offset in task ref put growing the
fput_many(). Which doesn't (on the surface) make a lot of sense, but
may just mean that we have some weird side effects.

I have applied it, thanks.

-- 
Jens Axboe

