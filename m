Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDBAC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463C821734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBMWfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:35:03 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:41276 "EHLO
        9.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMWfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:35:03 -0500
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 17:35:02 EST
Received: from player715.ha.ovh.net (unknown [10.108.42.192])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 64A3D903E6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:47:55 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id E5037F2A64BB;
        Thu, 13 Feb 2020 17:47:44 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 0/6] docs: sysctl/kernel.rst rework
Date:   Thu, 13 Feb 2020 18:46:55 +0100
Message-Id: <20200213174701.3200366-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10073144994123304325
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekkedruddvvddruddviedrudduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A recent discussion about differences in the "panic" description in
sysctl/kernel.rst led me to look into completing that file, and it
turned out that more work was needed than documenting "panic". This
patch series is the first batch, making the resulting documentation
hopefully nicer and more accurate. It doesn't add fields that are
present in 5.5 but not documented, that's the subject of another
series of patches I haven't started working on yet...

Regards,

Stephen


Stephen Kitt (6):
  docs: pretty up sysctl/kernel.rst
  docs: merge debugging-modules.txt into sysctl/kernel.rst
  docs: drop l2cr from sysctl/kernel.rst
  docs: add missing IPC documentation in sysctl/kernel.rst
  docs: document stop-a in sysctl/kernel.rst
  docs: document panic fully in sysctl/kernel.rst

 Documentation/admin-guide/sysctl/kernel.rst | 1026 ++++++++++---------
 Documentation/debugging-modules.txt         |   22 -
 2 files changed, 530 insertions(+), 518 deletions(-)
 delete mode 100644 Documentation/debugging-modules.txt


base-commit: 359c92c02bfae1a6f1e8e37c298e518fd256642c
-- 
2.24.1

