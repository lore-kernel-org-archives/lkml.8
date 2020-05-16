Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A21C20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iyXst3Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEPSED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgEPSED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 14:04:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF4C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 11:04:01 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l3so4863503edq.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRmBzgaQzO0FI7kpt2DHRV7sye7vtapRD4uHVMFzSQA=;
        b=iyXst3Tg0ZkZzl5eeraYGP6hYMjMrNLReQ3q0JoxcZuVb7qq6TEZOxZaiiLfxX0WUQ
         Z7JC3o83hpGG24c3C8bvu3M8gIQhP0ZKIp00BQpRdjbpD5lXvr2LU9W87A07ca9lEkjL
         Ec/qUjpI4wifR1ofTKX8gxeUhK2LoEs3YLmR2R+pJApW3S/+Ha7NcYf/UNxyahzNOvJW
         aP0QArO6a2CsVHMkFu3pV7Rbe/v79jRkTS5Q8WDJI8aqDaHeApYyb7Cfhb/+wmEBvQn/
         BaGHt005ooqyKNJW6OtLC6C/fWdXdDnaknqkAQC2FNUC0iT1V9WkS3ne2A+RiTdL0zGV
         dFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRmBzgaQzO0FI7kpt2DHRV7sye7vtapRD4uHVMFzSQA=;
        b=tko95fYY4Y4RCaPHFCnrIqKqMuPL+lf2Vb+V+CWhvmeDSVgjgaaFJjwClZCQ4/ZefO
         GwLbrk/xD8nC52RVwaBWG1hivM7mcnIgOm6csYXJ8BUX/wBT8FFsownpAq6aa9jsOhu/
         HSXg8dkMUQ/+rz+ankjgkr9mV/OO/QkhDYiYSiddN8xcj919cjX32s1SFjs/MumVHXiQ
         mAoLmG1npBFvpIG5INDVBM/17H7ZfXCYTK3fDKDVXOExAe2AWXPD8dc1YFfUfemTJS04
         c+SPD5OsV76OL/u9/mXF+IKglP9iNNMV6yY5dB7ZSnzYlwKz1ZThkMNHYW+rsjb855z1
         dDiQ==
X-Gm-Message-State: AOAM532i2dby0eH3QtCr0EyDXuSyS8We9fP1pHW0cSq0vi14Qt/Kk2XS
        s7VDQlX/kbSqkkz83MLKJQnLsI6hoJcmRL07C11E/34r
X-Google-Smtp-Source: ABdhPJyuKQj/k36gP0MPe3k4moMsG9Dk4ECCqJLgj/kTI9d2iANv6/VFO6fWIHo1cfkMg7Iy93Q8k0fbOiU9SXUUvgg=
X-Received: by 2002:aa7:d850:: with SMTP id f16mr7121658eds.365.1589652239045;
 Sat, 16 May 2020 11:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
In-Reply-To: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 May 2020 20:03:48 +0200
Message-ID: <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
To:     Tobias Baumann <017623705678@o2online.de>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000006bce605a5c7c1e7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000006bce605a5c7c1e7
Content-Type: text/plain; charset="UTF-8"

Hi Tobias,

