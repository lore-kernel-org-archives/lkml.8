Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36477C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3820724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dK0+c9bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:56:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:55351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRQ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584550581;
        bh=0MdBDKZz6fAY+TxmYNydSRzfwOCiMYDTnxPndAe+j4Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dK0+c9bodfi/UD+GXonEXV/+EuPu/xlrqke8n6qddhPLbMyAalxXfPmDwh8jbHSEf
         cue9GD8VPgefO7Vgffi1C7TP6KQgX+fq2jrc5acJQQX7E46k+EUtTKSNO3H+I1joZe
         Y4XWR6f8s5LbHExDIVshXz1TCm6f7dAeLD0JxLFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5eR-1iyKBs0Smr-00J5i8; Wed, 18
 Mar 2020 17:56:21 +0100
Date:   Wed, 18 Mar 2020 17:55:52 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Oscar Carter <oscar.carter@gmx.com>
Subject: Re: [PATCH] staging: vt6656: Use ARRAY_SIZE instead of hardcoded size
Message-ID: <20200318165551.GA3082@ubuntu>
References: <20200314164754.8531-1-oscar.carter@gmx.com>
 <20200317104506.GA4650@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104506.GA4650@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:8++pG89+OeDxgjT4Ibi/oYjl/3FVbtlFRCbf4uoQNXTO+XfK1E5
 yfGqKA7GGA+WaQrsr73Zu8WuLeRJezvcZXnc1DAzqsFYVjtUVXL8+47Mi7ljvG3fRmCRXPO
 Tt8HrqjROp+LjLR1++C3pLWS7PzeEjgBjTKfcx7VG7POBzkD295JATuKLD1pvhAYF5ybQdZ
 lZZ+m7lPavTWxinXgY3Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZP2cT0rRTB8=:rgGD80Q77COxrZbszR8WG0
 7J3dZ5fgjwZbmIiQS2yh8b4cW2Vu5tA+03HpV5G66t3pfc4XDQYH0ANHYXRUROqneuLOx5PqE
 1nhAqI+MnnStIhBYRFQ68Eqpsfg1tqkpVh8hXUPxVwCQomqzmlVwxYoDzRWjRdaLxqnWlFmaQ
 bkgBoIYYk7nOPlCrpB5CBC1VW3VTMhgfYviLnYnuyhaUhvSlIGGtuUq2yOHELT/3M1DNl1pTR
 SzagGQEb7cQmp72qHCjQcQlydXdym9+DR8Do7KqpIuqvRpuozGMSz/kOiXDtziyJxPLQlPRxj
 xADBHtj4Dod/IAnpgQHmAt1FkSGZFVNvjtRBuMkCMT6q1Mq0nvIbKllo3+7VaxndDTliltCNd
 mxmeaI7p/jteTId0DaXx+4ePlSBFUu1Hp9dMPLvRoRIxjYDQRDYIWzpm0Mx5kbzL6HvgtrTCz
 p1ROgONaDI7/JjHYWJRsO3fXs/04sGQ4tCqZMZxwl/9eF88FuFzoYBm2BSOclk3DOapQZl2rY
 zzFvuG5pWSD3HOGezuCiv6pcSwY6hSB9kG1pjAiI4Il2zWueOBzdtDG2JsYoPHE0usy0aX0uq
 qkNlMaB2mXr6HLl5ZPUJE9CaQQTqod2DjSR4dipUhIyz0GV06quF3UgY2Ud0d/qbr6u6IqYtr
 4hF3I+O5L+/lUo4HKx20p5RshazN051JVPDTO78FCHODmMJNRojgDD8JGAuOThzu3F43tf0Un
 wlrbvrzd/H67R+DX/cXPH8DNyRQMJLlXrkTH6xs94DBIeX8jLhFbxYZykv3kUj+vLkYd4DwQc
 jD+TzV55w7dK5a/e+0aWYgjVe5ePOXXLFgAvZAVAidKk7c3C8WY1/bYeaHS5YyLXGaN6+H+Oq
 OuFNMjsNToaDP0+qPR6Fz+4w4aM1AhV/BzJRj77YUQUMcc/cQrvhV4J1jDITheGxC53kSRrkg
 Lta0WVehPNYEjTPBxy6ziQkNny0Wh6JCJlyz4YDUcoUBygm+YywySaiUhQvT9yfN7GYDwvXT6
 a6MV6bY20AB/QfU4UaZ0OkZ+rWpTJYFgmEDgkQoSbr5IlH4rsbjAAkzdCYqExJh5uXD9/oTbx
 HM94ZuLrHxPP/u56TJ8Io7/+qGW2ZREM09gtL4SIZmb7JlGU1l6ZdHrIQB4mRyfBoCWUns86N
 CtxjAlhwWF6eJ38GoitQKGdHGel8wrKHoDS0Hr3aP59XztMOPYi8/+U2WR8uZKc34rv4lXIQq
 YHp7nOTa10vQ9ixeE
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:45:06PM +0300, Dan Carpenter wrote:
> On Sat, Mar 14, 2020 at 05:47:54PM +0100, Oscar Carter wrote:
> > Use ARRAY_SIZE to replace the hardcoded size so we will never have a
> > mismatch.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/main_usb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt665=
6/main_usb.c
> > index 5e48b3ddb94c..4370941ffc04 100644
> > --- a/drivers/staging/vt6656/main_usb.c
> > +++ b/drivers/staging/vt6656/main_usb.c
> > @@ -23,6 +23,7 @@
> >
> >  #include <linux/etherdevice.h>
> >  #include <linux/file.h>
> > +#include <linux/kernel.h>
> >  #include "device.h"
> >  #include "card.h"
> >  #include "baseband.h"
> > @@ -116,6 +117,7 @@ static int vnt_init_registers(struct vnt_private *=
priv)
> >  	int ii;
> >  	u8 tmp;
> >  	u8 calib_tx_iq =3D 0, calib_tx_dc =3D 0, calib_rx_iq =3D 0;
> > +	const int n_cck_pwr_tbl =3D ARRAY_SIZE(priv->cck_pwr_tbl);
>
> Please use ARRAY_SIZE(priv->cck_pwr_tbl) everywhere instead of
> introducing this new variable.
>
Ok, I create a new version of the patch and I resend it.

> regards,
> dan carpenter
>
thanks,

oscar carter
