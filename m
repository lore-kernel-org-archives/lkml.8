Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC04C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AAF2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GKHupCap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgDMOi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:38:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:36459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgDMOi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586788718;
        bh=7+gW3BFwZ5bYk2D5SD2MBju9rDIRFKHeZgJpA93GphQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GKHupCapOcADynwirN9z8IU2it6OF4e6Addhvgg4k2Nk0kZejB/TDZN86wGLig1IA
         3Nh3U7azkyezqLVaZ4jKm0f/yyIr0KWNNWeERqWZHiP0q8dXhi43JahoqMXbiWlE7L
         ABANwzdZfZUZc/0pZCW7BKVj/BENi+yfcIFs2Oks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1io7a70tAz-00al57; Mon, 13
 Apr 2020 16:38:38 +0200
Date:   Mon, 13 Apr 2020 16:38:36 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>, devel@driverdev.osuosl.org,
        Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] staging: vt6656: Use define instead of magic
 number for tx_rate
Message-ID: <20200413143835.GC3101@ubuntu>
References: <20200407163915.7491-1-oscar.carter@gmx.com>
 <20200407163915.7491-2-oscar.carter@gmx.com>
 <20200413125633.GB3127208@kroah.com>
 <20200413141315.GA3101@ubuntu>
 <20200413142907.GA3548777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413142907.GA3548777@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:GOMNog9IolI/m0UPEqlgipCA6W7EpQRdWJu1ApJS5JqVIl1xNfQ
 0KJn/vWNuBh+Z59kC+sul85jzdQOxNKOWuxTgDWmdh9VPBwUYVMeKY/m72tbe1RVXxcWpRT
 R6YTCDsKcI2kuW3BjdiH9oY68LcTa9ep8T7q7V1hSimi/rSOMUcmTJCRvD4GTZBGaV4bU7N
 mgX2H3j7z9Pi8sfixV+rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Nk03dupN/4=:DFjbxWxbQswu6BRbh44PqH
 gn1pfp36dOeF/GnjgBA1MvEIqBDTMX5xoJnV1pw1tIB8EkHPgo5WegC7Fn3JSK272hvvdV90r
 2el4J+daFIY0O8SVPEYLyChdIt8AEySuRiRZVJ4JEPzs+Jef3W10pdfYnW0VgzGuGOniy0EDo
 yXSsDz6hDHxqH8wlsmBzo2ginDWNCmQYtTLjNLn9+wBSi2OuoyitHaqO7cY02B/k2sIWBVApn
 Zr6BWS6vrpuxUmVwjZGnouDeQE2f/Evo47HtQ9j41ojKieP4JpbJAROxZpuq+bQFvA+Kvg1I+
 nA+u2PTIgxETPVuOe4sq2tpraIGeg4ekLa+6njVsf/cNdKCrvCirkB9Z1QFt+FXjz/ydi9T+8
 QRPtJfutLK5wtriS0SRvcnr7i924sOzMxx6ZBR0ZBcnoRv9MY9blznFmornGiO0Cs7EGjVamT
 y6/c31RBBs+8wP3U05jLV5LR677CvLtj9MF2zIhhPmLmB8Z5XGw+f/4wMOvB7BoEb045JpZ0/
 tFueXP6yh5LjOEea0n31w/M/2oEuJJegyCr9vWdCENdb1Pv2ZrpE3XzWdBhPVFsBOnF+5tVZx
 VVQwwCZ8zdGq+Ie4LYB67E1L0AHo9DcuTr5Gf39B0AnXYaZGuXQvoZ4adCRxBFVnkYi3uKQvK
 Auc6pj6aMXTZC39o243iRwu22RelUfNYPiEaPyEw57Wb89NMs2fNl5Svk/Z/q65PT6n+Hxkq6
 qhPlhvI6PI+Br7u2HYPBkkMW3zXMhDagNuroghyRSdQbFYxkdwFFmbf75hE4nurG5Qx9Mx1p+
 MPE4s/P5yurEnQqLzAc3jq2TC2k/ceGlfvpiBZ32Y/YsbZNDPRmfc0c/4KQqaz84tzIFzgE5a
 FhFITRpeQegvc3x/pBtUyHqjEe7pBEOt6efO5Xx9dPBjFe43AWSLmXBKfWzuktqQsooSahgKR
 SYMgexXF9uPbyMP5MwlbLjcviYIw5IMvF9xb8u8EOffypX2kHJcjWGNWUcmenLPkP7kO540Sj
 lC9YsUSErnrPphAwcFlh9xa0Bv+Ht6Gqp4LsmR0yBLD+mVE47aJItMISsKAqpXgDQetGknXNG
 72egbwTF8NcH0ljyLVGEr6dPE9vVx9ZzFd1VuP6jYLFgmgm0RONRyMN5vdNdiZD/p2nSWZA09
 x2TxJR2ISREIQW2cyQqw6yNGGUUZU/rwOfQNXM7g8f6NREGUJuxaWfNDOo6aEkwsCSZ7R3p1t
 8ww8BMTnW29kUBoFo
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:29:07PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 13, 2020 at 04:13:15PM +0200, Oscar Carter wrote:
> > On Mon, Apr 13, 2020 at 02:56:33PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Apr 07, 2020 at 06:39:14PM +0200, Oscar Carter wrote:
> > > > Use the define RATE_11M present in the file "device.h" instead of =
the
> > > > magic number 3. So the code is more clear.
> > > >
> > > > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > > ---
> > > >  drivers/staging/vt6656/baseband.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > This patch did not apply to my tree, please rebase and resend.
> > >
> > I need to rebase only this patch for this serie so, it's necessary to =
send all
> > the serie or only this patch?
>
> If I applied the other one, just this patch.
>
> > If it's only this patch I need to indicate v4 in the subject or a v2 d=
ue it's
> > related only with this patch?
>
> As so many of your patches were rejected because of this, rebase them
> all, and resend them all as a single patch series, so that I know what
> order to apply them in and have a chance to get it right :)

Ok, I will create a patch series with all the rejected patches rebased.
>
> thanks,
>
> greg k-h

thanks,

oscar carter
