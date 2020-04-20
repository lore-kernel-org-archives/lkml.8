Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FCEC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BAD2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwK+rrRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgDTWEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:04:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgDTWEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587420269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=koRDkKLTG8zaPUuuVy6B0Oldh6kvQLudDYsHC51m2RE=;
        b=ZwK+rrRiFIyJKCPt6I/PaLp4FGEpJDc3OMEWjzF+PlaNBTiC0s8E/KlQVWE5SUZau9aE5y
        JLIPalvCuy3Ehm1APK/oSiy7e6gY9USmJQ28yRUxc0lWIy9ZRMJm+Bptm8lBR4SHVXDXVY
        X5e2kqWlTK4FIJ7N/ZeQhG0NRsPmpjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-szAtL_ClPXyRciQ-e8Cplg-1; Mon, 20 Apr 2020 18:04:24 -0400
X-MC-Unique: szAtL_ClPXyRciQ-e8Cplg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CABDF1853889;
        Mon, 20 Apr 2020 22:04:23 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC67C5C1B2;
        Mon, 20 Apr 2020 22:04:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: surface3_power: i2c_acpi_new_device() returns a PTR_ERR
Date:   Tue, 21 Apr 2020 00:04:21 +0200
Message-Id: <20200420220421.171298-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_acpi_new_device() never returns NULL, it either returns an i2c_client
or a PTR_ERR. Adjust the mshw0011_probe() error handling to take this
into account.

Note the goto out_err will cause i2c_unregister_device() to get called
even though the i2c_acpi_new_device() fails, this is ok as it accepts
a NULL pointer argument (and treats it as a no-op).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/surface3_power.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/surface3_power.c b/drivers/platform/x86=
/surface3_power.c
index 946ac2dc08ae..32e6e86e27dd 100644
--- a/drivers/platform/x86/surface3_power.c
+++ b/drivers/platform/x86/surface3_power.c
@@ -522,8 +522,10 @@ static int mshw0011_probe(struct i2c_client *client)
 	strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
=20
 	bat0 =3D i2c_acpi_new_device(dev, 1, &board_info);
-	if (!bat0)
-		return -ENOMEM;
+	if (IS_ERR(bat0)) {
+		error =3D PTR_ERR(bat0);
+		goto out_err;
+	}
=20
 	data->bat0 =3D bat0;
 	i2c_set_clientdata(bat0, data);
--=20
2.26.0

