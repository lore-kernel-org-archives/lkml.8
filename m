Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCBC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54749208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgCKEgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:36:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49996 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgCKEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:36:03 -0400
Received: by mail-il1-f200.google.com with SMTP id b72so510140ilg.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 21:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TOW6EyRWWRmr0XeVGg68EU3oaAG/uTESSlfkqLc+cAM=;
        b=buAsAcC2VXCIQ6sNTC8S9fTlfZiWtRg5nYrEqhfupHQP7WAjjUgT82NrVQWqG6ZMGh
         k7OXsKvxGh13dHsSdX7evjgTrkTsvDvIGQ9icgr5XpCDxNFvmqCnJmUpDBI78wXIlAIy
         5ipCeijvgNf6nce3izN6Tjgki7stVxXsydGX0s0HpVfs1pcBRKOaZUZO/DCBBCr3pXZ7
         MUlAcSk3DOcqBC8jYf9n6ZnVRLVF3B1LcuQWqjHBZFimg9XaB6RpfdJa8t8aLV1sW/nS
         abckBMq1tya6QgpzjH68TQ1Qtl1yez8NqstiMnsFbKvPDJZo3AsAR0V3iSbpHFd4wJvb
         CAMQ==
X-Gm-Message-State: ANhLgQ3+Zl1rc5hzcBP4c9LVk94siH0ehC68HRg2AgQx8q+IyJ6CIaz8
        djCxNYBYzGM34OkDnjrkzivelRNhA8gYXPP+SzC1RQ/2zl2D
X-Google-Smtp-Source: ADFU+vux2t/xaiujvf8Y0YWq1KqzivojgudC+oOlyt8deIl3lhzOJSMIuuTOmRBd2XaXjPCRM7y5g8S9EcYG/6ABJbFkK9akhOZH
MIME-Version: 1.0
X-Received: by 2002:a92:7b10:: with SMTP id w16mr1278071ilc.93.1583901362950;
 Tue, 10 Mar 2020 21:36:02 -0700 (PDT)
Date:   Tue, 10 Mar 2020 21:36:02 -0700
In-Reply-To: <0000000000002e20b9059fee8a94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019196205a08cc67d@google.com>
Subject: Re: WARNING in idr_destroy
From:   syzbot <syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com>
To:     a@unstable.cc, airlied@linux.ie, airlied@redhat.com,
        alexander.deucher@amd.com, b.a.t.m.a.n@lists.open-mesh.org,
        christian.koenig@amd.com, daniel@ffwll.ch, davem@davemloft.net,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kraxel@redhat.com,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mareklindner@neomailbox.ch, mripard@kernel.org,
        netdev@vger.kernel.org, noralf@tronnes.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 5b3709793d151e6e12eb6a38a5da3f7fc2923d3a
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed May 8 08:26:19 2019 +0000

    drm/ast: Convert AST driver to |struct drm_gem_vram_object|

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a66fb5e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17a66fb5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a66fb5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=05835159fe322770fe3d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e978e3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b1a819e00000

Reported-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Fixes: 5b3709793d15 ("drm/ast: Convert AST driver to |struct drm_gem_vram_object|")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
