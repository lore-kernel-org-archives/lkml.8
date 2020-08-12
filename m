Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84664C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB6220838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247879;
	bh=LpI7CPhlAdoRLmDUn7wNA8GzncD0FgN2SN8GD26o+lI=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=erwCrthb2yauFwYlq3leN7HX5QPpHcKtnComlvXWFdhRuWQp/kPu/X/kTRBxloV3O
	 MYWcvCrIbjCCMvu7hZ0DWn8gI9OizujLeh885neT4MZ56VT+9JgRWAowdng6GQPDGx
	 4E7y8LegtDqG2YLwh0Jf9+H35++cTgraPKlvk2BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHLP55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgHLP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9A623106;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=LpI7CPhlAdoRLmDUn7wNA8GzncD0FgN2SN8GD26o+lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiwUdwqxPPvBVbN01cXUlo6M07sa/l/VLjU/1QtsxNzFRkVxQ4lFJD937mHVQ3O0M
         16TgPCIGpxcjfXk7RZZ0kZS7qXAXDeAX8Lh37kczJ6XZzol5uANf27omSZ7LIH6fFT
         kWbW6iNsPamTyac5DsQr5TPvQDdDjttjCLLKYbMo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7U-Dz; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 41/44] staging: hikey9xx: add a TODO list
Date:   Wed, 12 Aug 2020 17:56:51 +0200
Message-Id: <b022b37ec7f3012019e9b8dcd0adda25875c0682.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the things that are needed to be able to move those
drivers out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/TODO | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 drivers/staging/hikey9xx/TODO

diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
new file mode 100644
index 000000000000..65e7996a3066
--- /dev/null
+++ b/drivers/staging/hikey9xx/TODO
@@ -0,0 +1,5 @@
+ToDo list:
+
+- Port other drivers needed by Hikey 960/970;
+- Test drivers on Hikey 960;
+- Validate device tree bindings.
-- 
2.26.2

