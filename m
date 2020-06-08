Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3602C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE880204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660050;
	bh=bOJZp4MY8yMotHM7SIxa+gP+l7ndwy2nMGpeBaSHfwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xCbeDDiGqmZb7ez4F26i0JmfNiceLmvSX6GHTvTVUKyxgZiKnzk9/VR4A0ychd0nY
	 EaurQLJpLe51YHPxNBr1GgURDxrYXIlbjWy36MSkzpFMkhilRlktCc7rhTBH3HXPwm
	 hPnBMvcz4eKsrirSMMLINiPerLVes7Vy2uq8DGbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgFHX0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbgFHXUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A246820842;
        Mon,  8 Jun 2020 23:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658454;
        bh=bOJZp4MY8yMotHM7SIxa+gP+l7ndwy2nMGpeBaSHfwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytYpVZ4G+H6NBbuVGo8CEU3Q40+TNAwnO+70/xB1RjmaEsXmRYj4B+LfHL39UVkft
         KC5Wft1vDSitWkj4Hq6noAX69pMheZ8WvnnM7bPe/U5lthxeKrZdnR7Q0SWJjsQ/im
         NH4IFCkI/2LW4RUVmprVtGPuObGFco/NERDlWe8A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 095/175] media: cec: silence shift wrapping warning in __cec_s_log_addrs()
Date:   Mon,  8 Jun 2020 19:17:28 -0400
Message-Id: <20200608231848.3366970-95-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3b5af3171e2d5a73ae6f04965ed653d039904eb6 ]

The log_addrs->log_addr_type[i] value is a u8 which is controlled by
the user and comes from the ioctl.  If it's over 31 then that results in
undefined behavior (shift wrapping) and that leads to a Smatch static
checker warning.  We already cap the value later so we can silence the
warning just by re-ordering the existing checks.

I think the UBSan checker will also catch this bug at runtime and
generate a warning.  But otherwise the bug is harmless.

Fixes: 9881fe0ca187 ("[media] cec: add HDMI CEC framework (adapter)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/cec-adap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index b14c09cd9593..06383b26712b 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1732,6 +1732,10 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		unsigned j;
 
 		log_addrs->log_addr[i] = CEC_LOG_ADDR_INVALID;
+		if (log_addrs->log_addr_type[i] > CEC_LOG_ADDR_TYPE_UNREGISTERED) {
+			dprintk(1, "unknown logical address type\n");
+			return -EINVAL;
+		}
 		if (type_mask & (1 << log_addrs->log_addr_type[i])) {
 			dprintk(1, "duplicate logical address type\n");
 			return -EINVAL;
@@ -1752,10 +1756,6 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 			dprintk(1, "invalid primary device type\n");
 			return -EINVAL;
 		}
-		if (log_addrs->log_addr_type[i] > CEC_LOG_ADDR_TYPE_UNREGISTERED) {
-			dprintk(1, "unknown logical address type\n");
-			return -EINVAL;
-		}
 		for (j = 0; j < feature_sz; j++) {
 			if ((features[j] & 0x80) == 0) {
 				if (op_is_dev_features)
-- 
2.25.1

