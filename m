Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B403205CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBuCvzeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGFXKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgGFXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:10:16 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454AFC08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:10:16 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so34381303ili.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se6npIx/isoI+wc+DuA8rTR4AlHBZ2FFSB7wVA4cQcE=;
        b=UBuCvzeWAF5+IDTI7RF1zsFrtgZM/fbjlSisrBTBcKRILehXI+LrHwlgiz4LyYb8pW
         Sf/SlBzf13tuYo7bFT8anxfKfI/fAOybik1Dpi4uQs30mVQm3eDvraBaivCejyOojATg
         7MBl8KArREbaxVhzRuGvbOrFSZbJDp52D+yMjWCJs6den5Ah9H5jt8p3V8SI+cR/BbUI
         KPcdF0KK8/mCWakrO/4pq96mlk8xkwxg2KOrENdz/Iy0u2LZsvmmByOfJqkGw5u15Iu+
         xZwvgB/on5WygSTkF7Y5XPoEaRfZpv4rEz0j99mcxVW6qB9dZI9aZgneyFJYc36FMcnO
         jLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se6npIx/isoI+wc+DuA8rTR4AlHBZ2FFSB7wVA4cQcE=;
        b=ZM3lrjeCvh99woQGKvEoX+bkmSMkIw7TTjRh35W4iJM2EmA3o0cJFKR8ejAGA6YHoA
         kbF56GWXGFhd4QTFd3oPe56FUfJtHGGe1anS7DafEaBw138HlThagQaBvJarxn2EbK0W
         lsGFkY6oA87GczXrhDv1Zw/a85Uv8vKLgVp/PDusIvWHxk7iUQC0637qwHEMtt1TVGm1
         a82gQFf2ghVeJCWz0KDpakn5LwwhjUGpFIvLHSEAjDmHjxMc4RkevSbTsZFlW+deWjQl
         EFcAkZvI8gYZlIdZf4/OllQpqo/uu8jwDqgD/fFokXeE2IgW2tCTYVKbACINxyw0Nkrp
         IO8w==
X-Gm-Message-State: AOAM530BNBPiRk3TDB2T/2UYlHCxDqZMqvIWe1g/xdF0JeBqJBi/okY1
        0NmEAOpREOxeSulsYRRyLBebrQ==
X-Google-Smtp-Source: ABdhPJz+uOnUC2+fv7mONCYyVbVTuWfakSgIjtxksvBBZj8yHC5xDmCxIRCMR3/dUnlXEPmw8bbGgg==
X-Received: by 2002:a92:dd02:: with SMTP id n2mr32990236ilm.257.1594077015622;
        Mon, 06 Jul 2020 16:10:15 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w16sm11523029iom.27.2020.07.06.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:10:15 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: ipa: declare struct types in "ipa_gsi.h"
Date:   Mon,  6 Jul 2020 18:10:09 -0500
Message-Id: <20200706231010.1233505-3-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706231010.1233505-1-elder@linaro.org>
References: <20200706231010.1233505-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers to two struct types are used in "ipa_gsi.h", without those
struct types being forward-declared.  Add these declarations.

Fixes: c3f398b141a8 ("soc: qcom: ipa: IPA interface to GSI")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_gsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ipa/ipa_gsi.h b/drivers/net/ipa/ipa_gsi.h
index 3cf18600c68e..0a40f3dc55fc 100644
--- a/drivers/net/ipa/ipa_gsi.h
+++ b/drivers/net/ipa/ipa_gsi.h
@@ -8,7 +8,9 @@
 
 #include <linux/types.h>
 
+struct gsi;
 struct gsi_trans;
+struct ipa_gsi_endpoint_data;
 
 /**
  * ipa_gsi_trans_complete() - GSI transaction completion callback
-- 
2.25.1

