Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6EAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE3E207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DtXt1pBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgEUUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:52:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33122 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgEUUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:52:42 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 57DDE20B717B;
        Thu, 21 May 2020 13:52:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57DDE20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1590094361;
        bh=+1AzLCrtBMWO9kmppJbH5Z5Mq2KpzrX0FhIXgB9Ixm4=;
        h=From:To:Cc:Subject:Date:From;
        b=DtXt1pBXWGv1oRLaEreW/zbQI16f4J283YC7QFhxJv9+m/Wx/YJPEzxXi6c9yz5gZ
         1ZlblXOGW0dj3lmlNvVJy1tVfV7bvbHLNpmJBEKl0lrX2EpXJ8bTRrkaVxRs84GIPd
         4axLISzWPVAE3YSIoviT2FFYzAzaq2PHHDXDAIdE=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] pstore/ram: Undefine the correct macro after a recent renaming
Date:   Thu, 21 May 2020 15:52:23 -0500
Message-Id: <20200521205223.175957-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Undefine parse_u32, instead of parse_size, as the name of the macro
recently changed but the #undef directive wasn't updated at that time.

Fixes: 6b31e99b85b0 ("pstore/ram: Refactor DT size parsing")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

Hi Kees - Here's a minor fixup that I noticed was needed while reviewing
your for-next/pstore branch. It is only build-tested but I think that's
all that's needed here.

Tyler

 fs/pstore/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index df8965817c7b..ca6d8a867285 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -674,7 +674,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parse_u32("flags", pdata->flags, 0);
 	parse_u32("max-reason", pdata->max_reason, pdata->max_reason);
 
-#undef parse_size
+#undef parse_u32
 
 	/*
 	 * Some old Chromebooks relied on the kernel setting the
-- 
2.25.1

