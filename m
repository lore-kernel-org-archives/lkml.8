Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD0C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FED206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="FUBKUtbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgC1QbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:31:13 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17471 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgC1QbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585413066; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jmahVfXXiKrAgLaTYjDkKdnexrQaJNzWaKYmMpUsaw7M/+e1zl+NqFX46b9mwqxWe53G7+BR72Q93k6G2K6kIaGw5gXzIjedBrL39LySO/9Gb4dYgHMPa1Yx1uZFJpLh4mtre4RoLGgrvvrBbBzaPsbxjHg4D4tFNxvoX1CtjM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585413066; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XjIv4xlxQZ6wCF5IGABghzHdi4GY3K4HquTmkmKpzbs=; 
        b=CrqmyGrhn3yhY171+stkO2fHMWmi13E1gKJ4NgiiGn6WeTkVE9iLMNQU2GM2rR+HGlRV+YFqXTsdnqzIN5tyt+iqKXV2QpuTZ+kOSRAFo4raW1umkLje3g94YIag4wQ2ez+fZGAK6n0auoUT3I+x+jw1CGeFO0qbBAMLA9MosOs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585413066;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=XjIv4xlxQZ6wCF5IGABghzHdi4GY3K4HquTmkmKpzbs=;
        b=FUBKUtbIewxEqNCCocK1Fyfa+HYZA9rLJPlG0XXP6l7NE5qFXV3I5/kwHZeYop6r
        9eWLvfSQSB9rymGVqet58oECqc16TymNv4IQQjhnJ+qMjRqfb/fgn7nLNk3eWn/krwx
        5Oze+OowoBkVdQUgPX3LGoxbCUpBckWn6nc6Of9k=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585413064074384.74081461290166; Sat, 28 Mar 2020 09:31:04 -0700 (PDT)
From:   aimannajjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <6a4d94b4e5446f4665dc11290ed1351661554f01.1585353747.git.aiman.najjar@hurranet.com>
Subject: [PATCH v2 1/5] staging: rtl8712: fix checkpatch long-line warning
Date:   Fri, 27 Mar 2020 20:08:07 -0400
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

Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
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


