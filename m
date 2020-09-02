Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59462C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3356A2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599058415;
	bh=fMkJifuCEn8uJKL0YvQ8zIgezv+eq2ISTyQs7pCJMU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjDMpiYCRQTkt2/At36VhmJZb2JHDxTfIT/tLu2usy2k1LmEP1C8EsVYRsAebhnjT
	 ZsKC3mBkgwBCme1zTd0QL9jUXyKZ/TeKHutiZBv45ft2mGTG1ebCJUZ4kD6pNCExpP
	 Sxjb8yLsAFFjkmZExWTNYsA2fj41D0uynsD2jwdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIBOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIBOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:52:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B3C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:52:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so4479461qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Umk5Ulvu4oLoYIO+HUXZ2g8XNW9wJ6mMmUfCXe6cwzE=;
        b=u1QrlX4tBu3SeweQyeFvKcbd9BBbzKPHcAtreRTlE33njRMc4xrp/YRss9Ci+1XqX+
         0xWJ6n7UQr5uBOb+HLR1Gi1qqN/3rG4mHZvtQlPi50OjxzIAQ5GVt57+5LQn4Od+lzjl
         jYGMV86QT9ZunHZEH/BhYUBDXSQblsoWLudOKuTH8j1YF7k27tHzvRVh8Y4hgcDS/6PC
         +Zk1u8BeT7PHGtED6kcFwnHyMDUoOv9vK31Qca6YjTjUNyAy3yyeOHMxwL4c1B60duVJ
         qXoKMXatMGF3ZaXHvIDSU0tDAHb6hDyN9jRZhvc6r0HNEm2oANhB8njQAruZnTk08Egb
         XX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Umk5Ulvu4oLoYIO+HUXZ2g8XNW9wJ6mMmUfCXe6cwzE=;
        b=Rb4Wiq3M7pDsMTO+sw7xzhQe3whAIXaa1REuq7/CzV0CADxhg/JjsOn7RKND6KOOr7
         3pNwuE4ZQCSvd1IlFaXoGPixKhYMIeWvDJsea9D/HjKYkQj7YiroEgCMSony+I6Gb4ap
         oNlkVgiFlC2NEg6cRzP1PigOJ5uM7XRXfpNg+y5glniVrMgZMR8MS86kPYBzG05v/ySk
         Dbf7xvAJAbLtgPAJi4kmrUKC9uCLRElUQyDGjJ1Lv2zgwqa9NefW6DaWbKvMZ0QxCvYK
         7TbJgiizkPpt1q4bpFfrwYFADhfqck6BPiiaeCoBbI70Wso1K0BQ6YJYAd0MCuvG00uE
         Q98A==
X-Gm-Message-State: AOAM531dCHrWQzsdPbR/iilY0Wxov48c4I732kht519CesC8cZswW/p1
        eVWzV0ALAW8tLsTWw4BrFf4=
X-Google-Smtp-Source: ABdhPJwtF2MnHLtEgYqsM1xBk1VrAbk4U4yp0K+SVFwUEGI/lp1d3JSafaq/2JyqeLrKZqK4fC46LQ==
X-Received: by 2002:a37:8b01:: with SMTP id n1mr7286182qkd.62.1599058369875;
        Wed, 02 Sep 2020 07:52:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id r11sm4772987qtt.2.2020.09.02.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:52:49 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:52:41 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/6] workqueue: kasan: record workqueue stack
Message-ID: <20200902145241.GG4230@mtj.thefacebook.com>
References: <20200825015833.27900-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825015833.27900-1-walter-zh.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:58:33AM +0800, Walter Wu wrote:
> Records the last two enqueuing work call stacks in order to print them
> in KASAN report. It is useful for programmers to solve use-after-free
> or double-free memory workqueue issue.
> 
> For workqueue it has turned out to be useful to record the enqueuing
> work call stacks. Because user can see KASAN report to determine
> whether it is root cause. They don't need to enable debugobjects,
> but they have a chance to find out the root cause.
> 
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
