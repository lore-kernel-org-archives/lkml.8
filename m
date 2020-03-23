Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B26C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4D720722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC5UhptY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCWRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:38:02 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46074 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgCWRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:38:02 -0400
Received: by mail-ot1-f53.google.com with SMTP id c9so4086679otl.12;
        Mon, 23 Mar 2020 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD9qGn/FmD1rIVTC9XP6vGVct8WmBBkX3v6FBswGPLo=;
        b=bC5UhptYgtbbDlWbU1n91QCCT5Tl3F4HyRqvOVej/yWh9rfjkQ7q/ELO7xqpwZz8L3
         dCJd8s+ZsTxjwYOUejEJaxiANNHTaDWfk8rzn+UWhGKYl/VxkJMpE1Nff+Dpz5MyPaeE
         GG1kIvNQrOjpxKjizYgOlrHsqwbI62HNEKmMSwA52xYB5nPaXw0wuHh29vVsNYWdnN4r
         vL1iDcEWOGB2Z+GgsQaVgXOz2hWElDuUgwlT9YbOaloOIy3EFr77Jn0OjZlTcZIEgc4x
         nOQsS0hUxmmZrzcrSprEWan7EE1YjAD+CIonZpgWLBcpWiSojK5hHGkwh70jm5Vub3+6
         LyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD9qGn/FmD1rIVTC9XP6vGVct8WmBBkX3v6FBswGPLo=;
        b=P5x+/YcypsNdx/KCzOpDOSXNpo9NQgSjUdP3wVFWz5d+47o/EEjiMzQB5qOLb/Wrcb
         c65TAU6FNwuprSz1ksqKZ/55yppLZBeglC2pyPYgWPz+ZZK3Qy9Ze12zLsIMAhoK6f4+
         TREsFB6bUFHXCBXEC/XzUqBEiZsY9rCduBtSbXW49bgNvbTikZCJgfUw718BnBaGst8+
         uvVCus11JfvMt0jnl0HnFWezJeC8u98ThHxseCW/uPo4XoqDfGkbUj8K1Uhx6N1fOjMJ
         VjcY6IY+04zw5VhLjsa+OHKrxfapeHT6++1iyQSqR/50S8m7BKRPo1O4VOEEK53/GfNb
         PPiA==
X-Gm-Message-State: ANhLgQ1bjuNgKETodu10+F/0l/y+M4lYCP3fDe7SZ5Z8IN7fNHWFKoid
        ejFSUUY7Mqbp0THjJ4d8Hs2cYSvvXHY1LzYE0knTivc9JLE=
X-Google-Smtp-Source: ADFU+vtY5BuUG08awkgHy74vpXHheRICUH8sGnleTk1N+m0gvVWzjl+iL9yd+Fermo30XPv0ebF0jhoMLaVre8nngwA=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr19951523oth.48.1584985080193;
 Mon, 23 Mar 2020 10:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000183b7e05a188fd79@google.com>
In-Reply-To: <000000000000183b7e05a188fd79@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 23 Mar 2020 10:37:49 -0700
Message-ID: <CAM_iQpUW1rqttQnN9df7FX8H2R+2xTZDrSYDN11hOLRK8=ZhNA@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in __init_work
To:     syzbot <syzbot+5470940d8c65601e282f@syzkaller.appspotmail.com>
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

#syz fix: net_sched: cls_route: remove the right filter from hashtable
