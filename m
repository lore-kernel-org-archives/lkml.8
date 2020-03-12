Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092BFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD90920716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCLW2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:28:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38476 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgCLW2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:28:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 999851A11AB;
        Thu, 12 Mar 2020 23:28:39 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DB571A11BA;
        Thu, 12 Mar 2020 23:28:39 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id C7CA840A63;
        Thu, 12 Mar 2020 15:28:38 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 0/6] Fix sparse warnings for common qe library code
Date:   Thu, 12 Mar 2020 17:28:21 -0500
Message-Id: <20200312222827.17409-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QE code was previously only supported on big-endian PowerPC systems
that use the same endian as the QE device.  The endian transfer code is
not really exercised.  Recent updates extended the QE drivers to
little-endian ARM/ARM64 systems which makes the endian transfer really
meaningful and hence triggered more sparse warnings for the endian
mismatch.  Some of these endian issues are real issues that need to be
fixed.

While at it, fixed some direct de-references of IO memory space and
suppressed other __iomem address space mismatch issues by adding correct
address space attributes.

Li Yang (6):
  soc: fsl: qe: fix sparse warnings for qe.c
  soc: fsl: qe: fix sparse warning for qe_common.c
  soc: fsl: qe: fix sparse warnings for ucc.c
  soc: fsl: qe: fix sparse warnings for qe_ic.c
  soc: fsl: qe: fix sparse warnings for ucc_fast.c
  soc: fsl: qe: fix sparse warnings for ucc_slow.c

 drivers/soc/fsl/qe/qe.c        |  4 ++--
 drivers/soc/fsl/qe/qe_common.c |  2 +-
 drivers/soc/fsl/qe/qe_ic.c     |  2 +-
 drivers/soc/fsl/qe/ucc.c       |  2 +-
 drivers/soc/fsl/qe/ucc_slow.c  | 33 +++++++++++++--------------------
 include/soc/fsl/qe/ucc_fast.h  |  6 +++---
 include/soc/fsl/qe/ucc_slow.h  | 13 ++++++-------
 7 files changed, 27 insertions(+), 35 deletions(-)

-- 
2.17.1

