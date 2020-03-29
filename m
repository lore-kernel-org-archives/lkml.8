Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15303C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09212073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="Cpbj+3Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgC2S65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:58:57 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17436 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgC2S65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585508330; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NVZaM/NPBjclc4eqzftERihHB0SIYGpyCry619907Y7skG3ved2cUPuJauhR0X82It1VLQlQhvLAlY0V7Lsoajp9cqjPEYpRENOcuPlI+uGvE9nBkbVwZOYuCtUgD6JIZtl+s2+sQHGImf4RnckT1CIo5PqBSxLonFSU10eBswM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585508330; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ezUEMqPpc9ilQcbK7oMGYWwoxxfkJK9+laWJNyAlIRw=; 
        b=DAcn9HgwgML7z6XB7pR/ElUAcG/gkrxhvz5WIflw+G2Q9muEWtEW/APKW+rSmR/wASlkIuOEktBsqg/NhdmEoEcnSd/1jKpt9XhViU43ZuBfCTv/ZlMOO8KegVVcT6oGdlhvCuoFNAL0bJIpaDDoz7qMAbERW6CMv7SBRh9wPSU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585508330;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=ezUEMqPpc9ilQcbK7oMGYWwoxxfkJK9+laWJNyAlIRw=;
        b=Cpbj+3Fb/a8CaisD7juq//K4DCUZJCmL0rE8p1r3XD8g/MMH7RVfjUtSJ0I+Zc2/
        bl+a30SXIQ/ntvsy5o5uQmtAzO5pfyoTE2Awj+arp+QqvBQA4SjuWd1c/MdsdUlZyTK
        GHWhOgNkRm+Cwe28YDLhrJup3gSLDuUMJfxru6Bc=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585508328742635.2117972556791; Sun, 29 Mar 2020 11:58:48 -0700 (PDT)
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Aiman Najjar <aiman.najjar@hurranet.com>,
        Joe Perches <joe@perches.com>
Message-ID: <acd523d0d24cc81fae9eb933a066d87815587cee.1585508171.git.aiman.najjar@hurranet.com>
Subject: [PATCH v3 1/5] staging: rtl8712: fix checkpatch long-line warning
Date:   Sun, 29 Mar 2020 14:57:43 -0400
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

This patch fixes these two long-line checkpatch warnings
in rtl871x_xmit.c:

WARNING: line over 80 characters
\#74: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:74:
+       * Please allocate memory with the sz =3D (struct xmit_frame) * NR_X=
MITFRAME,

WARNING: line over 80 characters
\#79: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:79:
+               kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4, GFP_A=
TOMIC);

Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index f0b85338b567..628e4bad1547 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -71,12 +71,13 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 =09_init_queue(&pxmitpriv->apsd_queue);
 =09_init_queue(&pxmitpriv->free_xmit_queue);
 =09/*
-=09 * Please allocate memory with the sz =3D (struct xmit_frame) * NR_XMIT=
FRAME,
+=09 * Please allocate memory with sz =3D (struct xmit_frame) * NR_XMITFRAM=
E,
 =09 * and initialize free_xmit_frame below.
 =09 * Please also apply  free_txobj to link_up all the xmit_frames...
 =09 */
 =09pxmitpriv->pallocated_frame_buf =3D
-=09=09kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4, GFP_ATOMIC);
+=09=09kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4,
+=09=09=09GFP_ATOMIC);
 =09if (!pxmitpriv->pallocated_frame_buf) {
 =09=09pxmitpriv->pxmit_frame_buf =3D NULL;
 =09=09return -ENOMEM;
--=20
2.20.1


