Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0EFC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DB72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgD3Mhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:37:33 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:46709 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgD3Mha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:37:30 -0400
IronPort-SDR: RjH9kWxykJsDNSrK6BXPYcjG94sZwGo5oCJppMqZncR54ZJ/ffl0WfqTkp3YP9uC6fNSKbFmif
 kD92gjGN9V7pzHhAx7EL10dbfSBRT2kJMaAM02jVPyVHuXiMsTOiB8noyspxudaakuqvu3wVpW
 ko37AZMKp5O3zycGGgaSv6rD1aVikhrMy1JAVxc1ubwhaOL6/TFyYB+HTG20Yil6tpymlo5afN
 pBRRW77PsLkxZsIKpz1T0nkL/r/+XXcpVszcHjZGpHh3S3hTEce0SfC+pzd08IooTx6q4vbprg
 O48=
X-IronPort-AV: E=Sophos;i="5.73,334,1583186400"; 
   d="scan'208";a="278151916"
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
Subject: [PATCH v2 2/3] tee: optee: Add support for session login client UUID generation
Date:   Thu, 30 Apr 2020 15:37:10 +0300
Message-Id: <20200430123711.20083-3-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
References: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Apr 2020 12:37:21.0583 (UTC) FILETIME=[17E24BF0:01D61EEC]
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