On Thu, May 7, 2020 at 10:57 AM Tobias Baumann <017623705678@o2online.de> wrote:
>
> Hello Community
>
> I was referred to you by Martin. I have an older Android TV box that
> runs for over 3 years with Armbian Linux (Debian Jessie Headless Kernel
> 3.10.99). I'm looking forward to the new kernels and I'm glad that older
> hardware is still supported.
> Together with Oleg(balbes150) and Martin(xdarklight) I am testing the
> new kernel 5.x for ARM ( Amlogic S812 / Meson8m2 ) . Martin has written
> a patch for the SDIO controller in the last days so that also Wifi
> module and MMC are recognized. I could now successfully load the driver
> module RTLWIFI from the kernel. But unfortunately the card is only
> listed on the desktop as "not ready" or in the terminal (iwlist) as "no
> scan result". In the dmesg/lsmod RTLWIFI->RTL8723bs is loaded and the
> module is loaded with version v4.3.5.5_12290.20140916_BTCOEX20140507-4E40 .
>
>
> I would like to ask you to check the driver because even in kernel
> 3.10.99 a newer version (v4.3.16_13854.20150410_BTCOEX20150119-5844) is
> loaded and also at github are hard kernels ( version 2017 Kernel 4.9>)
> and ap17 and thirdyouth (v5.2.17.1_26955.20180307_COEX20180201-6f52).
> More recent ones can also be found - these have already been
> successfully tested with Debian 10. i hope that this may solve the
> problem with my Linux box.
>
> I would appreciate feedback on this request or information about
> debugging . My Linux box is also available for testing purposes
I just tried this on one of my Meson8b boards to see if it's some
problem with the MMC controller driver (meson-mx-sdio).
Here are my steps:
- (boot the board)
- ip link set up dev wlan0
- (wait until that finishes, it takes a while because it seems to load
the wifi firmware)
- iw dev wlan0 scan
- (wait a few seconds, then it shows many 2.4GHz wifi networks)
- wpa_passphrase MY_24GHz_WIFI_SSID > /tmp/wpa_supplicant_conf
- (enter the passphrase and press CTRL-D)
- wpa_supplicant -iwlan0 -c/tmp/wpa_supplicant.conf -Dnl80211 &
- (wait a couple more seconds for it to connect)
- dhcpcd wlan0
- then I ran iperf3, see the attached result
- then I ran dmesg | grep -Ei "(rtl8723bs|wlan0)", see the attached result

with these commands wifi is working "fine" for me.
my definition of fine: it connects to my AP and traffic can flow.
transfer speeds are on the low side (with 15Mbit/s and 5Mbit/s) but I
have no reference (for example from a vendor kernel) so I can't say if
that's to be expected.

I am not sure about any "desktop" tools and their behavior because I
don't use these.
can you please try the steps above and attach the output of the
"failing" commands (together with the dmesg output)?


Best regards,
Martin

--00000000000006bce605a5c7c1e7
Content-Type: text/plain; charset="US-ASCII"; name="iperf3.txt"
Content-Disposition: attachment; filename="iperf3.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ka9xnkgh0>
X-Attachment-Id: f_ka9xnkgh0

