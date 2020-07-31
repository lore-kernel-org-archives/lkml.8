Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6C922B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGaU1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:27:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56718 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:27:07 -0400
Received: by mail-io1-f69.google.com with SMTP id q20so1434216iod.23
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vsQ0DA/5bvGhTmkbMHk7MzKsMz9FnLBedu0Y4dKMUQk=;
        b=qtpfqBiD4kJJKWgnnCMi5In/Hp1eRnbQLsTc3eTF9Mph+f28E3DvvSzsYW5HVemsJx
         92NqLNKHx+leF2iuJbmlwfGSH3NIH4VBHDstLBME3Vo7WZQESEhnpd59xQvnAYkGrNLf
         5Df9d9bX0QN9i//HcMHso/jRHBYsZItXXSpWUCB7HZUVZFC+JjYER0mXp/CIzaBcjEli
         fyxStPYbARdxprmH2knvALUkaOF6NTAUnpi3ZJVvvnoK1YWkiEBLqb14abmxMCapry0T
         ML57yRXMicBTf4hC5LJrlGRjuArMwmmoUYsyvejmQJkHFiDUIeh7hBocFA3Rzsl8eCsd
         FTsg==
X-Gm-Message-State: AOAM531rdzbkFQoU9wbNfypLjG02RTmcKSBOJFKTClHq19gtt/c4jPEq
        ZnKplH3wSFPEYqmAGokldCTFgXXRP1l7GZ9Nwt/OSTDFKCrm
X-Google-Smtp-Source: ABdhPJwscJdmgTVAyN5A0mZcFslfTu4NvgG3c61P7M1Sunc5hbze6ecpT6iF8lTHZO9lbQOYSIomIKIyhyXMYrlqb/aJNkQgzi+J
MIME-Version: 1.0
X-Received: by 2002:a92:8b45:: with SMTP id i66mr5706387ild.19.1596227226917;
 Fri, 31 Jul 2020 13:27:06 -0700 (PDT)
Date:   Fri, 31 Jul 2020 13:27:06 -0700
In-Reply-To: <000000000000c5c9ad05abbfc71b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d75f8b05abc29c92@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in qrtr_endpoint_post (2)
From:   syzbot <syzbot+1917d778024161609247@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e42671084361302141a09284fde9bbc14fdd16bf
Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Thu May 7 12:53:06 2020 +0000

    net: qrtr: Do not depend on ARCH_QCOM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a8076c900000
start commit:   83bdc727 random32: remove net_rand_state from the latent e..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11a8076c900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16a8076c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=1917d778024161609247
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ac9b60900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14256c5c900000

Reported-by: syzbot+1917d778024161609247@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
