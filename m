Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F4A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883011;
	bh=UvXZ+IxoIeeey089XnZGi/88/VdiyQwT0ComwzdImDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsgSeUCbx6cxfEssE64nNTUQPAZaah0hEOUedKq8TYSR6+Y1l6IDMPK4kCOF09V0T
	 4348ICM80tMlQQos5yJB4QnzPOFDtP4wXOn4MLkIseD74fypQrb3lwYn3XbB2+8Wf6
	 xNIXBEGhmwPZ+GiQXfXvzfubEzp7pm6Gl0KP5L4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440549AbgDNQuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440480AbgDNQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726472137B;
        Tue, 14 Apr 2020 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882978;
        bh=UvXZ+IxoIeeey089XnZGi/88/VdiyQwT0ComwzdImDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntlI9LgX+ytnJs8ED0kZgkN/4SxtCotaGpTTagmvYyUzw9VuyZOjcFC4OWpxPYu1j
         PyM9busMDB2J46H57wrdQm6DdxXKm2+PdfrwwQA7WgwKCAMc/feIm2fS3KauJoXLWz
         Fkktld+KsUlX6EcBCvBCkky93zcvXROOdIzzWXfU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 12/15] tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
Date:   Tue, 14 Apr 2020 13:48:51 -0300
Message-Id: <20200414164854.26026-13-acme@kernel.org>
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

To pick the change in:

  88be76cdafc7 ("drm/i915: Allow userspace to specify ringsize on construction")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 829c0a48577f..2813e579b480 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1619,6 +1619,27 @@ struct drm_i915_gem_context_param {
  * By default, new contexts allow persistence.
  */
 #define I915_CONTEXT_PARAM_PERSISTENCE	0xb
+
+/*
+ * I915_CONTEXT_PARAM_RINGSIZE:
+ *
+ * Sets the size of the CS ringbuffer to use for logical ring contexts. This
+ * applies a limit of how many batches can be queued to HW before the caller
+ * is blocked due to lack of space for more commands.
+ *
+ * Only reliably possible to be set prior to first use, i.e. during
+ * construction. At any later point, the current execution must be flushed as
+ * the ring can only be changed while the context is idle. Note, the ringsize
+ * can be specified as a constructor property, see
+ * I915_CONTEXT_CREATE_EXT_SETPARAM, but can also be set later if required.
+ *
+ * Only applies to the current set of engine and lost when those engines
+ * are replaced by a new mapping (see I915_CONTEXT_PARAM_ENGINES).
+ *
+ * Must be between 4 - 512 KiB, in intervals of page size [4 KiB].
+ * Default is 16 KiB.
+ */
+#define I915_CONTEXT_PARAM_RINGSIZE	0xc
 /* Must be kept compact -- no holes and well documented */
 
 	__u64 value;
-- 
2.21.1

