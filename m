Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682192085B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBHXI769"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbgF3M65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbgF3M6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:58:54 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E9C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:58:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so20846697iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nae080oEZX7FnMGUXLt4+wKsFcs0lNWW0DRxHmTZnmM=;
        b=zBHXI769t9uyz8WBfdyyP9ALh1MsJ5LaGP07LTYIJH8Dkufa1muknxr/m4u32IKesg
         RKkKzyxfQ4SsXmS1/oyNegmI9clfMwrqWQtIQJzzpOQC3KmN6KaAl0q5nvJURf/V6iuv
         qBHnsEfeHoMM8TtinepXa8kazRAq2jxMe/16ERmlxmfz1IIsoobUhzLRuSXsfvu/MwmY
         8GDyCBpbL1aDcfW+ZYSn2e9jalJi0GMsGkiJXoQ/ChT08ohORR/RFx1iSXf3BuB87Y9g
         twQI+nQFJ7+Qoi3yvvCX2kAjDeIMjdKqxyyLbpQuNA156JW3GQeOPLlm2R+w1D8/Ag6p
         Sk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nae080oEZX7FnMGUXLt4+wKsFcs0lNWW0DRxHmTZnmM=;
        b=fHIH2tXea7D9Gw4CtB7uwDTux0AaDbY9RnILtdLw8NRBaCY6rvqBo7URxYfvkAQqno
         Wjrmi3uO2YoIuLPKcd+AblBf2/drTO1jgmflMIPe08m2HOPObY1OrlbevnGjqFD293Ty
         B/wZuChMYefm32YAhA+7pBzWRdTSnLp39YBJ7rAo0jQzhLHOwZ5C0TtjLIM16mok62cb
         aTwGQQ/i+cZmyJ8A1DaP+1bZTbuOohUC6WHVIsVdNclJms9SkCgc+YqVQ5h3PV7WSjiU
         9x79O5g4KrS2I35VUJoAbsnvafHQiyUi1nxoPOs4JHHHgj3FHZuXNLBMweRu5mjdy+IC
         C3lA==
X-Gm-Message-State: AOAM5318nkUWkjkZP80D6GWAbJOox0ZdUvfK5ToGjnpgsaE69oXBXUoO
        cvy2Pk/B0nBgHWQ2ibTD3Ot9zA==
X-Google-Smtp-Source: ABdhPJwtS0fI5UJxLBaBgqS6d1G1x5c68po82HuqaSxuRcKfIpUgseiiTFMDsfs5CcSC0RjLKeSh7Q==
X-Received: by 2002:a6b:15c2:: with SMTP id 185mr21540522iov.207.1593521933515;
        Tue, 30 Jun 2020 05:58:53 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z9sm1622588ilb.41.2020.06.30.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:58:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: ipa: kill IPA_MEM_UC_OFFSET
Date:   Tue, 30 Jun 2020 07:58:46 -0500
Message-Id: <20200630125846.1281988-4-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630125846.1281988-1-elder@linaro.org>
References: <20200630125846.1281988-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microcontroller shared memory area is at the beginning of the
IPA resident memory.  IPA_MEM_UC_OFFSET was defined as the offset
within that region where it's found, but it's 0, and it's never
actually used.  Just get rid of the definition, and move some of the
description it had to be above the definition of the ipa_uc_mem_area
structure.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: No change from v1.

 drivers/net/ipa/ipa_uc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index a1f8db00d55a..9f9980ec2ed3 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -35,12 +35,6 @@
  */
 /* Supports hardware interface version 0x2000 */
 
-/* Offset relative to the base of the IPA shared address space of the
- * shared region used for communication with the microcontroller.  The
- * region is 128 bytes in size, but only the first 40 bytes are used.
- */
-#define IPA_MEM_UC_OFFSET	0x0000
-
 /* Delay to allow a the microcontroller to save state when crashing */
 #define IPA_SEND_DELAY		100	/* microseconds */
 
@@ -60,6 +54,10 @@
  * @hw_state:		state of hardware (including error type information)
  * @warning_counter:	counter of non-fatal hardware errors
  * @interface_version:	hardware-reported interface version
+ *
+ * A shared memory area at the base of IPA resident memory is used for
+ * communication with the microcontroller.  The region is 128 bytes in
+ * size, but only the first 40 bytes (structured this way) are used.
  */
 struct ipa_uc_mem_area {
 	u8 command;		/* enum ipa_uc_command */
-- 
2.25.1

