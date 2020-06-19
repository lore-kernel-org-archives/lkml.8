Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A70C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B665214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="dcoVTscf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JK58oyCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgFSIbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:31:11 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50215 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730651AbgFSIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:31:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D77D65802A6;
        Fri, 19 Jun 2020 04:31:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 19 Jun 2020 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cPGj9GS8nOdw4uD4AAEpm4pe3JQ
        bsTnhxLAPKtdHq0Q=; b=dcoVTscfnyiG3XZe+6OhFHV21XhGtTpVz8ma8AIuz2/
        qRJcG502Xu8eIXVW3UD3RWjyCxeMTP+sqwM1NMQkvkAVBkY7+OgnSPdYAbWRzxLR
        taBsz60BFOVUCTW1f7ptX0ZMph/mS3Wby9QQrQ97ecWmZaHuuLn/1JN7f1z3YV5y
        xBQZGvatSEv2kBWEEYLZqZ9jApTVpoO+KqS/yXutOTUof2q5DeTwqHpxn2KoqkU2
        Ac16LtyRN/kFbGbgRRRlbBP5OCA3Na1HgtXsHm1OaDLW4yJKlVsa7MyqKIICYJOX
        tq+QRUcydKlrFpcEH/WXi5BHFaOush0RLZF8ejad09Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cPGj9G
        S8nOdw4uD4AAEpm4pe3JQbsTnhxLAPKtdHq0Q=; b=JK58oyCNJVQf3dKVFi7Ohg
        UQ526XPSS0NAmxmme3XGcBOcgltaTAI1V1k3vhErVUCbcrL4APDv1D3Wb5NS3hUa
        keBWhXFXhaB1NgI/nYqa+v4dItdi4i8rUlr8fAQqw3XkIi+DeOIIraVbmm8hsilj
        QRMb6rfBE/2v5Fy2Sqm/Bk71Z4e/tsaEgb2huFCYJyoCTnaX/KoKIPs1c8nGWkfG
        nyfBAlywdOFf5hsZmsRYY0Dy4AhEm4V48P2xO8gqZmaXSVov7dhLkXrQud2k14Ed
        0vtKhkZz7tJQVaWbUCUs7srgD1wLTh50ulXlwBBsAGfUHkfS8rQTGtO66/UnhGPA
        ==
X-ME-Sender: <xms:xHfsXhICKjVMvOxMsZVVG0b_K5NFdQDj2lu4jKs8B3vS4KPKbrrjog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrd
    gtohhmqeenucggtffrrghtthgvrhhnpeelgeegfffhffekkefgveeilefgjeekvdeludeu
    udelgeekheegleevueegteekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrph
    hpshhpohhtrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepkeefrdekiedrkeelrddu
    tdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:xHfsXtIpTS3TO97S7Wj2CUNSIXdstGPqDbpBUs8yBgaClS5bM4aSZg>
    <xmx:xHfsXpvSZT6lKabLY-B8Zk5n9tjfSgn_1oezTk5_2Cbwf_Fw0htuJQ>
    <xmx:xHfsXiZaWeLTiz4QKxEGJhdbNZtrLG8RvdTkf-uBv0ROEH_zOEr54A>
    <xmx:xHfsXlSKW8dPinekqarl9cMK2cQoJymwWSu5AbKge1oWEwhbq-KGpw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A796F3061856;
        Fri, 19 Jun 2020 04:30:59 -0400 (EDT)
Date:   Fri, 19 Jun 2020 09:47:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        syzbot <syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Borislav Petkov <bp@alien8.de>, devel@etsukata.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: INFO: trying to register non-static key in is_dynamic_key
Message-ID: <20200619074700.GA8425@kroah.com>
References: <00000000000004a76305a8624d22@google.com>
 <20200619070527.GA544353@kroah.com>
 <CACT4Y+YEYT17HH=vh9XtRi7uRiY=db6u-L0dRYs7msF1jNX5Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YEYT17HH=vh9XtRi7uRiY=db6u-L0dRYs7msF1jNX5Xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 09:35:30AM +0200, Dmitry Vyukov wrote:
> On Fri, Jun 19, 2020 at 9:07 AM Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Jun 18, 2020 at 02:17:15PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    b791d1bd Merge tag 'locking-kcsan-2020-06-11' of git://git..
> > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13f305a9100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=16c2467d4b6dbee2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=42bc0d31b9a21faebdf8
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136ad566100000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10138f7a100000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com
> > >
> > > INFO: trying to register non-static key.
> > > the code is fine but needs lockdep annotation.
> >
> > Why is INFO: triggering syzbot?
> 
> This is a kernel bug, no?
> 
> And there are lots of other kernel bug types that start with INFO:
> https://github.com/google/syzkaller/blob/master/pkg/report/linux.go#L1302
> 
> The rules to understand when linux kernel has bugged are insanely
> complex in syzkaller:
> https://github.com/google/syzkaller/blob/master/pkg/report/linux.go#L914-L1685
> (+hundreds of hardcoded function names and file names above).

I understand it's tough, but "the code is fine but needs lockdep
annotation" feels like it's a "here's an improvement that you can make"
type of report, not a "crash" like this message says.

thanks,

greg k-h
