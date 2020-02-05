Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88546C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7420720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580938589;
	bh=J8KWbx5Vd1+BCY+HDf4P/4Zw1QpVWI9/qZ+2elqkuqY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GgTJxLyET6erB8yDKBhSWJzYmlR4uq9+Hv4jH9FQ4zFRn8fX45HUKM//bsImzmAnN
	 MS+cD9U7tyH9fxvaGBmTVdi/yflhzVfxmppAyquo7PUtk8W3/7irgw1t7ubFrx541f
	 NNWwm4hexCMlIJZmUHliyGyKEB32AmoRW0PK6e34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBEVg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBEVg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:36:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9142072B;
        Wed,  5 Feb 2020 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580938587;
        bh=J8KWbx5Vd1+BCY+HDf4P/4Zw1QpVWI9/qZ+2elqkuqY=;
        h=From:To:Cc:Subject:Date:From;
        b=jRkD8jEyCjYQ3rjRtgw0rVD55GWMxdN7lba9jBInCUKifAfitr3kKXdUkvaIbERAy
         IVe8bBVJWylBOkFGXY+SP2kITGNyF1Ehjqp9CG6avkAU9iaRwWePTQXXG4tb+nA/Sx
         5vseyhaod5LzrK+jyvTkoDloEzn8x5aJTRbuw2f8=
From:   Sasha Levin <sashal@kernel.org>
To:     gregkh@linuxfoundation.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] Documentation/process: Change Microsoft contact for embargoed hardware issues
Date:   Wed,  5 Feb 2020 16:36:21 -0500
Message-Id: <20200205213621.31474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Sasha Levin as the Microsoft contact. A new contact will be
assigned by Microsoft.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 33edae654599..a6f4f6e5c78b 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 
-  Microsoft	Sasha Levin <sashal@kernel.org>
+  Microsoft
   VMware
   Xen		Andrew Cooper <andrew.cooper3@citrix.com>
 
-- 
2.20.1

