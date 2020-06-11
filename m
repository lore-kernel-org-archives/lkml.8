Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC02C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3F8206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAdfqTa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFKCF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:05:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B6DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:05:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x22so2623135lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hnHKIzS41GEo89Iuw03X5GmSxi7D1lwQQJW4EUMasuw=;
        b=rAdfqTa6+gIX/5dokn44QP7FxNEPlLZQBT4iSMRctA6FapNrfwSqgJ2c6joLmBDKe2
         KOemYJhFqy3xzk0yT3ONnQvy2RBMtcQF33RRSgw20SZRfjuFnq1PjQiSR/THpgyIA7CQ
         ZWWDaJ/dbk687ltRarmYsbZOyFfndJhnY6qNV2QuJJXYdoj/W6LdMOoEFWoaiZCXSBHi
         /YQWmFMdfEDninsH5hnglKA5NXGpU4E1wp+NFtTp9FXrvEX3kAjrewhz4QKHaLVQf9CN
         3uaVYK+SqNhS7yTuct7vtMt/wlWvWzxyi0+9+2nMuhYK0wdXrBbvM+Bp/FY2Lkh9QJ0t
         30Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hnHKIzS41GEo89Iuw03X5GmSxi7D1lwQQJW4EUMasuw=;
        b=fkZRHnFlrlucAnMZzXBKbNXuLr3VoHm9BIZ2WVBkJJQ2qdAzLjO2QYB44l3boMH/AN
         Biq4lebmC8/qE3a/gDHxAS4jBPKEMg1S6+rWnn+bgPe1AJ85xNiMfYQI1PZRxJN7wbFW
         jHP+0f0vM9TrO9bxSsZK6ISm6ZvYMsm0y+7/4xkqRN0+Hh+/Tz/U7nnKRdGoQwJfIoHN
         Q7siRi5klbM/+0eI6nHui3UK9DDbf/6coLvzjriQcmFh7ch0mSJ012nwRLxDiTbOPOmk
         u3ZDR0qAsXS6JUd9mW/Vl3P/RB+TYWqh7zE5qyXOfW7IsytF1wZtiVrAQMqVrQjRwnx3
         +WVg==
X-Gm-Message-State: AOAM530F6ad1TXfyfxZ4IQO6YuJk4BIMmKIUcC2aAnoDbvR4wrbHe1KR
        mr7atz5yG03g32HW4/yIyStelmMMlgrjxELIYjXqkYtdRcQ=
X-Google-Smtp-Source: ABdhPJzdqqERhweDWlto+RkiPjeDngTuAhrvRQ5bexxWheNvxTjVEXuD7WA3Dq8HdYyFsrbPRvJ3RVfEywt0VIlzgVc=
X-Received: by 2002:a19:6554:: with SMTP id c20mr3051122lfj.140.1591841123919;
 Wed, 10 Jun 2020 19:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200609060137.143501-1-daeho43@gmail.com> <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain> <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
 <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
 <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com>
 <20200611000037.GC1339@sol.localdomain> <CACOAw_xqHnL0MthPykSrKJ8OXez-XigCFgC-vwm_keEZh_g8zw@mail.gmail.com>
 <20200611015651.GD1339@sol.localdomain>
In-Reply-To: <20200611015651.GD1339@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 11 Jun 2020 11:05:12 +0900
Message-ID: <CACOAw_x3yC8ELYj7qSC7PM2RwpYRwQu7mT1vJhoFUQX4uzx2=w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I got it. Thanks for quick response~ :)

2020=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:56, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jun 11, 2020 at 09:23:23AM +0900, Daeho Jeong wrote:
> > Yes, I saw the implementation in vfs_write().
> > But if we use mnt_want_write_file() here, it'll call mnt_clone_write()
> > internally if the file is already open in write mode.
> > Don't you think the below thing is needed? We can increase the counter
> > each of them, open and ioctl, like other filesystems such as ext4.
> >
> > int mnt_clone_write(struct vfsmount *mnt)
> > {
> >         /* superblock may be r/o */
> >         if (__mnt_is_readonly(mnt))
> >                 return -EROFS;
> >         preempt_disable();
> >         mnt_inc_writers(real_mount(mnt));
> >         preempt_enable();
> >         return 0;
> > }
>
> No, this seems to be left over from when mnt_want_write_file() was paired=
 with
> mnt_drop_write() instead of mnt_drop_write_file().  I sent a patch to rem=
ove it:
> https://lkml.kernel.org/r/20200611014945.237210-1-ebiggers@kernel.org
>
> - Eric
