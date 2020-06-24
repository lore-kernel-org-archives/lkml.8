Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC8820836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Abuv2fru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbgFXMpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbgFXMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:45:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58ABC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:45:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so1376528pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0tzWmwEnL1LNuOR840NxOvrYGVoBsalkkpC/ourtLA=;
        b=Abuv2fru6/Pff6od6rE13vinRzDiQx++f7JKLMmu51TFcFV1zrwEaqJEO5XjB7RG/E
         xVdLOln4m0d1V8forlHVaME8RsaMSblfkAZSDWg7OHLWzCboQHUeKzpQPLcnGLlPWdgO
         TEhn/hQRFfgJQSS6WHJBuEzCdCcjhiSaio1s40nc77N5QcdWKT2BIFPQZBs+yszWK3uT
         Wrf5wPK7oHaLNCT02CNNlO6KobDMMQrpHxCNqCRr1EuZn0PvnfsDbObtjnDbQOx6yiC0
         DIx64uiTWmrTYB3WqS6/r1wpneEFSz4SSPh9NMH4h+DXESO+SaP2SYSg8zznMoa/EkYK
         BPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0tzWmwEnL1LNuOR840NxOvrYGVoBsalkkpC/ourtLA=;
        b=b2rNdNlPakqC2aGmoyhxXMviE3iPMIZ+m2/CfmIiOXaHIxTR5WqGwqmIq8WjrLr8sN
         qgu/9oKpttZycJHvuShqBK1hEVz4h8B+3ChrSnxr/2JtvvKaXIEhPLMJ25ZFbGltN3v9
         ykhKb1/i+fiHusAb52ZdyswQGyHVoXw2lqF/V04GDB6aqyKSnUItaUkRAyND0eR6bz6G
         XFS14Cv8nXU6+VT8kBkQGyYCgItUryEuduDTHSxAygnzU8WOT9RupYAXpagFJUeUEIuS
         kSUBBTU5fZYg1008JzVq/D9Hr+wnmQ29vkpAEmU99xb9KW1+zwl5isB9wEsnDA5XJcth
         IhPA==
X-Gm-Message-State: AOAM530GKm139N1IjRje5jO1IckersduCz+6XPpAxUGNytZHFB2vn99d
        BYHKIkLbj1ubgEKdYpZGyOws62+EhcD4MhkFPXiKrA==
X-Google-Smtp-Source: ABdhPJxSy9Ws3muDQ004JfgPOJ/nj14xUipC5iE0Q+QQT/5t0ysEqLOJsiaMrjk8zg9GtaCMZEVvF+lqcH7Wfb093P8=
X-Received: by 2002:a65:64d8:: with SMTP id t24mr15238480pgv.286.1593002721077;
 Wed, 24 Jun 2020 05:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009a6e9805a8c57c58@google.com>
In-Reply-To: <0000000000009a6e9805a8c57c58@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 24 Jun 2020 14:45:10 +0200
Message-ID: <CAAeHK+yu4H=2BuVhv7UMt4S0qtx_3Ngn4YLFni6nTNAQsWkK0Q@mail.gmail.com>
Subject: Re: BUG: corrupted list in corrupted (3)
To:     syzbot <syzbot+0b3de1d31a24da20947b@syzkaller.appspotmail.com>
Cc:     akpm@osdl.org, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 9:37 PM syzbot
<syzbot+0b3de1d31a24da20947b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f8f02d5c USB: OTG: rename product list of devices
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=11bfddf1100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fbe5dc26525767f1
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b3de1d31a24da20947b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11abf20d100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ea5a11100000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0b3de1d31a24da20947b@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:26!
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009a6e9805a8c57c58%40google.com.

#syz dup: BUG: corrupted list in em28xx_init_extension
