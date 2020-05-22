Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54280C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AEA2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgEVGVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEVGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:21:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74453C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:21:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jc13K-0003Qx-0Z; Fri, 22 May 2020 08:21:06 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jc13I-00026O-G9; Fri, 22 May 2020 08:21:04 +0200
Date:   Fri, 22 May 2020 08:21:04 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Bin Liu <b-liu@ti.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, russell@personaltelco.net,
        fercerpav@gmail.com
Subject: Re: [PATCH v1] usb: musb: dsps: set MUSB_DA8XX quirk for AM335x
Message-ID: <20200522062104.7s2vpmmqigvvljsn@pengutronix.de>
References: <20200327053849.5348-1-o.rempel@pengutronix.de>
 <20200519221851.GA15845@iaqt7>
 <20200520044934.hyngdg774ibqai46@pengutronix.de>
 <20200520145505.GC15845@iaqt7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qkgmncfs3aa353y"
Content-Disposition: inline
In-Reply-To: <20200520145505.GC15845@iaqt7>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:05:09 up 188 days, 21:23, 178 users,  load average: 0.13, 0.11,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qkgmncfs3aa353y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 09:55:05AM -0500, Bin Liu wrote:
> On Wed, May 20, 2020 at 06:49:34AM +0200, Oleksij Rempel wrote:
> > On Tue, May 19, 2020 at 05:18:51PM -0500, Bin Liu wrote:
> > > Hi,
> > >=20
> > > On Fri, Mar 27, 2020 at 06:38:49AM +0100, Oleksij Rempel wrote:
> > > > Beagle Bone Black has different memory corruptions if kernel is
> > > > configured with USB_TI_CPPI41_DMA=3Dy. This issue is reproducible w=
ith
> > > > ath9k-htc driver (ar9271 based wifi usb controller):
> > > >=20
> > > > root@AccessBox:~ iw dev wlan0 set monitor  fcsfail otherbss
> > > > root@AccessBox:~ ip l s dev wlan0 up
> > > > kmemleak: Cannot insert 0xda577e40 into the object search tree (ove=
rlaps existing)
> > > > CPU: 0 PID: 176 Comm: ip Not tainted 5.5.0 #7
> > > > Hardware name: Generic AM33XX (Flattened Device Tree)
> > > > [<c0112c14>] (unwind_backtrace) from [<c010dc98>] (show_stack+0x18/=
0x1c)
> > > > [<c010dc98>] (show_stack) from [<c08c7c2c>] (dump_stack+0x84/0x98)
> > > > [<c08c7c2c>] (dump_stack) from [<c02c75a8>] (create_object+0x2f8/0x=
324)
> > > > [<c02c75a8>] (create_object) from [<c02b8928>] (kmem_cache_alloc+0x=
1a8/0x39c)
> > > > [<c02b8928>] (kmem_cache_alloc) from [<c072fb68>] (__alloc_skb+0x60=
/0x174)
> > > > [<c072fb68>] (__alloc_skb) from [<bf0c5c58>] (ath9k_wmi_cmd+0x50/0x=
184 [ath9k_htc])
> > > > [<bf0c5c58>] (ath9k_wmi_cmd [ath9k_htc]) from [<bf0cb410>] (ath9k_r=
egwrite_multi+0x54/0x84 [ath9k_htc])
> > > > [<bf0cb410>] (ath9k_regwrite_multi [ath9k_htc]) from [<bf0cb7fc>] (=
ath9k_regwrite+0xf0/0xfc [ath9k_htc])
> > > > [<bf0cb7fc>] (ath9k_regwrite [ath9k_htc]) from [<bf1aca78>] (ar5008=
_hw_process_ini+0x280/0x6c0 [ath9k_hw])
> > > > [<bf1aca78>] (ar5008_hw_process_ini [ath9k_hw]) from [<bf1a66ac>] (=
ath9k_hw_reset+0x270/0x1458 [ath9k_hw])
> > > > [<bf1a66ac>] (ath9k_hw_reset [ath9k_hw]) from [<bf0c9588>] (ath9k_h=
tc_start+0xb0/0x22c [ath9k_htc])
> > > > [<bf0c9588>] (ath9k_htc_start [ath9k_htc]) from [<bf0eb3c0>] (drv_s=
tart+0x4c/0x1e8 [mac80211])
> > > > [<bf0eb3c0>] (drv_start [mac80211]) from [<bf104a84>] (ieee80211_do=
_open+0x480/0x954 [mac80211])
> > > > [<bf104a84>] (ieee80211_do_open [mac80211]) from [<c075127c>] (__de=
v_open+0xdc/0x160)
> > > > [<c075127c>] (__dev_open) from [<c07516a8>] (__dev_change_flags+0x1=
a4/0x204)
> > > > [<c07516a8>] (__dev_change_flags) from [<c0751728>] (dev_change_fla=
gs+0x20/0x50)
> > > > [<c0751728>] (dev_change_flags) from [<c076971c>] (do_setlink+0x2ac=
/0x978)
> > > >=20
> > > > After applying this patch, the system is running in monitor mode wi=
thout
> > > > noticeable issues.
> > > >=20
> > > > Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > >  drivers/usb/musb/musb_dsps.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_d=
sps.c
> > > > index 88923175f71e..c01f9e9e69f5 100644
> > > > --- a/drivers/usb/musb/musb_dsps.c
> > > > +++ b/drivers/usb/musb/musb_dsps.c
> > > > @@ -690,7 +690,7 @@ static void dsps_dma_controller_resume(struct d=
sps_glue *glue) {}
> > > >  #endif /* CONFIG_USB_TI_CPPI41_DMA */
> > > > =20
> > > >  static struct musb_platform_ops dsps_ops =3D {
> > > > -	.quirks		=3D MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
> > > > +	.quirks		=3D MUSB_DMA_CPPI41 | MUSB_INDEXED_EP | MUSB_DA8XX,
> > >=20
> > > The MUSB_DA8XX flag cannot be simply applied to MUSB_DSPS, at least t=
he
> > > teardown and autoreq register offsets are different as show in
> > > cppi41_dma_controller_create().
> >=20
> > ok
> >=20
> > > Do you understand what exactly caused the issue?
> >=20
> > No.
> >=20
> > Disabling DMA support "solve" this issue as well.
> >=20
> > Beside, with DMA support, there remains one more crash with different s=
ymptoms.
> > I can workaround it by disabling CPU Freq governor, or setting it to pe=
rformance.
> >=20
> > > The kernel trace above doesn't provide enuough information.
> >=20
> > Do you have any suggestions how to instrument the kernel to get needed
> > information? Or, should I try to capture USB traffic before the crash?=
=20
>=20
> First can you please try the following patch instead?
>=20
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi4=
1.c
> index 7fbb8a307145..26c996f8b2bd 100644
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
> @@ -614,7 +614,6 @@ static int cppi41_dma_channel_abort(struct dma_channe=
l *channel)
>         }
>=20
>         /* DA8xx Advisory 2.3.27: wait 250 ms before to start the teardow=
n */
> -       if (musb->ops->quirks & MUSB_DA8XX)
>                 mdelay(250);
>=20
>         tdbit =3D 1 << cppi41_channel->port_num;

