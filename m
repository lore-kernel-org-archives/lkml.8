Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F5C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9671220836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFI4t5Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCXIyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:54:00 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38140 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgCXIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:54:00 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so1141791pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRPCgJIscfkoaZkuKu6vD2HdLKZ1Q3Ue4LqlGy+vaWU=;
        b=UFI4t5GzR6KAi870daDmfxXau80Q8z5OYoEbYUjBPlp1KtkzpPEBGgw0h299Uqzf/j
         vR0MHWalO9YuF0loS9SVZnNNVC6/gP/m1/CvKgxB5CMh31y0AsZtUKpgSJdmmHQ3AX9D
         OcCp5PDvrO22stqSno9+QM1h9prQ5ukrJ40/GjDDBTJM1yxd9+lEiY2WtTDK0g3+xOfu
         TGAGkhsg0zNQrT9L4Tf+GXPJVa4ry9gS9Mf1D6MD+cWO7gxuMcXmlM1WXgaZcb3MJ6nq
         be146EPKhpxLupFCggSB3OZqnNeJvytXthsZMByofXLr/CDbUOu6n5yfUZ0Xdjl/m75C
         LHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRPCgJIscfkoaZkuKu6vD2HdLKZ1Q3Ue4LqlGy+vaWU=;
        b=Ii8cgPYI61H4wR4UUBQORX4M5v0N4fRxjbsiu7HnpFCiklHIjHuYZmIMY4PVns+jro
         bVay84w2o+KSX1hJtnG64IqmvTR6OAIeR+OGGGRNL5MNj3h2+A3R4ynVngvENvixcYHA
         HFRr4nEih4uDIJF8CwCMRJyBEuH+kDapfS62lYAPXnkkf60VGZz/M2m7kOu1YAoan365
         4ZC7BMfqiuG9KSvWC403baYSiOR2BNgfnYyQg/7bvK24GKR9aLWk4Z5yWfVryJKYJmbv
         ldFGPYXjVnBdNiOUmijKVHz+CT3Q2fSFvJ1nrc9DV+xHC2bFY7Rd3sO6yPxmqVwNQfA9
         MVbQ==
X-Gm-Message-State: ANhLgQ1YWbtcQJ+wusBECC0QaDsnqoKzEMMwkvxPnxVe/7swhquu9J6k
        oUzJuJkn5jU8VOLhNwzZJWA=
X-Google-Smtp-Source: ADFU+vsAdgckar4S2FjoMmzYD7pXTdSjgdyhkzZ6YmJimQLRgYVO4W/Jw9uKMW2M8GASusgEYR89vQ==
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr2354684pjy.157.1585040038735;
        Tue, 24 Mar 2020 01:53:58 -0700 (PDT)
Received: from localhost.localdomain ([103.231.90.171])
        by smtp.gmail.com with ESMTPSA id d3sm14658695pfn.113.2020.03.24.01.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 01:53:57 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux@leemhuis.info, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] rearrange the output text, cosmetic changes
Date:   Tue, 24 Mar 2020 14:15:13 +0530
Message-Id: <20200324084513.18237-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the subject like says, purely cosmetic changes to read cleanly.
Jumbled up the line.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/debugging/kernel-chktaint | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 2240cb56e6e5..74fd3282aa1b 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -195,8 +195,9 @@ else
 	echo " * kernel was built with the struct randomization plugin (#17)"
 fi

-echo "For a more detailed explanation of the various taint flags see"
-echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources"
-echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
 echo "Raw taint value as int/string: $taint/'$out'"
+echo
+echo "For a more detailed explanation of the various taint flags see below pointers:"
+echo "1) Documentation/admin-guide/tainted-kernels.rst in  the Linux kernel sources"
+echo "2)  https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
 #EOF#
--
2.24.1

