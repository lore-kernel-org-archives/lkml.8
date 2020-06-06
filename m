Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C4AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3627F206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgFFODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:03:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55212 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgFFODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:03:04 -0400
Received: by mail-io1-f70.google.com with SMTP id t23so7691620iog.21
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LJZAuGgzfSnkvHTmE00Iff6jeeP1gMLsIve5vPXs9J8=;
        b=bdLZQJ3p7HZbjJ4SWil/V1IVKE2GLUZMraEu7lCJabJWsLtw39+jIQp95SrQ/4uHf/
         j48xAFhnqjmGPa3b3NWnJQ9VCQtR5dLkLeU3Er5Iajz3WdpwGMi8b8bbggA84SVWGSIA
         ekWPxK7E1iPvI2nD1H/FsZeIYDKvk3H1tN2+5hLhdUDglBvSJTfzUcYxY74cvejPGolB
         7+hePo022KcdAJq782EA12R1lYYNvlySyXFmDGVaPcf6laqT+VDa3REbbhgZnRTHuTAN
         CJGJLPwNoY3gRWOwm3OaBlt40tKeEx7xQbkalSa4lad+v+ds+iYvS64lkyIa4KpqR3CC
         g82Q==
X-Gm-Message-State: AOAM533Tw4VOhg/U47OWIK0YYdjPLw5NRN0t5cPv02VSywlLhMUOXISr
        1MqJ1a07K9dfULQqO2F2tcjQlV366OQVr2m7JtqLfLevgO5s
X-Google-Smtp-Source: ABdhPJzqn+ZSrIp0x1Uvpzv2NUn6zmkiotwyelbnzRpg0vI/I0Hdz20BOyamVd6Xl18toENqbikwZsxqDbgImYnWA1pkJU5UCXOc
MIME-Version: 1.0
X-Received: by 2002:a02:998b:: with SMTP id a11mr13290455jal.117.1591452183421;
 Sat, 06 Jun 2020 07:03:03 -0700 (PDT)
Date:   Sat, 06 Jun 2020 07:03:03 -0700
In-Reply-To: <000000000000c54420059e4f08ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011eb1705a76ad69d@google.com>
Subject: Re: WARNING in dev_change_net_namespace
From:   syzbot <syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        ebiederm@xmission.com, edumazet@google.com, eric.dumazet@gmail.com,
        hawk@kernel.org, jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        mkubecek@suse.cz, netdev@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org, songliubraving@fb.com,
        suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 13dc4d836179444f0ca90188cfccd23f9cd9ff05
Author: Will Deacon <will@kernel.org>
Date:   Tue Apr 21 14:29:18 2020 +0000

    arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109aa3b1100000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=129aa3b1100000
console output: https://syzkaller.appspot.com/x/log.txt?x=149aa3b1100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=830c6dbfc71edc4f0b8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12032832100000

Reported-by: syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com
Fixes: 13dc4d836179 ("arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
