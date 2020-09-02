Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB0DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D0D2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599036922;
	bh=5z1uEqG+wAJQOlCy6iqhMsGNezM4SD/VS2ml/uiU0Wc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N0W1Tot5p2PdZYDe8gG187xFrJP9hFVz2wNnjCXBgOeddoVf01SVHN7oEcSAb5wLq
	 myBxTkFkk0pj7Kqsa4Kb0yJKSPAQUEyNmtAKAxrn9ncu34rH8vHy5+jQcMUBnGLf64
	 cIVJa2wpCfoDc5mvO3fkjsD4Q6S/omNoQgVfcpPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIBIzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBIzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:55:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B990C2078B;
        Wed,  2 Sep 2020 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599036919;
        bh=5z1uEqG+wAJQOlCy6iqhMsGNezM4SD/VS2ml/uiU0Wc=;
        h=From:To:Cc:Subject:Date:From;
        b=D/qaUEbxQYa3Ppmk1WKX9leVTZXUqog3yaeX24dlLIejCvt94c1SPPzlhG8UYsxLx
         mpu+1bjNMaet0+xS+C6NMTCkz24fL1MQBlwj6w/BOSdHOkURerTP7HJZZ0CDTLhUut
         +2MH1qPxqQ84SHw0uKssUBkHKzdiAejGPrYOwj3s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -rc 0/4] Protect from GCC garbage input in GCOV
Date:   Wed,  2 Sep 2020 11:55:09 +0300
Message-Id: <20200902085513.748149-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi Linus,

Both Colin in Ubuntu [1] and I in FC 32 are having same kernel crashes
while GCOV is enabled. The reason to it that n_fuction variable that
should be provided by GCC is not initialized (or wrongly set).

This patch is based on the RFC [2] which I sent to gather feedback, but
didn't get any response, so sending it to you in proper -rc format.

Bottom line, GCOV is broken on GCC 10.2.

Thanks

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891288
[2] https://lore.kernel.org/lkml/20200827133932.3338519-1-leon@kernel.org

Leon Romanovsky (4):
  gcov: Open-code kmemdup() to work correctly with kernel and user space
    pointers
  gcov: Use proper duplication routine for const pointer
  gcov: Protect from uninitialized number of functions provided by GCC
    10.2
  gcov: Don't print out-of-memory print for all failed files

 kernel/gcov/fs.c      |  5 +++--
 kernel/gcov/gcc_4_7.c | 17 +++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

--
2.26.2

