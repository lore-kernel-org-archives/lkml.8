Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BED6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B8207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gDkfhk28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHROr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHROr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:47:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92507C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:47:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so9468552pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I00K/v5IGWyheJHiS2lIodpp4CK4FglzPziGuuMIbwo=;
        b=gDkfhk28ytQgU3CBz35IY6PmeA7lBQwqB1jTz4rry6wDkbkPWr7VQgrX4pHLfWLilH
         qxqK+BnTiFQIoDCxZbQCCWYhr/+n/Kkx5LU4g6B8Kn7ufx02KGFTBOtsBe4H3OgHbTpg
         wYqeQWPmUHdxiDyjp74Re51MbuIH/TBqICaJePKJ3yVJTwjqc0e4nyAY4nYS/Uk2iyjT
         2WmFITaZXfTwyeFbYDfzei/glr/PWPtvMa4tJGwOao0bGMBno8AD0Kc/PV4O6lxY/mLC
         50F06wc/4Ri0bMv7cHkmg4FY4hJ1juHRec04l9epTwd5cDYetNkYCzK9MWc3BPMujKhh
         mERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I00K/v5IGWyheJHiS2lIodpp4CK4FglzPziGuuMIbwo=;
        b=n0nCjkNJEbJHfWR6YiS+u3XTvbUwArd6OGt0hhAFv9WzRGZzTjSdSA//mCKWYv8BFD
         VUMI5bKHc6YP5h3+Z+fu+ybrmn6GA+wWTHygbghyY/ZiEq5twITyNGJTZqHWmSsl5lH7
         /tsLuZGLHkrA5YC1hMeLe2Q5Yvq7lJIp+z4T6qPV7G4QOj0gcfiRfXWQiSE3dlMJ1vs3
         kRTjIWHplmzAFSmdqilgnTXxO24z5So9WtWSyiQhUFXReekV4dtExkWCXsTbuzCd4hkc
         z5/2pzijoykuTtUfaTVCN5el8VuXOi67WFtp/b/HCFboFmkYGIa0kIWuz1DBF4EqGvYN
         6T4g==
X-Gm-Message-State: AOAM531VmVW1iNIVMXBmFWbOjCbXLInux6K8jkyiLW7XCnBcBzujeRSF
        sPA4hQFeM3c5YfblJBAs5+j5mj/B8nJpTOwxQoY=
X-Google-Smtp-Source: ABdhPJwP0VNbB9xVCAtkVMBifWN5MY9jg03wc65Qn9Uh0ACnI5lArH/MYljt5oOnIDhJu7I6DOx8kQ==
X-Received: by 2002:a17:90a:f481:: with SMTP id bx1mr267167pjb.172.1597762076371;
        Tue, 18 Aug 2020 07:47:56 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id t25sm24446695pfe.51.2020.08.18.07.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:47:55 -0700 (PDT)
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage v4
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, paolo.valente@linaro.org,
        oleksandr@natalenko.name
References: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad125518-ef0e-90b3-d82c-bef48393fafa@kernel.dk>
Date:   Tue, 18 Aug 2020 07:47:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with stable and Fixes tag, and noted Oleksandr's testing.

-- 
Jens Axboe

