Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07317C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD718206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIIRdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:33:13 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:45172 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIIRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:33:05 -0400
Received: by mail-il1-f208.google.com with SMTP id m80so2581270ilb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 10:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RHMlrFnyT8+nnCdXnH2Ubi2xomtVoDFKOV1HfEi/xqc=;
        b=TOm4242BYPJqWdzp6ige8LM8bq0lXExiNlq8yAkF6dqhQnZuSe/Rb23qhxk4Tj2GTQ
         bwMf4buURdFitgSRD4pwhWL6sGVf35HLv/Pz2ijGp/7Z1us85qCf/PD5TTFmlwVImKtS
         9Ih+hNy0AtWRA+MRiR2dIe2XsTZ3wtb/4NVORVF05wB6rgStAj3zbW+exBJWOakBVMIa
         J45rCLIJQPaGoBS+n9rxEA0DZ/WjFf0YLJ7c1UotwOy6MLMDQd8QaTr5Srbhz8OpHiwJ
         aSgO+Br9TjtwPQh7O/M7SFAhUffn84fBk6tCrldPm3p9Gqh1Tp0BlwvJCscjcl+ng+UB
         h0AA==
X-Gm-Message-State: AOAM5322a6fSPE9Ss0ZLsroJzUJZ0igWMrVX3wpHGq00r3tuReUdRzT1
        fb7e3IaoDCuxjalrhS2JzmjYvQ47eQW9aW3vbOTDtiZo6sF6
X-Google-Smtp-Source: ABdhPJyNupsiGDsWmTApz6JVaSUS/fwP2D5CJ9JpvXMOFPEVQiFV/GjMBhqHBVyt/XzP+2adiM0zjw6ybub5rASmH6Y7wJgFZliO
MIME-Version: 1.0
X-Received: by 2002:a92:9a92:: with SMTP id c18mr4633497ill.293.1599672784753;
 Wed, 09 Sep 2020 10:33:04 -0700 (PDT)
Date:   Wed, 09 Sep 2020 10:33:04 -0700
In-Reply-To: <0000000000002cc32605aedd876d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017994005aee4d82d@google.com>
Subject: Re: possible deadlock in _snd_pcm_stream_lock_irqsave
From:   syzbot <syzbot+561a74f84100162990b2@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        arnd@arndb.de, baolin.wang@linaro.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        paulhsia@chromium.org, perex@perex.cz, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e918188611f073063415f40fae568fa4d86d9044
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Aug 7 07:42:20 2020 +0000

    locking: More accurate annotations for read_lock()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112dc243900000
start commit:   dff9f829 Add linux-next specific files for 20200908
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=132dc243900000
console output: https://syzkaller.appspot.com/x/log.txt?x=152dc243900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
dashboard link: https://syzkaller.appspot.com/bug?extid=561a74f84100162990b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1209e245900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154b15ed900000

Reported-by: syzbot+561a74f84100162990b2@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
