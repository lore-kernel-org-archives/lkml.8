Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FCC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D93F2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883309;
	bh=KYgrRzJZ+v2MtmRgRhrMiVbwLP4xnRRe17npBnjIDz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xBCdSxXTsMz66EEyfZ77WcGdQXG4mTGu2lKEXWsWGChyMiAA0gckYN1B4IWH2zBfH
	 8fo3It7ePS+R0PwA9ZMd/cZi4T8eJoqDr+SD7vxsmwPzrb9tc1oOumOPMj5aJsrYTt
	 Xvp5X5pWfsCAWpsitwfN31Z6p1hB1g3plOWTkOTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391889AbgDNQzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440310AbgDNQtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B32821D7D;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=KYgrRzJZ+v2MtmRgRhrMiVbwLP4xnRRe17npBnjIDz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrw1GkKImF+CJjoYQO64+lyjCRGbzBnAJdiZJnXz3MLlaIEai9d5D+x61La8eui84
         Mn7afwUKcHvDhCveuOuX9GUTSPDb8de72sPmYQ48eWNMaCANeMG/8Bb9VC1LOFsTUy
         znXe0jBKMpDaxLZQt91H0eLYd9XsbHFnJGRqMxMs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068ma-84; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 21/33] docs: mm: userfaultfd.rst: use a cross-reference for a section
Date:   Tue, 14 Apr 2020 18:48:47 +0200
Message-Id: <f46b45f1aaec233217f2e0b0438bbd8cc16fe17b.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using "foo", let's use `foo`_, with is a ReST way of
saying that foo is a section of the document. With that, after
building the docs, an hyperlink is generated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 740d111faf1c..0bf49d7313ad 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -79,7 +79,7 @@ or shared memory need to set the corresponding flag in
 If the userland desires to receive notifications for events other than
 page faults, it has to verify that ``uffdio_api.features`` has appropriate
 ``UFFD_FEATURE_EVENT_*`` bits set. These events are described in more
-detail below in "Non-cooperative userfaultfd" section.
+detail below in `Non-cooperative userfaultfd`_ section.
 
 Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
 be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
-- 
2.25.2

