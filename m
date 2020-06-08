Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79823C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558F220760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662664;
	bh=J/mHmxTcdz6R3LWlTyf4BHmBvzBzTnR9MdLUtULekx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mYkmsnIVtNvXFmPnWYUlM3tI2+Sp39EhbK7nPtTQV6MhxIiGj+lokwBFdzbFKu833
	 pEpmaB+cne1XEqt6xTY3YKl6yc7xMQPbHpj89iiGChnCIo26rGp7cZyRm6Z2FqIubY
	 j5rDBtYLv50yE/pQ982YgxnxmMRrq8hmzp3Z39O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbgFIAar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgFHXPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:15:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD47B2068D;
        Mon,  8 Jun 2020 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658143;
        bh=J/mHmxTcdz6R3LWlTyf4BHmBvzBzTnR9MdLUtULekx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXFO/xCju7cBm+H22T+WOmybM4A8fg+abkhsRyr5eq3gNMCwEPfEtPQoDa734HrRC
         V9bWXo37+4paj4dVb6anYRrpHs+x6HcFbBYxDAyarrD68i7NEkOUd0vfhZIYKS7UER
         zvDyX5j0kVSaTOsHOuwC+QcST053Hv61xi+h0zks=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 176/606] iio: dac: vf610: Fix an error handling path in 'vf610_dac_probe()'
Date:   Mon,  8 Jun 2020 19:05:01 -0400
Message-Id: <20200608231211.3363633-176-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit aad4742fbf0a560c25827adb58695a4497ffc204 upstream.

A call to 'vf610_dac_exit()' is missing in an error handling path.

Fixes: 1b983bf42fad ("iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/vf610_dac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 71f8a5c471c4..7f1e9317c3f3 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -223,6 +223,7 @@ static int vf610_dac_probe(struct platform_device *pdev)
 	return 0;
 
 error_iio_device_register:
+	vf610_dac_exit(info);
 	clk_disable_unprepare(info->clk);
 
 	return ret;
-- 
2.25.1

