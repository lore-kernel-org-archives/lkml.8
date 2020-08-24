Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB12120702
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvPXFyii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHXVo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:44:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ECBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:44:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so11393031ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQGMDLgnQcZfCXtlBfQxFvlPhHCw4gBNVdghbltUFKI=;
        b=qvPXFyiiYLjL0OnYlRaR9GDjFDX6AiC7aEEDE1rnd6KnnoTKDTpuxAGNpcUMcTPNsI
         1gu3Ofi2/lxBJdZbwd/m/s0ZnERd7m9LRu7Il7zT19EhsYhoI0GEl0x4pSahHKYDqFMm
         LFU4qcP/zgO5a4z1mYSECe2w9s/q8YebpTWpgdpm6zqgCCtGfHgkNGMQnosbX5V/E1AN
         Ym51CUon6FkJDJJEr7+q2bGynfxeCuheU1FYe+0qJwRLutIb7jnaeb27RrARAYBajzLJ
         XmC3+O1u4CFz/FjvDgge4vK8REdhNfz6Fkiuk8G1kVDK580eIEWubgqgOPpij8X5PRVT
         xgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQGMDLgnQcZfCXtlBfQxFvlPhHCw4gBNVdghbltUFKI=;
        b=dQ10kpCKpCcPWdeHXofzyM2lcDJ14vesxZGYon81LYStLVJaMj9OfVmrt6M1f5fYzi
         I56mlHJFyjEFQqukqeDVIhk6S8qjyvdx3JRxl7l/zROEyGzw/GvZyAMArK0NvgfSUCPF
         PAKZxQvEW2PoUZX1mMHEKF32ZG/uUM5hZ4Gmo9URZN74wccLqvUNUrlrmAzjaTVNoz4v
         MzQtG5axOMtTpNPIswTbUBo11bpf/lDvi2j2un+ed12TkWR3AwlMraPldzXZkEZoKADl
         Fl8c/OvQQbDkOzl39D0rd5N1LhPN9puPy94s/Hy+nwZF8BX+B1qgIYghiQGlzvQ1W26L
         EQ7g==
X-Gm-Message-State: AOAM5320Xb1RuIpVLUN/M2PWWDRCwsDBLN4Soy/qBNFBzItWYEmhgd8S
        6eAZEanyggg2g9tcoc0EQ6E=
X-Google-Smtp-Source: ABdhPJxWLT04cLFqvdj1mZDGf1Au/fOfCDj5CY+3tAAV6bRyvi2qoUJDDZnZuLUmyFA6+qD11VPAfA==
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3335890lji.314.1598305461169;
        Mon, 24 Aug 2020 14:44:21 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id l18sm2564366lfc.27.2020.08.24.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:44:20 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] const_structs.checkpatch: Add phy_ops
Date:   Mon, 24 Aug 2020 23:41:32 +0200
Message-Id: <20200824214132.9072-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usages of phy_ops in include/linux uses const phy_ops * and all
instances of phy_ops in the kernel that are not const already can be
made const (patches have been posted for those separately).

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
See [1] for a patch series constifying the remaining non-const phy_ops.

[1] https://lore.kernel.org/lkml/20200823220025.17588-1-rikard.falkeborn@gmail.com/

 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index e9df9cc28a85..cd45cb3c2b04 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -39,6 +39,7 @@ nlmsvc_binding
 nvkm_device_chip
 of_device_id
 pci_raw_ops
+phy_ops
 pipe_buf_operations
 platform_hibernation_ops
 platform_suspend_ops
-- 
2.28.0

