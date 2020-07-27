Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40265C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A472083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859137;
	bh=LtcaDP+8s7NZB4utetwwB27kehj8gYyt/QbXVd8N9X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BSTTufCOTnCM1gIpAxQdJupkkQ1HfSf1SW+72kuDnKUQMuW5e7UEqS0Q0NmHgR3aM
	 nTxmeN2HgRrw/ci+cFq4Q9Rd3RU/YDfNeaMEC2v5wajv0bOxmrHIZFx83w09Xf8Gqa
	 xx39EmRXcW4xtLOV6IJ/gEgK+JizoazhtJdvWx3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgG0OMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgG0OMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:12:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAFF20838;
        Mon, 27 Jul 2020 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859132;
        bh=LtcaDP+8s7NZB4utetwwB27kehj8gYyt/QbXVd8N9X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4q51LxvZfWUbD1V9JgvkRC8JvRh10RRmhfefdwn/B/ZUE8HiM1k5EYUspjb/QwRA
         ifQo9CX4GqoPToQlP3veiMTyl4s04X97JVpRO2r7fzsMP0Z63LVtqsGRby45vEE8ac
         ihNQUjyzPlGIc6Rn0VbNSIcSd84l9ly3eKdITAI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Gronowski?= <me@woland.xyz>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 78/86] drm/amdgpu: Fix NULL dereference in dpm sysfs handlers
Date:   Mon, 27 Jul 2020 16:04:52 +0200
Message-Id: <20200727134918.314684663@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paweł Gronowski <me@woland.xyz>

commit 38e0c89a19fd13f28d2b4721035160a3e66e270b upstream.

NULL dereference occurs when string that is not ended with space or
newline is written to some dpm sysfs interface (for example pp_dpm_sclk).
This happens because strsep replaces the tmp with NULL if the delimiter
is not present in string, which is then dereferenced by tmp[0].

Reproduction example:
sudo sh -c 'echo -n 1 > /sys/class/drm/card0/device/pp_dpm_sclk'

Signed-off-by: Paweł Gronowski <me@woland.xyz>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -529,8 +529,7 @@ static ssize_t amdgpu_set_pp_od_clk_volt
 
 	while (isspace(*++tmp_str));
 
-	while (tmp_str[0]) {
-		sub_str = strsep(&tmp_str, delimiter);
+	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
 		ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
 		if (ret)
 			return -EINVAL;
@@ -630,8 +629,7 @@ static ssize_t amdgpu_read_mask(const ch
 	memcpy(buf_cpy, buf, bytes);
 	buf_cpy[bytes] = '\0';
 	tmp = buf_cpy;
-	while (tmp[0]) {
-		sub_str = strsep(&tmp, delimiter);
+	while ((sub_str = strsep(&tmp, delimiter)) != NULL) {
 		if (strlen(sub_str)) {
 			ret = kstrtol(sub_str, 0, &level);
 			if (ret)
@@ -882,8 +880,7 @@ static ssize_t amdgpu_set_pp_power_profi
 			i++;
 		memcpy(buf_cpy, buf, count-i);
 		tmp_str = buf_cpy;
-		while (tmp_str[0]) {
-			sub_str = strsep(&tmp_str, delimiter);
+		while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
 			ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
 			if (ret) {
 				count = -EINVAL;


