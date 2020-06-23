Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA7207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgFWTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:45:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41458 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbgFWTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:45:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3951D1C0C0A; Tue, 23 Jun 2020 21:45:34 +0200 (CEST)
Date:   Tue, 23 Jun 2020 21:45:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Subject: next-20200623: oops in btusb_disconnect() at boot on thinkpad x60
Message-ID: <20200623194533.GA3815@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting this at boot:

[    7.984584] *pdpt =3D 0000000033a31001 *pde =3D 0000000000000000
[    7.984584] Oops: 0000 [#1] PREEMPT SMP PTI
[    7.984584] CPU: 1 PID: 2532 Comm: systemd-udevd Not tainted
5.8.0-rc2-next-20200623+ #126
[    7.998580] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW
(2.19 ) 03/31/2011
[    8.000592] EIP: __queue_work+0x139/0x320
[    8.000592] Code: 90 83 7d f0 08 0f 84 b6 00 00 00 8b 45 ec 8b 9f
04 01 00 00 03 1c 85 40 63 1f c5 89 f0 e8 df f8 ff ff 85 c0 0f 85 4f
ff ff ff <8b> 03 e9 50 ff ff ff 89 45 e4 e8 48 0a cb 00 8b 4d e8 8b 45
e4 8b
[    8.007883] EAX: 00000000 EBX: 00000000 ECX: 47d88848 EDX: 03ffffff
[    8.007883] ESI: f4a348bc EDI: f492a600 EBP: f3b1dd0c ESP: f3b1dcf0
[    8.019981] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS:
00010046
[    8.023156] CR0: 80050033 CR2: 00000000 CR3: 33b1e000 CR4: 000006b0
[    8.028892] Call Trace:
[    8.034199]  queue_work_on+0x1d/0x30
[    8.034199]  hci_adv_monitors_clear+0x5c/0x80
[    8.042158]  hci_unregister_dev+0x161/0x2f0
[    8.042158]  ? usb_disable_endpoint+0x94/0xa0
[    8.042158]  btusb_disconnect+0x4b/0x120
[    8.057018]  usb_unbind_interface+0x64/0x230
[    8.057018]  device_release_driver_internal+0xc1/0x180
[    8.065196]  device_release_driver+0xc/0x10
[    8.068040]  bus_remove_device+0xa8/0x110
[    8.071767]  device_del+0x126/0x370
[    8.071767]  ? usb_remove_ep_devs+0x15/0x20
[    8.079199]  ? remove_intf_ep_devs+0x30/0x50
[    8.081371]  usb_disable_device+0x8e/0x240
[    8.087478]  usb_set_configuration+0x47c/0x800
[    8.087478]  usb_deauthorize_device+0x36/0x50
[    8.092662]  authorized_store+0x5d/0x70
[    8.096608]  ? authorized_default_store+0x60/0x60
[    8.096608]  dev_attr_store+0x13/0x20
[    8.096608]  ? component_bind_all.cold+0x52/0x52
[    8.106151]  sysfs_kf_write+0x2f/0x50
[    8.106151]  ? sysfs_file_ops+0x50/0x50
[    8.106151]  kernfs_fop_write+0x105/0x1a0
[    8.106151]  ? kernfs_fop_open+0x3c0/0x3c0
[    8.106151]  __vfs_write+0x2b/0x1e0
[    8.106151]  ? lock_acquire+0x3f/0x70
[    8.106151]  ? vfs_write+0x12a/0x180
[    8.106151]  ? __sb_start_write+0xd6/0x180
[    8.106151]  ? vfs_write+0x12a/0x180
[    8.106151]  vfs_write+0xa1/0x180
[    8.106151]  ksys_write+0x5c/0xd0
[    8.106151]  __ia32_sys_write+0x10/0x20
[    8.106151]  do_syscall_32_irqs_on+0x3a/0xf0
[    8.106151]  do_int80_syscall_32+0x9/0x20
[    8.106151]  entry_INT80_32+0x116/0x116
[    8.106151] EIP: 0xb7f45092
[    8.106151] Code: Bad RIP value.
[    8.146079] EAX: ffffffda EBX: 00000007 ECX: 004fb760 EDX: 00000001
[    8.146079] ESI: 004fb760 EDI: 00000001 EBP: 004c79f0 ESP: bfabc48c
[    8.146079] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS:
00000246
[    8.150364] Modules linked in:
[    8.150364] CR2: 0000000000000000
[    8.150364] ---[ end trace 468d097aaf220284 ]---

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7yW90ACgkQMOfwapXb+vJKfACgvIg/DW8c0YKzE2LmYNbQTIgc
W1sAniTMBfN+5Umby7GRG2wYmp85JyoG
=6eSe
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
