Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306DAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD4B207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927199;
	bh=JhwcJ/tqepTYH27UU61VLZNErKUrP6QK/XJvsBUTs9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCeXhtG166EC2VuCGzgdKqgixB3b1ZUSeu1EZiPZcW4Hiy+BSCovJfoQi0AJEcmhM
	 dZzyA8EQyQhCWeweIcp6hwUivs7j0zx0If7ojxerEhoByuaMPHtrJ2WfI4tBtkrW0d
	 vqNWYaSMiCcBCXaHhZmGtfRX5+nI6uILEjcYudFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgHTMj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbgHTJrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:47:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B963320724;
        Thu, 20 Aug 2020 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916860;
        bh=JhwcJ/tqepTYH27UU61VLZNErKUrP6QK/XJvsBUTs9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EstavljkfRUQADvAUFTGTDs0mZLic/YN5SyT6yO8bo7jH/JwN6cfM+rLJZpVM0/Sd
         fBRCbSN9R38CCbVRlqgkFwaB0fvE/7T3MgjFVsTuMc8sa+Ok1h7+wOMB4o43Xi2ByV
         Xk/APSsjWi1c1BCfY/XlsV/HWb3hHZfgCxbrE7ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.4 071/152] remoteproc: qcom: q6v5: Update running state before requesting stop
Date:   Thu, 20 Aug 2020 11:20:38 +0200
Message-Id: <20200820091557.359022608@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

commit 5b7be880074c73540948f8fc597e0407b98fabfa upstream.

Sometimes the stop triggers a watchdog rather than a stop-ack. Update
the running state to false on requesting stop to skip the watchdog
instead.

Error Logs:
$ echo stop > /sys/class/remoteproc/remoteproc0/state
ipa 1e40000.ipa: received modem stopping event
remoteproc-modem: watchdog received: sys_m_smsm_mpss.c:291:APPS force stop
qcom-q6v5-mss 4080000.remoteproc-modem: port failed halt
ipa 1e40000.ipa: received modem offline event
remoteproc0: stopped remote processor 4080000.remoteproc-modem

Reviewed-by: Evan Green <evgreen@chromium.org>
Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
Cc: stable@vger.kernel.org
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Link: https://lore.kernel.org/r/20200602163257.26978-1-sibis@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/qcom_q6v5.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -151,6 +151,8 @@ int qcom_q6v5_request_stop(struct qcom_q
 {
 	int ret;
 
+	q6v5->running = false;
+
 	qcom_smem_state_update_bits(q6v5->state,
 				    BIT(q6v5->stop_bit), BIT(q6v5->stop_bit));
 


