Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93641C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7192146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klpt5eD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCEJHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:07:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54210 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:07:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id cx7so2217825pjb.3;
        Thu, 05 Mar 2020 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwWk3rymKlBi7YMKzGNb1n6EmY/0fOhsKyM88/tetFg=;
        b=klpt5eD0lOtMOlCD5w9upzN5MpEqELB1VFCJEfVhkmU5Zh/Z5kIcGB7jZfHR+c/LaH
         2kbROwAXGEZ//027FUQT6zMBJ6GPWY5L5Ur9TWzhA8NqJ7ht6cAI1ecJx0meCQ89YnnE
         GEAKxEwX29TwLSK7YklkkL49IlUuVx9FseHC/XmkfBjvfRQfl76UvxWb6NS7S8f1NWrz
         VF37gLXVlQrlvF74m+789A/fhF/f4HTvK+WIdYq9d2QcuD6AUm0rLvW6t3qH/oWpMVo6
         Erubp45bmBx1/yw43tBtBM47YbmTEIVEUT0faLSCHSqOMKXuI8DErOZlRkaHyPxOrtmc
         E9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwWk3rymKlBi7YMKzGNb1n6EmY/0fOhsKyM88/tetFg=;
        b=kS951B6rNfUESNgq1bH4FA2bHhuhrPjsNK4EEDI6SLnacWBD4Hzyew/k6wsMmP7/d+
         /+ndgMEDJVFDJSM6Ce8FMzxgFG9ZG9+lLzuHxYdNsCe9IfZ8P5CZo1o+HzFmImqRY8tg
         o7m7r81BAV5I4kSW6PDE8xNKKfj8JZYZwWGacWIk8eE8qG3Oh2qqh8LyC4qXHQUI4/pE
         z9IyDz9fIUZj7jJPscpgdrFvZ/MOUMaUnYbJNDCVrjcbqPbuYtEO/IHI8RTFGLjIf2IE
         iwTaGHpBmb+P3p6pjgDNDuKSOLkorFLvQBjIiNb6hfPizfXkMBSlHaSEdcgutbGEP0dM
         hPxQ==
X-Gm-Message-State: ANhLgQ0m2tzZe0YyE0vJC/Me1FwURfQvot9jvn8kNyVREP7zuY4Dj6YY
        kE17TN+ZIxWSs+eFUa0sZkZAmCWw
X-Google-Smtp-Source: ADFU+vvbk9XiN+e5NS1NkizYhrxuArSYCMucjcPDA/Qy+EnS7Ar6iKHF9uTwRCjX+df5AMO+yMHWlg==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21mr7267961pls.148.1583399223859;
        Thu, 05 Mar 2020 01:07:03 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r14sm10626822pfh.119.2020.03.05.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 01:07:03 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] arm64: dts: specify console via command line
Date:   Thu,  5 Mar 2020 17:06:35 +0800
Message-Id: <20200305090635.30569-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The SPRD serial driver need to know which port would be used as console
in an early period during initialization, otherwise console init would
fail since we added this feature[1].

So this patch add console to command line via devicetree.

[1] https://lore.kernel.org/lkml/20190826072929.7696-4-zhang.lyra@gmail.com/

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
index 2047f7a74265..510f65f4d8b8 100644
--- a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
@@ -28,7 +28,7 @@
 
 	chosen {
 		stdout-path = "serial1:115200n8";
-		bootargs = "earlycon";
+		bootargs = "earlycon console=ttyS1";
 	};
 };
 
-- 
2.20.1

