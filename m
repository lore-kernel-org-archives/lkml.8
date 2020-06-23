Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEA2217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944729;
	bh=1k6CZDVhM+pi46f8OfwpQ7Q59PKV9xnhSzrXH9RT5lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7QxDy/Traz9UbPYE+57UAgUmaZIbkoRIFwHeLrPVJLq+ZSYsbS8nBkCembgwT8gW
	 Al1jdrP6jdvdckU09HLSCVWL8pDW4AkU0byVZDVEBXS9WK3drPn/Wcuw1NlKR24ZTP
	 04JrqHi9XZbviolN9/uDg2HrpE19KCTphXPF6dAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391986AbgFWUiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391965AbgFWUib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8990C21556;
        Tue, 23 Jun 2020 20:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944712;
        bh=1k6CZDVhM+pi46f8OfwpQ7Q59PKV9xnhSzrXH9RT5lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcDP5+Yk/F4eF16jE5kCEW3KsWiGl9kAIK75Vm3O05vt7rsZ8evWPGe/8D1UX3GpK
         oiRQzyQxu3BHaEqI24TELObZsCLTvYFWtcuVqtQu5cNm19nHQz04Zsqoxu/Bt0Q9yc
         bJ0zz113fT4czgvDTwnhXwqb+Ca3mW7TzZ3pMQGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/206] thermal/drivers/ti-soc-thermal: Avoid dereferencing ERR_PTR
Date:   Tue, 23 Jun 2020 21:56:33 +0200
Message-Id: <20200623195320.155707860@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

[ Upstream commit 7440f518dad9d861d76c64956641eeddd3586f75 ]

On error the function ti_bandgap_get_sensor_data() returns the error
code in ERR_PTR() but we only checked if the return value is NULL or
not. And, so we can dereference an error code inside ERR_PTR.
While at it, convert a check to IS_ERR_OR_NULL.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200424161944.6044-1-sudipm.mukherjee@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b4f981daeaf2a..452e034aedc13 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -183,7 +183,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (!data || IS_ERR(data))
+	if (!IS_ERR_OR_NULL(data))
 		data = ti_thermal_build_data(bgp, id);
 
 	if (!data)
@@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 	}
@@ -276,7 +276,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data) {
+	if (!IS_ERR_OR_NULL(data)) {
 		cpufreq_cooling_unregister(data->cool_dev);
 		if (data->policy)
 			cpufreq_cpu_put(data->policy);
-- 
2.25.1



