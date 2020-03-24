Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB977C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897A720870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056235;
	bh=0Tl/uLt/DtI6IenNCwj6LwcQMUVo0+qBxc/JUlB4s4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gxfHHtSdvbd/eu3q7DOY2S86PGEjxBQ9+qmixmWkJIbOLxY5FYG37Oq2SSWc4ZrOe
	 xpw0hbpE8T4GZOT6u7CJhGgmgECwm40SyTcrqNr9BU4MmkqX4jnnsO8aojgEcT9RMD
	 OTABwGnyULIy5eaUV96sryHH9Zt2ila7fuMxusWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgCXNXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgCXNXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:23:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0766E208CA;
        Tue, 24 Mar 2020 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056230;
        bh=0Tl/uLt/DtI6IenNCwj6LwcQMUVo0+qBxc/JUlB4s4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoQKtaoJ356EYx6u/4LH6TAp9+G4McavNVwHpjGO8g+fIJar264tgvkKW1GF4E0xn
         wtXsXuAGcBbSpHH7ZKtKdvTRzFw7Ojs+XVd7sFD8nFa8QX9XRGvzRlHesWK/jdWTMK
         CbX3aWte/1zDVwpySWmUgKbpeWYIHahuEHjMUz7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wen-chien Jesse Sung <jesse.sung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.5 063/119] iio: st_sensors: remap SMO8840 to LIS2DH12
Date:   Tue, 24 Mar 2020 14:10:48 +0100
Message-Id: <20200324130814.510451677@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

commit e43d110cdc206b6df4dd438cd10c81d1da910aad upstream.

According to ST, the HID is for LIS2DH12.

Fixes: 3d56e19815b3 ("iio: accel: st_accel: Add support for the SMO8840 ACPI id")
Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/st_accel_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -114,7 +114,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_matc
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
-	{"SMO8840", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
+	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
 	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
 	{ },
 };


