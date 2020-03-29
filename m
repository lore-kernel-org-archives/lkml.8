Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A642C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3093B20732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="Up9cF14+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgC2S7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:59:39 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17464 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2S7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585508342; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lTBFEV+X/tcnM+VxzuTY2S7SM/5KWyG3JimUZXjTdQSWy4ekXbaDBeMW+61FaN9gNSLPb9zQHTNxvKScSKy7F3XPzyUI+DJbmPphlLEPlBxkSszHbOiNgrmt9QM+vHOtk1Zk6msfPqoTed6Va9OAXtw0XtqvWbkodUTA4Xlwv3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585508342; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=St1J3cpslT5D0Lw0G4GIQcvm66Y3QaXPFrFkRhU5Rww=; 
        b=BfQ6XFHQy4YNthH30AAUyE41GgeTCSNooxuBwhYwLfeQBHe2FBHM5EIhCbWRxL3LLHqHqx1MKfE8qlNXcWpE2qZXVITxBdC2CNeWkK2GwRIVVXU0qGxhVU31ldrj9eUPXvcycA8LDKbsPQIm1QB9lgQKp2cJHsazBz34bdCRq8g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585508342;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=St1J3cpslT5D0Lw0G4GIQcvm66Y3QaXPFrFkRhU5Rww=;
        b=Up9cF14+1cmTGr6iJz0qkr8Q30oLTXrPSAZVZlF5d6GsOleFruYO9bYmnDX69039
        uMUQXx6FADKsNCzrYdCansiRzoE/45sRP5ff2kQqJ9aDD2D7JqRl8UmxG/oZurjY7xF
        q6BNJiygaHmk6xwQM5da9WHX/TeMEAMdrqLcyVEM=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585508341334564.6734790799218; Sun, 29 Mar 2020 11:59:01 -0700 (PDT)
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Aiman Najjar <aiman.najjar@hurranet.com>,
        Joe Perches <joe@perches.com>
Message-ID: <98805a72b92e9bbf933e05b827d27944663b7bc1.1585508171.git.aiman.najjar@hurranet.com>
Subject: [PATCH v3 5/5] staging: rtl8712:fix multiline derefernce warnings
Date:   Sun, 29 Mar 2020 14:57:47 -0400
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

This patch fixes remaining checkpatch warnings
in rtl871x_xmit.c:

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->PrivacyKe=
yIndex'
636: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:636:
+=09=09=09=09=09      (u8)psecuritypriv->
+=09=09=09=09=09      PrivacyKeyIndex);

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid=
'
643: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:643:
+=09=09=09=09=09=09   (u8)psecuritypriv->
+=09=09=09=09=09=09   XGrpKeyid);

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid=
'
652: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:652:
+=09=09=09=09=09=09   (u8)psecuritypriv->
+=09=09=09=09=09=09   XGrpKeyid);

Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 21026297413c..2f0d0ffa6fae 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -586,7 +586,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter=
, _pkt *pkt,
 =09addr_t addr;
 =09u8 *pframe, *mem_start, *ptxdesc;
 =09struct sta_info=09=09*psta;
-=09struct security_priv=09*psecuritypriv =3D &padapter->securitypriv;
+=09struct security_priv=09*psecpriv =3D &padapter->securitypriv;
 =09struct mlme_priv=09*pmlmepriv =3D &padapter->mlmepriv;
 =09struct xmit_priv=09*pxmitpriv =3D &padapter->xmitpriv;
 =09struct pkt_attrib=09*pattrib =3D &pxmitframe->attrib;
@@ -629,15 +629,13 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapt=
er, _pkt *pkt,
 =09=09=09=09case _WEP40_:
 =09=09=09=09case _WEP104_:
 =09=09=09=09=09WEP_IV(pattrib->iv, psta->txpn,
-=09=09=09=09=09       (u8)psecuritypriv->
-=09=09=09=09=09       PrivacyKeyIndex);
+=09=09=09=09=09       (u8)psecpriv->PrivacyKeyIndex);
 =09=09=09=09=09break;
 =09=09=09=09case _TKIP_:
 =09=09=09=09=09if (bmcst)
 =09=09=09=09=09=09TKIP_IV(pattrib->iv,
 =09=09=09=09=09=09    psta->txpn,
-=09=09=09=09=09=09    (u8)psecuritypriv->
-=09=09=09=09=09=09    XGrpKeyid);
+=09=09=09=09=09=09    (u8)psecpriv->XGrpKeyid);
 =09=09=09=09=09else
 =09=09=09=09=09=09TKIP_IV(pattrib->iv, psta->txpn,
 =09=09=09=09=09=09=090);
@@ -645,8 +643,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter=
, _pkt *pkt,
 =09=09=09=09case _AES_:
 =09=09=09=09=09if (bmcst)
 =09=09=09=09=09=09AES_IV(pattrib->iv, psta->txpn,
-=09=09=09=09=09=09    (u8)psecuritypriv->
-=09=09=09=09=09=09    XGrpKeyid);
+=09=09=09=09=09=09    (u8)psecpriv->XGrpKeyid);
 =09=09=09=09=09else
 =09=09=09=09=09=09AES_IV(pattrib->iv, psta->txpn,
 =09=09=09=09=09=09       0);
--=20
2.20.1


