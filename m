Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3521D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047517;
	bh=T7UqCQ4MmuEZ9jZMyvkZ7fXJdJnl0Slb6/yftBff6Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uo7AhXW74v026RRp09yrOxvi3fwEI+sNMKvRQ1NlrO0wQKfT+XpnRVmJVZdofFjLY
	 RMBgr+a/Vw2PWAqOckOajHke9cAmY+R2bVPqEEPW9CLBQ1Nlw4AZJZl108rOJl6hAM
	 g9re4vXxaX7wx+T8SZFwSMBLiL/IW/DOsqMmB7Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410214AbgDPOb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441727AbgDPOCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:02:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C18E20732;
        Thu, 16 Apr 2020 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045751;
        bh=T7UqCQ4MmuEZ9jZMyvkZ7fXJdJnl0Slb6/yftBff6Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmHvCaLvs577RAe4FlpEYk5h9vW5+v4kGDSiJBO8B0dJYFWtdOBHbb/nnz1ZyTz8e
         pfE/jciYs2CSg1iXzzBD9sH53DQMYC9TRVF5EHS7nCe9RlgS6PSqngiDZucDa/uM44
         mx4xKCh52u8/LlzqP/mX0SBG2UwdKA8iem8cY9ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.6 224/254] Input: i8042 - add Acer Aspire 5738z to nomux list
Date:   Thu, 16 Apr 2020 15:25:13 +0200
Message-Id: <20200416131353.844691497@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit ebc68cedec4aead47d8d11623d013cca9bf8e825 upstream.

The Acer Aspire 5738z has a button to disable (and re-enable) the
touchpad next to the touchpad.

When this button is pressed a LED underneath indicates that the touchpad
is disabled (and an event is send to userspace and GNOME shows its
touchpad enabled / disable OSD thingie).

So far so good, but after re-enabling the touchpad it no longer works.

The laptop does not have an external ps2 port, so mux mode is not needed
and disabling mux mode fixes the touchpad no longer working after toggling
it off and back on again, so lets add this laptop model to the nomux list.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200331123947.318908-1-hdegoede@redhat.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/serio/i8042-x86ia64io.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -530,6 +530,17 @@ static const struct dmi_system_id __init
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
 		},
 	},
+	{
+		/*
+		 * Acer Aspire 5738z
+		 * Touchpad stops working in mux mode when dis- + re-enabled
+		 * with the touchpad enable/disable toggle hotkey
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
+		},
+	},
 	{ }
 };
 


