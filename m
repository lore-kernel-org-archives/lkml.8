Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3294C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E5820788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgCXO2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:28:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54571 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCXO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:28:04 -0400
Received: by mail-io1-f70.google.com with SMTP id f20so8672727iof.21
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5DUdY94kcJjDfuPtHucA1+AoxiUtVx9ckQVqLZpRdfk=;
        b=pk+JkJ3M7tPkYG670uG/9v9bQKbNx/8zcLG7+lSLktptm9F2AYbo8wvGHXg0JnmZKR
         fT5Xdscyq4WinoVvLnWD1V/dGLL04kVJXyJRych7DSvZmHfIzsFxSFUMO4j6Eund4jAU
         1tk+oGOu27OS576bh1Rh61ml/z2v1/X6VnRwj3LF4EV8drssmAwyqZmPofuZI8vuLe6x
         Jm0Fj4ui+l0YhC/+Kbi6qpxg1Azzl3MwyRZcakBtzHXv792E85kXfboePcDtfrhP1LOc
         JPfe5/On/PyJttnbsEZTu+sw+SnobDB5jbjvotD9LsNyVX9vC59wEnhpequT+depA39p
         GDVQ==
X-Gm-Message-State: ANhLgQ2uXmxOrOj399DKwgt1tvofA/6THlW3Vz4eD5SMZy5gC4uVywYv
        yVyFtnF06b2S+IsF1tdK3R8KVseihvxGaVBKtKYcRBPNE5d4
X-Google-Smtp-Source: ADFU+vvS/QTynF8HliyIxM1iRtSlvS+NCm14vMAPvj/NIh43tNV8t9FSiC82R5IcAwB/rWk4CQIMzKiftWKUeamPt5Vex8ADmLfc
MIME-Version: 1.0
X-Received: by 2002:a5e:8401:: with SMTP id h1mr11507780ioj.167.1585060083276;
 Tue, 24 Mar 2020 07:28:03 -0700 (PDT)
Date:   Tue, 24 Mar 2020 07:28:03 -0700
In-Reply-To: <1585057397.7151.22.camel@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036236e05a19a8f6b@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in garmin_read_process
From:   syzbot <syzbot+d29e9263e13ce0b9f4fd@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+d29e9263e13ce0b9f4fd@syzkaller.appspotmail.com

Tested on:

commit:         e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=d29e9263e13ce0b9f4fd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17315ad3e00000

Note: testing is done by a robot and is best-effort only.
