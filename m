Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE275C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2802078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918321;
	bh=iJSfOu5xXFIHOTc9+QzvzLzsYl0R+SLT14vGfz3hFts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIotkg/5Qk02pT4qoB3JbSuv/70jmeoPsmsAwnlRYXLFCIab78xNHgGBV2wEgC9dJ
	 Th2J0vr/Q0BLNwBK2KsT+fHH+NKIf//S7sVf4Ln0iI5kiCjfq0WhUx6yGPAcR0UDzy
	 F+SvPIxjHHLbBmjPQIQOVYcnNP9RgZtXXNbgoaT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgHTKL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbgHTKLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:11:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C532206DA;
        Thu, 20 Aug 2020 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918312;
        bh=iJSfOu5xXFIHOTc9+QzvzLzsYl0R+SLT14vGfz3hFts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfSJWIvzS2nHBGDhp8QzGQxiIBOffPg8JA0rhsurBbFnFk8cBjnJBgpPLcYmd6l2L
         w2K0BfXfPi/xjAXgk+Ys50LUoJTAMfzZimp/JoltTjpkP/ZIFcA9iTFeRPifngEk67
         flmQGp4S2S8pdM76EMSVzHzWwH9SmLXGDCMi9qVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 085/228] iio: improve IIO_CONCENTRATION channel type description
Date:   Thu, 20 Aug 2020 11:21:00 +0200
Message-Id: <20200820091611.862981888@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Duszynski <tomasz.duszynski@octakon.com>

[ Upstream commit df16c33a4028159d1ba8a7061c9fa950b58d1a61 ]

IIO_CONCENTRATION together with INFO_RAW specifier is used for reporting
raw concentrations of pollutants. Raw value should be meaningless
before being properly scaled. Because of that description shouldn't
mention raw value unit whatsoever.

Fix this by rephrasing existing description so it follows conventions
used throughout IIO ABI docs.

Fixes: 8ff6b3bc94930 ("iio: chemical: Add IIO_CONCENTRATION channel type")
Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 64e65450f4833..e21e2ca3e4f91 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1524,7 +1524,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no offset etc.) percentage reading of a substance.
+		Raw (unscaled no offset etc.) reading of a substance. Units
+		after application of scale and offset are percents.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
-- 
2.25.1