IyBpcGVyZjMgLWMgMTkyLjE2OC4xLjEwMApDb25uZWN0aW5nIHRvIGhvc3QgMTkyLjE2OC4xLjEw
MCwgcG9ydCA1MjAxClsgIDVdIGxvY2FsIDE5Mi4xNjguMS4xNzUgcG9ydCA1MDA4MiBjb25uZWN0
ZWQgdG8gMTkyLjE2OC4xLjEwMCBwb3J0IDUyMDEKWyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRy
YW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgUmV0ciAgQ3duZApbICA1XSAgIDAuMDAtMS4wMCAg
IHNlYyAgIDkyMiBLQnl0ZXMgIDcuNTUgTWJpdHMvc2VjICAgIDAgICAgMTA1IEtCeXRlcyAgICAg
ICAKWyAgNV0gICAxLjAwLTIuMDEgICBzZWMgIDEuMTIgTUJ5dGVzICA5LjMyIE1iaXRzL3NlYyAg
ICAwICAgIDE1MyBLQnl0ZXMgICAgICAgClsgIDVdICAgMi4wMS0zLjAwICAgc2VjICAxLjE4IE1C
eXRlcyAgOS45NSBNYml0cy9zZWMgICAgMCAgICAyMDYgS0J5dGVzICAgICAgIApbICA1XSAgIDMu
MDAtNC4xOCAgIHNlYyAgMS40MyBNQnl0ZXMgIDEwLjIgTWJpdHMvc2VjICAgIDAgICAgMjcwIEtC
eXRlcyAgICAgICAKWyAgNV0gICA0LjE4LTUuMDAgICBzZWMgIDEuNjggTUJ5dGVzICAxNy4xIE1i
aXRzL3NlYyAgICAwICAgIDM0MiBLQnl0ZXMgICAgICAgClsgIDVdICAgNS4wMC02LjEwICAgc2Vj
ICAxLjkzIE1CeXRlcyAgMTQuNiBNYml0cy9zZWMgICAgMCAgICA0MjYgS0J5dGVzICAgICAgIApb
ICA1XSAgIDYuMTAtNy4wMCAgIHNlYyAgMS44NiBNQnl0ZXMgIDE3LjQgTWJpdHMvc2VjICAgIDAg
ICAgNDMzIEtCeXRlcyAgICAgICAKWyAgNV0gICA3LjAwLTguMDAgICBzZWMgIDIuNzMgTUJ5dGVz
ICAyMi45IE1iaXRzL3NlYyAgICAwICAgIDQzMyBLQnl0ZXMgICAgICAgClsgIDVdICAgOC4wMC05
LjAwICAgc2VjICAyLjgwIE1CeXRlcyAgMjMuNSBNYml0cy9zZWMgICAgMCAgICA0MzMgS0J5dGVz
ICAgICAgIApbICA1XSAgIDkuMDAtMTAuMDAgIHNlYyAgMi44MCBNQnl0ZXMgIDIzLjUgTWJpdHMv
c2VjICAgIDAgICAgNDMzIEtCeXRlcyAgICAgICAKLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLQpbIElEXSBJbnRlcnZhbCAgICAgICAgICAgVHJhbnNmZXIg
ICAgIEJpdHJhdGUgICAgICAgICBSZXRyClsgIDVdICAgMC4wMC0xMC4wMCAgc2VjICAxOC40IE1C
eXRlcyAgMTUuNSBNYml0cy9zZWMgICAgMCAgICAgICAgICAgICBzZW5kZXIKWyAgNV0gICAwLjAw
LTEwLjIyICBzZWMgIDE3LjUgTUJ5dGVzICAxNC40IE1iaXRzL3NlYyAgICAgICAgICAgICAgICAg
IHJlY2VpdmVyCgppcGVyZiBEb25lLgojIGlwZXJmMyAtYyAxOTIuMTY4LjEuMTAwIC1SCkNvbm5l
Y3RpbmcgdG8gaG9zdCAxOTIuMTY4LjEuMTAwLCBwb3J0IDUyMDEKUmV2ZXJzZSBtb2RlLCByZW1v
dGUgaG9zdCAxOTIuMTY4LjEuMTAwIGlzIHNlbmRpbmcKWyAgNV0gbG9jYWwgMTkyLjE2OC4xLjE3
NSBwb3J0IDUwMDg2IGNvbm5lY3RlZCB0byAxOTIuMTY4LjEuMTAwIHBvcnQgNTIwMQpbIElEXSBJ
bnRlcnZhbCAgICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUKWyAgNV0gICAwLjAwLTEuMDAg
ICBzZWMgICA1ODQgS0J5dGVzICA0Ljc2IE1iaXRzL3NlYyAgICAgICAgICAgICAgICAgIApbICA1
XSAgIDEuMDAtMi4wNCAgIHNlYyAgIDUwOSBLQnl0ZXMgIDQuMDIgTWJpdHMvc2VjICAgICAgICAg
ICAgICAgICAgClsgIDVdICAgMi4wNC0zLjAwICAgc2VjICAgNTQ5IEtCeXRlcyAgNC42OCBNYml0
cy9zZWMgICAgICAgICAgICAgICAgICAKWyAgNV0gICAzLjAwLTQuMDAgICBzZWMgICA5NjIgS0J5
dGVzICA3Ljg4IE1iaXRzL3NlYyAgICAgICAgICAgICAgICAgIApbICA1XSAgIDQuMDAtNS4wMCAg
IHNlYyAgIDc0OSBLQnl0ZXMgIDYuMTUgTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgClsgIDVd
ICAgNS4wMC02LjAwICAgc2VjICAxLjI5IE1CeXRlcyAgMTAuOCBNYml0cy9zZWMgICAgICAgICAg
ICAgICAgICAKWyAgNV0gICA2LjAwLTcuMDAgICBzZWMgICA0MjcgS0J5dGVzICAzLjUxIE1iaXRz
L3NlYyAgICAgICAgICAgICAgICAgIApbICA1XSAgIDcuMDAtOC4wMSAgIHNlYyAgIDQ1MSBLQnl0
ZXMgIDMuNjUgTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgClsgIDVdICAgOC4wMS05LjAwICAg
c2VjICAgNjAxIEtCeXRlcyAgNS4wMCBNYml0cy9zZWMgICAgICAgICAgICAgICAgICAKWyAgNV0g
ICA5LjAwLTEwLjAwICBzZWMgICA2MzggS0J5dGVzICA1LjIwIE1iaXRzL3NlYyAgICAgICAgICAg
ICAgICAgIAotIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAt
ClsgSURdIEludGVydmFsICAgICAgICAgICBUcmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJl
dHIKWyAgNV0gICAwLjAwLTEwLjI3ICBzZWMgIDYuOTAgTUJ5dGVzICA1LjY0IE1iaXRzL3NlYyAg
ICA4ICAgICAgICAgICAgIHNlbmRlcgpbICA1XSAgIDAuMDAtMTAuMDAgIHNlYyAgNi42MyBNQnl0
ZXMgIDUuNTYgTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgcmVjZWl2ZXIKCmlwZXJmIERvbmUu
CiMK
--00000000000006bce605a5c7c1e7
Content-Type: text/plain; charset="US-ASCII"; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ka9xql2b1>
X-Attachment-Id: f_ka9xql2b1

