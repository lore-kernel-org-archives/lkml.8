Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE00120FC3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHVHbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 03:31:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51645 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgHVHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 03:31:11 -0400
Received: by mail-io1-f70.google.com with SMTP id z68so2345431iof.18
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 00:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=st/hVTe2E9UvLC8UmO2GkUboqUCZ3XQhCIkbhqXTjpA=;
        b=WL9Mq3voFHKKzKzDsd0BdmPsh2O2VGMBoO/8PB7hFRtiLGrZ7FbxOk7NITantIKozu
         L1g0wtPL/PTT6LFIuPuK0lR17hUlwwku85gfshs3jYpJsiQ4IBxV0NtD9kmY3sTpAoeJ
         gZV7P8QTarQrYh1nYBLqa2ZX1c/5tE2aITv6AhZ5RzSBOGxJVNof8FhJWJ8ODkJJqClL
         vOeni0toGFrRtM5zZu1VuJpoV2RK6RrhqIz6D6s/h44P/G0Rf8a48Dm82YyK34phlM72
         hG4MsHThBEq165ZWOCMlaJlStiLEyEIlKL0Xh+lCeoJFAf+s4T+OQBGJ2GXsfDFlDzbI
         aLWg==
X-Gm-Message-State: AOAM530+ROq4LSsCQ7EK2Sx4CNVSJYybFdauIC/l2DCblpiAJ8sNseFt
        zokeSDmQA/l6GttXMKCDg1iBYTN2Ck3CEAZEhFMQzvr/TFts
X-Google-Smtp-Source: ABdhPJwDJ03bPMLLffCjApN5HVm3XE5CyNuvzwhwK3nMhUQDfP0iE4Evksxu0fstZGt0Ojjv2WExu+Qh5Yitp6b0W8YQQjCNOZOP
MIME-Version: 1.0
X-Received: by 2002:a92:a119:: with SMTP id v25mr5628952ili.77.1598081470384;
 Sat, 22 Aug 2020 00:31:10 -0700 (PDT)
Date:   Sat, 22 Aug 2020 00:31:10 -0700
In-Reply-To: <000000000000e8f42805ad5d136c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d511305ad725632@google.com>
Subject: Re: KASAN: use-after-free Write in vcs_read
From:   syzbot <syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jslaby@suse.com, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b1c32fcfadf5593ab7a63261cc8a5747c36e627e
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Tue Aug 18 08:57:05 2020 +0000

    vc_screen: extract vcs_read_buf_header

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13259dee900000
start commit:   494d311a Add linux-next specific files for 20200821
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a59dee900000
console output: https://syzkaller.appspot.com/x/log.txt?x=17259dee900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61d44f28687f508
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1f53726c3bd11180cb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16704b7e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588a046900000

Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com
Fixes: b1c32fcfadf5 ("vc_screen: extract vcs_read_buf_header")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
