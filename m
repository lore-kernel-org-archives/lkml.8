Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19994C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07D1206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IsjSX6Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgGOGEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgGOGEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:04:31 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C234EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:04:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B66KQ73r3z9sQt;
        Wed, 15 Jul 2020 16:04:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594793068;
        bh=xOeqp8wg1wzSnVdBuEdXN3kiPlzF1h3So05Ikk8GK1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IsjSX6GldAgrRTAtMdYr57r1MSZg9kBwHJotUn4NS4gGMWurBny8xWtuo7lBOViYq
         z0z6lnjn6w9fBEbtTZ7ZFynUxAFb3s6twgor0e67ul8RtElh3TkUXWlM5nHzNCyusi
         EPADOxaa5UaF/gOfPLvqK8lwh5otjiH8htIcCR3rYb5WRY7Er1dFYR7pm6fVDIObVr
         q/zvaiKWN3bJFBxbUENxQ7j++dBNXKMk+1plsjPd6oz/wgRa3oqPHy1xNyQEqmwkAq
         8adUY5BVxcFr+VGtMiyxJTfNXfefKk3gZjEzQHs9NCyXcEEF4bc/vU48ede17eMztb
         TaQ2TIxnRb/Mw==
Date:   Wed, 15 Jul 2020 16:04:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     syzbot <syzbot+98be80110b9043885626@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com
Subject: Re: kernel panic: System is deadlocked on memory
Message-ID: <20200715160426.225feefb@canb.auug.org.au>
In-Reply-To: <CALOAHbDsDTmi6EpfDeg2UcCX-btfw+dzQ2T6iZWvHUhffU0dFQ@mail.gmail.com>
References: <000000000000c62c0205aa73a505@google.com>
        <CALOAHbDsDTmi6EpfDeg2UcCX-btfw+dzQ2T6iZWvHUhffU0dFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OZqELQeYl2hzk=93DoC5kM4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OZqELQeYl2hzk=93DoC5kM4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 15 Jul 2020 13:54:04 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 12:49 PM syzbot
> <syzbot+98be80110b9043885626@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d31958b3 Add linux-next specific files for 20200710
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11a2fe13100=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3fe4fccb94c=
bc1a6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D98be80110b904=
3885626
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D101ec9671=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14a77000900=
000
> >
> > The issue was bisected to:
> >
> > commit e642d9be463d02c735cd99a9a904063324ee03d6
> > Author: Yafang Shao <laoar.shao@gmail.com>
> > Date:   Fri Jul 10 04:58:08 2020 +0000
> >
> >     mm, oom: make the calculation of oom badness more accurate
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1432bd77=
100000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1632bd77=
100000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1232bd77100=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+98be80110b9043885626@syzkaller.appspotmail.com
> > Fixes: e642d9be463d ("mm, oom: make the calculation of oom badness more=
 accurate")
> >
> > Out of memory and no killable processes...
> > Kernel panic - not syncing: System is deadlocked on memory
> > CPU: 0 PID: 6810 Comm: syz-executor919 Not tainted 5.8.0-rc4-next-20200=
710-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> >  panic+0x2e3/0x75c kernel/panic.c:231
> >  out_of_memory mm/oom_kill.c:1106 [inline]
> >  out_of_memory.cold+0xa6/0x182 mm/oom_kill.c:1041
> >  pagefault_out_of_memory+0x109/0x11c mm/oom_kill.c:1135
> >  mm_fault_error+0x123/0x380 arch/x86/mm/fault.c:930
> >  do_user_addr_fault+0x5f8/0xbf0 arch/x86/mm/fault.c:1317
> >  handle_page_fault arch/x86/mm/fault.c:1351 [inline]
> >  exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1404
> >  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
> > RIP: 0033:0x40154d
> > Code: Bad RIP value.
> > RSP: 002b:00007ffddf4649b0 EFLAGS: 00010202
> > RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffffffffffffd
> > RDX: 0000000000000001 RSI: 00007ffddf4665e0 RDI: ffffffffffffffff
> > RBP: 00007ffddf4665e0 R08: 0000000000000000 R09: 0000000000000001
> > R10: 0000000000000064 R11: 0000000000000246 R12: ffffffffffffffff
> > R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches =20
>=20
> Thanks for the report.
> This issue has been already fixed by
> "mm-oom-make-the-calculation-of-oom-badness-more-accurate-v3", which
> is already in the -next tree.

#syz fix: mm-oom-make-the-calculation-of-oom-badness-more-accurate-v3

--=20
Cheers,
Stephen Rothwell

--Sig_/OZqELQeYl2hzk=93DoC5kM4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8OnGoACgkQAVBC80lX
0GxSOwgAnQvhricRi5/pRseVMAVvmcQHIUSp7ht0HIMwoTXFLM4wMmF1Jo+k3s10
k10vF944IM96X3zCXTtz3v1tIQNDOQUzgs8YwuThUuEIGFTZ4rvh+g7x1p+6uFFA
AF8dSFNyajcBrdVNihOoMHP1jNpVx4jAGq/mqfhX4ioSLvECaw9Oo7sd7hbvsg9D
7AbSDHOlaBqomewEQTBhbu8+BhWiZLpop0fs7rRQEcyF25Upof7OqY0EcqxV/Ah8
J0x5hHNsB643odfv0c2zSWIP55sE/edwdSTHLiWPM0kJ1iA8XP9VWJN8IE6ucgjL
Onw+CS6I/QLzVleHNoyhx4Uw7CbGgg==
=MlP5
-----END PGP SIGNATURE-----

--Sig_/OZqELQeYl2hzk=93DoC5kM4--
