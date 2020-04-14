Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3EC20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883056;
	bh=ooRDyaPgSsVt4tLNtUCnIAPFTG4dZFZGWj4c122vd84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6buQ0W8RI4lGD0jB6cU4Ipy3YEcFos6Kdy2ukzVICYyuXIOAsfmZz57j9sLQmrZH
	 DRwjzaiGvIzw8VSJYiowDjDDmDDPmS+fWeahKamHM92s4qedrQeTQTec0zxBVHNQIv
	 dcAJW9FYZD8GYaOP7WTPj5t+Pq7CQqQGV8nsqowU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441023AbgDNQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440445AbgDNQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959CC215A4;
        Tue, 14 Apr 2020 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882969;
        bh=ooRDyaPgSsVt4tLNtUCnIAPFTG4dZFZGWj4c122vd84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeHHlKJrJjmFhWQD566xMcVZZ3RgShp6zE6sXdagx6I3JTVzCJKuOOS2UZym6bIg/
         HmEvKoLKwdCG+hv5sYQZRcNu088IZzXQN66IJ/xpxdPKyrcYC4qKr0GcEDeyHWN4ab
         geawZG7XtYlnh9lMuA/TYI8TC7yqHUzYevZr89vU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 09/15] tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
Date:   Tue, 14 Apr 2020 13:48:48 -0300
Message-Id: <20200414164854.26026-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  e98ad464750c ("fscrypt: add FS_IOC_GET_ENCRYPTION_NONCE ioctl")

That don't trigger any changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

In time we should come up with something like:

  $ tools/perf/trace/beauty/fsconfig.sh
  static const char *fsconfig_cmds[] = {
  	[0] = "SET_FLAG",
  	[1] = "SET_STRING",
  	[2] = "SET_BINARY",
  	[3] = "SET_PATH",
  	[4] = "SET_PATH_EMPTY",
  	[5] = "SET_FD",
  	[6] = "CMD_CREATE",
  	[7] = "CMD_RECONFIGURE",
  };
  $

And:

  $ tools/perf/trace/beauty/drm_ioctl.sh | head
  #ifndef DRM_COMMAND_BASE
  #define DRM_COMMAND_BASE                0x40
  #endif
  static const char *drm_ioctl_cmds[] = {
  	[0x00] = "VERSION",
  	[0x01] = "GET_UNIQUE",
  	[0x02] = "GET_MAGIC",
  	[0x03] = "IRQ_BUSID",
  	[0x04] = "GET_MAP",
  	[0x05] = "GET_CLIENT",
  $

For fscrypt's ioctls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 0d8a6f47711c..a10e3cdc2839 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -163,6 +163,7 @@ struct fscrypt_get_key_status_arg {
 #define FS_IOC_REMOVE_ENCRYPTION_KEY		_IOWR('f', 24, struct fscrypt_remove_key_arg)
 #define FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS	_IOWR('f', 25, struct fscrypt_remove_key_arg)
 #define FS_IOC_GET_ENCRYPTION_KEY_STATUS	_IOWR('f', 26, struct fscrypt_get_key_status_arg)
+#define FS_IOC_GET_ENCRYPTION_NONCE		_IOR('f', 27, __u8[16])
 
 /**********************************************************************/
 
-- 
2.21.1

