Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D71C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC220708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594275983;
	bh=2ohcZxWTNPLi5ARzFr1HdWWV3VCCgFLTCJdISVpZWt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJ7hWQGIeu/QJ0XxH+PxYbJf5XU/CzD1rPC0lvi/UP8isK3akyntZex2ZfPPbRos8
	 cy0CV425rSjZqkBzYTTvP1pAoitiDvA47X6sJ9RIj8M9tYBmtSaPOSKbfwbLe0UHnq
	 cwP1kEvLfXtvhKW3DMAAH6N6j58PEO2x7WqOKw2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGIG0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:26:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGIG0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:26:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5so1039059wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvurmaEhiDORUIXWHx/5zZKOFGfrQC85VP7M/ADppWE=;
        b=cyRlxO3iDMGA30ulQsHXsqsP5l/lct0+i5NjN/GaNUu0SlT0XDh1DfdZKXLAYkXGuA
         xL/4RFA2vtHyUIxw0B4hmKPpnjEZfhKHR7Q12Tl+FZFr1RxXVhaT/Bnw2YTQuN2fUjCd
         hGo+yDSJMG77lKeTUe3z5FyaJE4SFFFpNrS33vgmd2DiLZEduxz9W673iDeyMRF+FgUE
         MFV0St+g0EtwBZ5jZuDbGcoJetCZkHZkFyVtDBTe2EyrVimaTrBq6vAgQfP0vxFtmSZ/
         9Qw5xxZW2TXMqTJreXNLci3SaAYyVjf0DxpheF0t0Om7gIAnpYGnPIKt/XXB96tRWop6
         EK/A==
X-Gm-Message-State: AOAM531MuHni7ic9RI4YNr2ANAbS6I+ZiqxJc7Hha+IINFC38WpIITOm
        uIjmlKbyvr1hPxBBWL2tnf4=
X-Google-Smtp-Source: ABdhPJyuQOKQaP1k4yx1bb8YTA/GAEH2wIYZA+1TJ4gunRYB89gmzN5iYVQJ425ZtUl//4kqcvKAKw==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr57634636wrx.44.1594275974851;
        Wed, 08 Jul 2020 23:26:14 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id p4sm4178410wrx.63.2020.07.08.23.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:26:14 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] doc, mm: clarify /proc/<pid>/oom_score value range
Date:   Thu,  9 Jul 2020 08:26:03 +0200
Message-Id: <20200709062603.18480-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709062603.18480-1-mhocko@kernel.org>
References: <20200709062603.18480-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

The exported value includes oom_score_adj so the range is no [0, 1000]
as described in the previous section but rather [0, 2000]. Mention that
fact explicitly.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8e3b5dffcfa8..78a0dec323a3 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1673,6 +1673,9 @@ requires CAP_SYS_RESOURCE.
 3.2 /proc/<pid>/oom_score - Display current oom-killer score
 -------------------------------------------------------------
 
+Please note that the exported value includes oom_score_adj so it is effectively
+in range [0,2000].
+
 This file can be used to check the current score used by the oom-killer is for
 any given <pid>. Use it together with /proc/<pid>/oom_score_adj to tune which
 process should be killed in an out-of-memory situation.
-- 
2.27.0

