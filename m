Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A154C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336D92084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587457778;
	bh=sduEl9HQjPjWr785uJ3fozLUx7PNIRlsTLocklU5SBM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CPYIuNrQwKWV09YfIEFxxWYZQfEQsH/kPPdhOZj4CXcJTgPsnXd9levqggSE314Uq
	 YOHq9zy4KlSzssqA/OoqMJNYTEQWEmm9bN7xxK7/SokIVZIt35WvSImpu+AVK3Q4ze
	 B5m0X2Blq7TGzKWHY+WOHUaaHTy7mDseaNrOMUew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDUI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgDUI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:29:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520412084D;
        Tue, 21 Apr 2020 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587457775;
        bh=sduEl9HQjPjWr785uJ3fozLUx7PNIRlsTLocklU5SBM=;
        h=From:To:Cc:Subject:Date:From;
        b=Xrxo2lWIoXVHb65JwICJFHMgHdE/1KqG8QQba/GgApJHJFOfr8Ty9bhHh/4ir4fgo
         iKuBe+1v/VE8VaJks9sqSdhTOxRjHByw4tkkGN1GlkUgiDid08H30WvoQ1cMqs0idu
         gUhliZDUVSN36CN1VEuvgKI6EqAA4fpsyMs1Qqkw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 0/2] Two fixes in handling FD object
Date:   Tue, 21 Apr 2020 11:29:27 +0300
Message-Id: <20200421082929.311931-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

These two patches are fixing two crashes in FD object handling.

Thanks

Leon Romanovsky (2):
  RDMA/core: Prevent mixed use of FDs between shared ufiles
  RDMA/core: Fix overwriting of uobj in case of error

 drivers/infiniband/core/rdma_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--
2.25.2

