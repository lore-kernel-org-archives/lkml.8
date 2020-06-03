Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F62A2074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=meresinski.eu header.i=tomasz@meresinski.eu header.b="sydJSkWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgFCUfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:35:47 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21167 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591216528; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XtuGx0syGIaRfttsTq7X2YDyak4086XJ8kNU+QqBpgZOeHbjOyBy/bLOwxG+TUAtXMjtnZYfyJtvB0cu95pC/ns/BbsxrFXbjTnnjFBo59xM4PaxNVAhCVthPkGKyT18Wc7ATL1DD4FylFSwVmdyqaz4P+cq8JYGgxZw8Vp67T4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591216528; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject; 
        bh=iieshxWnuWqIoayg7cEdrMVEeyE1LrIxIGyyzYieWuQ=; 
        b=aubAok86zqg0oTrbfRKHVOR7MUIvBQTiV+YyODici4Hn4XihIbdy6w+hobsowCc/wilkzdxci1r2dyzVC4+TtfVbF29uqfP4w21GIFxGynEVPPrhXe8K+lGllV8bUy75IOFJENMLG6qyLsHIvCtqzH8CRt8kpjbB9qbQcUuDnRk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=meresinski.eu;
        spf=pass  smtp.mailfrom=tomasz@meresinski.eu;
        dmarc=pass header.from=<tomasz@meresinski.eu> header.from=<tomasz@meresinski.eu>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591216528;
        s=zoho; d=meresinski.eu; i=tomasz@meresinski.eu;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=iieshxWnuWqIoayg7cEdrMVEeyE1LrIxIGyyzYieWuQ=;
        b=sydJSkWd2rGSJH+RPW97lsb1/DAy+6tazkau/UFu893dMWcN7GGzVZPufgZ53Psn
        RmgmrI0pc5BbBhHV5h5iEVpW/znD7rq/E/dX/CH+NmK7X7HNJle/13I6tZr/QGfv/gM
        VZxut6NpZxcyAZcG6nMuLaZtTfxqfczLwNiHR5UA=
Received: from localhost.localdomain (78-11-200-65.static.ip.netia.com.pl [78.11.200.65]) by mx.zohomail.com
        with SMTPS id 1591216526971281.37892539217535; Wed, 3 Jun 2020 13:35:26 -0700 (PDT)
From:   =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>
Cc:     =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cox <jonathan@jdcox.net>,
        Dan Lazewatsky <dlaz@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Dodd <richard.o.dodd@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200603203347.7792-1-tomasz@meresinski.eu>
Subject: [PATCH] usb: add USB_QUIRK_DELAY_INIT for Logitech C922
Date:   Wed,  3 Jun 2020 22:33:46 +0200
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Logitech C922, just like other Logitech webcams,
needs the USB_QUIRK_DELAY_INIT or it will randomly
not respond after device connection

Signed-off-by: Tomasz Meresi=C5=84ski <tomasz@meresinski.eu>

usb: add USB_QUIRK_DELAY_INIT for Logitech C922

The Logitech C922 webcam, just like other Logitech webcams,
needs the USB_QUIRK_DELAY_INIT or it will randomly
not respond after device connection

Signed-off-by: Tomasz Meresi=C5=84ski <tomasz@meresinski.eu>
---
 drivers/usb/core/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 3e8efe759c3e..e0b77674869c 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -218,11 +218,12 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
 =09/* Logitech HD Webcam C270 */
 =09{ USB_DEVICE(0x046d, 0x0825), .driver_info =3D USB_QUIRK_RESET_RESUME }=
,
=20
-=09/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
+=09/* Logitech HD Pro Webcams C920, C920-C, C922, C925e and C930e */
 =09{ USB_DEVICE(0x046d, 0x082d), .driver_info =3D USB_QUIRK_DELAY_INIT },
 =09{ USB_DEVICE(0x046d, 0x0841), .driver_info =3D USB_QUIRK_DELAY_INIT },
 =09{ USB_DEVICE(0x046d, 0x0843), .driver_info =3D USB_QUIRK_DELAY_INIT },
 =09{ USB_DEVICE(0x046d, 0x085b), .driver_info =3D USB_QUIRK_DELAY_INIT },
+=09{ USB_DEVICE(0x046d, 0x085c), .driver_info =3D USB_QUIRK_DELAY_INIT },
=20
 =09/* Logitech ConferenceCam CC3000e */
 =09{ USB_DEVICE(0x046d, 0x0847), .driver_info =3D USB_QUIRK_DELAY_INIT },
--=20
2.17.1


