Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E4C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 22:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BD0206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 22:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDDWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 18:13:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:46067 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgDDWNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 18:13:04 -0400
Received: by mail-il1-f197.google.com with SMTP id p15so11037099ils.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 15:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bt/1x8EyTmuUIcBDvOOh7SgGrhssirnD/BYB/4tXepA=;
        b=HWSm0EUv6+qCiNQhdkB/SqOrcacHRGwQwB5Ny+ufkeFQywpdW1HAZZUJanGkeVtF9g
         b1xtBGWVxM5/C2rZxsnoIhLbi3yn1oC0zG/b8Xvq5xfP6m8+agjL+tm/5AnUU2Sc18Nr
         ID+ReGDAyt3iJ3k2YUICBu+gkQrUiLsaQqnNfJveDB/b+OCGcU5vU2kHI6Pi3fuaQbeZ
         6gUvRYiiaaqzwQv7kYS0pppfKhyQmRpZJzmj7LgKzHNHPsBN5k6oKyGkRbuJUFWsXv79
         7ds8iYSkF8Lj6/EnqIfdl9AOjKtgPrPJcCRj/qlpOZknCYDZL2iCofq9N1tSZJPhJf8P
         undw==
X-Gm-Message-State: AGi0PublqHbwWHMqmEVIFxQHR7Uf+DmcnnHB0VLYxuyXkwc/no1mA190
        E/mWYiixPzt/fdC4yuVgalWouUe4NXWqoW556M2OWduduKPt
X-Google-Smtp-Source: APiQypKcRyVBeoiDWCvZb7tswqkam9aNeXGh+t+Ou4uEcCLuNQD/97y44iDElTiQg68XVts3nXfySRjVZo8xHnjk4aisV+oXHT50
MIME-Version: 1.0
X-Received: by 2002:a92:8183:: with SMTP id q3mr14989618ilk.43.1586038384055;
 Sat, 04 Apr 2020 15:13:04 -0700 (PDT)
Date:   Sat, 04 Apr 2020 15:13:04 -0700
In-Reply-To: <20200404183707.GK45598@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b5aea05a27e5637@google.com>
Subject: Re: WARNING in ext4_da_update_reserve_space
From:   syzbot <syzbot+67e4f16db666b1c8253c@syzkaller.appspotmail.com>
To:     a@unstable.cc, adilger.kernel@dilger.ca,
        b.a.t.m.a.n@diktynna.open-mesh.org, benh@kernel.crashing.org,
        davem@davemloft.net, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mareklindner@neomailbox.ch, mpe@ellerman.id.au,
        muriloo@linux.ibm.com, netdev@vger.kernel.org, paulus@samba.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+67e4f16db666b1c8253c@syzkaller.appspotmail.com

Tested on:

commit:         54d3adbc ext4: save all error info in save_error_info() an..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
kernel config:  https://syzkaller.appspot.com/x/.config?x=4527d1e2fb19fd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=67e4f16db666b1c8253c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
