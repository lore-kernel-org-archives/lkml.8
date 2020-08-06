Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42717C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E095204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2YT/+ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgHFQhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgHFQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:35:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18BBC00216A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:09:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t6so39467093ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+FOmc3x4TlSIosvK+g/xbYJM2PQZPI5ZqFQRC+ljXI=;
        b=u2YT/+arQ2RT6JROfq2KclPiQp4+Q216/ziCsMWXtr9rNVYLBKRtFK6ZbJSSZd9PYp
         5MqQNXTpoE134DxS/Ec4aZOqUZhhsNxTmENZl2EeRinjavid10hIqBUv6oodlANe2SwJ
         Kgbbr4M0hEbLoS3xuOqRoMJJeYe6WoZc+FcByAn/5tnb0Igg/cKQqjhCRvI1S/A6XGJX
         tT1cbjFaLMp6GR6G+c7MoR43IwUXP0mxYZkfLALzluzzkTyur3Tqos38pP4hyQb8sxYh
         QHLR4fmX4aH5ThtvTDuFmbwBgcAmc1pcTvKTdlrwiGhQyPcdbaphs4xVm8jECht9r5CL
         thww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+FOmc3x4TlSIosvK+g/xbYJM2PQZPI5ZqFQRC+ljXI=;
        b=Lcx4RJ8dBK8kU59mHPY5Mm/G0JOaCIfv85rvRdELaGbGz/HPWFLOd+x90ZV1hjro/n
         h5zy+64p/XdC4I6x/T8BXcbvhc869a63OIk1hShIvZiWtKRLeeyFbiLiVVsHK7BXNMgL
         b1J2IKkJOjqC31DGXr3f6qmWro11IV9yKLd509fpv0VmucutOGmSOMBaNRluHi/yb1Nx
         SPK7XcLKjK5OTK4mkT683nVfS7SW+pAZkqY98xKcNhkb0pCsZ3iTHd3MXeMHZKFjl3Wo
         7Ubb7RKRl4bvOAl/hGq3pR57Jj/NSbROw37vHGT5Nw+hG3JWmf72BP9mIIrJahgy27Q9
         JpZw==
X-Gm-Message-State: AOAM532Abmq9asscz5dH/9hWHFnxFicQEleFO4s0J+vBzVAR2GdmwYax
        XtkrIUonR6FxZosgSF4hsnJRedE4WeaHoY4GwjuZ+ZzzJLw=
X-Google-Smtp-Source: ABdhPJw3JV+p1U0VEzzIMl77foo8ILJLvSfoLsNoqG/VsjTgotZRib0SJ53kgAs7YyHWHvURuABt6bcvPtjKrx6CBT8=
X-Received: by 2002:a05:651c:543:: with SMTP id q3mr4132966ljp.145.1596730143553;
 Thu, 06 Aug 2020 09:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006925ea05a69d5bfb@google.com> <000000000000ecb92805ac33a761@google.com>
In-Reply-To: <000000000000ecb92805ac33a761@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Aug 2020 18:08:36 +0200
Message-ID: <CAG48ez0Rdut=HxSyKUCiCVU=zZJPR7YXcOfL3tRBXXwUS0iKxw@mail.gmail.com>
Subject: Re: WARNING in binder_transaction_buffer_release (2)
To:     syzbot <syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:19 PM syzbot
<syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 4b836a1426cb0f1ef2a6e211d7e553221594f8fc
> Author: Jann Horn <jannh@google.com>
> Date:   Mon Jul 27 12:04:24 2020 +0000
>
>     binder: Prevent context manager from incrementing ref 0
[...]
> dashboard link: https://syzkaller.appspot.com/bug?extid=e113a0b970b7b3f394ba
[...]
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: binder: Prevent context manager from incrementing ref 0

I think this issue still exists, syzbot probably just hit it in a
weird way that doesn't work anymore.

This warning:

case BINDER_TYPE_FD: {
        /*
         * No need to close the file here since user-space
         * closes it for for successfully delivered
         * transactions. For transactions that weren't
         * delivered, the new fd was never allocated so
         * there is no need to close and the fput on the
         * file is done when the transaction is torn
         * down.
         */
        WARN_ON(failed_at &&
                proc->tsk == current->group_leader);
} break;

can be false-positive if the sender and recipient of the transaction
are associated with the same task_struct. But there isn't really any
reason why you wouldn't be able to have sender and recipient in the
same process, as long as the binder_proc is different.
(binder_transaction() has a weird check that refuses transactions to
handle 0 based on task_struct equality - which IMO doesn't really make
sense -, but transactions to other handles can happen just fine even
if both ends are in the same task_struct.)

Maybe the best fix is just to rip out that WARN_ON()?
