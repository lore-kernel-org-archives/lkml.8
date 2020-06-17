Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49975C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F57820B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTGU0GET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgFQWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgFQWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:32:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D8C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so4867208ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xn0hiQ3wOKNLF/so5eHDNbh4ekPAxqF2ZShnXBOeCAY=;
        b=MTGU0GETtPXN8nsCqz6Dv6hA7VLMbwgkdjohHcLvZm9NkUncY6UgZuHQ0NUhFl0/Bc
         yFQ+euftunyoIw45xk8SjxOUSV0o6t0SG1Kut+KsA8kqrDBJ2HtjY0t+FBXquc96lZqS
         VqTsm42x25rJ7GmpMA7VC51JgW4ZWfgxFDezSlf96LlBq2uBPZK5fYpfViF1lhTpPncG
         IrRjqugK6gIxgxfx6dSmqHFVoYBNDPb0PKjSx+96L8Qqm1iUK1C2ECM//66emrtCCDOz
         HNiCi29opDIbRj2wmOU0jQY8kdDBiZu7jrrAef0/atc562vJEhuSGLTg4DoMYEbuwwhB
         7P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xn0hiQ3wOKNLF/so5eHDNbh4ekPAxqF2ZShnXBOeCAY=;
        b=ZOoBAwA3aEpNcgrwCstlhutEKRnHDj+EKhLfXNEYcrnYGyjam99vgr+QMuyIYg4Kbe
         SHVNi/wFd4b6gCkpoIC4QM0bhE/L61f4OPIRFCEN2/N9TNfnXIyovjXh8mdz+YcWBjAu
         VLlTer8eZLq26FJaPLCk0OvpXVeAVwXfvr8Pyu09CD0F6xgLFUGnuUjUWJ3Ux+mnaTYq
         pA7NDf6CZ8RLld6cB75o4n2Lw7lhzY6mRsKf3KDP0r5WPQtgGKEueF1JTyckYodfRjRO
         W3d4dV6rgyhMMM8uLW4u6yypUubALR82ZdKEcfHtgOX9+1foozj0aT5kTPtCcy0G2iR/
         E9iA==
X-Gm-Message-State: AOAM531QbxBu1mEL0kDTyU4y0tzS/wUyN4592GqdBnX0bVotib2yrhnK
        Lj4g2PFnadKXB6H9Ei/Y0IU=
X-Google-Smtp-Source: ABdhPJzV/Kjo7Q6UVTeRF8pxqJwGYjI/doG085L6jvkZMXWt3CIGY3FhRSy83dnjZnkFQt6jfE3BBg==
X-Received: by 2002:a2e:8110:: with SMTP id d16mr761904ljg.12.1592433174511;
        Wed, 17 Jun 2020 15:32:54 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id 203sm226079lfh.19.2020.06.17.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:32:53 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/5] regulator: Constify some static struct variables
Date:   Thu, 18 Jun 2020 00:32:42 +0200
Message-Id: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify some static struct variables to allow the compiler to put them
in read-only memory. There are more of these, but I figured I could
start small. Also, is one patch per driver a good resolution or too
fine-grained?

Rikard Falkeborn (5):
  regulator: anatop: Constify anatop_core_rops
  regulator: cpcap: Constify cpcap_regulator_ops
  regulator: ltc3676: Constify ltc3676_regulators
  regulator: max8907: Constify static structs
  regulator: max8997: Constify struct regulator_ops

 drivers/regulator/anatop-regulator.c  |  2 +-
 drivers/regulator/cpcap-regulator.c   |  2 +-
 drivers/regulator/ltc3676.c           |  2 +-
 drivers/regulator/max8907-regulator.c |  6 +++---
 drivers/regulator/max8997-regulator.c | 14 +++++++-------
 5 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.27.0

