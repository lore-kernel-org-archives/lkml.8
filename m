Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97162C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6556B20866
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLQ1bbKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgCBVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:14:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36860 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:14:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so631386wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5matOJha1/pSHqpUD5pSs/+tLZfS/76GQlE2SX6b0M0=;
        b=WLQ1bbKd2/Yex4Q33Lc0u9NSdLhA9uHVbuYnOCrpz42gx4tDvnHyw37bkof+kxeg2g
         hJL/C/z7x+8qQSerlbyXUrA+K3/C10b4OngzKpAfFvgu3khnAIbSkWupZe0JF3C7h0fO
         fWbPL2ZpUuliXUNVKUpMceOP2RiYIhRRWQBORtNKsV7kISGDOYJmZbEAQjziwXAF6JVd
         1is4yQOO2QbvNBTQfj30G0Vm5wRIj0cesC1Kl1mxS2yI34qeBf+Cuez5b1eHJlDQehQY
         qHQ5hqvBMzE5OEhaeN+0Ln4OUv0VaZ0gs4P6ZNoybjQnf+yZ355jE8DP5XqYRQdeBjbO
         4sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5matOJha1/pSHqpUD5pSs/+tLZfS/76GQlE2SX6b0M0=;
        b=L1twUWwSjBrcfguOiDLnGXeqUW1d4YbdF+mFiAqzYr23nngQ+EI2xNJYT4OwKSPXXC
         fBIOBCh8tCa85K3+QXTWJmUdzZQGoamcD3TqluUWc48BC5louPsDr33lRZuWlU+Mwy5i
         /eFCo4hKioNBRWz2kDu8W90B5iNG02XOvKFFKueWwkgldfcCz/Pf6cuuI6tUp/r6yVeB
         m/5/luUJzOQEyZ8wnwLenNaX9qDgSwN2qkdiQihDHos2N1NCPO8cp6naPYppIsBspA8f
         wo7VfDPugufAtAoSVhQDmxBjSZInH+Q5XjSfcFaD4YpgGMgYWZ2geBzEQX4qw8qryQ46
         IarA==
X-Gm-Message-State: ANhLgQ0rs/T7krFwZRVW3k8Blv43RBVHWrfLkUM5/zp87nszNtNT4BsV
        1x8aqO2NsTK8e2faj2mQQNqAbL39VA3IYxbTbHU=
X-Google-Smtp-Source: ADFU+vuMf9SHRTAY+xs2I9u0Kg6nZacUjd/Ddr8o3fzGXr+IXjL892fsxOEvPf0cdRZOV1l6TiW91JlFQ1aXGbvCJbI=
X-Received: by 2002:a1c:208a:: with SMTP id g132mr279108wmg.143.1583183683752;
 Mon, 02 Mar 2020 13:14:43 -0800 (PST)
MIME-Version: 1.0
References: <1582293853-136727-1-git-send-email-chengzhihao1@huawei.com>
 <CAFLxGvyJdWcXQt3H2aknTuGhCJpV5YvAbW_wuHfs3m+KcNSjtw@mail.gmail.com> <58b11ca2-6b91-52b3-bc75-d44abb202cfb@huawei.com>
In-Reply-To: <58b11ca2-6b91-52b3-bc75-d44abb202cfb@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 2 Mar 2020 22:14:32 +0100
Message-ID: <CAFLxGvyYFEiEe108Hf_TO7q0ZsiLPswVsgPBQOU29aFqebD4XA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Don't discard nodes in recovery when ecc err detected
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 4:58 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> I mean, the uncorrectable ECC error is caused by hardware which may lead
> to corrupted nodes detected in UBIFS. I found uncorretable ECC errors on
> my NAND, in the environment of high temperature and humidity.
>
> At present, UBIFS ignores all EBADMSG errors, so the corrupted node is
> only considered in being caused by unfinished writing. I think UBIFS
> should consider the corrupted area caused by ECC errors in process
> ubifs_recover_leb(). no_more_nodes() will skip a read-write unit. Maybe
> the corrupted area is skipped.

Well, if your NAND data is corrupted by your environment UBIFS cannot
do much. Sure, we can paper over some places but at the end of the day
you will always lose.

What if the UBI VID header becomes unreadable or the root node of the
index tree?

-- 
Thanks,
//richard
