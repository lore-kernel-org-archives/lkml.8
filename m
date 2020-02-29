Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_MONEY_PERCENT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E88C3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925AB246AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 07:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiqNu/m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB2Hra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 02:47:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36497 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgB2Hr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 02:47:29 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so4948528iln.3;
        Fri, 28 Feb 2020 23:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfvM/f28hvJBZU+T0TBsS+3mSVMGX2yDctb6qlFBx+8=;
        b=eiqNu/m16shjkAYDtzd/eRWZtNzF2m+uIZMVTSlayTQ7dAu0BuSvR6stDhJ2OnV/o6
         vJlxI3YZnorqE9Hp8oXgt5rA2ZJqqIYozFzHMeG0Z+B4QL9pMeW+1cfSTSF77nxaajm7
         MeRZYEVuRL5xUd1da8Vo0u2+Im4Y7tZ/3nXCrOWEUHPqXP9te1Lw4T6S85fh7aEEoQdT
         ChfqC++nkFQLFEuGOcoyfeq+/3vGCzJkdv66mX3h0w0u0beqo9Wqi8PkG3Ms5NwNvJTv
         XtVJRIVYZxgxHv1KqliK2sUmV5fw+xdpf1YqbDQ/bHUGEPpP2XOA9qVry15ay8L+NvYC
         GMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfvM/f28hvJBZU+T0TBsS+3mSVMGX2yDctb6qlFBx+8=;
        b=CoIZKu4sVWnr0sKMKmCK9XgJjWDyQIFVxxNtr76Zec6E/R3hVDjTl2/tv63r8bcNpw
         Bn3yY9lU/Hbj8adC9ftv3RG3zzMJ3yRilJ/fR0mpzBnc9ah4LjkFxCX2NO40wMNDFvOl
         CR8+0afOIWt4/iyjYXb6hft0qCPixlXEs+TW6ztjHdZl7Swu2vIWFm8+fv3iXhohfZvs
         Um2EyuapahjrnouOfWMXkCg76viAS1I3vUyIv9JjgpHWFUo6lGW6THETyi6m0nDvoIqn
         NKvREcC7AQpwZ3dOVoAgDc753BphtdLITZePcvpXBB4YJzf15lVPsw9xNRRCUnRGL/+s
         Znuw==
X-Gm-Message-State: APjAAAUzPi/w6xPIOErM6KPU7xrlumfi392fZSsT/5oSPSSEiUPmLvQm
        zmS3VkNrXO5b8qfNtig3xRGSAJqqv5RjCWch+Xg=
X-Google-Smtp-Source: APXvYqxr/lATvmHc2l2X1AMCD15040g/UEioP+9p7KVsj/3MllNVL/c8bK9M/czRq/nlZaTSYY0pU5Bv+mPs8ERDQ40=
X-Received: by 2002:a92:d702:: with SMTP id m2mr7440529iln.149.1582962448744;
 Fri, 28 Feb 2020 23:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net> <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
 <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com> <20200228175905.GB3188@roeck-us.net>
