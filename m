Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B0AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AFC2065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTKeuYMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgGHMC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgGHMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FEC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so2716281wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEuQ0isQDZs4z6XMYzEe+OOf6ezHgXSzxswYMqwj6a4=;
        b=kTKeuYMJiUQcuxilaT9rXVewbfHw8SfFhgcTG5QDP5p55FBn3j+/Pt2Tj5AQaT3mNc
         jOHmQaoGDGfsJQ7GhFxVBNMbIRp48CHrWPdDJjSOrsmfHMY3rp3a+sYtj6oPuoliZzMw
         WNdJypkf/t9nRJ9RERASarhQ3shh6G4z4rYN8VOdDhzpbXAQ3XW3fwHDjwE+9wprv0mN
         eMWQxXxUveuWUoNRWcSvVwZF7qWOU7WC4yq4xifQoyuQ64upmvixE8vkN6ml+AKb1b8p
         /ut5TfdlDFd1bQy4JqQK+pkath1zDxsYycX1/Re8MuRMhyan3ul2cXdcWYmeWryt3LQs
         qO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEuQ0isQDZs4z6XMYzEe+OOf6ezHgXSzxswYMqwj6a4=;
        b=cb42jOZD2PF4JdfqAIVgAoQDeEentuy5rMTBWx7NvX0/3/AMqPxqKlLfndv2WBB904
         e7LEIS686uMEaJQDXeNDw18R8e6U+R+94ioj4uh0GoidRtgaRmLmIt5pzozzGSiCHdHW
         yA8SLBAjydTvRRKbdUceIi4cx9vOhEEUG3glO+9iPGbvnpr7pp4pUqyJm+bfig9e6wjh
         +rKXEzns7vcWR/nnonLoyfd2ohreJpvkAaytfU+whJixGGL73NvhSbdtuxrTvVr1i1N7
         xEP4q7Vchiws/wfUvPXTZGZrVu/vPqtDfs1CtMrdfiAlYm8/41nrqxVU34FPnA1gkF7G
         fx3A==
X-Gm-Message-State: AOAM532+mP5QLtWrqCP975m+uzq1L0dF4KsSmpDaErSLOs6vRTEy55vs
        MJ/x4ZoJqUV5F/MRownafyGF8zQy0Zw=
X-Google-Smtp-Source: ABdhPJx73gz4OHGK9q9TrCi5i7d6kqBovv7MtsV5YduvjgG7QbypnkpYq6Vk4YcwDOzaOFFX/3WtxQ==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr9786555wmg.68.1594209744661;
        Wed, 08 Jul 2020 05:02:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/30] Fix a bunch more SCSI related W=1 warnings
Date:   Wed,  8 Jul 2020 13:01:51 +0100
Message-Id: <20200708120221.3386672-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Slowly working through the SCSI related ones.  There are many.

Lee Jones (30):
  scsi: libfc: fc_exch: Supply some missing kerneldoc struct/function
    attributes/params
  include: scsi: scsi_transport_fc: Match HBA Attribute Length with
    HBAAPI V2.0 definitions
  scsi: libfc: fc_disc: trivial: Fix spelling mistake of 'discovery'
  scsi: fcoe: fcoe: Fix various kernel-doc infringements
  scsi: fcoe: fcoe_ctlr: Fix a myriad of documentation issues
  scsi: fcoe: fcoe_transport: Correct some kernel-doc issues
  scsi: bnx2fc: bnx2fc_fcoe: Repair a range of kerneldoc issues
  scsi: qedf: qedf_main: Demote obvious misuse of kerneldoc to standard
    comment blocks
  scsi: qedf: qedf_main: Remove set but not checked variable 'tmp'
  scsi: libfc: fc_lport: Repair function parameter documentation
  scsi: libfc: fc_rport: Fix a couple of misdocumented function
    parameters
  scsi: libfc: fc_fcp: Provide missing and repair existing function
    documentation
  scsi: libfc: fc_rport: Fix bitrotted function parameter and copy/paste
    error
  scsi: bnx2fc: bnx2fc_hwi: Fix a couple  of bitrotted function
    documentation headers
  scsi: arcmsr: arcmsr_hba: Remove some set but unused variables
  scsi: arcmsr: arcmsr_hba: Make room for the trailing NULL, even if it
    is over-written
  scsi: qedf: qedf_io: Remove a whole host of unused variables
  scsi: bnx2fc: bnx2fc_tgt: Demote obvious misuse of kerneldoc to
    standard comment blocks
  scsi: aic7xxx: aic7xxx_osm: Remove unused variable 'tinfo'
  scsi: aic7xxx: aic7xxx_osm: Remove unused variable 'ahc'
  scsi: aic7xxx: aic7xxx_osm: Remove unused variable 'targ'
  scsi: aic7xxx: aic7xxx_osm: Fix 'amount_xferred' set but not used
    issue
  scsi: qedf: qedf_debugfs: Demote obvious misuse of kerneldoc to
    standard comment blocks
  scsi: aacraid: linit: Provide suggested curly braces around empty body
    of if()
  scsi: aacraid: linit: Fix a couple of small kerneldoc issues
  scsi: aic94xx: aic94xx_init: Demote seemingly unintentional kerneldoc
    header
  scsi: pm8001: pm8001_init: Demote obvious misuse of kerneldoc and
    update others
  scsi: aic94xx: aic94xx_hwi: Repair kerneldoc formatting error and
    remove extra param
  scsi: aacraid: aachba: Fix a bunch of function doc formatting errors
  scsi: qla4xxx: ql4_init: Provide a missing function param description
    and fix formatting

 drivers/scsi/aacraid/aachba.c       | 17 +++-------------
 drivers/scsi/aacraid/linit.c        |  6 +++---
 drivers/scsi/aic7xxx/aic7xxx_osm.c  | 13 ++----------
 drivers/scsi/aic94xx/aic94xx_hwi.c  |  3 +--
 drivers/scsi/aic94xx/aic94xx_init.c |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c    | 31 ++++++++++++-----------------
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c   | 18 ++++++++---------
 drivers/scsi/bnx2fc/bnx2fc_hwi.c    |  6 +++---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c    |  7 +++----
 drivers/scsi/fcoe/fcoe.c            | 10 ++++------
 drivers/scsi/fcoe/fcoe_ctlr.c       | 26 ++++++++++++------------
 drivers/scsi/fcoe/fcoe_transport.c  |  4 +++-
 drivers/scsi/libfc/fc_disc.c        |  2 +-
 drivers/scsi/libfc/fc_exch.c        |  7 ++++++-
 drivers/scsi/libfc/fc_fcp.c         | 11 ++++++----
 drivers/scsi/libfc/fc_lport.c       |  7 +++++--
 drivers/scsi/libfc/fc_rport.c       |  4 ++--
 drivers/scsi/pm8001/pm8001_init.c   | 30 ++++++++++++++--------------
 drivers/scsi/qedf/qedf_debugfs.c    | 18 ++++++++---------
 drivers/scsi/qedf/qedf_io.c         | 30 ++++------------------------
 drivers/scsi/qedf/qedf_main.c       | 10 ++++------
 drivers/scsi/qla4xxx/ql4_init.c     |  7 ++++---
 include/scsi/fc/fc_ms.h             |  4 ++--
 23 files changed, 115 insertions(+), 158 deletions(-)

-- 
2.25.1

