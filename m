Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9966720728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgDXQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:53:49 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:53729 "EHLO
        8.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:53:49 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2020 12:53:48 EDT
Received: from player711.ha.ovh.net (unknown [10.108.42.145])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8D3A3164F86
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:35:38 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player711.ha.ovh.net (Postfix) with ESMTPSA id 676CC1196D5C9;
        Fri, 24 Apr 2020 15:35:30 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Jonathan Corbet <corbet@lwn.net>, devel@lists.orangefs.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: orangefs: fix pvfs2tab literal block
Date:   Fri, 24 Apr 2020 17:35:15 +0200
Message-Id: <20200424153515.134500-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 525232308669205942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a merge fix-up, the literal block is introduced too early;
this patch merges the localhost mention with the introduction, fixing

	Documentation/filesystems/orangefs.rst:124: WARNING: Literal block expected; none found.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/filesystems/orangefs.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/filesystems/orangefs.rst b/Documentation/filesystems/orangefs.rst
index e41369709c5b..463e37694250 100644
--- a/Documentation/filesystems/orangefs.rst
+++ b/Documentation/filesystems/orangefs.rst
@@ -119,9 +119,7 @@ it comes to that question::
 
     /opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
 
-Create an /etc/pvfs2tab file::
-
-Localhost is fine for your pvfs2tab file:
+Create an /etc/pvfs2tab file (localhost is fine)::
 
     echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
 	/etc/pvfs2tab
-- 
2.25.3

