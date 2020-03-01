Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 13:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CB520880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 13:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TtRZmATQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCANRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 08:17:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:39407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCANRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 08:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583068654;
        bh=JiACLfeTzfR7Tp6Twq5Fov4Jw+UmCO3dhmp6JKW9KT8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TtRZmATQioE7mXIuJAWkz8OnmNT5mNUZjKVdaoZCTNkhMLgIQwd1eM4MiND4Po/ka
         wMQ6o+PtukXuzaBUWZIRDc5f0cw3WgcWLbWzY0qA/5QAgqm+Zh8z0vNP8wFKIkpD+H
         g9rBgPhWwBiza6CSHNZGWq/vxPAuobsUg+n2pnxQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmGP-1ioOc03GLB-00K9Cj; Sun, 01
 Mar 2020 14:17:33 +0100
Date:   Sun, 1 Mar 2020 14:17:01 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Oscar Carter <oscar.carter@gmx.com>
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200301131701.GA7487@ubuntu>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
 <20200301122514.GA1461917@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301122514.GA1461917@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:flahmUZ+XCyJDKb/i7dVnEQwMGQN2TI+cxJTH71Ial7fb6bTqpw
 JUofBNqjwImhBYRb+IGDBRxp1rr9K8cXJoeZSb3ihw226qS1ArkxPlsZUAxL35tS3IeMIie
 +zxKxxnvIotDwYVq6Yk/oT5N6fMNTJYAOkFkEgZJQ//jOMjbrOL+JNyhioCOoAYjbDAKCrN
 3MrrMqFHoXz387tcDb6sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w1aCZ1/OF00=:cyTbnXZ3HdhezYQw03ztdO
 G+tU8TQFOsLj9awMj+WHXZuJMxsr3mzJStYs4Bc3AEapVu8IuvmpofZ/SGCgSmli+oEz+B3Gm
 TvjbHyjjqDMh4SBH1JxLo69G84CjgnSPYkM/k1qmzscM2yTZxW5MxYF7UbjzudHWmKPxzWbtF
 vzYy5cXJZxI1U9tjHGwzO2PPTQiri+6kg+kgWOpsL1DV+giPAirVZ0fbJltfSS10HDYsT2onJ
 GLAX/o1pBgRGPAWjAGpGBnGIiahq5WUWNmbbNLGS4/PGeCwo1lTJYT//xo6TaDWNPigC6PMKX
 guM098mPoTXTdAxzXLWI71c3T7RtH7FBjxVgcXf4fSnMtcRW5mbIa+Mqu26MNICuE+m9eZLP8
 5Y+bjil+d2YRQZBiOEN1AcOYH8bZvKd4jHdqPYFm7JqHiyvYTuKLrnNCPDz6siEQfSmcWjEmb
 T/CrF0/1kI9kI/njW4WNpqgXD1dmDu6fOWQC3XTL6xrkUBV3vl8vucChmxFrPO/GncvRcVm4H
 XpREjwXUl9fEJRAulE4+QQebli+Y5BTjY0bnRSrrox/XBeHhrpKCj3MH6dkerBMBaeohV6Nkk
 COzkTJPbZU9yhAm60wAS/WtVkyidp4i/Gs20YikHImeosZhqc4euFUKO6QGiq4lQ7h5bXoM9R
 k+VDyOUv2kJscu9kCdUm570hEgUf58+B2q81J+DWzqxGl5dTH4qJJEwMtg6VqJTgwNJvJTYwU
 IMNIYKNLBEmheWr22HG5d1IAHdlPWudOH7b2s/kjo/lzrvvpNEExi04vijAFxIYQjEZTDCuiz
 tjpkq4ygrBbgs6XWtPfsCTilISrSiZlS4gMRw+je2GyPJvKlwTxWEUEpeoND788eTDHMgDFsw
 hwx60/K5T540hwmNGABwhlv8E7PgeWxYZ4kv73WbJBU4hZrweEKmwa1mr1z3Lo9iuyEYtziv+
 oPlVgswEHfd1udW+jdEn5MBo2Z51gcIgjhL7YewzU5kl2BANjgl8KBcnmeRrmwDqwsd6qbpKW
 8g+QK9O8AzklySoovRpPvm/tA5UY0xPL3D3TxdtK+JTfEpbb8Nn8cHgf2iiWaQsGSeKIXuzYQ
 r/elXJpw4rDcILw4wVbaWylZIWp/xp4KkFm4QnLHwBWlW/kgl9N+saO8wtizYBsBI4fQ4tIDm
 fzE0IWWjTO3zBIcBk3j3PkGVjEfqw7CKM0ak91g3L/OUuCCi5M0DcLZkOzZeJkgfbLfSJ3Xza
 Zz01ENx8LdrqINqKc
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 01:25:14PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 01, 2020 at 12:26:20PM +0100, Oscar Carter wrote:
> > These include module parameters.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/main_usb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt665=
6/main_usb.c
> > index 5e48b3ddb94c..701300202b21 100644
> > --- a/drivers/staging/vt6656/main_usb.c
> > +++ b/drivers/staging/vt6656/main_usb.c
> > @@ -49,12 +49,12 @@ MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION(DEVICE_FULL_DRV_NAM);
> >
> >  #define RX_DESC_DEF0 64
> > -static int vnt_rx_buffers =3D RX_DESC_DEF0;
> > +static int __read_mostly vnt_rx_buffers =3D RX_DESC_DEF0;
> >  module_param_named(rx_buffers, vnt_rx_buffers, int, 0644);
> >  MODULE_PARM_DESC(rx_buffers, "Number of receive usb rx buffers");
> >
> >  #define TX_DESC_DEF0 64
> > -static int vnt_tx_buffers =3D TX_DESC_DEF0;
> > +static int __read_mostly vnt_tx_buffers =3D TX_DESC_DEF0;
> >  module_param_named(tx_buffers, vnt_tx_buffers, int, 0644);
> >  MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");
> >
>
> Why?  What does this help with?

If we declare these variables __read_mostly we can improve the performance=
. If
these variables are read many more times than written, each core of a mult=
icore
system can maintain a copy in a local cache and the time to access is less=
 than
if they use the shared-cache.

>
> thanks,
>
> greg k-h

thanks,

oscar carter
