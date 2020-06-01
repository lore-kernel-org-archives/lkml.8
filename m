Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4999F2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="Xvr3oVMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFAVL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:11:56 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B7DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:11:55 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 3F5D62AC1; Mon,  1 Jun 2020 23:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1591045910;
        bh=ZhGVdNkernqcQZbK4EYb5Wz0ZGp5PK1Gdi2mdPWfiJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=Xvr3oVMmhZ9J7FCsmvt6ntMHFoIaZsAbK9avhc3ejzSCfkiXy9aQdMpfyLM1EEKQx
         RFyQiKNM+IiPgiIlW5WQoLZdy8Qbgp06D3aPf6cqHhCgjbHFLB8+ySdZ1aDHw4cxgm
         qAjRJoFlPFJUblzZ1JbfZQbQtzpwl4ippEXdni4PSVvbzNjWMylMC4Z8QBw89FALIS
         1lJJnDWGcSN14KpVPTsg6+dlAPqQoxoWH9oo5BTBmcwKmh8nghmPCHndECzgPOJm1C
         S9MRYSgAMCYOGFyjR4NV2wyBfjCoH3lgNjWBaBcx4FMItk1JbCUO+6vSPG5KuaEaRb
         /hwjTOI2NIIlU3+4WNAcLvyfD86uwSLFEh6sT82EogQGv6NheIcvRPHdZnwx/PQDyN
         anRCodidWHQQHn/Zm2PSrXvGlj66PpZJ83sTkYeK/YUOFro8jIjHWqCsor7E5N+nyF
         /wHMMVmCeOhRkG4wiAkWZ1FbcmfnOd+afOkueFipvFHJFMQ5c62+WhDB9yMrq1IxjB
         wTNBvsssRTcg1+FH2UjfLw+iTWI0at8kbSNNxKlPHZFl5oLKZ2GGEVaDrO4SJhsVkg
         rEEiiKOO6TBkHGTWN/RLsS6cpVRu3CxMTg0AOp6YOIXRW73zML1KB9Id6M8LOJ1Tay
         gW7BswTl/zdrqBnpmzlM6oI0=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] coding-style.rst: cleanup new text
Date:   Mon,  1 Jun 2020 23:11:45 +0200
Message-Id: <20200601211145.27808-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove doubled word: "...than the parent and are are placed..."

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 Documentation/process/coding-style.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 17a8e584f15f..bd73e1b5c111 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -90,9 +90,9 @@ Statements longer than 80 columns should be broken into sensible chunks,
 unless exceeding 80 columns significantly increases readability and does
 not hide information.
 
-Descendants are always substantially shorter than the parent and are
-are placed substantially to the right.  A very commonly used style
-is to align descendants to a function open parenthesis.
+Descendants are always substantially shorter than the parent and are placed
+substantially to the right.  A very commonly used style is to align descendants
+to a function open parenthesis.
 
 These same rules are applied to function headers with a long argument list.
 
-- 
2.20.1

