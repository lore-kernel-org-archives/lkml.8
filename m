Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B97C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D917207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OeSj0X5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgEQAMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 20:12:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14723 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgEQAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 20:12:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec080f50000>; Sat, 16 May 2020 17:10:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 16 May 2020 17:12:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 16 May 2020 17:12:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 17 May
 2020 00:12:49 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 17 May 2020 00:12:49 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec081810000>; Sat, 16 May 2020 17:12:49 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Brian Geffon <bgeffon@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] selftests/vm: minor fixes for 5.7-rc5
Date:   Sat, 16 May 2020 17:12:43 -0700
Message-ID: <20200517001245.361762-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589674231; bh=wjLchc1ui/FmZZGmSH4qpXauQ1u6/oTfmbDWbGbON98=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=OeSj0X5leaSJg3f79iy0ZeLoGjRgdDteo6AyD3A8EHQls2wigV+WF74VdY+ZRYfDP
         iWynlilWUwj4dYSSxrDCfw4AuqyqH6KKEOnODl96NQzfNNxpjKdbKu5d+vYSX65MJi
         SuorSMJ4eu+2Gn3uBTwPitYwkGeB1VhuPqeJuX911gmcuTZi3qPQapjRfgwTvTGDRI
         U4H7MjhF8qgsNxZIXxFh8PW0d7E4mlsRLuCmfTse1tgSU7GfxDQQ6QgyZ/lrwUck3w
         AavC4b5b/aV/Od1MouLHI3sl2lch21w7qDEP3mNuNAb9zV5rH0W/ubGmvf0a0egNi0
         mvCjTkVEOUySA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a couple of tiny fixes, just so we can cleanly build
selftests/vm. These apply to today's linux.git. Some merge notes:

* The .gitignore fix is appropriate for linux.git, but it is a subset of
  what's required for linux-next and mmotm. In order to fix things now
  in linux.git, and keep it fixed in mmotm and linux-next, but without
  manual intervention required in git merges, I'm adding the missing
  item ("mremap_dontunmap") to the *top* of .gitignore for this patch.
  And then I'll send a separate patch to be applied to mmotm and
  linux-next, that will also add a different item ("khugepaged") to the
  *bottom* of .gitignore.

* The write_to_hugetlbfs.c fix is already applied to linux-next, but
  doesn't seem to be getting picked up for linux.git. Maybe it's in
  the merge pipeline, but if not, let's fix it here, before the -rc
  cycle is over.

John Hubbard (2):
  selftests/vm/write_to_hugetlbfs.c: fix unused variable warning
  selftests/vm/.gitignore: add mremap_dontunmap

 tools/testing/selftests/vm/.gitignore           | 1 +
 tools/testing/selftests/vm/write_to_hugetlbfs.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)


base-commit: 3d1c1e5931ce45b3a3f309385bbc00c78e9951c6
--=20
2.26.2

