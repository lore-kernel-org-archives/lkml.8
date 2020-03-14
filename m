Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D662074B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAAimfC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCNDGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 23:06:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36524 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCNDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:06:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id k18so11697082oib.3;
        Fri, 13 Mar 2020 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=NAAimfC0p9VaenVIBoNc/nXoUJmTfCBBHj9MpZpCP7nHRHcLBzmm6zUeHIBZvVtWRt
         mJ5R3vyondjX/f0i3lscFfQ5x2Nbau1h3IfKZw4q6ejGhglYAXNCxRJZe1YV1MOxukPD
         +FayuF/OqdlrlnEVzzfre8Yaok9gij1C3LmCcUAZJZw79Akd04ifEGqhJM50bffXCVnl
         vEQrcXfsuKn07yLI80azzBdAtJmEdMQ+LXmejItwaKiwjuKjcnpaZXMtPHsxQdi69Pqj
         XNCoZWP8/2wQORG18Y9CcYRNpe+2SQwNRpDZTAq+8lpGZlKJUphCV0fEjr0plp3buouR
         YITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=ugHzi2zA2tsQGLvRER3WGtAIYDIO7Mw7eKptjM8isy7aWMbl5858v646QBqAvNvKR7
         dbDzDNl2FCQJMQeBp9D90cD1oXjLp+4/zBhkQxMypYIUonKLfc3c5X+mfhR8DEb6q1Nj
         d4o4HjXToDswQXB5KQTS8qYggb0Hoc7VdJEXZbfDLqGcQNJ57D8qpaIoeljypAGkysG9
         eZmVjnpP8HHpVzNTjTfdoJYJe2KdxLrfNhqCfVrrYb0c4ilnzTulNHtcaL4IYQe36UzH
         IyBvMrMKCVqxrn9SpD8ZCB3k46IogAVLVxMBHyIpRmDVTN0HMG3Pum2N1yKUYe6xCkIQ
         TMwQ==
X-Gm-Message-State: ANhLgQ1D1O+0jmumXK+PBn4Ttk77QE81oTR0LDS6i0cAPT88zoaXOAyY
        GXxMqbvxTlnzobirdwOPg2NtV1/0R2IcQPf8HjQ=
X-Google-Smtp-Source: ADFU+vv+zz6mLJGMtBLZeG/y3TyjgadbSgFd0aMkwIDIez8u0HV/7xNg+u9i1KofFi51L+0wEWOj9FIqxKLcdYC4LuU=
X-Received: by 2002:aca:d489:: with SMTP id l131mr9876433oig.5.1584155189018;
 Fri, 13 Mar 2020 20:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bf5ff105a01fef33@google.com>
In-Reply-To: <000000000000bf5ff105a01fef33@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 13 Mar 2020 20:06:18 -0700
Message-ID: <CAM_iQpUo0L0+J7aGTvUsBWZ=A8cGxyN7oJVjqyent+9OCbJ_Jg@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in tcf_queue_work
To:     syzbot <syzbot+9c2df9fd5e9445b74e01@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/congwang/linux.git tcindex
