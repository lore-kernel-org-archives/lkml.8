Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EE82080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598438867;
	bh=2ybAv5AUSr/9AXTd/F5iA77kKZOVn7+1fkhHLl5o5j4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hxKdSRCttVVlG78R+Kzb8DuFL/g7AYM30x1AFSGhaIPGznXnjRoWNMQ7tHfCnXIXP
	 KSvcaNVbD2raaNRnHUEm7m93KsWa5rYajYkblHq0DGJATKTSrdtZDHCXWlQQCBCzfZ
	 ODzL6YHbZvppR3ilt47/lUl+aav1adp3GIAAA4No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHZKrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgHZKrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:24 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079EA206EB;
        Wed, 26 Aug 2020 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438844;
        bh=2ybAv5AUSr/9AXTd/F5iA77kKZOVn7+1fkhHLl5o5j4=;
        h=From:To:Cc:Subject:Date:From;
        b=MEw8i8+AnDWFoShsQ20g8fvsaagnyPejp2BcBcuctumA4TE4wz+ecIwukfqa+mZvh
         73oBQcG3usuXOgcDSF5pFzeZT8MJzY0DUiYLN4atiT8gFsYIgxzvR00VHpNq7Jr5y6
         W48FBO8asdFRXpOV/ohOqvxqQNq2iUFZFW6eZ/is=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxd-002Dtj-VP; Wed, 26 Aug 2020 12:47:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: scheduler: fix the directory name on two files
Date:   Wed, 26 Aug 2020 12:47:20 +0200
Message-Id: <20200826104720.530040-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the directory where the schedule docs are
stored are wrong on those files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scheduler/sched-capacity.rst | 2 +-
 Documentation/scheduler/sched-energy.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 00bf0d011e2a..9b7cbe43b2d1 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -365,7 +365,7 @@ giving it a high uclamp.min value.
 .. note::
 
   Wakeup CPU selection in CFS can be eclipsed by Energy Aware Scheduling
-  (EAS), which is described in Documentation/scheduling/sched-energy.rst.
+  (EAS), which is described in Documentation/scheduler/sched-energy.rst.
 
 5.1.3 Load balancing
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 78f850778982..001e09c95e1d 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -331,7 +331,7 @@ asymmetric CPU topologies for now. This requirement is checked at run-time by
 looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
 domains are built.
 
-See Documentation/sched/sched-capacity.rst for requirements to be met for this
+See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
 flag to be set in the sched_domain hierarchy.
 
 Please note that EAS is not fundamentally incompatible with SMP, but no
-- 
2.26.2

