Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F714C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B82822CB2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHEAYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:24:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45669 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:24:06 -0400
Received: by mail-io1-f71.google.com with SMTP id p17so27231519iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 17:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YcEYobWe0gtmbwSjs0eeDwSC4BGhccPAeLKXxasmpXw=;
        b=RFR81iCoG3SvWBFcNlbZAX0Eu6Eik6nSOuKRqMaCwNcwz8dtxWHK9UndjVpZi4304w
         QdXfmFlZupP6PnPmj/owDOMPItpCDwUsUKs7bi5fu4gShHkaw71genheKJdCxLHXt55q
         1YMmUPI4jw3nDfespliE3ArjbTTHpjbjFUFr0ot5CA4noRD+mqDMK4+eFr2j9kLA0PRd
         7RIm8wDN0ZZSoZFa0TZFqZ8PIrV+v+d4TnBkq/uZeCl2rc8LC2jO0qmd1YHAijMlcS4p
         XN82UdxB2hgyPtJFQ26jU40VoFyilJQ5SMlmAOtcXGkBHFjeQWVmsQRYZOMWqRljaew+
         4ZEg==
X-Gm-Message-State: AOAM532ejaz5VaAhxyS1LCXf+pKsf2+l7vn4fZL2S1e6PhISzeUn8qit
        gNzbSJA4ZBw1XfZVABLu4o00dl2d0hw4U1TwwAIKn0BNBoeW
X-Google-Smtp-Source: ABdhPJwuZalmKeWO+pHiPWSqqtn5gfgs4D6jBqCQuwsKDkM2LSlSrPL+ZsNuPLhlwiwWkpFQK5ByESHxEN/Ub93XP1IFRfUCg0KC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1649:: with SMTP id a9mr979747jat.115.1596587045563;
 Tue, 04 Aug 2020 17:24:05 -0700 (PDT)
Date:   Tue, 04 Aug 2020 17:24:05 -0700
In-Reply-To: <0000000000006d871805ac0f2416@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4484105ac16639c@google.com>
Subject: Re: WARNING: suspicious RCU usage in ovs_flow_tbl_masks_cache_size
From:   syzbot <syzbot+f612c02823acb02ff9bc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dev@openvswitch.org, echaudro@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pshelar@ovn.org,
        syzkaller-bugs@googlegroups.com, xiangxia.m.yue@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 9bf24f594c6acf676fb8c229f152c21bfb915ddb
Author: Eelco Chaudron <echaudro@redhat.com>
Date:   Fri Jul 31 12:21:34 2020 +0000

    net: openvswitch: make masks cache size configurable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110e06dc900000
start commit:   2f631133 net: Pass NULL to skb_network_protocol() when we ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130e06dc900000
console output: https://syzkaller.appspot.com/x/log.txt?x=150e06dc900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a13b78c7dc258d
dashboard link: https://syzkaller.appspot.com/bug?extid=f612c02823acb02ff9bc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8430a900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123549fc900000

Reported-by: syzbot+f612c02823acb02ff9bc@syzkaller.appspotmail.com
Fixes: 9bf24f594c6a ("net: openvswitch: make masks cache size configurable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
