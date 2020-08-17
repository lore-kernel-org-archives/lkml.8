Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEF320674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693137;
	bh=yXQOpAs4ndvdbKpfDxoRQL3kvSO841IDlA/qnlsWcOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrszJRXPKP0V+c5tvdb4LMkgaIov+ZnurIHIrOON66K2a9lsBiuNZAYGU6BIsgH3e
	 Vv7NIeyJIfd/zanWnRG0/M2jIlWWPMvJtKqTCX2MGnNOaXl5avE2pQ03Fhx0CTmonB
	 2ROnIIXljCiE3LV9+cGbXyOZsi42Xbb1T15cj120=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgHQTiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbgHQP0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:26:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C800023B1C;
        Mon, 17 Aug 2020 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678015;
        bh=yXQOpAs4ndvdbKpfDxoRQL3kvSO841IDlA/qnlsWcOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmRQdnZG8PkFXqGzrqbmCC65UvDXDijcrrRVYR9LJYqyZL73fWe1OKI4RMPuShavB
         lMA4sJ082PUWlmI7yW5T7z+Qoo1y3QHVFHHP0rR0fY6GmJniiE+m7/komga3Beuxit
         e67wEouHhjnCWAjusV2v8Wvd7qWxn6GACUx7LwgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 159/464] iio: improve IIO_CONCENTRATION channel type description
Date:   Mon, 17 Aug 2020 17:11:52 +0200
Message-Id: <20200817143841.424261451@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
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
index d3e53a6d8331b..5c62bfb0f3f57 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1569,7 +1569,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
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



