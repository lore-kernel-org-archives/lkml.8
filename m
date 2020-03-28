Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB27C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330152073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="lMNEFSTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgC1Qbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:31:44 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17498 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Qbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:31:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585413080; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=W8oA9fOJi/XAIOJXU6XhAyHxr+wYaLsPw5sqqNaUZ85vvAOcu+Vj1vQ56z8qgf15AutCSn3AOhuapy1dLorr2xOBaDdIcvxn5smXB1Q2S8FI4eabYOtyUNCfvIjBu8/Y9c0Vuoqsgm7M4LDev224eDvNIZDKndvfTWh/3pfQVHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585413080; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=r30IA0SFgRRCtxKTYYUNcQWC2l66w/oo3k+pQSUmJ44=; 
        b=hqlUmF+mlkYuQNil8qHfDMXPskka4IhbIf6PxYV77GcBXnx/nI4uBvdzyYt8zGvKKb83KIokgA+nZqVbe/uA65b64qE1ow4ulttTporgK/6u1cMfeK3zOMQL7wziD2g0jdhEU/fpamOuWK23l6EKEUxYv4JXg6esN5PHota1aaE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585413080;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=r30IA0SFgRRCtxKTYYUNcQWC2l66w/oo3k+pQSUmJ44=;
        b=lMNEFSThqOmxkh/7xYvh3tfmsfKvmwVq5jGOjvkUzYEYJRDvVqeYhwU0uMFfRQ0Q
        apEp8fHbVDn9G1bkMnxV+VHqNtSJXd+zlfqIKh8k1723MsvWRwu21Xe6KD3rjLEN3Fu
        bTnF9vDpO1EJp35+7VjOQdW4WUXKbhzjOViBeuuY=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585413078092311.25906734376474; Sat, 28 Mar 2020 09:31:18 -0700 (PDT)
From:   aimannajjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <e31645933cc807d61d29c392bfd0dab8ea8b06b1.1585353747.git.aiman.najjar@hurranet.com>
Subject: [PATCH v2 5/5] staging: rtl8712:fix multiline derefernce warnings
Date:   Fri, 27 Mar 2020 20:08:11 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585353747.git.aiman.najjar@hurranet.com>
References: <20200327080429.GB1627562@kroah.com> <cover.1585353747.git.aiman.najjar@hurranet.com>
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

Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 04da7b318340..82df5e26f8c8 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -589,7 +589,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter=
, _pkt *pkt,
 =09addr_t addr;
 =09u8 *pframe, *mem_start, *ptxdesc;
 =09struct sta_info=09=09*psta;
-=09struct security_priv=09*psecuritypriv =3D &padapter->securitypriv;
+=09struct security_priv=09*psecpriv =3D &padapter->securitypriv;
 =09struct mlme_priv=09*pmlmepriv =3D &padapter->mlmepriv;
 =09struct xmit_priv=09*pxmitpriv =3D &padapter->xmitpriv;
 =09struct pkt_attrib=09*pattrib =3D &pxmitframe->attrib;
@@ -632,15 +632,13 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapt=
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
@@ -648,8 +646,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter=
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


