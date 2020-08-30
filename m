Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AFDC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE2D206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Se4sbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgH3TYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3TYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:24:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542EAC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:24:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so3364253qth.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Skpi6H+OYPmXs+7QMT/lOgahlNwn/ONRzuEk3fT9+8s=;
        b=a3Se4sbQvM/cYT12thyCZ0Y/DU9wFGyNgrHlazvqWKrMzyRlf06M0i+h+wW3O9fJU5
         xKOCgb0LF2OcUaLSdaR0at9Iuu2ElIh7Quhb7hah3YhRDCAOdl1bUiFZvfTeD68saodF
         OgU5U/ebXzxaMd4XLd/xDDliARHXqV7h9FyOzTBPrfCzrZawb5LLlDM4ad2zIHwqt5Hk
         qfVfu2qns9RRtmFxaSVoglS+phgW3Nxzn8bWqebIy4VNou61s0QZHQTng9qL+6CNJemH
         1LWhAuGWwUVrIhnhM4/VFFJS77J0bEXof9ubj8ZzRk0p9tSuGfgru3OQKGeYuLv05krN
         46SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Skpi6H+OYPmXs+7QMT/lOgahlNwn/ONRzuEk3fT9+8s=;
        b=PlkkHS0+gZoS3rVgYx+4UNaESVzFMYeSqQk9wBl+VTkSIdku9UXy7o8jh8m62sMV5J
         28qru7r2b/sTt0qsZuj1daEJ6GFT0AO74Y7brnItR+M/klZcVFxaSO22QmhvSWmHX1m0
         RbY8vGOJwe9RzGbQsgBQ4JDC08LRPh2TtzxpFx/GxMY+cLYd5o3hNoaq70lLFTSbxJXj
         CCcbQX9Lj0bURb7J7JRdFaLI3x1gTQIwjEik54TtZd0Zwl2VM196oEmqJ0ecYqqygp8p
         qN3o/vRKwiXMUMWJC2hY66zm9r8MQCERe72JbTc7SnnMP4ETruliHZKis6DTlg4l5m4H
         HkbA==
X-Gm-Message-State: AOAM530OCF7jd9weGEgwL65TmSh3UV/bqjzoNh+m35LM6spB1Mv37nw9
        KqtFjhH14tTvUgBIsKRlgFzLU+3fyfwYD33xYqBMKVuBouU=
X-Google-Smtp-Source: ABdhPJyb9qi2LXnAbvFzVyN/tfOSbhD1qiFz3ip6XgbbtB5H0Jzc0lVlB0f2iHl8Rc4gDlTYGpwJ/gI8lWuPMfl82P0=
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr10420820qtp.164.1598815440336;
 Sun, 30 Aug 2020 12:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200828033250.910168-1-chengzhihao1@huawei.com>
In-Reply-To: <20200828033250.910168-1-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 30 Aug 2020 21:23:49 +0200
Message-ID: <CAFLxGvwzTiDDLaN3Q5BSa2+7cwxBooeJuHSrgNPaM9=ONBLTkg@mail.gmail.com>
Subject: Re: [PATCH] ubifs: setflags: Don't show error message when
 vfs_ioc_setflags_prepare() fails
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 5:33 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Following process will trigger ubifs_err:
>   1. useradd -m freg                                        (Under root)
>   2. cd /home/freg && mkdir mp                              (Under freg)
>   3. mount -t ubifs /dev/ubi0_0 /home/freg/mp               (Under root)
>   4. cd /home/freg && echo 123 > mp/a                       (Under root)
>   5. cd mp && chown freg a && chgrp freg a && chmod 777 a   (Under root)
>   6. chattr +i a                                            (Under freg)
>
> UBIFS error (ubi0:0 pid 1723): ubifs_ioctl [ubifs]: can't modify inode
> 65 attributes
> chattr: Operation not permitted while setting flags on a
>
> This is not an UBIFS problem, it was caused by task priviliage checking
> on file operations. Remove error message printing from kernel just like
> other filesystems (eg. ext4), since we already have enough information
> from userspace tools.
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/ubifs/ioctl.c | 1 -
>  1 file changed, 1 deletion(-)

Makes sense, thanks for fixing!
BTW: I didn't forget about the other valuable fixes from you, in the
next two weeks I'll hopefully
find more time for reviewing/testing. :-)

-- 
Thanks,
//richard
