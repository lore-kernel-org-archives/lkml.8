Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959612256C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594748475;
	bh=vM7p8L7u7/uyCT4xL0z7JnamaY49/SNemiuMcAsgCHM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=u3WA+WZ76bRmpRe0Deo0YSn2QsvgbA4GyoN5RQid3VXqAKxDb8wDooEMOdlx6r0oz
	 85fqsXMQ8dzB85Mj1GiU/itr8xUTUNk/sAgb15AndaxdVqRu2vew+jrHB+EYafuNE5
	 4ZJHkCSzNjjNQ0aaBnNTpYUN2fBwFRPtSrKNtGYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgGNRlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgGNRlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:41:14 -0400
Received: from embeddedor (unknown [201.162.240.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAF822518;
        Tue, 14 Jul 2020 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594748473;
        bh=vM7p8L7u7/uyCT4xL0z7JnamaY49/SNemiuMcAsgCHM=;
        h=Date:From:To:Cc:Subject:From;
        b=K97paYtiO5JswQ/SFsEKZgQumy6W6G3Fj7bzGFJvTbIWayONSCA0T5U8Cn407Y8cv
         YO6Dt1dVp1InaT8Qcuo1GU5O+7k5NEJdibWJpW2+/165Yy/cN2ZGobW6ll/S1zWSm9
         /q5I6p3+c9Neu6InWyvFtqpWkP8vVD8i2R782PQI=
Date:   Tue, 14 Jul 2020 12:46:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] mei: Avoid the use of one-element arrays
Message-ID: <20200714174644.GA30158@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases or, as in this particular case, replace the one-element array
with a simple value type u8 reserved once this is just a placeholder
for alignment. The older style of one-element or zero-length arrays
should no longer be used[2].

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the variable type is changed
but the corresponding sizeof that is passed as argument is not.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://github.com/KSPP/linux/issues/79

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/mei/hbm.c | 4 ++--
 drivers/misc/mei/hw.h  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index a44094cdbc36..f020d5594154 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -408,14 +408,14 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
 {
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_add_client_response resp;
-	const size_t len = sizeof(struct hbm_add_client_response);
+	const size_t len = sizeof(resp);
 	int ret;
 
 	dev_dbg(dev->dev, "adding client response\n");
 
 	mei_hbm_hdr(&mei_hdr, len);
 
-	memset(&resp, 0, sizeof(struct hbm_add_client_response));
+	memset(&resp, 0, len);
 	resp.hbm_cmd = MEI_HBM_ADD_CLIENT_RES_CMD;
 	resp.me_addr = addr;
 	resp.status  = status;
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b1a8d5ec88b3..8c0297f0e7f3 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -346,13 +346,13 @@ struct hbm_add_client_request {
  * @hbm_cmd: bus message command header
  * @me_addr: address of the client in ME
  * @status: if HBMS_SUCCESS then the client can now accept connections.
- * @reserved: reserved
+ * @reserved: reserved for alignment.
  */
 struct hbm_add_client_response {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 status;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 /**
@@ -461,7 +461,7 @@ struct hbm_notification {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 host_addr;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 /**
-- 
2.27.0

