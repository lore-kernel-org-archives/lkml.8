Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62512208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutex.one header.i=@mutex.one header.b="I1UNQqWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgGTFwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:52:46 -0400
Received: from mail.mutex.one ([62.77.152.124]:50204 "EHLO mail.mutex.one"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTFwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:52:46 -0400
X-Greylist: delayed 1266 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 01:52:45 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 43542BF40804;
        Mon, 20 Jul 2020 08:31:38 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D7lWadLv2zUF; Mon, 20 Jul 2020 08:31:25 +0300 (EEST)
Received:  [127.0.0.1] (localhost [127.0.0.1])nknown [109.103.89.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mutex.one (Postfix) with ESMTPSA id 1E54BBF4081B;
        Mon, 20 Jul 2020 08:31:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1595223085; bh=3Q9wo/RG1dE1G4AJjRDMl1EzN2ABC523RLFu8lO45+o=;
        h=From:To:Cc:Subject:Date:From;
        b=I1UNQqWcpweA0tJO4MSGrr+sXL60dyCyzOC0yYAVR6sUE6sE5bxzNnk0ctkdwzKIW
         myXeWMd10HeFDieroyfgs5xF1lbiV/L73zc+2b12jPmkoWCYM0SrbssyNUDisfQrRu
         rqINk9076cV13yEncmTngZt59JTweN9igrDykisI=
From:   Marian Posteuca <posteuca@mutex.one>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Marian Posteuca <posteuca@mutex.one>
Subject: [PATCH] staging: dpaa2-ethsw: fix switch/case fallthrough warning
Date:   Mon, 20 Jul 2020 08:30:36 +0300
Message-Id: <20200720053036.10383-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the fallthrough warning that is reported by checkpatch.

Signed-off-by: Marian Posteuca <posteuca@mutex.one>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 2fb75a7c9314..4986591097dc 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1362,7 +1362,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 		return NOTIFY_DONE;
 
 	switch (event) {
-	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
+	case SWITCHDEV_PORT_OBJ_ADD:
+		fallthrough;
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
 	case SWITCHDEV_PORT_ATTR_SET:
-- 
2.26.2

