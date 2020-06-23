Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185F9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B17206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896215;
	bh=Gw7wbqH2xsyBdC3kf/3jqvxF7UQqM1IL2xDyERsgPCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvugn/6xrOfyQ3Z8GF7fyFkpyOMYv1ucOd/77pynsPDSreTolAUsMMU8+gdRj/Qzs
	 Wu3BuYdriWn9QoFGceRVz8c8UJFfNMukSekmnj58FRHcut2HcZuM7EVjyj/Ey1QRWR
	 bN2tPeyysIawJEZcLskZ87hVop0Y+XbIF6kbaoZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgFWHKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731143AbgFWHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:16 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF802077D;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=Gw7wbqH2xsyBdC3kf/3jqvxF7UQqM1IL2xDyERsgPCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELP20hEP5skyojgUNa0qnyK4510HtscKXjQ8mbOxe+vq3STHudKBJ5FuSH7bVAbhx
         tTz6JeiRunOUMGsPD7NysbXVX8oIw4J4eBNHYZdrWpOVXoPss9P5E2/sPxp9bkydvY
         0A+Tx8041eAeJPb3453/Z69gB+d9ccXu+C0cS87g=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qjV-C8; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 12/15] docs: driver-model: remove a duplicated markup at driver.rst
Date:   Tue, 23 Jun 2020 09:09:08 +0200
Message-Id: <52c65b4ebca1262f80d8939e2027358f9b476f00.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "::" markup is there twice, causing a warning:

    Documentation/driver-api/driver-model/driver.rst:233: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/driver-model/driver.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
index 7d5040f6a3d8..06f818b1d622 100644
--- a/Documentation/driver-api/driver-model/driver.rst
+++ b/Documentation/driver-api/driver-model/driver.rst
@@ -228,8 +228,6 @@ over management of devices from the bootloader, the usage of sync_state() is
 not restricted to that. Use it whenever it makes sense to take an action after
 all the consumers of a device have probed::
 
-::
-
 	int 	(*remove)	(struct device *dev);
 
 remove is called to unbind a driver from a device. This may be
-- 
2.26.2

