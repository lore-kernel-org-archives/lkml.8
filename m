Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC50BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF1F20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbgFWQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:11:47 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:57267 "EHLO
        7.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFWQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:11:46 -0400
X-Greylist: delayed 16198 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2020 12:11:45 EDT
Received: from player729.ha.ovh.net (unknown [10.108.54.9])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id A8FAC16E57F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:25:29 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player729.ha.ovh.net (Postfix) with ESMTPSA id F331413CA8325;
        Tue, 23 Jun 2020 11:25:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006ec57e60d-c50f-47ce-902b-8d6c55eb38f1,D7C09D202404919884AD844CAC4983D4C4BCB1F3) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: sysctl/kernel: document random
Date:   Tue, 23 Jun 2020 13:25:14 +0200
Message-Id: <20200623112514.10650-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16620815902375103877
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekhedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the random directory, based on the behaviour seen in
drivers/char/random.c.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6d96f17b74a4..5f432f51f23e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -996,6 +996,38 @@ pty
 See Documentation/filesystems/devpts.rst.
 
 
+random
+======
+
+This is a directory, with the following entries:
+
+* ``boot_id``: a UUID generated the first time this is retrieved, and
+  unvarying after that;
+
+* ``entropy_avail``: the pool's entropy count, in bits;
+
+* ``poolsize``: the entropy pool size, in bits;
+
+* ``urandom_min_reseed_secs``: obsolete (used to determine the minimum
+  number of seconds between urandom pool reseeding).
+
+* ``uuid``: a UUID generated every time this is retrieved (this can
+  thus be used to generate UUIDs at will);
+
+* ``write_wakeup_threshold``: when the entropy count drops below this
+  (as a number of bits), processes waiting to write to ``/dev/random``
+  are woken up.
+
+If ``drivers/char/random.c`` is built with ``ADD_INTERRUPT_BENCH``
+defined, these additional entries are present:
+
+* ``add_interrupt_avg_cycles``: the average number of cycles between
+  interrupts used to feed the pool;
+
+* ``add_interrupt_avg_deviation``: the standard deviation seen on the
+  number of cycles between interrupts used to feed the pool.
+
+
 randomize_va_space
 ==================
 

base-commit: 46e906144c3f4b0a7b6dcc7713fafad65b1859e0
-- 
2.20.1

