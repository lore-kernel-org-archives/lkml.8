Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F00C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42C3206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615281;
	bh=UGGbM2hQYyJn/Vg6Sovij8kw+FeIOPufGCrPLGKnL/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIzzx00i1x+uh4m+NiqfbTf/ux6kmwftimU6RQuVpMP8Rykh3UjIpYaxNE8BPJyly
	 rcJ5Y4DHasKOszhhfaXuEct+KD8Th56vxzKfCtFYzwEMME3wFCYvzuk7KGtrLdNQcL
	 308exf2h5k7w/ESrsXVEH/9r1hZjuvfW/onDsTao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgEDSBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731110AbgEDSBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:01:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D28206B8;
        Mon,  4 May 2020 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615275;
        bh=UGGbM2hQYyJn/Vg6Sovij8kw+FeIOPufGCrPLGKnL/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHUO98cTzHzP7TYWpFoN6Zw+9Yfxr3nf2M0jp5jmKxY+XJe38rU6SpdW04xTxoM/x
         aQBpKz3QRFC7yL+XLui8MWw0R5BQ9CwM8GDwV3ZABzUCha0ktHgcEmrTy8fFWfXgnX
         C8KQfaiOzXrIaFHn/QShd7j2lSeQii0WpYT/3yJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 10/37] PM: ACPI: Output correct message on target power state
Date:   Mon,  4 May 2020 19:57:23 +0200
Message-Id: <20200504165449.690035547@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165448.264746645@linuxfoundation.org>
References: <20200504165448.264746645@linuxfoundation.org>
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


