Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C8C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03B20748
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="Ijdof/BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgC1Qb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:31:28 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17483 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Qb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585413072; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fBrAoAUiblJLmvNrWzx8Qola3brdppKlLIlWeRmwaggANdALblKRh9OcPvHpcvx1AYFRvMwhi+oyMjaF76u4enfr8WEGQFO6KJcd+6vt1GTShGhdAU+JzNy1Efl1PFtfaLzGuNKrgdvdN6OhYYqHGmYR7jgqNhP5BV2T6jIkUJw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585413072; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7MjhWFY7QgmsWF9j7BMZskE0eKgnDKHQSHK8EK548Mk=; 
        b=bsN55FAwmFgL18bOmDHP4hRBauT2+P29TTGIuEqAQMVP8OfD+NOAXivVDO5KmHTULwGL4wrnaimx/Cqdn62r6b0FY2h9LkVIhZPFF4SsCzlVPB4xlvq3tNNfbyw86B9LNMDuJKZidV+myjbEDOmA84E0Ds1tfTJ3ZuZDnYYK2fg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585413072;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=7MjhWFY7QgmsWF9j7BMZskE0eKgnDKHQSHK8EK548Mk=;
        b=Ijdof/BUuylw/pv3YDzMpEqzB1b6LsDYG8/rloFMczOwoaWa0NQroRvhondYrFrB
        o6xXOHOXj+kXmkwHyTt1d0raw1ZuT6OI7S+K+ds/vw3CjVPkztyqV573XNUOZTrQrnM
        6nioOCfixVSaI2sYn+KqiXuXP3Gpt4d31aTbKzQA=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585413070732111.22818257289418; Sat, 28 Mar 2020 09:31:10 -0700 (PDT)
From:   aimannajjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <1f14de8f1418df6de270b8b3d07793906db9ffee.1585353747.git.aiman.najjar@hurranet.com>
Subject: [PATCH v2 3/5] staging: rtl8712: fix checkpatch warnings
Date:   Fri, 27 Mar 2020 20:08:09 -0400
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

This patch fixes multiline dereference warnings in
rtl871x_xmit.c:

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrptxmic=
key'
379: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:379:
+=09=09=09=09=09psecuritypriv->
+=09=09=09=09=09XGrptxmickey[psecuritypriv->

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid=
'
380: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:380:
+=09=09=09=09=09XGrptxmickey[psecuritypriv->
+=09=09=09=09=09XGrpKeyid].skey);

Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 454c26f83406..0f789c821552 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -351,7 +351,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 =09struct=09sta_info *stainfo;
 =09struct=09qos_priv *pqospriv =3D &(padapter->mlmepriv.qospriv);
 =09struct=09pkt_attrib  *pattrib =3D &pxmitframe->attrib;
-=09struct=09security_priv *psecuritypriv =3D &padapter->securitypriv;
+=09struct=09security_priv *psecpriv =3D &padapter->securitypriv;
 =09struct=09xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
 =09u8 priority[4] =3D {0x0, 0x0, 0x0, 0x0};
 =09bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
@@ -369,15 +369,14 @@ static int xmitframe_addmic(struct _adapter *padapter=
,
 =09=09=09=09=09   0x0, 0x0};
 =09=09=09pframe =3D pxmitframe->buf_addr + TXDESC_OFFSET;
 =09=09=09if (bmcst) {
-=09=09=09=09if (!memcmp(psecuritypriv->XGrptxmickey
-=09=09=09=09   [psecuritypriv->XGrpKeyid].skey,
+=09=09=09=09if (!memcmp(psecpriv->XGrptxmickey
+=09=09=09=09   [psecpriv->XGrpKeyid].skey,
 =09=09=09=09   null_key, 16))
 =09=09=09=09=09return -ENOMEM;
 =09=09=09=09/*start to calculate the mic code*/
 =09=09=09=09r8712_secmicsetkey(&micdata,
-=09=09=09=09=09 psecuritypriv->
-=09=09=09=09=09 XGrptxmickey[psecuritypriv->
-=09=09=09=09=09XGrpKeyid].skey);
+=09=09=09=09=09psecpriv->XGrptxmickey
+=09=09=09=09=09[psecpriv->XGrpKeyid].skey);
 =09=09=09} else {
 =09=09=09=09if (!memcmp(&stainfo->tkiptxmickey.skey[0],
 =09=09=09=09=09    null_key, 16))
@@ -417,7 +416,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 =09=09=09=09=09length =3D pattrib->last_txcmdsz -
 =09=09=09=09=09=09  pattrib->hdrlen -
 =09=09=09=09=09=09  pattrib->iv_len -
-=09=09=09=09=09=09  ((psecuritypriv->sw_encrypt)
+=09=09=09=09=09=09  ((psecpriv->sw_encrypt)
 =09=09=09=09=09=09  ? pattrib->icv_len : 0);
 =09=09=09=09=09r8712_secmicappend(&micdata, payload,
 =09=09=09=09=09=09=09   length);
@@ -425,7 +424,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 =09=09=09=09} else {
 =09=09=09=09=09length =3D pxmitpriv->frag_len -
 =09=09=09=09=09    pattrib->hdrlen - pattrib->iv_len -
-=09=09=09=09=09    ((psecuritypriv->sw_encrypt) ?
+=09=09=09=09=09    ((psecpriv->sw_encrypt) ?
 =09=09=09=09=09    pattrib->icv_len : 0);
 =09=09=09=09=09r8712_secmicappend(&micdata, payload,
 =09=09=09=09=09=09=09   length);
--=20
2.20.1


