Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F367C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC3D206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056196;
	bh=ZnOOPiaHl5nWaN+RU3/cJreKj3msAVLbLRJAV8qcMPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KziI6YMtz4tNL/VzV7ncYFsWPVOO0reiH+pguUvXae1Axwa7ns9fjuo/JuTfX98N6
	 Lt7J3e5qZi+hNlLVaPRuF2yVTTDHWowlxcvb0aTphnvK1S+bXKgzLVo4AuwfrJA/Yl
	 0L3PUK4jnAlkbY6JrzHYye3MBG4lwmKKj7aPQ/IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCXNXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbgCXNXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:23:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE5220870;
        Tue, 24 Mar 2020 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056188;
        bh=ZnOOPiaHl5nWaN+RU3/cJreKj3msAVLbLRJAV8qcMPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1js38INsGLymQqs6QpU0UTY4jILeRC6Sf4N9UWZPBFftndrmZyzd/pANNTXWoMsd
         DxrY2dH5ulgDo5gq9YiyQyq5ls3/4D2lvXx/0yl1U5yTqL4XFsqSG/1taCD6Y93a5a
         052RVqc+fLPlmRUdaj30QM3cq82cRMXUUQ5CfDgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.5 050/119] usb: typec: ucsi: displayport: Fix a potential race during registration
Date:   Tue, 24 Mar 2020 14:10:35 +0100
Message-Id: <20200324130813.288931461@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 081da1325d351ea8804cf74e65263ea120834f33 upstream.

Locking the connector in ucsi_register_displayport() to make
sure that nothing can access the displayport alternate mode
before the function has finished and the alternate mode is
actually ready.

Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20200311130006.41288-3-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/ucsi/displayport.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -288,6 +288,8 @@ struct typec_altmode *ucsi_register_disp
 	struct typec_altmode *alt;
 	struct ucsi_dp *dp;
 
+	mutex_lock(&con->lock);
+
 	/* We can't rely on the firmware with the capabilities. */
 	desc->vdo |= DP_CAP_DP_SIGNALING | DP_CAP_RECEPTACLE;
 
@@ -296,12 +298,15 @@ struct typec_altmode *ucsi_register_disp
 	desc->vdo |= all_assignments << 16;
 
 	alt = typec_port_register_altmode(con->port, desc);
-	if (IS_ERR(alt))
+	if (IS_ERR(alt)) {
+		mutex_unlock(&con->lock);
 		return alt;
+	}
 
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp) {
 		typec_unregister_altmode(alt);
+		mutex_unlock(&con->lock);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -314,5 +319,7 @@ struct typec_altmode *ucsi_register_disp
 	alt->ops = &ucsi_displayport_ops;
 	typec_altmode_set_drvdata(alt, dp);
 
+	mutex_unlock(&con->lock);
+
 	return alt;
 }


