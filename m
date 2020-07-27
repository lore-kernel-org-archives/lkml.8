Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11376C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E5020663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860196;
	bh=5zQqoD96yDS07C+kDyvDQ1xSEMfj4vIcSvr/g+YgXR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HjH+GoB0FChCmsHcVurUsoH4/acVkKhVAu6CcrGCfyiQcSoQGwGAxsyNXdXjextG0
	 7pXlcv/+6buPIjyDNQtConr02q+/hxXAoZRIKLnnfu1zkxOx0Hk7gTR5iKOwGcTUtr
	 BPtm7svZtO/7Vm/n1oq80FgAR1znpuiW9Eve+J70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgG0OWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731924AbgG0OWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:22:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7209A2075A;
        Mon, 27 Jul 2020 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859762;
        bh=5zQqoD96yDS07C+kDyvDQ1xSEMfj4vIcSvr/g+YgXR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCF5PukcNzZJ3Nx3rbonF5NgvVk3nZOmteAaiQD4dWwf6de9tsfoCIIOQ0RZjR2bm
         oe81dipJkFJeNJ2xPR2c/eN+gthUm1k9FLc2iXZgeCEGfCSpPpl1tIyTNdT/9WEGqU
         jLxzbJAQ5OcgLI0ziuDadsuGrISsEnJ3lTgxXZao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Shik Chen <shik@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.7 096/179] scripts/decode_stacktrace: strip basepath from all paths
Date:   Mon, 27 Jul 2020 16:04:31 +0200
Message-Id: <20200727134937.343746664@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

[ Upstream commit d178770d8d21489abf5bafefcbb6d5243b482e9a ]

Currently the basepath is removed only from the beginning of the string.
When the symbol is inlined and there's multiple line outputs of
addr2line, only the first line would have basepath removed.

Change to remove the basepath prefix from all lines.

Fixes: 31013836a71e ("scripts/decode_stacktrace: match basepath using shell prefix operator, not regex")
Co-developed-by: Shik Chen <shik@chromium.org>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Shik Chen <shik@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Link: http://lkml.kernel.org/r/20200720082709.252805-1-pihsun@chromium.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/decode_stacktrace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 13e5fbafdf2f7..fe7076fdac8a3 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -84,8 +84,8 @@ parse_symbol() {
 		return
 	fi
 
-	# Strip out the base of the path
-	code=${code#$basepath/}
+	# Strip out the base of the path on each line
+	code=$(while read -r line; do echo "${line#$basepath/}"; done <<< "$code")
 
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
-- 
2.25.1



