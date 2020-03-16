Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1212920679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFqlVJZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbgCPSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:38:59 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39453 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgCPSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:38:58 -0400
Received: by mail-ot1-f45.google.com with SMTP id r2so3508235otn.6;
        Mon, 16 Mar 2020 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5MeuyFn7e4mHxz4tUSn4H5NtYvN6rAxu8E1UQB7qo4=;
        b=fFqlVJZf/utj5DXMnZJY1/7oZIFZxzBbgaoVuXKMwqUU36i/1OOy8SEu3fUxF6mhXy
         Z6VIy3HzZRynhnepTizhuYUx+twrzKxbmP/KwZO6ps/x9ALDyYCnKi1U/Hj7ZW4GZwvU
         Ldj+MpSplKM1g21lrlXFuygjXP8sPmAS3OXHebiVlunZc8L3w+ODe9Q49GZG4GHeZkPI
         +sWGh15AyUAPzMKB8lKC/ClzZUx6vKr5cDkmBS4LjVuzQHpU98+UKgm6LIPhOfIIHoi5
         GFUgRfJQn7lmHUp7Ee951ggLltYvnhooxe9+3vbzlc1dja0hSWSYckR+2K3/q0xWNFhh
         cWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5MeuyFn7e4mHxz4tUSn4H5NtYvN6rAxu8E1UQB7qo4=;
        b=TZRZNa+YPYhR/gWnGFf7WtOLy5w76FLpoC78QyOIXYOoCzlwGenOg1WxrL8A58p/0Q
         2OPsJ5DOJPgZWbU1HYUotTi+GTVfBDZOztjo+FtczCOSuzwxFEeQpbwPGQMD5wbboD7m
         PZpMTjd5trQBKtg9eEJRg4YLzgF3OGuf++6LFG0p9TWFRS2/+v/X5sbIcaJYW319VlRf
         Lshk4anQild1P0/mQGkHautU7vH7fybc4J2EkCQQ00JtDA0G0sTsr8iVFcWps2vBe9QT
         FvoDNLD00SfND84PjLe3kV+ROBQsa9oLWtgiFp8grHUnxFYdeT/uMEIGHfp+iYbuQlKR
         86Rg==
X-Gm-Message-State: ANhLgQ0Iqa91D5gdSXihidf9PEx0BTT/BP0inHgA2498z6gZ0GSW51Hg
        qw8XgPNOmnwxEzEwXC6vMPAH/RV9aDJpUTtcKps=
X-Google-Smtp-Source: ADFU+vuRdt3q64dbitsBauXjXkZnQqbPwYUIVUhmM7Zl9lDdq4ZPinFjgANOiz9ElZthcOh8vPTUfW7AjNjXdEEabOA=
X-Received: by 2002:a05:6830:1190:: with SMTP id u16mr481291otq.298.1584383937944;
 Mon, 16 Mar 2020 11:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e6150305a08797cc@google.com>
In-Reply-To: <000000000000e6150305a08797cc@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 16 Mar 2020 11:38:47 -0700
Message-ID: <CAM_iQpX3ozoGK0BBJKNbVTUCXOZpVx-OaJL4xcvJ3Yp9051RkA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in tcf_exts_change
To:     syzbot <syzbot+a37cda34d2b8b740a5f1@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexander Potapenko <glider@google.com>,
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

#syz fix: net_sched: keep alloc_hash updated after hash allocation
