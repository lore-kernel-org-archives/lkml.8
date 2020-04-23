Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB4C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2C9206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDWPY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:24:26 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:16382 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgDWPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:24:23 -0400
IronPort-SDR: xmltpFLAp/Ch+C8s6X8ZcWyZXCqxANXQnZqE0QWcc6RZ49diIS4b/bDe03G5OskVamH9rKrp+T
 oq4+l3143FtggGIP63BivpfQMLHDGpoOCuqGoKGHTsDyu5izW0eI3bI1YiNNRYwxSGlHA595Aw
 L9GtxbL4IBGcPwg6gSf4JYXifcX4tzSSFqfVHC4koYUnw/Fm2fHYhrorQTXbRt6CR8JZz04IgN
 7oGplHLt4QyJZDS0Q8zkTSplBQCDQgLA+K8/LNJAiVr7nCnwYvYm3yO90J2PwYj5ATv9Cmw4CW
 AI8=
X-IronPort-AV: E=Sophos;i="5.73,307,1583186400"; 
   d="scan'208";a="277228202"
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
Subject: [PATCH 3/3] [RFC] tee: add support for app id for client UUID generation
Date:   Thu, 23 Apr 2020 18:17:01 +0300
Message-Id: <20200423151701.111231-4-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
References: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Apr 2020 15:17:07.0464 (UTC) FILETIME=[409F6880:01D61982]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel does not provide common contex for application identifier,
instead different security frameworks provide own means to define
application identifier for running process. Code includes place holder for
such solutions but is left for later implementation.

Open questions:

1. App ID source

How to specify what source is used for app id?

Does it need to be protected on runtime?
- Should this be Kconfig setting?
- Cnfigure once during runtime thru sysfs or so?
- Configure from device tree?

2. Formatting for App ID

Should there be common format? Or common keyword id?

3. How to handle custom App ID sources

Android has own App ID so does Tizen.

Should there be place holder for this where to make local patch?

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 drivers/tee/tee_core.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 872272bf9dec..df03bd0071da 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -125,6 +125,15 @@ static int tee_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static const char *tee_session_get_application_id(void)
+{
+	return NULL;
+}
+
+static void tee_session_free_application_id(const char *app_id)
+{
+}
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -217,6 +226,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	 * For TEEC_LOGIN_GROUP:
 	 * gid=<gid>
 	 *
+	 * For TEEC_LOGIN_APPLICATION:
+	 * app=<application id>
+	 *
+	 * For TEEC_LOGIN_USER_APPLICATION:
+	 * uid=<uid>:app=<application id>
+	 *
+	 * For TEEC_LOGIN_GROUP_APPLICATION:
+	 * gid=<gid>:app=<application id>
 	 */
 
 	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
@@ -240,6 +257,34 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x", grp.val);
 		break;
 
+	case TEE_IOCTL_LOGIN_APPLICATION:
+		application_id = tee_session_get_application_id();
+		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
+			  application_id);
+		tee_session_free_application_id(application_id);
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		application_id = tee_session_get_application_id();
+		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
+			  current_euid().val, application_id);
+		tee_session_free_application_id(application_id);
+		break;
+
+	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
+		memcpy(&ns_grp, connection_data, sizeof(gid_t));
+		grp = make_kgid(current_user_ns(), ns_grp);
+		if (!gid_valid(grp) || !in_egroup_p(grp)) {
+			rc = -EPERM;
+			goto out;
+		}
+
+		application_id = tee_session_get_application_id();
+		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
+			  grp.val, application_id);
+		tee_session_free_application_id(application_id);
+		break;
+
 	default:
 		rc = -EINVAL;
 		goto out;
-- 
2.17.1

