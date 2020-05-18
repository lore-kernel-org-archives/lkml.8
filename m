Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F485C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537D120758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgERT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgERT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:59:08 -0400
Received: from mail.default.ilande.uk0.bigv.io (mail.ilande.co.uk [IPv6:2001:41c9:1:41f::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83503C061A0C;
        Mon, 18 May 2020 12:59:08 -0700 (PDT)
Received: from host109-156-104-24.range109-156.btcentralplus.com ([109.156.104.24] helo=[192.168.1.65])
        by mail.default.ilande.uk0.bigv.io with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <mark.cave-ayland@ilande.co.uk>)
        id 1jalud-0003Dx-DZ; Mon, 18 May 2020 20:59:06 +0100
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, arnd@arndb.de,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
 <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
 <cfc07b63-29e6-cda9-c611-235e37970763@ilande.co.uk>
 <20200517221346.GL23230@ZenIV.linux.org.uk>
 <20200518181825.GM23230@ZenIV.linux.org.uk>
From:   Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <cf84ad0e-11a8-1066-5b7b-edb7cf482f76@ilande.co.uk>
Date:   Mon, 18 May 2020 20:58:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518181825.GM23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.156.104.24
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct
 kernel_clone_args
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2020 19:18, Al Viro wrote:

>> I hadn't looked into details (the branch itself is only two commits long, but it
>> incorporates an openbios update - 35 commits there, some obviously pci- and
>> sun4u-related), but it's really easy to reproduce - -m 1024 and -hda <image>
>> are probably the only relevant arguments.  Even dd if=/dev/sda of=/dev/null bs=64m
>> is often enough to hang it, so I rather doubt that networking (e1000 on pciB,
>> FWIW, with tap for backend) has anything to do with that.
> 
> 	FWIW, virtio-blk-pci does appear to be much more resilent; I hadn't been
> able to reproduce hangs on that, while mounting identical fs from pata_cmd64x
> and doing the same aptitude dist-upgrade --download-only ended up with
> 
> ...
> Note: Using 'Download Only' mode, no other actions will be performed.
> Do you want to continue? [Y/n/?] y
> Get: 1 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl-modules-5.30 all 5.30.2-1 [2,806 kB]
> Get: 2 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libperl5.30 sparc64 5.30.2-1 [3,388 kB]
> Get: 3 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl sparc64 5.30.2-1 [290 kB]
> Get: 4 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl-base sparc64 5.30.2-1 [1,427 kB]
> Get: 5 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libsystemd0 sparc64 245.5-3 [309 kB]
> Get: 6 http://ftp.ports.debian.org/debian-ports sid/main sparc64 udev sparc64 245.5-3 [1,356 kB]
> Get: 7 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libudev1 sparc64 245.5-3 [153 kB]
> [ 1472.613660] ata2: lost interrupt (Status 0x58)
> [ 1472.615124] ata1: lost interrupt (Status 0x50)
> [ 1472.615812] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [ 1472.616515] ata1.00: failed command: WRITE DMA
> [ 1472.617145] ata1.00: cmd ca/00:60:0c:9b:23/00:00:00:00:00/e0 tag 0 dma 49152 out
> [ 1472.617145]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> [ 1472.618229] ata1.00: status: { DRDY }
> [ 1472.618743] ata1: soft resetting link
> [ 1472.779489] ata1.00: configured for UDMA/33
> [ 1472.781211] ata1: EH complete
> [ 1477.977424] ata2.00: qc timeout (cmd 0xa0)
> [ 1477.977897] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
> [ 1483.353324] ata2.00: qc timeout (cmd 0xa0)
> [ 1483.353697] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
> [ 1483.354453] ata2.00: limiting speed to UDMA/33:PIO3
> [ 1488.729323] ata2.00: qc timeout (cmd 0xa0)
> [ 1488.730255] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
> [ 1488.731320] ata2.00: disabled
> [ 1503.333388] ata1: lost interrupt (Status 0x50)

(lots cut)

Well it certainly looks like there's an IRQ going missing somewhere, but glad to hear
the virtio-blk-pci is working much better for you. Presumably the virtio-net-pci NIC
also works?

> ... at which point I killed the damn thing.  Unpingable, doesn't react to serial
> console (the output is obviously there, the input doesn't reach shell, at the
> very least).  That was on current debian kernel (5.6.0-based), but the mainline
> 5.7-rc1 behaves the same way.  qemu is (yesterday) mainline:
> 
> commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9 (HEAD -> master, origin/master, origin/HEAD)
> Merge: 66706192de 9ecaf5ccec
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Fri May 15 19:51:16 2020 +0100
> 
>     Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging
> 
> and anything since bcf9e2c2f2 exhibits that behaviour.  qemu arguments:
> ../qemu1/build/sparc64-softmmu/qemu-system-sparc64 \
>         -hda sid.img \
>         -drive id=hd,if=none,file=foo.raw,format=raw \
>         -device virtio-blk-pci,bus=pciB,drive=hd \
>         -netdev tap,ifname=tap4,script=no,downscript=no,id=net \
>         -device e1000,bus=pciB,netdev=net \
>         -nographic -m 1024
> foo.raw and sid.img have the same contents (sid.img is qcow2 - might or might not
> cause enough timing differences to trigger whatever's happening).
> 
> Looks like something got screwed in PCI interrupt routing in that sun4u branch back in
> 2017.  If you have any suggestions on debugging that, I'd be glad to help; I'm not
> familiar with openbios guts, though ;-/

I've had one other report of a cmd646 hang on Linux several years ago and that was on
some pretty high end hardware; however when tracing was enabled everything worked as
it should. Despite my best attempts I can't seem to reproduce it here on my normal i7
laptop which is quite frustrating.

Before bcf9e2c2f2 the on-board NIC (sunhme) and cmd646 were wired to sabre's PCI IRQ
lines directly onto a single PCI bus, and after that commit they were rewired via
simba PCI bridges to legacy OBIO IRQs since some OSs like NetBSD hard-coded the
legacy IRQ numbers for on-board devices. I'm not sure whether this is relevant to the
kernel or not, or perhaps there is some magic register somewhere missing from
emulation that should be helping here.

One thing to check is whether you see any network hangs using the sunhme NIC since
that is wired in exactly the same way as cmd646. That should help determine whether
it's related to the IRQs routing via the simba PCI bridge or just the cmd646 device.

If you able to reproduce the issue consistently and can help figure out what's going
on then that would be a great help. Perhaps it might make sense to split this into a
separate thread and drop the non-sparc lists?


ATB,

Mark.
