Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBEEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1175120739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203676;
	bh=UimGleFre7cAJ8h9wRRa31WiMBn6i+AWxCHOyITNml4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UxBHDuFyxM/iu7jOTyTmeNNGfRYL4J+n67gyzMUKyw/OHIrqGWnlnAowtQ9gre+1Y
	 KIOn+jnvteXhAoANYf3u2YShjYqWriEny8EwaPabxEWqHXre+1A0K5Ojja1FrtUkNv
	 dVBBgkw/dPGpHeyfD4jEfcAc/y0lvMJO7K8IxO8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgFOGru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgFOGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:15 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8349121548;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=UimGleFre7cAJ8h9wRRa31WiMBn6i+AWxCHOyITNml4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNvqCAHssrA7jviCYFrWSIirS4eSzhv3WwvKT47LLBz6xHs5C1llthxE/kTtJG99k
         JXft7cXR3NVFnIphATg3qYJFv96dNcPQYCROayWhuU+vY5HCIuSOQ5uMrmCg7Nc7uz
         iadIKHtvkalT6HI0nYwFAN8CHj9WP/pJR2YTahNI=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009no3-A3; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/29] docs: fs: proc.rst: fix a warning due to a merge conflict
Date:   Mon, 15 Jun 2020 08:47:07 +0200
Message-Id: <7d46aec2cb7a5328d260c7c815b9be9737b43ee1.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
added a new parameter to a table. This causes Sphinx warnings,
because there's now an extra "-" at the wrong place:

	/devel/v4l/docs/Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
	Text in column margin in table line 29.

	==    =======================================
	rd    readable
	...
	bt  - arm64 BTI guarded page
	==    =======================================

Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
Fixes: c33e97efa9d9 ("docs: filesystems: convert proc.txt to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/proc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 996f3cfe7030..53a0230a08e2 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -545,7 +545,7 @@ encoded manner. The codes are the following:
     hg    huge page advise flag
     nh    no huge page advise flag
     mg    mergable advise flag
-    bt  - arm64 BTI guarded page
+    bt    arm64 BTI guarded page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
-- 
2.26.2

