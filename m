Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE23C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27BF206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Cmfk0Dxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCGI3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:29:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:60209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgCGI3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583569763;
        bh=h79C+D9/EzcE+etbcbZdLaCiNxPE5dspkTyds0Z1D14=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Cmfk0Dxr0eO5wFGCFqKBoT264bq+7WbFiB/B7ewBbTVA5VkXU3L8QD4W62qXxHRMh
         DHkdLH5VBh9iIG0ssxXinGvo5wZEzZaBqp8r6XvK/olKFS/tCK71xdPfyqU7wwjacZ
         tyu3hfj078NEUnY8GTMmjpHJWaM7nOums7w4v7iI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1jaVyi3cwM-00iixk; Sat, 07
 Mar 2020 09:29:23 +0100
Date:   Sat, 7 Mar 2020 09:29:06 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200307082906.GA2948@ubuntu>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
 <20200301122514.GA1461917@kroah.com>
 <20200301131701.GA7487@ubuntu>
 <20200301150913.GA1470815@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301150913.GA1470815@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:/AbFBE0f0Zp6NqvRYmi/sHN078hyV83hTiMzs2AAgg1PNV/aoct
 SHvt/qID4eDmdTU1LS0/w7sHSKXUi2nxKLdi8Vu9Cy+nGT/2KsmP3Wlo7EJPGd00Il3HtHO
 3YfIpUmqfnrMbIeWroX+fWlEzMu9fhfCq2rsYaS3yediHnoRj14g6SPzciLxij6d4/F0qCz
 oNU82aIlLKA2NfGqv61OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MNFbH05vUpg=:0e7OB0RPcLe5GHyg0KXodm
 wEU1MNmm2cozk5fuk47ptom9QD3bvKlQdDVdp3Vah0issdUV8VUlQpzy+A+WRG1iO8vIDuuoQ
 biNOb6h0C66uF2yibEqzZsZKDi1O95PTRKcajRchzbQkM22DyVy60A4F9JJbxEVXiyks2j+wi
 O2ouYM8EtHKqt/JuO+85dLDH6EZKHAhdNV0sVzcQl8QVR6JIT2NBIvbmQJt2BXVdA4kFn2BgP
 EbwZbWENuPEahVxv89QAzJDHL/7h1zdoZYQ/5MeaB3gfPyObpydZzP3fd4G7Wivqh0slP7cHo
 9kl4C3qG7inzIy4GrB5RI6MNUK4S8LcanN9ypjBiA8ZpHqonSNlHF2O+a7aWjZOg1hFWQylSs
 UBzAltiZ4DLfsSNrjdr5lPTfoU5XAN8GSzfmE592H570vHfMfmzMwS8np2owRC/ts+k+zJYq8
 Ju3V+SiRgyK7rRpPqXSBEQ963KoMZ8VDhOx5BnbI4tmficlKF7F50rVgkKIGXiSrWlYwtpsdK
 l8peJKwFNnj2cWCdDCwZu7fD+qR8V6xPS0FIcKHRfUEkT3yNw/lStK4Mix+aKjGN6rVUOAbj/
 xeqo/Jx0Jo2uBwoGJxrGyPK4ncvOTfpqwVzJ20i6x/qTyTLfQr7pfkI+h3LdgjDSYufosVRZz
 al9VlXAjldteorzdUYRtVVoBsU95LxrJp5a3RPcK65sb/K//VWINySOo4DFl8iyciSDGohERN
 Vm390r0wS4T0/w2oZXwM9cLmHBQfmF/u+Q+XiG/yG/u41N1tnbiGctnRrwUdUw7iHt5LMDxNk
 60Tuz2Tb/J44u5qowXWwLqYCiKYSAuD+9jM9ChLAYDkXEqw5AAaikW8HGeoUKzoevFgXZu0NU
 oK7AhcSsEOPgVAihwbrbhjZEbGUOw52FNh/ap04UbvEr+iLH1XflC3/tLzdIfVguPQxr0W+ER
 1FV+t/OyYyPqa80bmVpC8Er884btTCDl7qeFpS96GxrZkLUzrCapWEWV4bl/zXbWkEiAaSMSx
 ZLpmcCnXoaFsoq+GYiQsmybhWwoS9DJe9yitsRODq+x/qnI5DCpBwf8jzEEhOS5en+kBrOIYy
 b++WAPjU5z8SHmPUX2R9mecOmefbKuBsBsanhMBz/BBqkXJziUkaIaGTSyBM7fsG1hVUsipXk
 TjpmjxIdruGmEb8Ie+Sdz+zRiCviS03XvSryRInavZd0Hi4diW9MXILfX5IkUcO754iQU3jbG
 ETstdqqYPSsVHCIq6
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:09:13PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 01, 2020 at 02:17:01PM +0100, Oscar Carter wrote:
> > On Sun, Mar 01, 2020 at 01:25:14PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Mar 01, 2020 at 12:26:20PM +0100, Oscar Carter wrote:
> > > > These include module parameters.
> > > >
> > > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > > ---
> > > >  drivers/staging/vt6656/main_usb.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/v=
t6656/main_usb.c
> > > > index 5e48b3ddb94c..701300202b21 100644
> > > > --- a/drivers/staging/vt6656/main_usb.c
> > > > +++ b/drivers/staging/vt6656/main_usb.c
> > > > @@ -49,12 +49,12 @@ MODULE_LICENSE("GPL");
> > > >  MODULE_DESCRIPTION(DEVICE_FULL_DRV_NAM);
> > > >
> > > >  #define RX_DESC_DEF0 64
> > > > -static int vnt_rx_buffers =3D RX_DESC_DEF0;
> > > > +static int __read_mostly vnt_rx_buffers =3D RX_DESC_DEF0;
> > > >  module_param_named(rx_buffers, vnt_rx_buffers, int, 0644);
> > > >  MODULE_PARM_DESC(rx_buffers, "Number of receive usb rx buffers");
> > > >
> > > >  #define TX_DESC_DEF0 64
> > > > -static int vnt_tx_buffers =3D TX_DESC_DEF0;
> > > > +static int __read_mostly vnt_tx_buffers =3D TX_DESC_DEF0;
> > > >  module_param_named(tx_buffers, vnt_tx_buffers, int, 0644);
> > > >  MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");
> > > >
> > >
> > > Why?  What does this help with?
> >
> > If we declare these variables __read_mostly we can improve the perform=
ance. If
> > these variables are read many more times than written, each core of a =
multicore
> > system can maintain a copy in a local cache and the time to access is =
less than
> > if they use the shared-cache.
>
> This is a USB driver, performance is always limited to the hardware, not
> the CPU location of variables.

Thank you for the explanation.

>
> Please always benchmark things to see if it actually makes sense to make
> changes like this, before proposing them.

I'm sorry.

>
> thanks,
>
> greg k-h

thanks,

Oscar
