Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27CC4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA920637
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgCVDbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 23:31:05 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55981 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVDbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 23:31:05 -0400
Received: by mail-io1-f72.google.com with SMTP id k5so8310845ioa.22
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 20:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8nZWcNO+DrxQ4s8b90bUZeMFLENWFuwrxp+C1YlPnOE=;
        b=VEapehTBj0Ctcnh0FTulfJaPBTZMrAiEg6/e+EOXtcLQcG6zIR1BqAqjYbBjppytTw
         o8tEswQnmp6AZbQ3/no+etVcsh5izBB3kUAqRQx1HkR/UL5xGZAoJuJY3egdVGB3F5GM
         fm36qKMEe21tksQ5D7qgfqf+lNCt2bnn6WFfJPmsJlVuV9h7uVIPjJ3SuFO+Sb++76OU
         Cgo4x09jEbsdaxPhleLK2gbW3V91Z5U+/VPoWvW/MRQG361ih+i9kaxAhUPD8tlwcQ3A
         6a6AhUgZrCZITk4UTlGVCYPn7pmVVoTz3n8+b09C7LXP23Ve8fTiZh8LZqCovXbFyT0c
         1RVg==
X-Gm-Message-State: ANhLgQ0CeNnOhpKhrVCjsdey3LO2KtVP6IGiqr4pIwxTs6aQ5BXvf6yo
        ZcvRQoeEHJ0ILRETYSBCXWNKRPFSwj5n0YtXyI7ls13QIbxQ
X-Google-Smtp-Source: ADFU+vu238tJAeWox3dcwhThsCAlmUdZYHUcZI17D3Ju1wPlJpIWrvO0GOq2JFMVs0LzLmjvnsgF4PcQN2ntWGBx/+nbM9k09DIq
MIME-Version: 1.0
X-Received: by 2002:a02:b701:: with SMTP id g1mr8752742jam.92.1584847864144;
 Sat, 21 Mar 2020 20:31:04 -0700 (PDT)
Date:   Sat, 21 Mar 2020 20:31:04 -0700
In-Reply-To: <000000000000f965b8059877e5e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f725a005a1692508@google.com>
Subject: Re: WARNING in vcpu_enter_guest
From:   syzbot <syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9446e6fce0ab9dfd44b96f630b4e3a0a0ab879fd
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Feb 12 12:27:10 2020 +0000

    KVM: x86: fix WARN_ON check of an unsigned less than zero

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1744891de00000
start commit:   5076190d mm: slub: be more careful about the double cmpxch..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14c4891de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c4891de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=00be5da1d75f1cc95f6b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bb4023e00000

Reported-by: syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com
Fixes: 9446e6fce0ab ("KVM: x86: fix WARN_ON check of an unsigned less than zero")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
