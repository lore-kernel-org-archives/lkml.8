Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7606BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CB4206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663010;
	bh=iN4uu/SZtCI23lgelTAMXjz+AGc7s2h6+bTtogWffiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2jDuRQVmAY3GjGZUr3aId0KlFFcwYa6Ypj2CAlLF6AMYkxx3t7490z6spzfHazTP0
	 hE6RqedTMpEtsYiQ3j4MXkdOMSF/8qKgkL90XFX9g+69eGbaGQbPdmPoA/fksQcZP1
	 UWrRfEKftgCg6/MriYyybUv0ttobkwJunFfuI+KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFHXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgFHXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA7520B80;
        Mon,  8 Jun 2020 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657892;
        bh=iN4uu/SZtCI23lgelTAMXjz+AGc7s2h6+bTtogWffiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWWYwh4UuThnu1ZfiBHM4XKxI4kOzGsbl1UmdZ9Yc5TvwB8h9zE9Ah1lVTs0DTPmU
         iZqCeKnYq7l5qNBGFGI5LxnqcmZxESzY0kMXpda1SXzyaQniJmNUTWSs/Qt5+esSKO
         35tDIsE5MBlFmOH4rsIkmQzfzdqUy1gsV08unFB4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 247/274] staging: greybus: sdio: Respect the cmd->busy_timeout from the mmc core
Date:   Mon,  8 Jun 2020 19:05:40 -0400
Message-Id: <20200608230607.3361041-247-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

