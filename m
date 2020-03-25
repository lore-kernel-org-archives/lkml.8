Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532BA20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj8sinew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCYJyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43308 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgCYJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:54:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id v23so603014ply.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/NYrQ5Nb270diTDzFJ+L0kNuyBm+yeaEX8X8C+1Apag=;
        b=aj8sinew6nIdVUkJwgQGDJhQiVwGka6OnfHJ53+z5eW8gMpeRibO9PV0Vwpuqoi780
         RM9vJC1zwcBwvZ99XYh5ohg1vMUBNfu1JVMiDr+jpaHtGir7c2G+YTv6zOCVyDAJV89K
         6PlmMW6C8QDBYO3UvMd5BcD6KkcsTQaE0yyyB6u8fVOv12exxzm+SGkMSuW4tdFRmuPm
         +9D7+XyG5kyWvItfDlEPX5uk47IEA4jvrLOIU8QPSm0iAZzpSoionHk6vePFrZ05e/He
         hCAI41GrhOBJ73VzgQzefwGqTAKiRgvlUDcfwvnr+beer4mk5uN+ncme0Ra0ShJO9owg
         LurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/NYrQ5Nb270diTDzFJ+L0kNuyBm+yeaEX8X8C+1Apag=;
        b=TiMqfgdEzMVwm8EiEppKej+5YLtmOzdpfo603TNDhY994dUl/ULnx56foWf3Ki40iz
         Mi3Fv4SFqxUKbufK3OABWUkJtosyFG08VBAUPmA+Qcbno7MlcjDe4G+VPKmUkXUu1+Cx
         XRD2exL18kB5N6e4yh2gELdasVd8U9fU2VzV68gg4MYzHLwVEv/UQKXxt6sszxUqTahz
         S4l4+Xai6Y97Ywzxc24f1WDI8EimbVT6VLvbVhGFHDNPmo2292bjUnBmHihcJD5bAKMo
         6DgvVTIkuqoOkj2Vhsumf78wl4v0U1HtANyShdH5D4efqoynRv7/PGmXMa8JvTNbJVgS
         bEBg==
X-Gm-Message-State: ANhLgQ1aZomEI6NEqqUgjh5e66VC73mZxlOaoqihEyRN4GPkr/6j1Gmc
        Mgl2NGIMGHRXQTa6n1nVYk8=
X-Google-Smtp-Source: ADFU+vvRGXRu0CV7DtzLSZpoYom710jnvxbX2PjNh+ccZLTCzj9zXqjsLNhrxx01Nt2nYV13ifT9Eg==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr2855334pjp.102.1585130053661;
        Wed, 25 Mar 2020 02:54:13 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id k4sm18907553pfh.0.2020.03.25.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:54:12 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:24:07 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, jeremy@azazel.net,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH v2] staging: kpc2000: Removing a blank line
Message-ID: <20200325095407.GA3788@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch warning by removing a blank
line.
CHECK: Please don't use multiple blank lines

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
Changes in v2:
  - Make the subject and commit message correct by mentioning that
    this patch specifically removes a blank line.

 drivers/staging/kpc2000/kpc2000/pcie.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/pcie.h b/drivers/staging/kpc2000/kpc2000/pcie.h
index cb815c30faa4..f1fc91b4c704 100644
--- a/drivers/staging/kpc2000/kpc2000/pcie.h
+++ b/drivers/staging/kpc2000/kpc2000/pcie.h
@@ -6,7 +6,6 @@
 #include "../kpc.h"
 #include "dma_common_defs.h"
 
-
 /*      System Register Map (BAR 1, Start Addr 0)
  *
  *  BAR Size:
-- 
2.17.1

