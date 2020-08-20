Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4847520885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917311;
	bh=JhwcJ/tqepTYH27UU61VLZNErKUrP6QK/XJvsBUTs9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSJoTVGe91jPZ5mjZnFmsNbEF8mGHMbiUsb3tu7cG8Sd/sNUkPOMcb/iYcouzM3P0
	 M2MmzDORMsxxUhezH+eAaWEjR5udLnKj8YNApn6b8nYDxbh3+im6OrSAXXj98NyxV1
	 W3VaxaKKHT8XnNxfr2GxjWYd4HQgXPkmgURVm/oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgHTJzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgHTJzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:55:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F81D207FB;
        Thu, 20 Aug 2020 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917300;
        bh=JhwcJ/tqepTYH27UU61VLZNErKUrP6QK/XJvsBUTs9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGIqgxRb3bQBL7BqgDZvpGNiWCG6meqfOoMfz/nL7nLSjcnIISpLlVD99znI+q4md
         aqsXu8FcgNCI1Cb4KWs1+YbXQKrzZqiAFFdYEUZDALNUZGn4RSaFnYv9RgWoa0mE5+
         P0mAmlgP4M12uOLtVY+3TnJiBP3/EPWE/Y6NwYMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.19 47/92] remoteproc: qcom: q6v5: Update running state before requesting stop
Date:   Thu, 20 Aug 2020 11:21:32 +0200
Message-Id: <20200820091540.111488629@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
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
 


