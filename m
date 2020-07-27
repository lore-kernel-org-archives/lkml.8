Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B0BC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EA120775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859496;
	bh=9eh4zjibUGsJrkBsVkA2O+Xz5FTZwE39Qzz12cZceuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XXJ1VahX8RzVohspuAbKHX15kflDrjZQJV/fRoyeFdXkj1DaXtxKxM+CioFGh+3J5
	 cE2Q8z7eSI4eHhQ1KJ0713aqGcmMWHECOuo0BiW31L1cKn5z/f6zo43sulPCkAJJ3b
	 rHJ0Vrb6xRFkqfJfOYl613qbjHV2ZINmBS2f62C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgG0OSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731188AbgG0OSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:18:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6372520775;
        Mon, 27 Jul 2020 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859490;
        bh=9eh4zjibUGsJrkBsVkA2O+Xz5FTZwE39Qzz12cZceuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+II9mm9XhSUHtcBDrb3spic9eQ6mywZ+qWnt9nmGQcH7Q7I74NcKKqyYJUt3i5G7
         m5qr0FE7Y1n25HuFoglT91YorFs1otoHME8su6jOb/3i2DGBy1IyvuiFqIexH1V3Fj
         W19R18yfGBaG7ln0G1bru1S/6is9MyAiCUGrUOUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 129/138] drm/amd/powerplay: fix a crash when overclocking Vega M
Date:   Mon, 27 Jul 2020 16:05:24 +0200
Message-Id: <20200727134931.876843687@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiu Wenbo <qiuwenbo@phytium.com.cn>

commit 88bb16ad998a0395fe4b346b7d3f621aaa0a2324 upstream.

Avoid kernel crash when vddci_control is SMU7_VOLTAGE_CONTROL_NONE and
vddci_voltage_table is empty. It has been tested on Intel Hades Canyon
(i7-8809G).

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208489
Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)")
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -642,9 +642,6 @@ static int vegam_get_dependency_volt_by_
 
 	/* sclk is bigger than max sclk in the dependence table */
 	*voltage |= (dep_table->entries[i - 1].vddc * VOLTAGE_SCALE) << VDDC_SHIFT;
-	vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
-			(dep_table->entries[i - 1].vddc -
-					(uint16_t)VDDC_VDDCI_DELTA));
 
 	if (SMU7_VOLTAGE_CONTROL_NONE == data->vddci_control)
 		*voltage |= (data->vbios_boot_state.vddci_bootup_value *
@@ -652,8 +649,13 @@ static int vegam_get_dependency_volt_by_
 	else if (dep_table->entries[i - 1].vddci)
 		*voltage |= (dep_table->entries[i - 1].vddci *
 				VOLTAGE_SCALE) << VDDC_SHIFT;
-	else
+	else {
+		vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
+				(dep_table->entries[i - 1].vddc -
+						(uint16_t)VDDC_VDDCI_DELTA));
+
 		*voltage |= (vddci * VOLTAGE_SCALE) << VDDCI_SHIFT;
+	}
 
 	if (SMU7_VOLTAGE_CONTROL_NONE == data->mvdd_control)
 		*mvdd = data->vbios_boot_state.mvdd_bootup_value * VOLTAGE_SCALE;


