Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE4AC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936FE20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Ul31r6vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgG1KDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgG1KDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A11C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t1so460770plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1PScPr62Fyv3G3V3sqS9lJD1oItrdYt39x4/kLlLZg=;
        b=Ul31r6vzFpqUyBilU7EeOT3mAZRosSmTqaVJ985PdzmOAZtWDkssXn7e4nFkZdB5m9
         XR6md9kmdPIPjc93Fz2i296TlFqH6ocjojtZjIltEBXzUikdf5DZIDStIMH67MXCyRw9
         cy6TMPOP/iSKXxdKY+GlZtczBqiAgZdTHAZnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1PScPr62Fyv3G3V3sqS9lJD1oItrdYt39x4/kLlLZg=;
        b=JLRlBFhPNDMVfqWGhKE5y59Rc8oN1MjFqLpyoUkylX0qbbW9R71YFQb3kAKRlZONii
         fDK6ePZydGd3bpdkNIQE9EvA5/zQXLmCJehmLm3i29rJvAZf48S+0I2AINBSOmtvnCWB
         lrXEJhjG/V2HrNcdcxE4KxUHpgGMpLSh59WqmanafyDe5y7qBHAE6sJu232GoRBoICDx
         M7rtG5INEXTmpeHG1vflr/us76ix+nMLFrO/34RrpS7a7B2ixeRF4fcJ9X7OOa+mjR6P
         gw2wrtxBxks2SkWcG62qlrNK1EG+EfnTZD9QdDRdrTsu3mCclpWSuDYi4nYpHCNvJemn
         e0sQ==
X-Gm-Message-State: AOAM531l9e4zVGN7gVu4HZW7w+Xt1u+SURpzuXYfyObmuF44oxoQJQsX
        b1x4og/iKy/JrA0cxmI/pbwllg==
X-Google-Smtp-Source: ABdhPJxBj4iAMGZV3EZloiPno+R8OrDHdwl0YojYT+mnKhr8ONEgW8XZTju+MwFCl58YDsJMqdR9Nw==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr3886308pjz.176.1595930622799;
        Tue, 28 Jul 2020 03:03:42 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:42 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 4/9] ARM: mstar: Adjust IMI size of infinity
Date:   Tue, 28 Jul 2020 19:03:16 +0900
Message-Id: <20200728100321.1691745-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infinity has 88KB of SRAM at the IMI region.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/infinity.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/infinity.dtsi b/arch/arm/boot/dts/infinity.dtsi
index f68e6d59c328..cd911adef014 100644
--- a/arch/arm/boot/dts/infinity.dtsi
+++ b/arch/arm/boot/dts/infinity.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "mstar-v7.dtsi"
+
+&imi {
+	reg = <0xa0000000 0x16000>;
+};
-- 
2.27.0

