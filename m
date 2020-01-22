Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92128C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028C2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686851;
	bh=P7rZRElKkOwxcczbNkXYkerQ7t32gQFeDOJWyqJPqGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bxbYWsol5FiOYIsQxsJs0FHGGQoBQPXjVtBSUV8f3tikRyfvcH4sCyuewMG4Mn+QW
	 VJSRO+A3nPhQngYoa46QNOhaboG7gb0UQoGrqqx6nqLDeCzaAXsYlKCXPXfPot6okH
	 ocBQvqjt2ujgY8T4lZsiQxF6n9jeO+fpO1fEab04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbgAVJe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:34:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbgAVJeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A505B2467C;
        Wed, 22 Jan 2020 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685663;
        bh=P7rZRElKkOwxcczbNkXYkerQ7t32gQFeDOJWyqJPqGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxVGqquZOiOJvHJ0BtmXr6+18KP8LpDVdmGvORTmXhQAGjEUVoaq0SnytdwZJiVXx
         /sdZ2EJmmMFHmrUzerXym1TgGtYuoy4bK4Zs2eSYWoIbypxkMN/W0X9q8HOVnofoH0
         mrXIdZYSokiOjhOcVzlF6n5K1vXd5O4nyH0FBxQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 29/97] iio: imu: adis16480: assign bias value only if operation succeeded
Date:   Wed, 22 Jan 2020 10:28:33 +0100
Message-Id: <20200122092801.018446040@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 9b742763d9d4195e823ae6ece760c9ed0500c1dc upstream.

This was found only after the whole thing with the inline functions, but
the compiler actually found something. The value of the `bias` (in
adis16480_get_calibbias()) should only be set if the read operation was
successful.

No actual known problem occurs as users of this function all
ultimately check the return value.  Hence probably not stable material.

Fixes: 2f3abe6cbb6c9 ("iio:imu: Add support for the ADIS16480 and similar IMUs")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/adis16480.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -372,12 +372,14 @@ static int adis16480_get_calibbias(struc
 	case IIO_MAGN:
 	case IIO_PRESSURE:
 		ret = adis_read_reg_16(&st->adis, reg, &val16);
-		*bias = sign_extend32(val16, 15);
+		if (ret == 0)
+			*bias = sign_extend32(val16, 15);
 		break;
 	case IIO_ANGL_VEL:
 	case IIO_ACCEL:
 		ret = adis_read_reg_32(&st->adis, reg, &val32);
-		*bias = sign_extend32(val32, 31);
+		if (ret == 0)
+			*bias = sign_extend32(val32, 31);
 		break;
 	default:
 			ret = -EINVAL;


