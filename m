Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A054E20758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEQWN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 18:13:57 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48834C061A0C;
        Sun, 17 May 2020 15:13:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jaRXW-00Alrb-WC; Sun, 17 May 2020 22:13:47 +0000
Date:   Sun, 17 May 2020 23:13:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, arnd@arndb.de,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct
 kernel_clone_args
Message-ID: <20200517221346.GL23230@ZenIV.linux.org.uk>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
 <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
 <cfc07b63-29e6-cda9-c611-235e37970763@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc07b63-29e6-cda9-c611-235e37970763@ilande.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 05:34:34PM +0100, Mark Cave-Ayland wrote:

> FWIW if you're running a more recent version of QEMU (>=3.1) then you can also boot
> from the virtio-blk-pci device directly instead of having to switch back to the IDE
> device after installation as you have done above. Should be something like:
> 
> qemu-system-sparc64 \
>          -m 4096 \
>    	-device virtio-blk-pci,bus=pciB,drive=hd \
>  	-drive
> file=/home/brauner/.local/share/qemu/sparc64.img,format=raw,if=none,id=hd,bootindex=0 \
>         -net nic \
>  	-net user \
>  	-nographic
> 
> Note the removal of the legacy -boot argument and the addition of "bootindex=0" to
> the -drive argument.

	Is virtio-blk-pci more resilent to lost interrupt bug introduced in 
"sun4u: update PCI topology to include simba PCI bridges"?  I hadn't tried
it yet (reverted to the last working mainline qemu commit for now); IDE
definitely is screwed by that - both the Linux and NetBSD drivers, actually.

	A 50Mb worth of wget(1) is more than enough to trigger that crap;

commit 063833a6ec
Merge: d634fc0499 bcf9e2c2f2
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Oct 19 18:42:51 2017 +0100

    Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging

hangs, d634fc0499 works, bcf9e2c2f2 hangs.

I hadn't looked into details (the branch itself is only two commits long, but it
incorporates an openbios update - 35 commits there, some obviously pci- and
sun4u-related), but it's really easy to reproduce - -m 1024 and -hda <image>
are probably the only relevant arguments.  Even dd if=/dev/sda of=/dev/null bs=64m
is often enough to hang it, so I rather doubt that networking (e1000 on pciB,
FWIW, with tap for backend) has anything to do with that.
