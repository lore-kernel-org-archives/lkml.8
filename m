Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A1DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE74921D80
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670917;
	bh=hi1aczpcTujPkeB1XjLIT9pw1YvDNzWxbCRXWh+zmzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uScbvS8PitysxsRRN3lhLFxf7oREzg5N+Qu4emJvxoKTlz2nydWcnUpmB3EYbSDIZ
	 6rJHeglZ3QZQmDljFlSIi3fYnlL+eJIkdkvAx2ARWJsISPG9JjrEY8eEFhRozjTOHB
	 se/FUz1rQGthwTpMWz4Bk0vn0LmIpAodfZAP0mOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgIIRBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbgIIPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:50 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F18222246;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=hi1aczpcTujPkeB1XjLIT9pw1YvDNzWxbCRXWh+zmzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PAOPNSU7PZLRYcxfKYvB6irFXTnLKl4yDt4ElhNaFw5wkAlcG+iuAQRNH5/eZF33m
         Bnee4+mzj+gSc5XZTe8tG1zUFTHkV4EFZuno5Jo77PCiPis5xvkTlI12K9q5kpjkP5
         6GhYI7BH8CygUJ5tkt4YoCd7BceJdY/4/vCcvHK0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXh-OS; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] docs: admin-guide: net.rst: add a missing blank line
Date:   Wed,  9 Sep 2020 16:10:56 +0200
Message-Id: <6207e85187596f1de4f178414f741965e32f4b7d.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing blank line after a literal block, which
causes this warning:

	Documentation/admin-guide/sysctl/net.rst:303: WARNING: Literal block ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/net.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 57fd6ce68fe0..f2ab8a5b6a4b 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -300,6 +300,7 @@ Note:
       0:    0     1     2     3     4     5     6     7
   RSS hash key:
   84:50:f4:00:a8:15:d1:a7:e9:7f:1d:60:35:c7:47:25:42:97:74:ca:56:bb:b6:a1:d8:43:e3:c9:0c:fd:17:55:c2:3a:4d:69:ed:f1:42:89
+
 netdev_tstamp_prequeue
 ----------------------
 
-- 
2.26.2

