Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E920C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7B6206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgDWPYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:24:23 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:16382 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgDWPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:24:21 -0400
IronPort-SDR: 5UHbcRstNnxq4VXDubgGDjVY/rU0l0kD/mq5oGNO+do8IZhEPgMnIAJpSt0K+9iNJYAx4Tyv/3
 hUhWxgSJyZzK42dujoBNFJ7GzXfCjW6XwLPtAX2vG0g9Oo1hZNS1hPVh6dIP14jvNur084ezTg
 BNQxfXHpW2iguvKoUz2/cbqCLiYAg/ZawNNQEHlfCpMOaJKrfUCeX00HT4rGsQS1LG6QoVc6YL
 MbDDCTUXSzHZlDOjeleIAKpDmwrqYLanB/Q+r1C5b+gVntx7t8TsQaljcsiHGgih0ZAIvMXZR8
 7U8=
X-IronPort-AV: E=Sophos;i="5.73,307,1583186400"; 
   d="scan'208";a="277228194"
From:   =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
To:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Subject: [PATCH 2/3] tee: optee: Add support for session login client UUID generation
Date:   Thu, 23 Apr 2020 18:17:00 +0300
Message-Id: <20200423151701.111231-3-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
References: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Apr 2020 15:17:07.0386 (UTC) FILETIME=[409381A0:01D61982]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for client UUID generation for OP-TEE. For group based session
logins membership is verified.

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 drivers/tee/optee/call.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index cf2367ba08d6..dbed3f480dc0 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -233,9 +233,13 @@ int optee_open_session(struct tee_context *ctx,
 	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT |
 				  OPTEE_MSG_ATTR_META;
 	memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
-	memcpy(&msg_arg->params[1].u.value, arg->uuid, sizeof(arg->clnt_uuid));
 	msg_arg->params[1].u.value.c = arg->clnt_login;
 
+	rc = tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u.value,
+					  arg->clnt_login, arg->clnt_uuid);
+	if (rc)
+		goto out;
+
 	rc = optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
 	if (rc)
 		goto out;
-- 
2.17.1

