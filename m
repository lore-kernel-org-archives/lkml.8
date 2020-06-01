Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B495320678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036757;
	bh=hu3+Cu1mobOMU0osGTqGMIyMafxT7FTy0kESiJ1M/lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8Fr5+o6V28p4MFw3Jo1D3UmnHFHSsIroLSZAUjHgyPYEyjxSzFfFJWVo93ZE/DjV
	 nEvAmiLDtc/u2fyrvwS4sudGvWaZv3Tgpu87xrEHWTSkyCWeo1DxMk6alDQ1nl6H2D
	 L6ekPfFuQtv5moyxIlmsfVOx8Jz7zzsGQssdrbEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgFASOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731467AbgFASOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:14:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5FF2068D;
        Mon,  1 Jun 2020 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035258;
        bh=hu3+Cu1mobOMU0osGTqGMIyMafxT7FTy0kESiJ1M/lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDo5RK5q768jawu4KETQ0JxHqvTzoltoc87PCI/b1mkgReFXk427ign34Ue3JBMd4
         cGsepx+ujR6Y5dGLMbCS9kyC6vZL4broPUpZARYZ9MnO3Da4VZwHe5baO/vfXPvh2z
         rXRcYATA2jtVHKBPMkaI9f0IpqXWHxKUHIF5se3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amy Shih <amy.shih@advantech.com.tw>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 078/177] hwmon: (nct7904) Fix incorrect range of temperature limit registers
Date:   Mon,  1 Jun 2020 19:53:36 +0200
Message-Id: <20200601174055.390545696@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

[ Upstream commit 7b2fd270af27edaf02acb41a7babe805a9441914 ]

The format of temperature limitation registers are 8-bit 2's complement
and the range is -128~127.
Converts the reading value to signed char to fix the incorrect range
of temperature limitation registers.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct7904.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 281c81edabc6..dfb122b5e1b7 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -356,6 +356,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret, temp;
 	unsigned int reg1, reg2, reg3;
+	s8 temps;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -461,7 +462,8 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 
 	if (ret < 0)
 		return ret;
-	*val = ret * 1000;
+	temps = ret;
+	*val = temps * 1000;
 	return 0;
 }
 
-- 
2.25.1



