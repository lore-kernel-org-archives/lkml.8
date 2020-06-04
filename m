Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B2B206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgFDNJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:09:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42722 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFDNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:09:07 -0400
Received: by mail-io1-f69.google.com with SMTP id v16so3564750ios.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u+o2RcyaHSofblAhvnfVshy/ql7Met8tthhkmRydCTY=;
        b=rK+KaOYvwV5puhXTVam8FUnSLMk0YaQa9/7RqhHLpA6vVJ0/iO5Q6valRQXE5E2vR0
         j3rL+FZ7pZ0bRtJOQj3MZBbeO+pYuqy7Py9V8+43cn7J5DWB4gmcAhe2h20EpE5zr7QR
         FBVb+vdktCwuoxs/5b4soqDvQj0NDbD4d0tlsLZpXUOdDuVtEV0JiKFf7ZoijU8WdtEU
         5uu5Jf3SWqNYTmI6Lm+BpAYywYZsIaoyTFz8COP+ekl8oDxbj+0Iq0ZzoyhBAsH1rVD5
         B7ML84np32dO805S2EAGjD8qYiniHjPNwbIcDgnKDOstAe/tJrki47nYAURyaJ7wO8dD
         uXqw==
X-Gm-Message-State: AOAM530piz0sor/t+7NQRDhwGO+VrDEI4DHFhBaQYgFEGIX2Vgy138S/
        cskxfCKMBPrQP40eASBW50mZCRIfimjMDn+oeXGveD+kCbaB
X-Google-Smtp-Source: ABdhPJzv0fpa1LEbfmP9G7nInep6IYlF2rdPEZ+bA0p++ozOTMgXiZEO3IRN+O2prm6dT0jXr2eer3ZzH36mkQc4A3bweWh9DzjZ
MIME-Version: 1.0
X-Received: by 2002:a92:9acc:: with SMTP id c73mr3904247ill.74.1591276146848;
 Thu, 04 Jun 2020 06:09:06 -0700 (PDT)
Date:   Thu, 04 Jun 2020 06:09:06 -0700
In-Reply-To: <000000000000c8a76e05a73e3be3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078fab705a741d901@google.com>
Subject: Re: WARNING in kvm_inject_emulated_page_fault
From:   syzbot <syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        junaids@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ee1fa209f5e5ca5c1e76c7aa1c2aab292f371f4a
Author: Junaid Shahid <junaids@google.com>
Date:   Fri Mar 20 21:28:03 2020 +0000

    KVM: x86: Sync SPTEs when injecting page/EPT fault into L1

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138f49de100000
start commit:   cb8e59cc Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=104f49de100000
console output: https://syzkaller.appspot.com/x/log.txt?x=178f49de100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a16ddbc78955e3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=2a7156e11dc199bdbd8a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134ca2de100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178272f2100000

Reported-by: syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com
Fixes: ee1fa209f5e5 ("KVM: x86: Sync SPTEs when injecting page/EPT fault into L1")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
