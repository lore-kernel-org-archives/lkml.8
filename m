Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62EC207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanbrattlof.com header.i=@bryanbrattlof.com header.b="WBEFxwcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgIBTWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:22:22 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:35223 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:22:21 -0400
Date:   Wed, 02 Sep 2020 19:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail2; t=1599074538;
        bh=lC9yM5F2xA3iUzmvU7i6jZrbqpUBJ2c8bvsh7D8BVD4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=WBEFxwcK4zd35J4iPHhB7yMusADtlm9QyDdVaU80lDW/H1qLqwUka9GaxdyK6bmp7
         Kw5/H8ECdxdFxS8CzSoQYUYxA5zPX415EGQmgjhketD9HKETX/sfv818Bbf5XCsYgl
         Edg9wVm9hYP6xtc2GPdJENse+w2OAZNY6GwTXj4BWnufW9WvV7WBZNWhAxNkAss/JG
         ee2J1EPdvgyamUI9cuaJtR8fxYn9JpwXIjiczeKUE7JPO1FiuOadGfVe4kT47jbsbh
         AYDs7VO5mhzUzmDF+MOXwEYXa1VC2TAr2wSBQm5u2mSj3kJhjutdiADDDQN/aSTcOy
         t2q4Vkdy93BpQ==
To:     Marcus Wolf <linux@wolf-entwicklungen.de>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     trivial@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: pi433: break long lines
Message-ID: <87y2lsrnl8.fsf@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


scripts/checkpatch.pl is warning about some lines exceeding 100
charecters. This will cleanup the warnings.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/pi433/pi433_if.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433=
_if.h
index 16c5b7fba249..d5c1521192c1 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -117,9 +117,15 @@ struct pi433_rx_cfg {
=20
 =09/* packet format */
 =09enum option_on_off=09enable_sync;
-=09enum option_on_off=09enable_length_byte;=09  /* should be used in combi=
nation with sync, only */
-=09enum address_filtering=09enable_address_filtering; /* operational with =
sync, only */
-=09enum option_on_off=09enable_crc;=09=09  /* only operational, if sync on=
 and fixed length or length byte is used */
+
+=09/* should be used in combination with sync, only */
+=09enum option_on_off=09enable_length_byte;
+
+=09/* operational with sync, only */
+=09enum address_filtering=09enable_address_filtering;
+
+=09/* only operational, if sync on and fixed length or length byte is used=
 */
+=09enum option_on_off=09enable_crc;
=20
 =09__u8=09=09=09sync_length;
 =09__u8=09=09=09fixed_message_length;
@@ -130,12 +136,16 @@ struct pi433_rx_cfg {
 =09__u8=09=09=09broadcast_address;
 };
=20
-#define PI433_IOC_MAGIC=09=09=09'r'
+#define PI433_IOC_MAGIC=09'r'
=20
-#define PI433_IOC_RD_TX_CFG=09_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,=
 char[sizeof(struct pi433_tx_cfg)])
-#define PI433_IOC_WR_TX_CFG=09_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,=
 char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_RD_TX_CFG                                             \
+=09_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_t=
x_cfg)])
+#define PI433_IOC_WR_TX_CFG                                             \
+=09_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_t=
x_cfg)])
=20
-#define PI433_IOC_RD_RX_CFG=09_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,=
 char[sizeof(struct pi433_rx_cfg)])
-#define PI433_IOC_WR_RX_CFG=09_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,=
 char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_RD_RX_CFG                                             \
+=09_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_r=
x_cfg)])
+#define PI433_IOC_WR_RX_CFG                                             \
+=09_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_r=
x_cfg)])
=20
 #endif /* PI433_H */
--=20
2.17.1

