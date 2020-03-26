Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEA2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC520409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ionFLP/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgCZRWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:22:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:50289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbgCZRWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585243347;
        bh=MWQpqiFq+1hK9zp12FeAP0ENS8Btp4Us1plOsjWVOA4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ionFLP/z5hIMPcvYYdpYjsCoEq0rpFaf+I84HduZC/LtfLDDeCNk6pc97WHph6ZVJ
         j8xUbf6gRkv6WPlnQHLEgCkkkDYCfGOGlyzFa35oFfRPOQshcMjcrCeFvaDfE8wNo8
         GcN1PbgGofKXwYBo8iDv7T7OLRDpUPqf0fJRfF18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTRH-1iudja17wr-00NUbM; Thu, 26
 Mar 2020 18:22:27 +0100
Date:   Thu, 26 Mar 2020 18:22:25 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6656: Use ARRAY_SIZE instead of hardcoded
 size
Message-ID: <20200326172224.GC3629@ubuntu>
References: <20200318174015.7515-1-oscar.carter@gmx.com>
 <20200324095456.GA7693@jiffies>
 <20200324131830.GD4672@kadam>
 <20200325091924.GB15158@jiffies>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325091924.GB15158@jiffies>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:HLqxRcmQo28JRdSPp73j2tg1Y8Oyog28LeDWrq1bY2PGNpeNplf
 w+FiAc4Vgo+vp+aHfnauFLt6+tkoivrd+7WWSQ1oYbakn8QuqIOg41G0Q7PJ53ZjBsPNA20
 znqRWWPFpCp2V63I0K0ia5x4yk30Kt+pOoXGZpeP5vmUzjiv8IX5+IXZirn2nz4oyac2iXw
 4+mOsuFVoCAYViHuuP3VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0rOYc05hHsg=:YWfhe8q5SwPvx1E1cvHmPp
 juNhBP2AXxFVwySkTWRdQcXCV751daKlHy2ZEfcJrB+3qMG8eXEF9mG9NwjWIMIet0NahjcLI
 G9Aizlt49U6GwvL02tGeVgs4Ls5OR8fihViij64ldaAhF5XUAM5T7tQbl5GgH5l3TxQ7jfqoU
 oiTVab0A1OzWezNg4XZrcMf7+4yeTN7LsHCwyehHS3ww4zekphdRUcvCXwAisEvfa1i6OQyfz
 80HC97nHG4Xh4ooh7lNvMvRYKDeoPuRbiby6vsMGGakhXiMnBcnNPd6d2ecrSSWADbMuKTUcC
 RRz7tQw+nZwDyyDvrt0TO/6ONDEiVmhF3v46Ehd7tTMJM/1nUBfcnOLUWyG1hq9vRC68Ne4Mo
 OM5Dck0eClP0kkl5JczZykLo6kxjYQGE1mRALY5v0i+2jb5SGcBo5QyS0EmfoB4mla1xMXZhP
 fDfQ+IZB1b/ukTKw1VOzzLlE6/pCW51iZaDCBQRbTBwsvF53dAoOYBkHBmYtuHpgdQ72W3zbr
 7VgAqvLAn4r+eehlAQfv87+BqJQ1hWvvGlIcBsF2GeCUyyqAWwl8c3XnyKjhCp5Rr6ajVYLuA
 81refT6rqxyyfXnZtO5xkF7icqC6l2OVyt7Wu0EUQsQGe3tZWX1My67gIv4EF0UcOGauCb7E9
 w3Rv6Jm1UPC219K9EXaznesBBowSaa1IyvMY9k4odEBgPT7FbLuLRzd3CYXH/YCb+BCPWpdOv
 N6cMcHGyPVtXxwLyIJ6bwoAKbCdBhs/Klkkj81SpyKxxrMVIuVe72iTANLIle0OXuguOAatj/
 MX8GjUTdI4xZu6mIZ9luJRzayjVDcDFnVfIdSyvAkmcRx8CasJO4AfMf+7JbqylQc729ePdbD
 63jsvnRPtlk1iVPaJogGLFS44XlQeX82ZvhfnpUYi5MoUNubqylru9SzEi0OUqzVNvddlw2YL
 cax3k+Fl/ImsqrwsaxE1KaCAxP2af8jfCq6k12UlJjR/WIzWDhsu9z7wRniGMl3Dh+tEyBD0w
 m//r+0NW+CB6i01QVwkS/cvki13aVbsDtKiwYSwlLZOlw2uHEK1Qk3jQQ6aDjcBjw9qmzGhbA
 9dI3HWamH6zaZf69xxaRT+PDNSiL7SzfcS+ACW7A176WC5DA+IEseUNlj2zcP41ucHfoVNss3
 +lOJENqsqbV7OS8G2WcNhr+LK+5V4FQh1uvZiMzgfW3dZd3X2YmP7fq9FgZNJL934OFmz0/vn
 XDcOshFa+Fa2Y8raE
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 09:19:24AM +0000, Quentin Deslandes wrote:
> On 03/24/20 16:18:30, Dan Carpenter wrote:
> > That's a bit over engineering something which is pretty trivial.
> > Normally, we would just make the size a define instead of a magic numb=
er
> > 14.
>
> My bad, I meant "define", not "macro".
>
> > If people change the size in the future (unlikely) and it causes a bug
> > then they kind of deserve it because they need to ensure all the new
> > stuff is initialized, right?  If they change it and it results in a
> > buffer overflow then static checkers would complain.  If they changed =
it
> > and it resulted in uninitialized data being used then it would be zero
> > so that's okay.
>
> I wasn't sure where I should stand on this, that's clearer now.
>
> Thanks,
> Quentin

Dan and Quentin, thanks for your time to review my work, and make comments=
.

oscar carter
