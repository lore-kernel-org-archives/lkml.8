Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18E120B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581608;
	bh=iN4uu/SZtCI23lgelTAMXjz+AGc7s2h6+bTtogWffiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3s9czxwSzSSBfcB9FJyN4NhqVhcxDZCxte2Z1pT1JzTF312VciQYDzxKnzJ6RKQV
	 G4TLal1WDx5Hety6p1ddotKHhPqjuNyOr2IuCQ0lRjQSIj8B1/kjcUdiXSuzW9bPj2
	 lxdr4sND7fa6jG0u4LWRsCOs1gzYdTcHb8apOFyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404532AbgFSPqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404320AbgFSP0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74DE21582;
        Fri, 19 Jun 2020 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580389;
        bh=iN4uu/SZtCI23lgelTAMXjz+AGc7s2h6+bTtogWffiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qoKGm0YYGedsVsOhuZzPvyHacioZNPWRnJiWAQNrrGb2BBQjRtCh9aDS8dUhv2jMs
         KQfa3yNX+47vnebpRJfQDXgBr1W5OZBDru/h4XSLafmpTvBpTr2IKCVudJ2I+Ac+dB
         sbmLBtgkJuLxMHsZI5gdCMo6HEa5yDTtJEf4TSBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 230/376] staging: greybus: sdio: Respect the cmd->busy_timeout from the mmc core
Date:   Fri, 19 Jun 2020 16:32:28 +0200
Message-Id: <20200619141721.208210621@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit a389087ee9f195fcf2f31cd771e9ec5f02c16650 ]

Using a fixed 1s timeout for all commands is a bit problematic.

For some commands it means waiting longer than needed for the timeout to
expire, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
1s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Cc: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20200414161413.3036-20-ulf.hansson@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/sdio.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 68c5718be827..c4b16bb5c1a4 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -411,6 +411,7 @@ static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
 	struct gb_sdio_command_request request = {0};
 	struct gb_sdio_command_response response;
 	struct mmc_data *data = host->mrq->data;
+	unsigned int timeout_ms;
 	u8 cmd_flags;
 	u8 cmd_type;
 	int i;
@@ -469,9 +470,12 @@ static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
 		request.data_blksz = cpu_to_le16(data->blksz);
 	}
 
-	ret = gb_operation_sync(host->connection, GB_SDIO_TYPE_COMMAND,
-				&request, sizeof(request), &response,
-				sizeof(response));
+	timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
+		GB_OPERATION_TIMEOUT_DEFAULT;
+
+	ret = gb_operation_sync_timeout(host->connection, GB_SDIO_TYPE_COMMAND,
+					&request, sizeof(request), &response,
+					sizeof(response), timeout_ms);
 	if (ret < 0)
 		goto out;
 
-- 
2.25.1



