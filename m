Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F52C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710222070A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgEQPBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:01:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgEQPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:01:30 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jaKn6-00031w-BG; Sun, 17 May 2020 15:01:24 +0000
Date:   Sun, 17 May 2020 17:01:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Miller <davem@davemloft.net>
Cc:     arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct
 kernel_clone_args
Message-ID: <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200512.130633.293867428547074800.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 01:06:33PM -0700, David Miller wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Tue, 12 May 2020 19:15:24 +0200
> 
> > I've tested this series with qemu-system-sparc64 and a Debian Sid image
> > and it comes up no problem (Here's a little recording
> > https://asciinema.org/a/329510 ).
> 
> Can you show how you put this environment together and also what
> compilation tools you used?  Looks great.

Sorry for the delay. That mail somehow got lost in my inbox.

So in general, I used qemu-system-sparc64 which is available in Universe
with either Debian or Ubuntu and that's what I've been using as host
distro. So you need a 

deb http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
deb http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe
deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe

int /etc/apt/sources.list

So after this, you should be able to install

apt install qemu-system-sparc

Now we need an image and believe it or not there's a guy who lives in
Berlin too who builds Debian images for all crazy architectures. You can
download them from:

https://cdimage.debian.org/cdimage/ports/

They're built quite frequently. Sometimes you get unlucky because a new
kernel won't boot anymore then going a couple of months back usually
helps. So for this experiment I downloaded:

https://cdimage.debian.org/cdimage/ports/9.0/sparc64/iso-cd/debian-9.0-sparc64-NETINST-1.iso

then I did:

cd .local/share/qemu
truncate -s 15GB sparc64.img

And then to _install_:

qemu-system-sparc64 \
        -m 4096 \
  	-device virtio-blk-pci,bus=pciB,drive=hd \
  	-drive file=/home/brauner/Downloads/debian-9.0-sparc64-NETINST-1.iso,format=raw,if=ide,bus=1,unit=0,media=cdrom,readonly=on \
	-drive file=/home/brauner/.local/share/qemu/sparc64.img,format=raw,if=none,id=hd \
	-boot order=d \
        -net nic \
	-net user \
	-nographic \

Then the Debian install will run after it finishes you can boot with:

qemu-system-sparc64 \
	-name debian-unstable-sparc64 -machine sun4u,accel=tcg,usb=off -m 4096 \
	-smp 1,sockets=1,cores=1,threads=1 \
	-uuid ccd8b5c2-b8e4-4d5e-af19-9322cd8e55bf -rtc base=utc -no-reboot -no-shutdown \
	-boot strict=on \
	-drive file=/home/brauner/.local/share/qemu/sparc64.img,if=none,id=drive-ide0-0-1,format=raw,cache=none,aio=native \
	-device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-1,id=ide0-0-1 \
	-msg timestamp=on -nographic

If the install isn't setting up the repos right and you can't install
stuff the correct url is:
http://ftp.ports.debian.org/debian-ports/
to put into sources.list

> 
> > This is the sparc specific bit and _if_ you agree with the changes here
> > it'd be nice if I could get your review, and if technically correct,
> > your ack so I can fold this into a larger series and move on to the next
> > arch.
> 
> With the delay slot instruction indentation fixed:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thank you, Dave!
Christian
