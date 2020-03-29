Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF8FC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC7720781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="OzdpZ2fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgC2S7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:59:07 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17443 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC2S7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:59:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585508334; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OKw2hYItWU74WbmklwaUZt6BdkfUczGcsdaJ0f3Ip/0IcXaCxd12OQVArl2FLx5BpbaYKYDTsssM7sK4gt3GdP8niECjYLmBm8/z+yT6zJynN9lmITfFrtm8ZwWtV0VGUXQNFgP0UQTK/azEBrf2A7O8mX/gvKY28sIwfdxIuMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585508334; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=e0DPm9Cyl0FybcTHdAlqkPRGupFmjUIIExQ1uX3Lc1E=; 
        b=koqt4+xURk8PRLatRxHwH8TwUzl87hg6zmgOXTC52AUUM3uoZ4nDAegWiVTAjgPBK7XemOQjg99YOSoC5GbR8BpinUCGi4KHaIYmClmz0Z/kYHDVwPWGgKFsYt7Wnnm1qjQM1hHrLS6vgb9XsIvuLm3rbSuP4PyLogTNS26paOc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585508334;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=e0DPm9Cyl0FybcTHdAlqkPRGupFmjUIIExQ1uX3Lc1E=;
        b=OzdpZ2fgkGz5PYHTvgNWySnG81pHvP9VPS7uon1DytHZaJk/q+Dq9v+xAYW8uZP4
        Bt179QMSbSZGsOBiMeVO+G7d24cpAWQCxSvnoHNNzaRYKYRzpMoC12vq+2FL+kx2JX6
        w5tkVnXEHwwPRWNF2k7HSgnaLqiTsS5Mx8AvRMiI=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 15855083319161007.5900282440623; Sun, 29 Mar 2020 11:58:51 -0700 (PDT)
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Aiman Najjar <aiman.najjar@hurranet.com>,
        Joe Perches <joe@perches.com>
Message-ID: <de477e0d8f352c1d6cd75d64d84ac6f9017db254.1585508171.git.aiman.najjar@hurranet.com>
Subject: [PATCH v3 2/5] staging: rtl8712: fix long-line checkpatch warning
Date:   Sun, 29 Mar 2020 14:57:44 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585508171.git.aiman.najjar@hurranet.com>
References: <cover.1585508171.git.aiman.najjar@hurranet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning in rtl871x_xmit.c:

WARNING: line over 80 characters
130: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:130:
+=09=09pxmitbuf->pallocated_buf =3D kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_=
SZ,

Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 628e4bad1547..454c26f83406 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -127,8 +127,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 =09pxmitbuf =3D (struct xmit_buf *)pxmitpriv->pxmitbuf;
 =09for (i =3D 0; i < NR_XMITBUFF; i++) {
 =09=09INIT_LIST_HEAD(&pxmitbuf->list);
-=09=09pxmitbuf->pallocated_buf =3D kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_=
SZ,
-=09=09=09=09=09=09   GFP_ATOMIC);
+=09=09pxmitbuf->pallocated_buf =3D
+=09=09=09kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
 =09=09if (!pxmitbuf->pallocated_buf)
 =09=09=09return -ENOMEM;
 =09=09pxmitbuf->pbuf =3D pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
--=20
2.20.1


