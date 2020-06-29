Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F317204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUHcgi2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390524AbgF2VU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbgF2Sws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217FC02E2D1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so15513539wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M622QyXkGImCQOBm9coRWRHenvXfV0A+BN5blU47k6s=;
        b=hUHcgi2vihm8gXNvlTePM3HpVMkMlur2cTNuCxMxvj+KIjqeq3e8gkHbWaW1YdmXzZ
         8jjqtglnruE6j5R+lzaQu9fZdxFcvfr1+fxXFIY/TZgE8cmjdG05PtbWEBK2p6YoFSAc
         ESoURzHQKCCoMmpFTYSoVA96mFuSvZYrh3fVsl5U7gS4TD8kIGhj6LnJBXyXJlQk2qyl
         4DjC7HmsgszTC7Rt8nzICoJYKVCaCicSoLOKR5PhvNuXAp3boRKRdhjoqdVM6UGhnrSH
         w48rWMBw1XdQtKe0b63eQl+7z9/yHDPxyDtyOsVXu29tQKp0eH7Fjr4NtXu/Z4bdF5Mc
         77bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M622QyXkGImCQOBm9coRWRHenvXfV0A+BN5blU47k6s=;
        b=etC9MNfjUlXnrA/XHc+YvVFq8yCXQuX8/goJaJ1wVx9oNA50U5OdlHfN14rPsmV8gl
         4+qgs0JecKAmjjTZoVkxPSqX6pNXbV5hxA8UN4MUckLW3jKqVGqM5FVp9Jz6t+L2qVy0
         nm1QZpUtkQUqWzb+nB4tjgfhj65vAk1fzYGZW+q1q9gB1GfX2O2SczGlG9HVOjd3g3dd
         3unM3Uorq67Q9JxDRgbuRYKSOlMDhXoQi/JV8Rr004iRqShagmleeg/H1rMSP+6SzVf0
         QEb4T2UYGMemMerDSUf2EPIXlQMNlX6g9WdJJRMNXfh7cvKQ1YeNnG6ikP4i/LLJkcCm
         bDCQ==
X-Gm-Message-State: AOAM532g0eTRWileBOo0fWa8A9KZ0WdS+nccBlR7TFWoHOmIi8nUQqcd
        o5A6orB9qTnhThXWuJoOvITn7A==
X-Google-Smtp-Source: ABdhPJxHpy4/biSgBzjt0OrJ9J5FM6Wm0UnBQzDsoEPjxlScdZKQtk0/AHSsk+eH8Q4Ea8ol50x1Lw==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr18320824wmb.168.1593439496774;
        Mon, 29 Jun 2020 07:04:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/20] misc: habanalabs: gaudi: Remove ill placed asterisk from kerneldoc header
Date:   Mon, 29 Jun 2020 15:04:31 +0100
Message-Id: <20200629140442.1043957-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 kernel builds report a lack of description of gaudi_set_asic_funcs()'s
'hdev' argument.  In reality it is documented, but the formatting
was not as expected '@.*:'.  Instead, there was a misplaced asterisk
which was confusing the kerneldoc validator.

Squashes the following W=1 warning:

 drivers/misc/habanalabs/gaudi/gaudi.c:6746: warning: Function parameter or member 'hdev' not described in 'gaudi_set_asic_funcs'

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 61f88e9884ce9..bdb9c0080c464 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6739,7 +6739,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 /**
  * gaudi_set_asic_funcs - set GAUDI function pointers
  *
- * @*hdev: pointer to hl_device structure
+ * @hdev: pointer to hl_device structure
  *
  */
 void gaudi_set_asic_funcs(struct hl_device *hdev)
-- 
2.25.1

