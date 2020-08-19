Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF46C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800AC2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GHo2+Xcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHSNEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgHSNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:03:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA6C061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:03:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so758053pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xSNMFlLKMxGrhzSOSB0eVoDmjD0XhuL86GrYJiKVF9s=;
        b=GHo2+XclsexMdeg0w7FyVGIexz5XELUhRHnUFYi4SnpLXT5E1N7oEzYpR8ESQgtniR
         wnVamMa7081QYZKDuDgIyLiIdkMMLbAKLRYSAGMkSTD8yqB1mcSsQuq9+UfA9E1tbzrC
         j1Cw6sJd2TwupmTCxK8wYYZgh2FnwZkkXnshSViILSmakfWAHMXRE9k+VBLDMS9la8zb
         9qzrsVI3w7V9phaJDNQk6u/A7IPGj7R5+M3BksfnHX4Wa2HO+n1VpHS7mHhXu7oDJ4C/
         LzEi33SzL7tu/LHzIK1SsOYn+7kqGMG9eVk1BnEPgtcKr85GLb1OQNiJjr8hqFM38faL
         RHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSNMFlLKMxGrhzSOSB0eVoDmjD0XhuL86GrYJiKVF9s=;
        b=Z0yfKl1JTxwDaKcJCRAJIw9rrXowvygpHhRW+RxAoJsvYz1IPPMg+k8e14sMANFFVD
         Dp6y7PY76HqaYqnoWo0frf2mNW1nj0MLfJ7jzzFlZ2DDi8IGk3b3gEYAhRsVkE6kjS28
         oEiIRelVqtzZHmMrw9MP3dMPhTGLRksQy90/sNTS4IUuAlyIGZ7cxe6kieye51aaOgHu
         hbRSoNYB9eAoetrvQTJr3QjINLwcBYLCcbfLBLxedZxfoMRnz9nli/+j7KS7r52+fTnh
         p9YBskO5/cshYkMOS9AQZ+YtApcKoWv1qbxVfAVZcRELa9Fc9NtkHiSFK5y4x5KqEvL/
         abwQ==
X-Gm-Message-State: AOAM5318+7LwgL2lj9f8cmuaF3gWsdjtYih6cCejsRImFmnM+R8MunaS
        Zmf6Zc5w91xotWkDttahqnt9Tuvf47G5z7In
X-Google-Smtp-Source: ABdhPJyAqDKTIKjRMLUlf2JvyMO4Oq4Y9F0jTYUv2JtPFsTI/9cHbkbI6REdfYKzhINRhOdB2CHhWQ==
X-Received: by 2002:a17:90a:cc14:: with SMTP id b20mr3862322pju.1.1597842232486;
        Wed, 19 Aug 2020 06:03:52 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z23sm24146798pgv.57.2020.08.19.06.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:03:51 -0700 (PDT)
Subject: Re: [PATCH] rbd: Convert to use the preferred fallthrough macro
To:     Miaohe Lin <linmiaohe@huawei.com>, idryomov@gmail.com,
        dongsheng.yang@easystack.cn
Cc:     ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200819085304.43653-1-linmiaohe@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1968d5b6-3543-a213-4118-9c36f9a48343@kernel.dk>
Date:   Wed, 19 Aug 2020 07:03:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819085304.43653-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 1:53 AM, Miaohe Lin wrote:
> Convert the uses of fallthrough comments to fallthrough macro.

Applied, thanks.

-- 
Jens Axboe

