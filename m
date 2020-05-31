Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09304C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2A12073B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWKNNMEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgEaSgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:36:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC9C061A0E;
        Sun, 31 May 2020 11:36:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so8679768wmh.2;
        Sun, 31 May 2020 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M4Vb8AIB4w00zqO8c6xC06PjBVQmUqzkHGhiWbZjDvA=;
        b=EWKNNMEBfz8f2LrErrfa1S/YAFzpWmajoeGaYhMt6B/xyjDhmGbTfYnLXNU0QxDdm+
         HMNFhskubc6L4O8WK3T4R3cHbIHmxM9lityvjhn9Gi/oVY6DQK7vrNZGogxggWumPY0K
         N730CGAZJkstyy7PNQzy8loN1uCaBKgA3WrcUvRBZIQAqvGvwYwEeREODoXpqiPTBHCa
         wC8s/xoNt81SqSy+xikkwf+p0lnmlEC5whARFW/XmEkuJG/ClBjmzCkg/JMLswuHyplf
         o8zEXHk19NWCwvizDaYxs8s0ncc/8bn35G/V656zHEWsgATxDwJNbswEbZIZ/mEg1U52
         ivhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M4Vb8AIB4w00zqO8c6xC06PjBVQmUqzkHGhiWbZjDvA=;
        b=jjVkNab5LU3cNkaIR7Hx8uKW/Sx7VsR5MB0HVPpyCl8F6VMamZUhjf6bJFSbmSlU2d
         9ddHBv3Ej8AsOgAIX7ouqu70KEmLUi1t/e+h+BBFYJAIt3LaLikwepBcGgkhC7iBANHH
         FRACjSOgk3AwdiHYL+5epjCiEBSIo17T6lT9Qrlmvd6DmqoyUmqLNPpDNagcAb/OzmhG
         lpkE/Ips3TPQ8Yt2SHWw7fBXbQvuLhZgT2XH5/Ih8PSWLxvuW74xhP3rc62yosTfLamt
         OSlcLOfLbHlrYz6SUaETEHAoHpzpX/Cr79JaSMFZcsS4GUdIebbB8JYYsKp2VVEVqcFV
         mMFQ==
X-Gm-Message-State: AOAM5318a6BRA75REvVAWRSiB1qGgnQftGAyKlW/TKcNGCm9ytllq2IU
        YOBrHCMGrl1/Aj8YYdjT3xxL43+i
X-Google-Smtp-Source: ABdhPJx2MNni6KdpYtRmJzG0YV2Cu4Hp3iSLnwe8+K/6tx4RyKMJmmBsV6sg44/ELPdDrEBz4RT40w==
X-Received: by 2002:a1c:2e41:: with SMTP id u62mr19198176wmu.91.1590950173287;
        Sun, 31 May 2020 11:36:13 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d2d:7800:bd95:ecb6:e9e3:ecd3])
        by smtp.gmail.com with ESMTPSA id h1sm9849991wme.42.2020.05.31.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 11:36:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Chucheng Luo <luochucheng@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc: zh_CN: use doc reference to resolve undefined label warning
Date:   Sun, 31 May 2020 20:35:56 +0200
Message-Id: <20200531183556.5751-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation generation warns:

  Documentation/translations/zh_CN/filesystems/debugfs.rst:5:
  WARNING: undefined label: debugfs_index

Use doc reference for files rather than introducing a label to refer to.
This resolves the warning above.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jonathan, please pick this quick warning fix.

applies on your doc-next and next-20200529

 Documentation/translations/zh_CN/filesystems/debugfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
index f8a28793c277..822c4d42fdf9 100644
--- a/Documentation/translations/zh_CN/filesystems/debugfs.rst
+++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/filesystems/debugfs.txt <debugfs_index>`
+:Original: :doc:`../../../filesystems/debugfs`
 
 =======
 Debugfs
-- 
2.17.1

