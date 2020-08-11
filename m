Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B63720772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHKHCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:02:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44938 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgHKHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:02:06 -0400
Received: by mail-io1-f72.google.com with SMTP id m12so9030007iov.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TCO+CRsxJrzBCsKOBMk3YisLrnkYLPAHpyx6MjWmV2I=;
        b=H/tJ7Ec3Vk/IImvb0plMhBv0u5JCgoHZs4u1rpI2oR1So3nR8H3ttkZt4uZfaFUxf+
         3ZJcQ7FouWauUCvQ8K2OKeW/u5rUKbMmrKG/hDDASIFSbAvhO20pVBoPhdnTdvRcTRjk
         bo3SUyVd7S9Fn3PZfbHcpPxAOX9/gF1HbK9dMBq4+d119RAsDTU28pyTCYr0MBq5E+wA
         U9L0eqcNI1VnTuQdrEZ8+gWs/jGbJvK/pnPjxtHPl24YHJj31zarkRWe4OJIP7fzfpSw
         i82CGyFQf2WR2pNzu9ZtZsHRpbm99pw1ioo6T2tdmMrW2VFh8SmvTPTYnMftVIPcGaPE
         7XJA==
X-Gm-Message-State: AOAM531xK6hJPqjNdO1DS42Syabz732M47QsarOb0cP6W3RPBAkWawZ3
        ULYGO6oCicYuOO32iCtbaJv8z1UGaHzXLcFfM0oULG27y24Z
X-Google-Smtp-Source: ABdhPJyIOSFerfWVR1Xo+/AxlOPWMpkrbzwv7jfTrQQsSCTPmQrSRvQ8Qgc2g4nydi3v0jjeKq2dBeLk3CJlnTSTNsYyiHQh6z0f
MIME-Version: 1.0
X-Received: by 2002:a92:db51:: with SMTP id w17mr1349732ilq.105.1597129325132;
 Tue, 11 Aug 2020 00:02:05 -0700 (PDT)
Date:   Tue, 11 Aug 2020 00:02:05 -0700
In-Reply-To: <00000000000079a77705a8ce6da7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015bfd405ac94a6c0@google.com>
Subject: Re: general protection fault in qrtr_endpoint_post
From:   syzbot <syzbot+03e343dbccf82a5242a2@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, bkkarthik@pesu.pes.edu,
        dan.carpenter@oracle.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 8ff41cc21714704ef0158a546c3c4d07fae2c952
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue Jun 30 11:46:15 2020 +0000

    net: qrtr: Fix an out of bounds read qrtr_endpoint_post()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f1cfe6900000
start commit:   1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c907630cbdbe5
dashboard link: https://syzkaller.appspot.com/bug?extid=03e343dbccf82a5242a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1496f9f9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1692523d100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: qrtr: Fix an out of bounds read qrtr_endpoint_post()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