WyAgICAyLjQ0MTQ4OF0gUlRMODcyM0JTOiBtb2R1bGUgaW5pdCBzdGFydApbICAgIDIuNDQyMTg1
XSBSVEw4NzIzQlM6IHJ0bDg3MjNicyB2NC4zLjUuNV8xMjI5MC4yMDE0MDkxNl9CVENPRVgyMDE0
MDUwNy00RTQwClsgICAgMi40NTExNjNdIFJUTDg3MjNCUzogcnRsODcyM2JzIEJULUNvZXggdmVy
c2lvbiA9IEJUQ09FWDIwMTQwNTA3LTRFNDAKWyAgICAyLjQ1NTgwMl0gUlRMODcyM0JTOiBtb2R1
bGUgaW5pdCByZXQgPTAKWyAgIDE2LjQ3ODgzMF0gUlRMODcyM0JTOiBydHdfbmRldl9pbml0KHds
YW4wKQpbICAgMzcuMjA5ODU3XSBydGw4NzIzYnM6IGFjcXVpcmUgRlcgZnJvbSBmaWxlOnJ0bHdp
ZmkvcnRsODcyM2JzX25pYy5iaW4KWyAgMzM3LjgwNzY2NF0gUlRMODcyM0JTOiBydHdfc2V0Xzgw
Ml8xMV9jb25uZWN0KHdsYW4wKSAgZndfc3RhdGUgPSAweDAwMDAwMDA4ClsgIDMzOC4zNDYxOTBd
IFJUTDg3MjNCUzogc3RhcnQgYXV0aApbICAzMzguMzc3MTQ2XSBSVEw4NzIzQlM6IGF1dGggc3Vj
Y2Vzcywgc3RhcnQgYXNzb2MKWyAgMzM4LjM4OTI0MV0gUlRMODcyM0JTOiBydHdfY2ZnODAyMTFf
aW5kaWNhdGVfY29ubmVjdCh3bGFuMCkgQlNTIG5vdCBmb3VuZCAhIQpbICAzMzguMzk1NTU1XSBS
VEw4NzIzQlM6IGFzc29jIHN1Y2Nlc3MKWyAgMzM4LjczMzY3MV0gUlRMODcyM0JTOiBzZW5kIGVh
cG9sIHBhY2tldApbICAzMzguNzU0MTE0XSBSVEw4NzIzQlM6IHNlbmQgZWFwb2wgcGFja2V0Clsg
IDMzOC43NTg2MTFdIFJUTDg3MjNCUzogc2V0IHBhaXJ3aXNlIGtleSBjYW1pZDo0LCBhZGRyOmRl
OmFkOmJlOmVlOmZmOjAwLCBraWQ6MCwgdHlwZTpBRVMKWyAgMzM4Ljc2ODg5N10gUlRMODcyM0JT
OiBzZXQgZ3JvdXAga2V5IGNhbWlkOjUsIGFkZHI6ZGU6YWQ6YmU6ZWU6ZmY6MDAsIGtpZDoxLCB0
eXBlOkFFUwpbICAzMzkuMTAzNzY0XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogd2xh
bjA6IGxpbmsgYmVjb21lcyByZWFkeQo=
--00000000000006bce605a5c7c1e7--
