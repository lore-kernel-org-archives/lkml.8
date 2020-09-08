Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C263B2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="J4Aozqdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIHVWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgIHVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:22:37 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 14:22:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so479254ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqOh6m3rLnlC8ajqd5NeDF4oaHEgZ3CJ+Z2OjKrzUuc=;
        b=J4AozqdwEKhDUAF8qiC996g76KjEa+7fEqijzj1IFbCJEoXLhNG+Nrp0d50v6SzQzQ
         0uMGM41XDzGUpPiQtyQbPJ0eME8YRxb1Cnjz2IE6qrdgGZYl1ejj6n2uUX6pmNj+8rqH
         z0x+ZG76FWV/i42HQSlOGyd4mIfoB3DMKskJQMoYkyIA4qDxccFXw3QsJxJa7JJNdaJg
         mRjXd9Dgsr1QqCoTmoxMC8l3Xd/GAJnafq2Gxr6w5P42JzdZY8kHj6qyZJ+pXhdWhIVE
         jOXyBnV+6IKcft3XKG87pIdf6nyFg5pkYc2zr76bhSk6vtD7FJETscD3DmITNWD4nkPF
         rbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqOh6m3rLnlC8ajqd5NeDF4oaHEgZ3CJ+Z2OjKrzUuc=;
        b=fi2OjzGZ8eEacj8ji6ytg6HXczPI2p9FXCQsYR1Qu9R9PwupcpKWFAW5glCPzAy0+T
         J1653BRbv+vN/vi/9iYH8h/cO2tT3T6vYi/NF5vm7n4N8dwgue7GErpWGKVjQ92udzHi
         G348bC2ZUVGMtHim3RtHnMm7GewfrNl6tJWyqO9QddnXfbhUmTHJnDYQDv770LhbiP8z
         vmAEYcyoESAyIVfiM2TSiUCNNN0v2boXbqBI7qRbpdQLzxwy1nC3kzkT5pe0he+x7G+6
         qZDyyy22bDbcixy2HoLuf53oQ+4KFYuwm1O8/kLfygqlwqXWAsuFJOp364aub/JbBtVy
         cm3w==
X-Gm-Message-State: AOAM53078bsiGGBkacrRORLhEnIQYmpjGWuFejYkXxhvU57L9CPq54ee
        mHbpRwe1FlAGMu0wueJ4JdO5jBdjIC2YLBcJj/Ak
X-Google-Smtp-Source: ABdhPJyKvVm5mCUhxRz1wocuTCtuocuPD14pIldrj3Y3TUjT2RAvb0w0smMDFxSMcrS2qzG/vcpJ24LMokTS4CQ84OI=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr375281ejz.431.1599600153969;
 Tue, 08 Sep 2020 14:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200908135915.22039-1-wanghai38@huawei.com>
In-Reply-To: <20200908135915.22039-1-wanghai38@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Sep 2020 17:22:22 -0400
Message-ID: <CAHC9VhTMmChHskO2K8GchSxX06C-XdAVVQu9Gfih1BH-=eb+uw@mail.gmail.com>
Subject: Re: [PATCH net-next] cipso: fix 'audit_secid' kernel-doc warning in cipso_ipv4.c
To:     Wang Hai <wanghai38@huawei.com>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 10:02 AM Wang Hai <wanghai38@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
> net/ipv4/cipso_ipv4.c:510: warning: Excess function parameter 'audit_secid' description in 'cipso_v4_doi_remove'
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  net/ipv4/cipso_ipv4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for catching this and submitting the fix.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 2eb71579f4d2..471d33a0d095 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -498,7 +498,7 @@ static void cipso_v4_doi_free_rcu(struct rcu_head *entry)
>  /**
>   * cipso_v4_doi_remove - Remove an existing DOI from the CIPSO protocol engine
>   * @doi: the DOI value
> - * @audit_secid: the LSM secid to use in the audit message
> + * @audit_info: NetLabel audit information
>   *
>   * Description:
>   * Removes a DOI definition from the CIPSO engine.  The NetLabel routines will
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
