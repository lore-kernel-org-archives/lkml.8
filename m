Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8112DC54FFF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5314C24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813371;
	bh=0ofxD2pXQYvifZBLcI9btxAKPZ/MMG5dl+RHuuaoxxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQ3ZOdZXsdl7pcCdV8rJc1cvqIM9llNN+HbsR1by64vzI8OqmAkIP5AI10PMK7Hiw
	 xO+34ynBh61JKpCmJ8CIWogEsOfK32sG0cYcIZhYBEMd2VjNeiucSZipSCUM9FiO4z
	 I3/QZsJkSfob7jGpVdburPX8FM8g/RBXMSbkXLYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbgB0OPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389312AbgB0OPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:15:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B1E2469F;
        Thu, 27 Feb 2020 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812929;
        bh=0ofxD2pXQYvifZBLcI9btxAKPZ/MMG5dl+RHuuaoxxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAl7PVS5UAuSq+fl+N5cbm0g70mIkS0tN+LxjWyKNWQ7Q9KjKARILLOyUGl2Ispw1
         SLVUJrZV+NEdDtMiMXsnNX0nTQRjqKLvqtfpmRlvCo7OvPNuF5z6+gV45WHlDskkVj
         wXv9L8jjCclbEn/SlmoJzbC3q/JkSeUaMkEIK+xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 5.5 071/150] ACPI: PM: s2idle: Check fixed wakeup events in acpi_s2idle_wake()
Date:   Thu, 27 Feb 2020 14:36:48 +0100
Message-Id: <20200227132243.412235414@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 63fb9623427fbb44e3782233b6e4714057b76ff2 upstream.

Commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
waking up the system") overlooked the fact that fixed events can wake
up the system too and broke RTC wakeup from suspend-to-idle as a
result.

Fix this issue by checking the fixed events in acpi_s2idle_wake() in
addition to checking wakeup GPEs and break out of the suspend-to-idle
loop if the status bits of any enabled fixed events are set then.

Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
Reported-and-tested-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/evevent.c |   45 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c          |    7 ++++++
 include/acpi/acpixf.h         |    1 
 3 files changed, 53 insertions(+)

--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -265,4 +265,49 @@ static u32 acpi_ev_fixed_event_dispatch(
 		 handler) (acpi_gbl_fixed_event_handlers[event].context));
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_any_fixed_event_status_set
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      TRUE or FALSE
+ *
+ * DESCRIPTION: Checks the PM status register for active fixed events
+ *
+ ******************************************************************************/
+
+u32 acpi_any_fixed_event_status_set(void)
+{
+	acpi_status status;
+	u32 in_status;
+	u32 in_enable;
+	u32 i;
+
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &in_enable);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &in_status);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	/*
+	 * Check for all possible Fixed Events and dispatch those that are active
+	 */
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+
+		/* Both the status and enable bits must be on for this event */
+
+		if ((in_status & acpi_gbl_fixed_event_info[i].status_bit_mask) &&
+		    (in_enable & acpi_gbl_fixed_event_info[i].enable_bit_mask)) {
+			return (TRUE);
+		}
+	}
+
+	return (FALSE);
+}
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1003,6 +1003,13 @@ static bool acpi_s2idle_wake(void)
 			return true;
 
 		/*
+		 * If the status bit of any enabled fixed event is set, the
+		 * wakeup is regarded as valid.
+		 */
+		if (acpi_any_fixed_event_status_set())
+			return true;
+
+		/*
 		 * If there are no EC events to process and at least one of the
 		 * other enabled GPEs is active, the wakeup is regarded as a
 		 * genuine one.
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -753,6 +753,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_gpe_status_set(void))
+ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_fixed_event_status_set(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_gpe_device(u32 gpe_index,


