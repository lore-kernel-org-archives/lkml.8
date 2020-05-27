Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1095FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E1220835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgE0V5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:57:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49740 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgE0V5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:57:43 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D81951A0989;
        Wed, 27 May 2020 23:57:41 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F6DD1A0984;
        Wed, 27 May 2020 23:57:41 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id DE9AD40A5F;
        Wed, 27 May 2020 14:57:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.8)
Date:   Wed, 27 May 2020 16:57:40 -0500
Message-Id: <20200527215740.9279-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.8

for you to fetch changes up to e9e4ef9116b12951eaee3f8447ba9bbb40ab3620:

  soc: fsl: dpio: Remove unused inline function qbman_write_eqcr_am_rt_register (2020-05-22 18:11:03 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.8

DPAA2 DPIO driver
- Prefer the CPU affined DPIO

QUICC Engine drivers
- Replace one-element array and use struct_size() helper

Cleanups in various drivers

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: qe: clean up an indentation issue

Gustavo A. R. Silva (2):
      treewide: Replace zero-length array with flexible-array
      soc: fsl: qe: Replace one-element array and use struct_size() helper

Roy Pledge (1):
      soc: fsl: dpio: Prefer the CPU affine DPIO

YueHaibing (2):
      soc: fsl: qbman: Remove unused inline function qm_eqcr_get_ci_stashing
      soc: fsl: dpio: Remove unused inline function qbman_write_eqcr_am_rt_register

 drivers/soc/fsl/dpio/dpio-service.c   |  6 +++++-
 drivers/soc/fsl/dpio/qbman-portal.c   | 12 ------------
 drivers/soc/fsl/qbman/qman.c          |  5 -----
 drivers/soc/fsl/qe/qe.c               |  4 ++--
 drivers/soc/fsl/qe/ucc.c              |  2 +-
 include/linux/fsl/bestcomm/bestcomm.h |  2 +-
 include/soc/fsl/qe/qe.h               |  2 +-
 7 files changed, 10 insertions(+), 23 deletions(-)
