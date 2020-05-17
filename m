Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CDFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9E1207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEQRPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgEQRPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:15:31 -0400
X-Greylist: delayed 2439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 May 2020 10:15:31 PDT
Received: from mail.default.ilande.uk0.bigv.io (mail.ilande.co.uk [IPv6:2001:41c9:1:41f::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75374C061A0C;
        Sun, 17 May 2020 10:15:31 -0700 (PDT)
Received: from host109-156-104-24.range109-156.btcentralplus.com ([109.156.104.24] helo=[192.168.1.65])
        by mail.default.ilande.uk0.bigv.io with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <mark.cave-ayland@ilande.co.uk>)
        id 1jaMFU-0001BY-4U; Sun, 17 May 2020 17:34:53 +0100
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>
Cc:     arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
 <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
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
Message-ID: <cfc07b63-29e6-cda9-c611-235e37970763@ilande.co.uk>
Date:   Sun, 17 May 2020 17:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
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

On 17/05/2020 16:01, Christian Brauner wrote:

> On Tue, May 12, 2020 at 01:06:33PM -0700, David Miller wrote:
>> From: Christian Brauner <christian.brauner@ubuntu.com>
>> Date: Tue, 12 May 2020 19:15:24 +0200
>>
>>> I've tested this series with qemu-system-sparc64 and a Debian Sid image
>>> and it comes up no problem (Here's a little recording
>>> https://asciinema.org/a/329510 ).
>>
>> Can you show how you put this environment together and also what
>> compilation tools you used?  Looks great.
> 
> Sorry for the delay. That mail somehow got lost in my inbox.
> 
> So in general, I used qemu-system-sparc64 which is available in Universe
> with either Debian or Ubuntu and that's what I've been using as host
> distro. So you need a 
> 
> deb http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
> deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
> deb http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe
> deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe
> 
> int /etc/apt/sources.list
> 
> So after this, you should be able to install
> 
> apt install qemu-system-sparc
> 
> Now we need an image and believe it or not there's a guy who lives in
> Berlin too who builds Debian images for all crazy architectures. You can
> download them from:
> 
> https://cdimage.debian.org/cdimage/ports/
> 
> They're built quite frequently. Sometimes you get unlucky because a new
> kernel won't boot anymore then going a couple of months back usually
> helps. So for this experiment I downloaded:
> 
> https://cdimage.debian.org/cdimage/ports/9.0/sparc64/iso-cd/debian-9.0-sparc64-NETINST-1.iso
> 
> then I did:
> 
> cd .local/share/qemu
> truncate -s 15GB sparc64.img
> 
> And then to _install_:
> 
> qemu-system-sparc64 \
>         -m 4096 \
>   	-device virtio-blk-pci,bus=pciB,drive=hd \
>   	-drive file=/home/brauner/Downloads/debian-9.0-sparc64-NETINST-1.iso,format=raw,if=ide,bus=1,unit=0,media=cdrom,readonly=on \
> 	-drive file=/home/brauner/.local/share/qemu/sparc64.img,format=raw,if=none,id=hd \
> 	-boot order=d \
>         -net nic \
> 	-net user \
> 	-nographic \
> 
> Then the Debian install will run after it finishes you can boot with:
> 
> qemu-system-sparc64 \
> 	-name debian-unstable-sparc64 -machine sun4u,accel=tcg,usb=off -m 4096 \
> 	-smp 1,sockets=1,cores=1,threads=1 \
> 	-uuid ccd8b5c2-b8e4-4d5e-af19-9322cd8e55bf -rtc base=utc -no-reboot -no-shutdown \
> 	-boot strict=on \
> 	-drive file=/home/brauner/.local/share/qemu/sparc64.img,if=none,id=drive-ide0-0-1,format=raw,cache=none,aio=native \
> 	-device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-1,id=ide0-0-1 \
> 	-msg timestamp=on -nographic
> 
> If the install isn't setting up the repos right and you can't install
> stuff the correct url is:
> http://ftp.ports.debian.org/debian-ports/
> to put into sources.list

FWIW if you're running a more recent version of QEMU (>=3.1) then you can also boot
from the virtio-blk-pci device directly instead of having to switch back to the IDE
device after installation as you have done above. Should be something like:

qemu-system-sparc64 \
         -m 4096 \
   	-device virtio-blk-pci,bus=pciB,drive=hd \
 	-drive
file=/home/brauner/.local/share/qemu/sparc64.img,format=raw,if=none,id=hd,bootindex=0 \
        -net nic \
 	-net user \
 	-nographic

Note the removal of the legacy -boot argument and the addition of "bootindex=0" to
the -drive argument.


ATB,

Mark.
