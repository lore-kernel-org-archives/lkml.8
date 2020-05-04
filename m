Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4454A2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615224;
	bh=UGGbM2hQYyJn/Vg6Sovij8kw+FeIOPufGCrPLGKnL/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPA6XFjxQ4sXICtMFuqzuG0R5RcRC96TH/iXxRuI398iVy5dfFCyw9h5hm/obOlvC
	 TozpyZ0e1qS3zeTheZyhvV8WQk1myEMPgXggmzrEp5Z+ML+C/4A4y2UNHfJgLBBjxM
	 UV7BNz/n8g+O2jEPAMt933LfZREw1ty55tKyVwmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgEDSAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbgEDSAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC70206B8;
        Mon,  4 May 2020 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615216;
        bh=UGGbM2hQYyJn/Vg6Sovij8kw+FeIOPufGCrPLGKnL/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5gaJFyG4QHHdxcQk8eRy8HIAFKkeMZYlLuTyCe9aU2gPrvlA7Mt8NXJyFIn3WtSX
         Wv6bCwFUIh2qhH96dZlvC5sKm3wcjNZ4TKPHuW2cbzg8NOrVVo0MQNhKmMUlzkOp2x
         OEE/xlpIKk+Gw6pspbsUKOoqkOWM8D7C/kJ+CFtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 13/26] PM: ACPI: Output correct message on target power state
Date:   Mon,  4 May 2020 19:57:27 +0200
Message-Id: <20200504165445.605376922@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
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
@@ -227,13 +227,13 @@ int acpi_device_set_power(struct acpi_de
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


