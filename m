Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10446C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D903520733
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589265455;
	bh=9XCtK1rSBgjG98b7eHZ6C6kXPSCVAWf3F4PW5m4qkjE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Sl9SxspamK8iis1AbDR4qSRrN63z6CjObpAW0pUndIk1xTiK8m6rtCthxisGkZj0J
	 hVYI5k+rHRkew2moVpR4EI/mjbI4eEBPv2h8PnQxI7a9zNy2hBbllNEtofSooJdxZ3
	 yeWD5GLlPQ//HPln+JR32L0DDoJsATcj1ZyRLEjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgELGhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:37:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45AD20714;
        Tue, 12 May 2020 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589265454;
        bh=9XCtK1rSBgjG98b7eHZ6C6kXPSCVAWf3F4PW5m4qkjE=;
        h=From:To:Cc:Subject:Date:From;
        b=sojiTnRVkj7AGP/a3JzZ0XpgQXjHYiT4dFCZi+cKPdYrfyuTtBU02LyFl91Wy/Ohr
         2v+amjOd3dH/U4VAxTYhkNe8gWdK+32JeWd++WHXDm8nrw+c9Sr+ChGWZXl1hF0rOf
         kLHXHyRlLNIa+ekUR6bmP3WO2ZKFOijRyv1UoCXw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ingo Molnar <mingo@kernel.org>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH rdma-next 0/2] Fix kasan compilation warnings
Date:   Tue, 12 May 2020 09:37:26 +0300
Message-Id: <20200512063728.17785-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

The following two fixes are adding missing function prototypes
declarations to internal kasan header in order to eliminate compilation
warnings.

Thanks

Leon Romanovsky (2):
  kasan: fix compilation warnings due to missing function prototypes
  kasan: add missing prototypes to fix compilation warnings

 mm/kasan/common.c |  3 ---
 mm/kasan/kasan.h  | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

--
2.26.2

