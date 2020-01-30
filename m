Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D590C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C422082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409833;
	bh=IVVM1hgl08D2fgpzsJMgLZQwDiwjlJhV9sFa2kUzlz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmnM2ltjd5w77BeFhpPkPM2fUwjSsJS1ENeS4MkDe5Q8lirHHdvAlnfMBe6NKp48J
	 ypxK2Cxc/dgkIcJZ1wXyLz9OYuVeaZLVGynfew9oYFqPZgmQ58Clof9qV/fmO3euZM
	 XrL+jMkHw/ULBVbRQWLqamp/rzZuVPoUwSCQTlis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgA3Snv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgA3Snp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:43:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81ED20CC7;
        Thu, 30 Jan 2020 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409824;
        bh=IVVM1hgl08D2fgpzsJMgLZQwDiwjlJhV9sFa2kUzlz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyAqLoMUcNgVJc1yI05hdkqgEa3RvRPmxh2BmPEbRNsBaQAVb/EoooaHdKEZFmOtB
         mF4c4m4R1uSMWQjQDvPa8UEb7csnPe7/ON4y1YhJqq/QklPttYAG2esXx/bWCbdwbT
         d9NA9t9pxISdt43PoeBk4cZZAtV5AoUAQ9relErI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hebb <tommyhebb@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.4 010/110] usb: typec: wcove: fix "op-sink-microwatt" default that was in mW
Date:   Thu, 30 Jan 2020 19:37:46 +0100
Message-Id: <20200130183615.465301147@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hebb <tommyhebb@gmail.com>

commit 0e64350bf4668d0fbbfec66fd8e637b971b4e976 upstream.

commit 4c912bff46cc ("usb: typec: wcove: Provide fwnode for the port")
didn't convert this value from mW to uW when migrating to a new
specification format like it should have.

Fixes: 4c912bff46cc ("usb: typec: wcove: Provide fwnode for the port")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/d8be32512efd31995ad7d65b27df9d443131b07c.1579529334.git.tommyhebb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm/wcove.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -597,7 +597,7 @@ static const struct property_entry wcove
 	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
-	PROPERTY_ENTRY_U32("op-sink-microwatt", 15000),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 15000000),
 	{ }
 };
 