The setup is running, it may take some time until it is reproduced.
Reproduce ability seems to depend on the traffic in the air. Since
currently most people are on vocation, there is not many things happen
on WiFi.=20

> >=20
> > If it helps, ath9k_htc is a usb wifi adapter. It generates a lot of
> > USB traffic on multiple endpoints. Bulk with data packets and Interrupt
> > with register accesses, LED blinking... etc.
>=20
> Do you have a link to the picture or description of the adapter? I'd like
> to see if I can buy the same to take a look.

It is AR9271 based adapter. Searching on ebay for this chip will give a
lot of adapters (even very suspicious .. promising 600!!! or 300!! Mbps,
actually it is 150 Mbps)
I would recommend ALFA AWUS036NHA or this one
https://www.thinkpenguin.com/gnu-linux/penguin-wireless-n-usb-adapter-w-ext=
ernal-antenna-gnu-linux-tpe-n150usbl
This adapters provide access to the UART pins of the AR9271 chip, so you
will be able to talk to firmware.
Firmware source code is available here:
https://github.com/qca/open-ath9k-htc-firmware
The debian package for this firmware is build from source as well and in
the main repository (coll he?! :D)

If you do not wont to hack on firmware, then you can use the mini adapter:
https://www.thinkpenguin.com/gnu-linux/penguin-wireless-n-usb-adapter-gnu-l=
inux-tpe-n150usb

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7qkgmncfs3aa353y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7Hb0wACgkQ4omh9DUa
UbOWjw//UmK6/Pt0DeRXivR9+9eGSvR06IU01vaGhsYlIasOZVQ3fsezOgyzJXMi
zev1Ujc0thdgXhlE3im5G+ftRiVQb35SGjMxKl9EZFmWHyQiBdnW4AnXYa7g2pOn
nNFeZzrMAgn7a/+JR80/BGXPOJHFc1qZf2ziaaX9tiSZmQSpRvOqfVm9v1e/VFGM
WZ4tI9QyEQlauBlzZ7fr16dNGuHjeXolT1buQIkP+oMpwrPaPMM76LXML4IEriq3
og3SXbzO8xP66hHSrClpvgNt/OTxYFkPzZlSwFV9XZXcW0MWqMW2Rhvn7/d4DfsT
cxleA74w4F1C2f3+h00iGCcguRQks7T7vNK2NXF22dBIvcmJUKpkUvcnIIOAbwR9
2atesJG+ojl8CxjlGRTLWJD6z5YYRsu/Jamn2SXVfRX055J50KHWaJHAeNOQf3Ht
2JRgS55P5t0drjjXWmQkq57hu+Y+P2JQ62VYWFk5xoGsLdpXrvCPe81krS0zTn5X
7KmYshgjkv810U9vAAg79rqcHIqmEy6eYFGxYAIczu2Bese2R6xJRPb+p1AnJDDd
dhUAsIf21KRRkvkaKHdDhEdBmFkNkOvEsS+JOE12x/L1qdFU7yaaZpIZUZHPRVSh
zKTZ7D7TzR/tWY3Ml2TmhsGqxLDOYRfoo5wBXY0KoXe/P7tmwmQ=
=dfpa
-----END PGP SIGNATURE-----

--7qkgmncfs3aa353y--
