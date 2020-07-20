Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D4C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCFB206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262661;
	bh=crdC/FcSNnFfmvavFML0b9RIg1+uRvGXlo87yIAceSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GdcW9EtUPRK4onL9o0/A1iFrSxnJ4ddv7y85QuxuF+IbucMnyN4WROnZ3ri4qiXOr
	 uP2yMxDx0r+lm2vXUk1e6UBNr5tmPg8y9rtrc3HJP9HZPvZxUxK04mzM8s2YlL5H8f
	 uARQb8SvyZ2sH4tkPXa54dnSWBIRwfB8P0M/phHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgGTQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731471AbgGTP5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A8A22BEF;
        Mon, 20 Jul 2020 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260661;
        bh=crdC/FcSNnFfmvavFML0b9RIg1+uRvGXlo87yIAceSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgxgMPUPVzcfSzr/yUJ8RR2DJKbFxSzhEG8QXjV5Q+cXCfIL9iIoWDx4yas9WasWA
         Hs11lMzNkzYQTpKKM0MsmJIoICpWulaDnDEcSGIpkCs/HyW7wxbF8F06GnjmG1dMom
         oEn2qOgheGg6XH0iHJpwQ5DT4vUyx1Dzy6FNbVTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 049/215] iio: core: add missing IIO_MOD_H2/ETHANOL string identifiers
Date:   Mon, 20 Jul 2020 17:35:31 +0200
Message-Id: <20200720152822.534195030@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

commit 25f02d3242ab4d16d0cee2dec0d89cedb3747fa9 upstream.

Add missing strings to iio_modifier_names[] for proper modification
of channels.

Fixes: b170f7d48443d (iio: Add modifiers for ethanol and H2 gases)
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/industrialio-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -130,6 +130,8 @@ static const char * const iio_modifier_n
 	[IIO_MOD_PM2P5] = "pm2p5",
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
+	[IIO_MOD_ETHANOL] = "ethanol",
+	[IIO_MOD_H2] = "h2",
 };
 
 /* relies on pairs of these shared then separate */


