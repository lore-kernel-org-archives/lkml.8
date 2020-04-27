Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B90C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BAE2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD0Cgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 22:36:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbgD0Cgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:36:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6C9FFC015C3213800F8A;
        Mon, 27 Apr 2020 10:36:38 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 10:36:32 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <festevam@gmail.com>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH-next] soc: fsl: Make some functions static
Date:   Mon, 27 Apr 2020 10:35:55 +0800
Message-ID: <20200427023555.206622-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

sound/soc/fsl/fsl_easrc.c:967:5: warning:
'fsl_easrc_config_context' was not declared. Should it be static?
sound/soc/fsl/fsl_easrc.c:1128:5: warning:
'fsl_easrc_set_ctx_format' was not declared. Should it be static?
sound/soc/fsl/fsl_easrc.c:1201:5: warning:
'fsl_easrc_set_ctx_organziation' was not declared. Should it be static?
sound/soc/fsl/fsl_easrc.c:1245:5: warning:
'fsl_easrc_request_context' was not declared. Should it be static?
sound/soc/fsl/fsl_easrc.c:1290:6: warning:
'fsl_easrc_release_context' was not declared. Should it be static?
sound/soc/fsl/fsl_easrc.c:1317:5: warning:
'fsl_easrc_start_context' was not declared. Should it be static?
sound/soc/fsl/fsl_easrc.c:1335:5: warning:
'fsl_easrc_stop_context' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 sound/soc/fsl/fsl_easrc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 97658e1f4989..f36928f93e97 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -964,7 +964,7 @@ static int fsl_easrc_release_slot(struct fsl_asrc *easrc, unsigned int ctx_id)
  *
  * Configure the register relate with context.
  */
-int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
+static int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv;
 	struct fsl_asrc_pair *ctx;
@@ -1125,7 +1125,7 @@ static int fsl_easrc_process_format(struct fsl_asrc_pair *ctx,
 	return 0;
 }
 
-int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
+static int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
 			     snd_pcm_format_t *in_raw_format,
 			     snd_pcm_format_t *out_raw_format)
 {
@@ -1198,7 +1198,7 @@ int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
  * to conform with this format. Interleaving parameters are accessed
  * through the ASRC_CTRL_IN_ACCESSa and ASRC_CTRL_OUT_ACCESSa registers
  */
-int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
+static int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv;
 	struct device *dev;
@@ -1242,7 +1242,7 @@ int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
  * Returns a negative number on error and >=0 as context id
  * on success
  */
-int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
+static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
 {
 	enum asrc_pair_index index = ASRC_INVALID_PAIR;
 	struct fsl_asrc *easrc = ctx->asrc;
@@ -1287,7 +1287,7 @@ int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
  *
  * This funciton is mainly doing the revert thing in request context
  */
-void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
+static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 {
 	unsigned long lock_flags;
 	struct fsl_asrc *easrc;
@@ -1314,7 +1314,7 @@ void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
  *
  * Enable the DMA request and context
  */
-int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
+static int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_asrc *easrc = ctx->asrc;
 
@@ -1332,7 +1332,7 @@ int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
  *
  * Disable the DMA request and context
  */
-int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
+static int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_asrc *easrc = ctx->asrc;
 	int val, i;
-- 
2.22.0

