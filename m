Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFEFC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0197D20746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615580;
	bh=/nWLM2QtbqWu5WV+PzF5Ti7Lv0T74trSZLX54kLdsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N9DRI1cJFLJprCfyJmlRDgRTia3l6qhCc7T4mv1gjjWTkHHdIyqP9sEpjZYv6/OxK
	 IBHIcskfom4FuAoU432UH1wfIquoUydKDuNJlJKUK5HsYqVjYD75IrJuiXRMMQpIip
	 PmpvunHxiCB0s7CIVdyz2G/daQq1QCwAWeV6Spo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbgEDSGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731923AbgEDSGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:06:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5AC206B8;
        Mon,  4 May 2020 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615572;
        bh=/nWLM2QtbqWu5WV+PzF5Ti7Lv0T74trSZLX54kLdsrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTKRneX8/fbeFtCd5iNO5AJiRaJao0niezZ9X7zQvkpHRNJRLq20IZ9RpVMB7DNLK
         kdXT7oM02RYfkfRjfgNhSPtfmchq2iZ/UlkOh906OWsFfir5JnxBmw2yn8ksavjqH/
         8OJDBh3I7lHXGD4xEdoOqVeveDWmKvG0PB1SaHTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.6 34/73] PM: ACPI: Output correct message on target power state
Date:   Mon,  4 May 2020 19:57:37 +0200
Message-Id: <20200504165507.536432677@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit a9b760b0266f563b4784f695bbd0e717610dc10a upstream.

Transitioned power state logged at the end of setting ACPI power.

However, D3cold won't be in the message because state can only be
D3hot at most.

Use target_state to corretly report when power state is D3cold.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/device_pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -273,13 +273,13 @@ int acpi_device_set_power(struct acpi_de
  end:
 	if (result) {
 		dev_warn(&device->dev, "Failed to change power state to %s\n",
-			 acpi_power_state_string(state));
+			 acpi_power_state_string(target_state));
 	} else {
 		device->power.state = target_state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device [%s] transitioned to %s\n",
 				  device->pnp.bus_id,
-				  acpi_power_state_string(state)));
+				  acpi_power_state_string(target_state)));
 	}
 
 	return result;


