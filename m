Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D136C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F53E20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf4KuVgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgGAMNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgGAMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:13:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C122C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:13:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so1729298ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tw287Wj0rT1y9xvMzyezmJaiA3ZqkKxDAyWTdh35zE4=;
        b=Bf4KuVgW2Z1nRKgLhIqnAuqFliXvxBoha2MFFMx7oO4y8XkA4sEdlo24lbzb8N6cs3
         Fc58y165gRsxDj2Cw1MqvdgVEP2VXjf/I5UT7OQs1lKr1HoKmG5WJ0uFb1rwENQ2wTd6
         KKUcQ0p7ZTjrkUyRkWKDGF6rqxsPL7xbmTjGaItHCKABOXEHck1bknQqKW1Dfdn6+mFh
         GfkNcOHgMx3yzTEMm3+pwp8Un+zUQBxFsImqJV7AxrfYdCL4EhB3IkSRyGptxlisqdSI
         AHGzIRLmFFK8BJfTZVhQaEMSRE4A5Ko6N4Gphjd7vw+Yt8O19vL5cTSJE+JRQcg9c4Ec
         60TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw287Wj0rT1y9xvMzyezmJaiA3ZqkKxDAyWTdh35zE4=;
        b=jV+dk/kyPCbVdfMKEqJT4EW9UULbkPp2iUCfqsGfCkuR9oLF5eA1zH6OVzEXb5hoVg
         a4f9IayH1oi7IqkI7aVT5IiC85pFGkTrH2qiUnUhcdLz2tgiDu0jKcoZuOpO5ozzyPQl
         tgDT6ewSjxVH6VZUhcZvWdORarLbEWwwRSYtaUeYrKMjcuAV1WAPwMDJtGmtwB5jAFco
         VPBun7eWaOk5+g48ejy1W7HjFO2FUqCVttufGTCi2J/y5nXkpZxgeqxS/kDliy2KQ1mp
         +DtWlsw35TEerDrKOD7ZKHbTdxBF9WrR+vMG6T/ldjdTzVJvl2jq6HuzCU+iglb1hNLK
         UuyQ==
X-Gm-Message-State: AOAM531CQHKSGAVAuOMkNWdk4piux7KHWWro5Xch0ibxXboNIgwtKAXp
        xTEgo//p1/K6uSEaDbP9/uB55SNWOn6IkvNIHz8=
X-Google-Smtp-Source: ABdhPJwg3vMtPToOU5TYqQME1BrTFI3j2TIB5/PPj9tmTMadGWyspXda4m2zF4s9f8NmW9eW+wsZCqMdlsEacTBI8oI=
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr6540812ljk.335.1593605580788;
 Wed, 01 Jul 2020 05:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200630005625.2405062-1-daeho43@gmail.com> <961072bb-4c8f-b01e-666d-1f5e35a8b76d@huawei.com>
 <CACOAw_wQx5wjdWDX_WFebNS42t=wBuSh_k7oQ4v7abBv80SZXw@mail.gmail.com> <9d1afacc-6033-2bae-d55d-909d50f1904b@huawei.com>
In-Reply-To: <9d1afacc-6033-2bae-d55d-909d50f1904b@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 1 Jul 2020 21:12:49 +0900
Message-ID: <CACOAw_zFLgeoomdHhRmzYMtCocTugW5AVxb2wZnoRAC9+hR9Gw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add symbolic link to kobject in sysfs
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2020/7/1 15:04, Daeho Jeong wrote:
> > Actually, I want to keep the mount number remaining to the same
> > number, even if it's re-mounted.
>
> Then once there is f2fs umounter, the order will be incorrect...

Actually, we prepared this patch for a strictly controlled system like
Android to easily access the sysfs node for a specific partition like
userdata partition using a specific number.
In this system, we don't worry about another unexpected f2fs umounter
interfering in between unmounting and mounting a partition.

When we are under the condition that we can keep track of how many
times the userdata partition has been re-mounted, we might as well use
the original partition name like "/sys/fs/f2fs/dm-9".
This is for when we couldn't do that.
