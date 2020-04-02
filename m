Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A811C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2007E20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h9U6MBB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbgDBQSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:18:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:44535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389458AbgDBQSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585844318;
        bh=Ha6uhEHP6yt0gDqDKrJoPEb7up/ARPeYWAyiPscmxhk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h9U6MBB23/IrRh+hgK8kbV18dQaObah4to1o4DuTrnIGi2axNR6awjSLodkY2F3Qh
         xD+zywErFDEBWcFPIIUVErG9wsTWOXIUAjy3FwtFWxW1vm+NjMd7Az4MY8JtjuVS3W
         ACikdVbsoFBu5vjQTKK0OxL8Z5m4QmJ4YUEodPK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hvR-1jA79F1owR-011ltw; Thu, 02
 Apr 2020 18:18:38 +0200
Date:   Thu, 2 Apr 2020 18:18:25 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use defines in vnt_mac_reg_bits_*
 functions
Message-ID: <20200402161825.GA3939@ubuntu>
References: <20200328095433.7879-1-oscar.carter@gmx.com>
 <20200331102906.GA2066@kadam>
 <20200401165537.GC3109@ubuntu>
 <20200402091917.GA17323@jiffies>
 <4e5fc495-9355-02b7-4148-ea4de5370617@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5fc495-9355-02b7-4148-ea4de5370617@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:zgJ0x0lB71mFFzXhTSJLU6lMqD7zrO7EH6/wEuwXDz9/rmEt9P/
 CK4qnq2WEHU3R+oqaUBz/LJIps5b882EIcJOb20W+Vo8+67qbO1P2oNZ8H7fi9dL675A7v2
 x9VneawAF0TQnBqDtPd1aXkUhB4EA/U7IDdWC8Zt9Q8XiBfgrgkHWhmqQdxWg8+j1CmF7hw
 k+qvq0uBEVtwN0vp4oo9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D7pbub1xazs=:+3glSZlpMMy5g2/PRgN+Nz
 djfSv7lj8tdK91yOA+ERI1jYCWMEeyLXeWT5LhGGqSp6M0QXNY+EhzkzHiosxe/YumFF0Ci9G
 frZ8SZXWlUQYj1PQl/0ZQQ5CGQMbbde4BUS+XYEG8+wa42Db5J9YHNmPszcCDbXPcHfr5g1Gw
 c1yi6v5aYQn722wFInobiv7CM5HOU6XFY7MPoHmQLE/Oyz+zwtE6934YuWOV2ZhcJbPbdnYWQ
 i6n8pQFiRrE+KPfFxR6mNhzHzKLSFqqu+tD6oFysYouSjAN8p68BeffvdN2iMM0nT23QRF/Xh
 HYXdhIn8kawRoG6/RUjvPni6Gyn+Z7+u8+XaO5BOBjphXIdtwVWtvYTlQxKfTE9vgvRYrUew5
 8mNhEbvYGEzDiIDM2HJbUlngNJcW6U6LQeAA32qxJdBPLWPzgluDMib2CAqkpP++Q6B3g0yw3
 KuEIlAJg6p4Nblka/iefcdHifpQziKmivAIesEwChSR2dnPfbk5sZ9w/PkKkP01dWd0OnIY7s
 a0KYZJvrTAz3IKbfDbOMGz98F4aKgKWS+nYf4nDUHJfUv1IsJjbzV3JwRuiKkmg3fFrIRfMu2
 T+/twXGAXGIcYHrafoJG2BtfHUwdpAhtfQLM+cESggTJ7FPtAW6us3xEjTgLDzCzIF7Hjh1zx
 bkfk1s/L4w3Cox4gVhUwM9hNpMIXjNtdDAgiD7P+eSahSVtOtFuAqZ7qU7AUomfYRf+69w/S0
 umjUUna1Zx80vxZzgTQ0x/mXRvlmLnCQ7jJMDyRbsvdMF5PmCQSFZ8xJtD8jYcPSora4dR78F
 gJW3EGY+iyTAoiCsO3kf7ZdfHab/SZuYXbQPTZpzcw/wDCc7Bq221avPpT4I7AlpKIp+W+tNJ
 2ClkVNGq3JectmRfq2U2KMs5jbDKtNVnqO3qXf/aA633FrQ674ayIldXEF/ZcPB43gDHEEi1R
 ZVbTgeiAodNys7O3FBcrJXeeCoDvWYqnQTuW3MEUx1ivAn6V5/R1hvIh/exnW8UPEtojJDSHv
 3mxg4KJ871YmQ9AQchyIxnjuHFQKPjRSHBKs7jb6vlCVJqKYwyT2qrFzuJDF2xMIIXkBcj+88
 JiZCNvB5V3Q4dhvAy5pdLjIEafF/TANHXNNPxiORzbVd6NtVxD6xcVbPgJVfaPzdPr1jV+WK+
 YCYz/rY07rjTSdwoRnbyHyWdImdKp992WNX5Wj8HLGuJ7ptH3OxkLJDec40LA/pUrAecsG+ju
 VmRphkGrNsbpFOws8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:58:07AM +0100, Malcolm Priestley wrote:
