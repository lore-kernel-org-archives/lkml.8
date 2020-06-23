Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78248206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896231;
	bh=qEGJr5QDKWsCILpk5nSvbtWGYk438RJ2eoAVE6k9gr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eC4WlXf7Z7xFF7U/+MlJsA9SAog3qK/Sic7uTInReacLURQSXgjzstO9X6ajlhNZc
	 6ES0abfxYrBekU3gc/yFhGFkA2jNudfx+Z6qi7QCT26rbOL266P7f/BhDNtDR8mRAw
	 udWPPqbBA6pcOBniV+f6S1WWnUp5AlZ99kxQaYRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbgFWHKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730998AbgFWHJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:15 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0EB20774;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=qEGJr5QDKWsCILpk5nSvbtWGYk438RJ2eoAVE6k9gr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egMU6jAhlJDCoNWAUbozx5KHdM0Fwma76H+2+eIk0+tXkycp1OHSwfyx3Us58QxO6
         V0YMC4Yl2HecP2OoBssCCXWpRYHVsCdTpRe9ltdaApZz6qUmXFiYb9rA6pg1Y53wl0
         FySy1zIxnLeKm1FxHcbcL3RRiGVNLKAS8ni6jpyQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qjC-6o; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: [PATCH v2 08/15] kcsan: fix a kernel-doc warning
Date:   Tue, 23 Jun 2020 09:09:04 +0200
Message-Id: <20f7995fab2ba85ce723203e9a7c822a55cca2af.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the kernel-doc markups there have two "note" sections:

	./include/linux/kcsan-checks.h:346: warning: duplicate section name 'Note'

While this is not the case here, duplicated sections can cause
build issues on Sphinx. So, let's change the notes section
to use, instead, a list for those 2 notes at the same function.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 7b0b9c44f5f3..c5f6c1dcf7e3 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -337,11 +337,13 @@ static inline void __kcsan_disable_current(void) { }
  *		release_for_reuse(obj);
  *	}
  *
- * Note: ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
- * checking if a clear scope where no concurrent accesses are expected exists.
+ * Note:
  *
- * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
- * fit to detect use-after-free bugs.
+ * 1. ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
+ *    checking if a clear scope where no concurrent accesses are expected exists.
+ *
+ * 2. For cases where the object is freed, `KASAN <kasan.html>`_ is a better
+ *    fit to detect use-after-free bugs.
  *
  * @var: variable to assert on
  */
-- 
2.26.2

