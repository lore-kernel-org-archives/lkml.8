Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F226A22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598512936;
	bh=xqpEWCNUHC36j728axPvEzv4x72zk9bh91GMKmUqGRg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xJwmTw7ODhAJs09fW4R0dzxPFZxGOxPuphoiL7PVIcMPDBwYadCoIEZxldWo25TNw
	 4c2aTiFfRDz2cqyuQzqProu6IPlemHXDk1Y7DSsDuLJkjMvXND23HWtHBXBqaBieT/
	 t/JriW738Hki296qfGEX57SQyPWjoCkf40FTwHqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgH0HWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgH0HVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:21:52 -0400
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F19322BEA;
        Thu, 27 Aug 2020 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598512912;
        bh=xqpEWCNUHC36j728axPvEzv4x72zk9bh91GMKmUqGRg=;
        h=From:To:Cc:Subject:Date:From;
        b=GBFFMVA9Yi9eVLz+FfgGXh8a2EbChvc6bg/FWEn5JZ3Y0EXKC2ceVCb+59caB53ta
         XxZ4B+r5agRbEce4vUdZCGco9XI7yR9tcJjGyHEtxY+pxR3PZUc1fYdXeMERwAG8wN
         AMBjNd/tqeiqnpdcGLuuYwlGBAAxIQ6GFB6B44Yg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kBCEI-002s5B-6T; Thu, 27 Aug 2020 09:21:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v10 0/4] Add a glossary for the media subsystem
Date:   Thu, 27 Aug 2020 09:21:44 +0200
Message-Id: <cover.1598512802.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are too many technical terms at the media subsystem, and sometimes
the same thing is refered differently at the documentation and on the ML
and IRC discussions.

Let's add a glossary to the uAPI documentation, in order to start using
a common vocabulary at the subsystem's discussion and to let things
clearer for people trying to understand the subsystem.

I'm pretty sure that this document doesn't cover everything, but it can
(and should) be improved overtime.

On version 10, I addressed the comments from Hans (minor adjustments
and typos). Also, two patches were folded together.

Mauro Carvalho Chehab (4):
  media: open.rst: better document device node naming
  media: open.rst: remove the minor number range
  media: docs: add glossary.rst with common terms used at V4L2 spec
  media: open.rst: document mc-centric and video-node-centric

 .../userspace-api/media/glossary.rst          | 216 ++++++++++++++++++
 Documentation/userspace-api/media/index.rst   |   3 +
 .../userspace-api/media/v4l/open.rst          | 110 +++++++--
 3 files changed, 315 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/userspace-api/media/glossary.rst

-- 
2.26.2