>
>
> On 02/04/2020 10:19, Quentin Deslandes wrote:
> > On 04/01/20 18:55:38, Oscar Carter wrote:
> > > On Tue, Mar 31, 2020 at 01:29:06PM +0300, Dan Carpenter wrote:
> > > > On Sat, Mar 28, 2020 at 10:54:33AM +0100, Oscar Carter wrote:
> > > > > Define the necessary bits in the CHANNEL, PAPEDELAY and GPIOCTL0
> > > > > registers to can use them in the calls to vnt_mac_reg_bits_on an=
d
> > > > > vnt_mac_reg_bits_off functions. In this way, avoid the use of BI=
T()
> > > > > macros and clarify the code.
> > > > >
> > > > > Fixes: 3017e587e368 ("staging: vt6656: Use BIT() macro in vnt_ma=
c_reg_bits_* functions")
> > > > > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > > > ---
> > > > >   drivers/staging/vt6656/baseband.c |  6 ++++--
> > > > >   drivers/staging/vt6656/card.c     |  3 +--
> > > > >   drivers/staging/vt6656/mac.h      | 12 ++++++++++++
> > > > >   drivers/staging/vt6656/main_usb.c |  2 +-
> > > > >   4 files changed, 18 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging=
/vt6656/baseband.c
> > > > > index a19a563d8bcc..dd3c3bf5e8b5 100644
> > > > > --- a/drivers/staging/vt6656/baseband.c
> > > > > +++ b/drivers/staging/vt6656/baseband.c
> > > > > @@ -442,7 +442,8 @@ int vnt_vt3184_init(struct vnt_private *priv=
)
> > > > >   		if (ret)
> > > > >   			goto end;
> > > > >
> > > > > -		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
> > > > > +		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY,
> > > > > +					  PAPEDELAY_B0);
> > > >
> > > > This doesn't clarify anything.  It makes it less clear because som=
eone
> > > > would assume B0 means something but it's just hiding a magic numbe=
r
> > > > behind a meaningless define.  B0 means BIT(0) which means nothing.=
  So
> > > > now we have to jump through two hoops to find out that we don't kn=
ow
> > > > anything.
> > > >
> > > I created this names due to the lack of information about the hardwa=
re. I
> > > searched but I did not find anything.
> > >
> > > > Just leave it as-is.  Same for the rest.
> > > Ok.
> > >
> > > >
> > > > There problem is a hardware spec which explains what this stuff is=
.
> > > >
> > > It's possible to find a datasheet of this hardware to make this modi=
fication
> > > accordingly to the correct bit names of registers ?
> >
> > I haven't found any so far, if your researches are luckier than mine, =
I
> > would be interested too. Even getting your hands on the actual device =
is
> > complicated.
>
> All I can tell you is it related to command above it MAC_REG_ITRTMSET
> without it the device will not associate with access point is probably T=
X
> timing/power rated.
>
> Other bits in MAC_REG_PAPEDELAY are related to LED function and defined =
in
> LEDSTS_* in mac.h.
>
> I think it is some kind of enable so something like ITRTMSET_ENABLE woul=
d
> do.
>
I think the best for now is leave it as-is due to the lack of information =
about
bit names of registers.

> Regards
>
> Malcolm

Thanks,

Oscar carter