In-Reply-To: <20200228175905.GB3188@roeck-us.net>
From:   =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>
Date:   Sat, 29 Feb 2020 09:46:52 +0200
Message-ID: <CAKv9HNbugeO0E5w8PsN-EpgHBtAjOYZppkUz1u0a5Ue6k20GwQ@mail.gmail.com>
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 at 19:59, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Feb 28, 2020 at 08:14:35AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Feb 27, 2020 at 8:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 2/27/20 2:27 PM, Guenter Roeck wrote:
> > > > On 2/27/20 2:06 PM, Doug Anderson wrote:
> > > [ ... ]
> > > >>> -       if (urb->num_sgs || urb->sg ||
> > > >>> -           urb->transfer_buffer_length == 0 ||
> > > >>> +       if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
> > > >>> +           (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
> > > >>>             !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
> > > >>
> > > >> Maybe I'm misunderstanding things, but it feels like we need something
> > > >> more here.  Specifically I'm worried about the fact when the transfer
> > > >> buffer is already aligned but the length is not a multiple of the
> > > >> endpoint's maximum transfer size.  You need to handle that, right?
> > > >> AKA something like this (untested):
> > > >>
> > > >> /* Simple case of not having to allocate a bounce buffer */
> > > >> if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
> > > >>     (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
> > > >>   return 0;
> > > >>
> > > >> /* Can also avoid bounce buffer if alignment and size are good */
> > > >> maxp = usb_endpoint_maxp(&ep->desc);
> > > >> if (maxp == urb->transfer_buffer_length &&
> > > >
> > > > No, transfer_buffer_length would have to be a multiple of maxp. There
> > > > are many situations where roundup(transfer_buffer_length, maxp) !=
> > > > transfer_buffer_length. I agree, this would be the prudent approach
> > > > (and it was my original implementation), but then it didn't seem to
> > > > cause trouble so far, and I was hesitant to add it in because it results
> > > > in creating temporary buffers for almost every receive operation.
> > > > I'd like to get some test feedback from Boris - if the current code
> > > > causes crashes with his use case, we'll know that it is needed.
> > > > Otherwise, we'll have to decide if the current approach (with fewer
> > > > copies) is worth the risk, or if we want to play save and always
> > > > copy if roundup(transfer_buffer_length, maxp) != transfer_buffer_length.
> > > >
> > >
> > > Thinking more about this, the situation is actually much worse:
> > > In Boris' testing, he found inbound transactions requested by usb
> > > storage code with a requested transfer size of 13 bytes ... with
> > > URB_NO_TRANSFER_DMA_MAP set. This means the requesting code has
> > > provided a DMA ready buffer, transfer_buffer isn't even used,
> > > and we can not reallocate it. In this situation we can just hope
> > > that the chip (and the connected USB device) don't send more data
> > > than requested.
> > >
> > > With that in mind, I think we should stick with the current
> > > scheme (ie only allocate a new buffer if the provided buffer is
> > > unaligned) unless Boris comes back and tells us that it doesn't
> > > work.
> >
> > I dunno.  I'd rather see correctness over performance.  Certainly we'd
> > only need to do the extra bounce buffer for input buffers at least.
> >
> > Although I don't love the idea, is this something where we want to
> > introduce a config option (either runtime or through KConfig),
> > something like:
> >
> > CONFIG_DWC2_FAST_AND_LOOSE - Avoid bounce buffers and thus run faster
> > at the risk of a bad USB device being able to clobber some of your
> > memory.  Only do this if you really care about speed and have some
> > trust in the USB devices connected to your system.
> >
>
> I understand your point. Unfortunately that would only work if the driver
> doesn't set URB_NO_TRANSFER_DMA_MAP.
>
> $ git grep "=.*URB_NO_TRANSFER_DMA_MAP" | wc
>     115     498   10104
>
> isn't exactly reassuring - a quick checks suggests that almost 50%
> of USB drivers set this flag.
>
> So all we'd really accomplish is to give people a false sense of
> security.
>
> In this context, I did play around with configuring the real receive
> buffer size (ie in my reproducer 1522 instead of 1536). If I do that,
> reading the HCTSIZ register after the transfer reports 0x7fff2
> (or -14 = 1522-1536 if I treat the value as signed) as actual transfer
> size. Maybe that would be an option, if properly handled, but who knows
> what the IP actually does in this case, and what it does on other
> implementations (not rk3288).
>
> Guenter

Hi Guenter.

I decided to give your patch-set a spin on my Lantiq device and I'm
sorry to report that I'm now experiencing a complete crash of the
kernel due to unaligned access if I try to do usb transfers:

Unhandled kernel unaligned access[#1]:
CPU: 1 PID: 3149 Comm: sh Not tainted 5.6-rc3 #0
task: 87db2580 task.stack: 868c6000
$ 0   : 00000000 00000001 00000000 81125088
$ 4   : 8064ffc4 00000001 00000001 2a624a29
$ 8   : 00000c43 00000c42 80010770 00000000
$12   : 7f801be8 77fac2a0 00000022 00000000
$16   : 87c02300 014000c0 87d1ddc0 00000000
$20   : 87db2580 00000000 00000000 00000000
$24   : 00000000 77f5fbcc
$28   : 868c6000 868c7e00 00000000 800347b0
Hi    : 0000001b
Lo    : 0000005b
epc   : 8012d278 kmem_cache_alloc+0x128/0x17c
ra    : 800347b0 copy_process.part.94+0xd8/0x1690
Status: 1100c303 KERNEL EXL IE
Cause : 00800010 (ExcCode 04)
BadVA : 2a624a29
PrId  : 00019556 (MIPS 34Kc)
Modules linked in: ath9k ath9k_common option ath9k_hw ath10k_pci
ath10k_core ath usb_wwan qmi_wwan pppoe nf_conntrack_ipv6 mac80211
iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp
xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack
xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD usbserial
usbnet ums_usbat ums_sddr55 ums_sddr09 ums_karma ums_jumpshot
ums_isd200 ums_freecom ums_datafab ums_cypress ums_alauda pppox
ppp_async owl_loader nf_reject_ipv4 nf_nat_redirect
nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat
nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6
nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack ltq_deu_vr9
iptable_mangle iptable_filter ip_tables crc_ccitt compat cdc_wdm
drv_dsl_cpe_api drv_mei_cpe nf_log_ipv6 nf_log_common
 ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables
nf_reject_ipv6 pppoatm ppp_generic slhc br2684 atm drv_ifxos
usb_storage dwc2 sd_mod scsi_mod gpio_button_hotplug mii
Process sh (pid: 3149, threadinfo=868c6000, task=87db2580, tls=77fadefc)
Stack : 80657098 00000100 77fa6db0 00000000 00000012 00000012 ffffffff 800347b0
        80650000 8013906c 87c02c00 8012d9fc 00000000 00000000 00000020 807b0000
        879f1148 00000001 868c7e98 804f6018 00000000 801391a8 868c7ef0 80153258
        00000000 00000001 864f62a0 00000020 864f62b8 80044818 00000400 8015fe94
        00000003 00000005 00000012 00000000 7f801be0 00430871 00000000 77fac000
        ...
Call Trace:
[<8012d278>] kmem_cache_alloc+0x128/0x17c
[<800347b0>] copy_process.part.94+0xd8/0x1690
[<80035f00>] _do_fork+0xe4/0x3bc
[<80036238>] sys_fork+0x24/0x30
[<8001c438>] syscall_common+0x34/0x58
Code: 00000000  8e020014  00e23821 <8ce20000> 10000009  cc400000
1040ffbd  00000000  8e060010

---[ end trace 3d8df00f1a0d123c ]---


Don't be fooled by the Call Trace, the stack unwinder is most likely
totally confused due to memory corruption.

The culprit is the first patch in the series that does not align DMA
carefully enough. Apparently these big endian MIPS devices are very
picky on how that is supposed to be handled.

Couple of years ago mips people even contemplated on adding warn_on to
kernel to yell at driver authors who do not align their DMA properly.
[1.]
That patch explanation actually served as an inspiration for commit
56406e017a88 in the first place.

[1.] https://www.linux-mips.org/archives/linux-mips/2016-11/msg00267.html

-- 
Antti
