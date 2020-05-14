Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26175C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035F72053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgENKoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:44:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45405 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:44:04 -0400
Received: by mail-il1-f198.google.com with SMTP id t10so2758563ilf.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hoXGVtl4km8jJ8wNjtYih/eDPSljKbLmILj3chomVUg=;
        b=Gacd2PhcMKcZmWHuTT52knSM5Ipzv/VSeHnZvPVwgR7LPmSAhSmqV9IvsOx8RnOtfY
         aQQf6w29ZJoMFHNXeNmQXjsYA6h1Cjqx2No5u5QWnL1DrpCn0Pwg/NIukxmljnO6ZtKd
         zT8OicSsxihYyKCtnErx3APVuooY9XqMT/9QROyy//SXj+c4yJCmhKHP4mN/pf2vKwFH
         QwzwnHP1RXGpEjtcBWzOeZXgh1gh4OQrfLpM0aPGVUQDeOvHJIERVMKLDIYQmIZHJaIR
         7bLKFGT2OlWydd0KWnTFGGaYQan9gvFz1ehH8reEioAhDVuSX2wKqiSAE+EabHRu8lf2
         v/PQ==
X-Gm-Message-State: AOAM532h4VvVJTsmS/pRcQoCbE7Zvg68Gdn69gwrMzRWlGcUgNr4xhDq
        J/7ydBY0i3unE0qKCB4QFTWqhRpVOk8h9it9fjlQx38NDkbO
X-Google-Smtp-Source: ABdhPJzXo+5o8hNjij+UzCHkt9MgIvEAIQE+bNQv2oX8TNmIwCsWtTIm+byzrRQU1GzPoCsb/WkxdGdHVzDOB8z2t/DmzKj+OJKn
MIME-Version: 1.0
X-Received: by 2002:a92:8747:: with SMTP id d7mr3992371ilm.235.1589453044173;
 Thu, 14 May 2020 03:44:04 -0700 (PDT)
Date:   Thu, 14 May 2020 03:44:04 -0700
In-Reply-To: <20200514092004.GA1577276@kroah.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015d1cd05a5996049@google.com>
Subject: Re: WARNING in memtype_reserve
From:   syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com,
        dmitry.torokhov@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com

Tested on:

commit:         d5eeab8d Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0212dbee046bc1f
dashboard link: https://syzkaller.appspot.com/bug?extid=353be47c9ce21b68b7ed
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bd6806100000

Note: testing is done by a robot and is best-effort only.
