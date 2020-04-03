Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA2DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40B32080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585902963;
	bh=Rtrv6PQbv6yjI47jeE8NHrwZrPw1Cvh6qpvNH8HWTM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jrfsMr74itj+Bhz30YjbykejHoR4EoJfSeyHXEYCHcs/8oQsWXDWH2DPlzeKfrd5i
	 lXoCZggZmUhfTZv2Z9cFwrD7CYMywSfd+0KbzKDJVQIm5isPIAZzW4oadp9vq0DT7C
	 +0Lj+ztSYM7L8dIzP8elRKZMH3HbuB0PFo5+yFiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbgDCIgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:36:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52679 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390228AbgDCIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:36:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id t8so6257669wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtpPxyoRisktwYV8GKqImVHBqT8VlKdeN8AOG5tsI4w=;
        b=uQXIOLBSyVB79mhxCO02vl5yD93mXZliV2Ixg3D3kZrAi/aSxHzThq3XqmyZGfWrTR
         BQ8T2U9Ku05qNqOwN1lT1Lvg0EgAV9tsU/u/QPfSXrkP/O6jjOvZCxq88PajsW8dVrLO
         Zf7P74UVU/b+qMgG96K5icFn9OX2/h+Fc16ixBtevI1CJsRvclyJ9ZUL8ZmMBlKI9X3P
         23BrGMqsiouM3zQvaxNv5t8D3HmtAb3wgYUj/XYmqi0KwW2KpuCqePx1XauvyWhidtDS
         Bp9QhDDq/Ed6lIr/tRuuClR9+YtCInbEF8Gfmtgp1/Vsnct1HFeE9YhrFeQQumlL0zYu
         gdlA==
X-Gm-Message-State: AGi0PuYTz0+FZslcVth8/a/g9ZpdXibjnlYyN+0Okujn+A15NL9kTVPA
        +ouy55P6IQZrGSxnKyRcn2FjUV3v
X-Google-Smtp-Source: APiQypKXYZXqpkSNfmPVOPnqf50MiBJus1LGu50LqojrBPE6PAqj6Q97YN1fijOnLAcDh2veZDOdAQ==
X-Received: by 2002:a7b:c18c:: with SMTP id y12mr4615614wmi.56.1585902958758;
        Fri, 03 Apr 2020 01:35:58 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v7sm11010275wrs.96.2020.04.03.01.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 01:35:58 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neil Brown <neilb@suse.de>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
Date:   Fri,  3 Apr 2020 10:35:42 +0200
Message-Id: <20200403083543.11552-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403083543.11552-1-mhocko@kernel.org>
References: <20200403083543.11552-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

It seems that the existing documentation is not explicit about the
expected usage and potential risks enough. While it is calls out
that users have to free memory when using this flag it is not really
apparent that users have to careful to not deplete memory reserves
and that they should implement some sort of throttling wrt. freeing
process.

This is partly based on Neil's explanation [1].

[1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..e3ab1c0d9140 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -110,6 +110,9 @@ struct vm_area_struct;
  * the caller guarantees the allocation will allow more memory to be freed
  * very shortly e.g. process exiting or swapping. Users either should
  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the consumption
+ * of the reserve based on the amount of freed memory.
  *
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
-- 
2.25.1

