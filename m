Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DF3C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D41720873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="YGZmQ8GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgD3W6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgD3W6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:58:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E8C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:58:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h124so7618041qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwaXAKuRd0apGvpDhNCHAFUyDcZ/LeyJTl3LHyQWiwI=;
        b=YGZmQ8GWP6O2iWZDHWeYV+qL8FMiaRmtsxbz69scygNhquADfQVsbpoVBYM3QC0dTU
         t5BMZa9/cc51xVx9QZvTbTJKFYFMfHriP4veaT5UB1//NnNg7+0XPqI0B8qA/YQO6Trs
         ODWlwi/Z2xJ4g4HRNN3Netfxfe+l11nBgKK667Wd1jhRlghv5U0KJyh72j8quYtLvJZx
         0S39woQfT0AwekP+ecAruBhm6CQ6qE30TOGK5VA9fla/qOS9SJIQLCq2k3OVPxwNTv/m
         eYrZ+OE+SPFO4cOZPNgCwAYmgE4M6ypCY8+z1qT9xJv4CKfUdR8JecebIhlyL8KRHsYu
         85Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwaXAKuRd0apGvpDhNCHAFUyDcZ/LeyJTl3LHyQWiwI=;
        b=C1EfTHcC2jrMjbgJgxbwM0DrxmXj8PTc0E0chvHC41aYPL3R+6YUTnu3tYLo1qygzG
         9v+7CI5Vd3QcK8tSfFJ6fq/sVhPNHaJzlI+H1bjD63UGhCrkF15G70VGD5o5x++LQYzg
         EOmtrtnuNEMi4/Q39AG4dnuIe7NhOGm4w2AsYVKQSRac/NL8PjPx9111Xi7qPRjWJHNL
         v6nAUvwmBAuy0g7V7Git/UMCN8cmf+WSpbOUW1NOOXVcB0zOCzDxTdw8YgW/De/qehid
         Se9FPcnigdAGGn5bWpf5kOrHqBGw/QwYoojI2GjE5L136rViFk6Qgefn6nSZrzttd4Yj
         hmpA==
X-Gm-Message-State: AGi0PuZATWP7T9eecI76zT7+SXXMmQmHBelnIMaMr5ma9kXwObkqEGCO
        8KfZXw2ueB+O+8uONA0/LLMG86TQ3o/N+w==
X-Google-Smtp-Source: APiQypLfhmjyRVuRf2Lt6npZZiun6EfqTX4lxs32lNtxWW7GfoDXIAI1rIkPsqMKP/JogVM2TtNnpg==
X-Received: by 2002:ae9:e10b:: with SMTP id g11mr926581qkm.449.1588287513228;
        Thu, 30 Apr 2020 15:58:33 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id s50sm1165641qtj.1.2020.04.30.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:58:32 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     mchehab@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RESEND] doc: misc-device: add uacce to toctree(index)
Date:   Thu, 30 Apr 2020 19:58:28 -0300
Message-Id: <20200430225828.114033-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:

Documentation/misc-devices/uacce.rst: WARNING: document isn't included in any toctree

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Documentation/misc-devices/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index c1dcd2628911..1ecc05fbe6f4 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -21,4 +21,5 @@ fit into other categories.
    lis3lv02d
    max6875
    mic/index
+   uacce
    xilinx_sdfec
-- 
2.25.1

