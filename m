Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459C520787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645889;
	bh=3mVnKTF2uYAXRjiu36c2VE+rQ9dRUSV0W8Csiw4csOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVlefvt/XWCU9OMOfm9P/un2XazPPu4TfJtGMJHD/ZYXvUKjfUA0qXJUIO8DGpiUs
	 vpr5WPCkuLLAfjjq5PysFJzWa7OY/we3VKw5AFfMzijDzhBPNC7OlVf/idcfggm3Kp
	 N8PHJAyCJxW7xyZB9z6YJMkhvBZiVYpvEgXe2qyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgCaJL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbgCaJLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:11:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BFDD20675;
        Tue, 31 Mar 2020 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645879;
        bh=3mVnKTF2uYAXRjiu36c2VE+rQ9dRUSV0W8Csiw4csOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwyjIy9X86lHD9B3x1r1ay6dy2hRHu01ZSrkHRI12OFWTha1+Msy2qv4HfzPAugVb
         6o3lWWICoucFHKoKTTW5uZSMyHD1bbcUoVdm2c8hmMPVpYrMJONkWGQ7bXIoCvrT73
         Yihd09viiFMUf0B1LB2adUcUCwDJbRWwPRpLlku8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 006/155] ACPI: PM: s2idle: Rework ACPI events synchronization
Date:   Tue, 31 Mar 2020 10:57:26 +0200
Message-Id: <20200331085419.054651700@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 024aa8732acb7d2503eae43c3fe3504d0a8646d0 upstream.

Note that the EC GPE processing need not be synchronized in
acpi_s2idle_wake() after invoking acpi_ec_dispatch_gpe(), because
that function checks the GPE status and dispatches its handler if
need be and the SCI action handler is not going to run anyway at
that point.

Moreover, it is better to drain all of the pending ACPI events
before restoring the working-state configuration of GPEs in
acpi_s2idle_restore(), because those events are likely to be related
to system wakeup, in which case they will not be relevant going
forward.

Rework the code to take these observations into account.

Tested-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sleep.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -977,6 +977,16 @@ static int acpi_s2idle_prepare_late(void
 	return 0;
 }
 
+static void acpi_s2idle_sync(void)
+{
+	/*
+	 * The EC driver uses the system workqueue and an additional special
+	 * one, so those need to be flushed too.
+	 */
+	acpi_ec_flush_work();
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+}
+
 static bool acpi_s2idle_wake(void)
 {
 	if (!acpi_sci_irq_valid())
@@ -1021,13 +1031,8 @@ static bool acpi_s2idle_wake(void)
 		 * should be missed by canceling the wakeup here.
 		 */
 		pm_system_cancel_wakeup();
-		/*
-		 * The EC driver uses the system workqueue and an additional
-		 * special one, so those need to be flushed too.
-		 */
-		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
-		acpi_ec_flush_work();
-		acpi_os_wait_events_complete(); /* synchronize Notify handling */
+
+		acpi_s2idle_sync();
 
 		/*
 		 * The SCI is in the "suspended" state now and it cannot produce
@@ -1055,6 +1060,13 @@ static void acpi_s2idle_restore_early(vo
 
 static void acpi_s2idle_restore(void)
 {
+	/*
+	 * Drain pending events before restoring the working-state configuration
+	 * of GPEs.
+	 */
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+	acpi_s2idle_sync();
+
 	s2idle_wakeup = false;
 
 	acpi_enable_all_runtime_gpes();


