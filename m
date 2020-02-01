Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2FDC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE6A206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QFytIJRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBAN6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 08:58:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:38927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgBAN6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 08:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580565515;
        bh=DMmmkxPfvWTgnefRIWa5E6yg7hEUmkhU2X3UrLbt2Io=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=QFytIJRrUAVV/0hxPlwvObvVMv3e1s5HuYGlC4WKJv4uhbubtl3l9Al23W5No2jEV
         X7jbeFDfOc8+FeWwlpz97fiPvRdIHRivwx/kN1n6YIOt60Ybq79m5cOaXrNWTuWbjG
         Ap9ZYJbEMRB2EIUrHEUIBbjpQGe16GWB7fA03zcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from acme7.acmenet ([186.48.107.113]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1j8jDP1tdZ-00SwSX; Sat, 01
 Feb 2020 14:58:35 +0100
Date:   Sat, 1 Feb 2020 10:58:29 -0300
From:   edes <edes@gmx.net>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: kernel 5.4.11: problems with usb sound cards
Message-ID: <20200201105829.5682c887@acme7.acmenet>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vuU4VgO+oL3qiyvbR1bfKwce0AWh0pUYaLxsanAHBIYHsToaNtS
 4ta/hUK74/cFScNgZJpGy/QpdbRQOGgul0ERzd1f9aHesbhVgR5C8FeS1VDG6g3MS+7SANr
 a6K4TyR3KQEBpW2kFK9TOSh/U+36pFFumFNwjXSR95F7kVWrwFhcV3AKhHbC8ajwRQjLGa7
 kJqWPbhl7zcq+A3SrYWcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vcN37QN5H0A=:+or3ihHr6Jy/Iq4JiEjTjv
 nil2ECcda9XpPCj0P/Pa0Kw2NwW5sXF5yFah/04u/n7Ydy7bfLXz/Hi9k4aPRceidrOwxXWCf
 I5SgipR2cYjcIXuLdyhDqwTr719GmbzWqZNyoqU9kVca0UaCVvctpV5l863XDvtwbyFZApdID
 0xADnyGeoXKzIWgV9lFSBiDPGQRBACth+x+bAE2ZNNhN2vdvIJpTfN7/pXsf2upOtjdUoEeBd
 G229RKHErw+BcNx+HHTfgUWngBd+VtF8UV8bzp0vwSgioz6rTvUnuEUu6m2x19h3vYyx89CPE
 RxJ0U3ehmFTRlvYtkWFZ2xOGtVhn2AtZYc+RLlk1yOKHCS7wKtNEQoO366uwFx29sBWiIkwvC
 RvqY/5dNNVZRmEBKy08BBy+aJTSvaTbjCMGrDaVBvm7VhIo7EGYr7/hcLjJtSSmAjdAvT5/Mo
 pTfvT29fv0iYZCtEgdT7GWyFCm7zkCcEMblA8M2/OMZ9roBI4IQ94FQxnpKss0fpHKdBQp8GD
 hhm31jMsdbVpWAQaP9cuEU2RUGErNYQ6i8LYcShZhVmcFjifIz2Qn70R+f+8vYeiKrcF/VHbV
 6/oCeul9xkE1NloTDjB+YLVMAqG7N+wcEWC3M+P3hfHGrwD7Lur8jN5yPqk5mnXRf9VgzLGe+
 BWy5yhVqCVO1Y1xvgf4jMCTkqKQntuiinjMCW9q4ZJ1SQ3goI8xopW7biR8XyeWf4mK7oy+1L
 +79Poy5JnpgMQBSRMFLNFRzQZ92WiYuS1pTiXrYJyxH4GQqaWrfr8+q/GCOXK0K4UjtRnN5qD
 CUCOHFCL6OH3wUvrwg075a5HDiUy6dRWpN3b8n57No8lONhyx0Fm3FICfNX72IQC51TFSCbWO
 IGQtwBUQkqUDQ7TiJ1oaVMU086jYioCUqwGGMPH3qy8oTXI4HSRTT0tyJR0dSvWbejHcVGUKK
 SPdRg/FNsJCLxxa0vLi2ftSBLMNifYhD3yBbk/q9n80O4X6Dyv+eAqmBzxoLG/+d/4K2hr8JB
 7mg9IlBsvhEweROv+dX/D5IFpzF26pxzGb+IM4sJ5MVveKfLOGhnb8hOE/9ntwE8MtDXDa00K
 wA2GfjWrobVNskyHEkPj276uo1GQqf4rwQXiYTylEk3KL7XOvH6DRSIzV0Ve3x7HrGyz4+kAf
 xMrwqU67TGmWxi4XQdrflwfpFBeR9jmlQ/bBW0KdS6t5NZD57HtEUChZCJAJboAhMpVOol3el
 d0MDTFlUlMjN3eslJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list, I hope this is the right place to post this problem.

Changes introduced in 5.4.11 (seemingly, in drivers/usb/core/config.c)
cause problems with at least some models of USB sound cards.

I have a Sound Devices USBPre2, a high quality sound card that until
5.4.10 always worked perfectly out of the box as a standard USB audio
device.

Beginning with 5.4.11 and up to 5.5.0, when the sound card is connected,
dmesg shows:

[ 1310.743135] usb 3-10.3: new high-speed USB device number 6 using
xhci_hcd
[ 1310.755472] usb 3-10.3: config 1 interface 2 altsetting 1 has
a duplicate endpoint with address 0x85, skipping
[ 1310.755474] usb 3-10.3: config 1 interface 2 altsetting 2 has a
duplicate endpoint with address 0x85, skipping
[ 1310.755852] usb 3-10.3: New USB device found, idVendor=3D0926,
idProduct=3D0202, bcdDevice=3D 1.00
[ 1310.755853] usb 3-10.3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[ 1310.755854] usb 3-10.3: Product: USBPre2
[ 1310.755855] usb 3-10.3: Manufacturer: Sound Devices
[ 1310.755855] usb 3-10.3: SerialNumber: HB1116132005
[ 1310.756803] usb 3-10.3: 1:3 : UAC_AS_GENERAL descriptor not found
[ 1310.757550] hid-generic 0003:0926:0202.0005: hiddev96: USB HID v1.01
Device
[Sound Devices USBPre2] on usb-0000:00:14.0-10.3/input3
[ 1310.773161] systemd-udevd[3856]: controlC0: Process '/usr/sbin/alsactl
restore 0' failed with exit code 99.

No capture device is created under /dev/snd, and the card works only as a
playback device.

ls -l /dev/snd
total 0
drwxr-xr-x  2 root root       60 feb  1 10:36 by-id
drwxr-xr-x  2 root root       60 feb  1 10:36 by-path
crw-rw----+ 1 root audio 116,  0 feb  1 10:36 controlC0
crw-rw----+ 1 root audio 116, 16 feb  1 10:36 pcmC0D0p
crw-rw----+ 1 root audio 116,  1 feb  1 10:14 seq
crw-rw----+ 1 root audio 116, 33 feb  1 10:14 timer

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: USBPre2 [USBPre2], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


arecord -l
**** List of CAPTURE Hardware Devices ****




=2D-


