Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9EC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D06C21D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048655;
	bh=CHZCDzVZtTmPQ15/Y7IU5HMGBNokPes40qIBuCXVNVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAzdIepOcWdWD54kmUEsE2fpHUq+n7lbqhvR9CrLbAIJ+eVks88vVl+b0G8B95oda
	 EzfbnGlBxHjS2JayaBcyxojdIyRjeFCKIxgnP2hLjm3jWl3d6bHQYqfhX8kyRRP8iC
	 qHYAyAJDn1OKK6kpz5QS3pP6O5DXmM0s0Xv5KrL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394683AbgDPOuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502589AbgDPN6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBE721744;
        Thu, 16 Apr 2020 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045498;
        bh=CHZCDzVZtTmPQ15/Y7IU5HMGBNokPes40qIBuCXVNVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4L4dn9KTv1ves8WGL20iSoTv5UROGEqiDt8mXrH4LhbSndVGq/As0tQ/llfOi0uc
         kTOohZ0QenBFkPIUGr3XCgtelo8QsBeZP6mAfufTpn2iycZv5Vy7uPBKB4adRNd9Xb
         ZcEpD3Va4aan68cRCgj5fFLwtVyICq4dIOmMQVoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.6 159/254] remoteproc: qcom_q6v5_mss: Reload the mba region on coredump
Date:   Thu, 16 Apr 2020 15:24:08 +0200
Message-Id: <20200416131346.503860271@linuxfoundation.org>
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

From: Sibi Sankar <sibis@codeaurora.org>

commit d96f2571dc84d128cacf1944f4ecc87834c779a6 upstream.

On secure devices after a wdog/fatal interrupt, the mba region has to be
refreshed in order to prevent the following errors during mba load.

Err Logs:
remoteproc remoteproc2: stopped remote processor 4080000.remoteproc
qcom-q6v5-mss 4080000.remoteproc: PBL returned unexpected status -284031232
qcom-q6v5-mss 4080000.remoteproc: PBL returned unexpected status -284031232
....
qcom-q6v5-mss 4080000.remoteproc: PBL returned unexpected status -284031232
qcom-q6v5-mss 4080000.remoteproc: MBA booted, loading mpss

Fixes: 7dd8ade24dc2a ("remoteproc: qcom: q6v5-mss: Add custom dump function for modem")
Cc: stable@vger.kernel.org
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200304194729.27979-4-sibis@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/qcom_q6v5_mss.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1030,6 +1030,23 @@ static void q6v5_mba_reclaim(struct q6v5
 	}
 }
 
+static int q6v5_reload_mba(struct rproc *rproc)
+{
+	struct q6v5 *qproc = rproc->priv;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, rproc->firmware, qproc->dev);
+	if (ret < 0)
+		return ret;
+
+	q6v5_load(rproc, fw);
+	ret = q6v5_mba_load(qproc);
+	release_firmware(fw);
+
+	return ret;
+}
+
 static int q6v5_mpss_load(struct q6v5 *qproc)
 {
 	const struct elf32_phdr *phdrs;
@@ -1188,7 +1205,7 @@ static void qcom_q6v5_dump_segment(struc
 
 	/* Unlock mba before copying segments */
 	if (!qproc->dump_mba_loaded) {
-		ret = q6v5_mba_load(qproc);
+		ret = q6v5_reload_mba(rproc);
 		if (!ret) {
 			/* Reset ownership back to Linux to copy segments */
 			ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,


