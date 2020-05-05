Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5457C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C932084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgEEOCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:02:20 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEEOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:02:19 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N49Qd-1j5KPS3F33-0107Nn; Tue, 05 May 2020 16:02:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tao Zhou <tao.zhou1@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: allocate large structures dynamically
Date:   Tue,  5 May 2020 16:01:52 +0200
Message-Id: <20200505140208.284473-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TSc6c1YhMkCs/1m6SAPJGzLtfTJo7NH6Kjg0A5Q4anVbFFYTPN5
 1czvuDksXTPHuVVr43jFu9sB5c2K9U6ytyW55vWyZ4r7H0ZUmFKe76IuD5mBKMJUf1MmwPe
 tlZvkffxNQkE68Ei2SmM2ddGqT4IuwdBy7H+4QdwPa2l1iB61k6gKOkn+y+Hiaa/z4D32XR
 4c8iHqP3q0nR2voq6Q9XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehOmyu1YHYk=:YfokoQK8msooNpbn1YmqWu
 OB8R4hZYKfau7q9kunjemn98+cEQ83JLib4NTIyyi7SXBQlM2UwbtF7lmaC91tJHHITRe5swG
 39aHpP4h60fJDMPo35ysmZ6bQqiJrrkbkNj6GQoczvZhNtnWmPQ9/pZMIuF1Bxx+0GX1t5H9V
 8soeOvbfWOjDrUEibO3tHcSEWbm+Yu8BUP1vMp6yalpadQuXwhXMjwvivJX0XJabCEGNG/qRl
 er9HM3fbhZb5zRNfqBcY3pqmhSJv+2rf4T90SL45KksdW7L7oQ9FldpwfArZBmsJUznZxUHbh
 9hXQs5mn49vQXjB4gY499V168K/8gLQdHAUxp4Sxf2PSoZbWjags0nn8FT2SSm1R+7W9Ac63Y
 2+qgAspf/KnaaLRYw0AxOd+8qxbj+IFtRRUyFyHGu0uQHrOgyn19q1zdkc2H6rt4BhQDqyqh2
 HxLHQCLBlmD7mQ9HUtmUSXSwnYAnN5faU7rK7drwpq6yHla8i7dvl6IE30adDSJ6OYK47rDq6
 zEZZZCBYrNMjF808LpJIalmU1GLyIaHsrdkp0kzUR3yGEr8p3xRuWh7LnWa+5juk5dpB/rJM9
 yuiJ4ZT6hsyAsFyN2/bemmwsaEqDEZVpXAm+vpvVP99ZJSDCwE47tX6UDuL4VUDK6gRlDBVTq
 xhpfMP+/EbAm5WjojLeJQo5eHGE7EbAUm1A7RkounGFSYdRFmaUSZAUf57MbYcWmIm8Hu7FeH
 uA9rLOi0+w1T6PGTl4QgcW3lurPeHQIxVMfMiZzZwJb+KCUnQbNYpp0UdfuBib7a4L44eBtFC
 kn0PlqTfzUUwHMjku0boUq9b2pW5q8tkPyqqbXi3JkkTbTWn+c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the structure was padded to 1024 bytes, it is no longer
suitable for being a local variable, as the function surpasses
the warning limit for 32-bit architectures:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:587:5: error: stack frame size of 1072 bytes in function 'amdgpu_ras_feature_enable' [-Werror,-Wframe-larger-than=]
int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
    ^

Use kzalloc() instead to get it from the heap.

Fixes: a0d254820f43 ("drm/amdgpu: update RAS TA to Host interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 538895cfd862..7348619253c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -588,19 +588,23 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		struct ras_common_if *head, bool enable)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	union ta_ras_cmd_input info;
+	union ta_ras_cmd_input *info;
 	int ret;
 
 	if (!con)
 		return -EINVAL;
 
+        info = kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
 	if (!enable) {
-		info.disable_features = (struct ta_ras_disable_features_input) {
+		info->disable_features = (struct ta_ras_disable_features_input) {
 			.block_id =  amdgpu_ras_block_to_ta(head->block),
 			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
 	} else {
-		info.enable_features = (struct ta_ras_enable_features_input) {
+		info->enable_features = (struct ta_ras_enable_features_input) {
 			.block_id =  amdgpu_ras_block_to_ta(head->block),
 			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
@@ -609,26 +613,33 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Do not enable if it is not allowed. */
 	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
 	/* Are we alerady in that state we are going to set? */
-	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
-		return 0;
+	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head))) {
+		ret = 0;
+		goto out;
+	}
 
 	if (!amdgpu_ras_intr_triggered()) {
-		ret = psp_ras_enable_features(&adev->psp, &info, enable);
+		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
 			amdgpu_ras_parse_status_code(adev,
 						     enable ? "enable":"disable",
 						     ras_block_str(head->block),
 						    (enum ta_ras_status)ret);
 			if (ret == TA_RAS_STATUS__RESET_NEEDED)
-				return -EAGAIN;
-			return -EINVAL;
+				ret = -EAGAIN;
+			else
+				ret = -EINVAL;
+
+			goto out;
 		}
 	}
 
 	/* setup the obj */
 	__amdgpu_ras_feature_enable(adev, head, enable);
-
-	return 0;
+	ret = 0;
+out:
+	kfree(info);
+	return ret;
 }
 
 /* Only used in device probe stage and called only once. */
-- 
2.26.0

