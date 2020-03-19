Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1362C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829452072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEiV91Rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCSRAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:00:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34743 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgCSRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:00:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so3351571ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CK/uSp7BbTSCKl35tJIDZhjlJczfTeolJYVvbwptV4M=;
        b=OEiV91RjCb5SrrrpKvHbyVq/Ll2bovI/WapuWca/s7CqnkAZGQK6F7gh6yzyXi7lGy
         G+EJV29vkwqhd1XzS5a6wmoTyvJvIYFHxajzzoir0JwgkT32VS4BV+TO1b4+J0LKONX9
         D9+hGdfQNgZau0wso1+mHTM4MIRvNh5zvk7oYvdVa/gPEtE+gTnqfs439Ueenuxs8ktJ
         kJ1MDrSQDJHgyJdhniEG2ZJwhAA0dPGUhtNUzJPyJfvKL5RI2nTM/N26wjM6udQ6pMu6
         we+QvsK4tFm9va7xAIQVlhQpo32w33erghO0yntQMbQd7pOM9f7JNGzDSgp0dwYwQ8CI
         s7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CK/uSp7BbTSCKl35tJIDZhjlJczfTeolJYVvbwptV4M=;
        b=KVgNABLPXj68YaSZyX19mEHUTBl/mRbV+y/o3cp1Q1Rux0beJKASKF3KvJmt+Kcd1s
         pMmj0NsUlnO9gENd1bTKX8HbUjRSdy2lR2OVdujByxUPq+zhvgRbOqEhi8qELWTLB1lY
         wL/PMnZkprFMlhNseS9kOLZLXFrz7GtdBe6E3Mu/4mkQZftVYApuQXoBzZAgzrlGTny3
         GW/REnRuBTDAEXo5vAlwgD93paVPrXnqYHtnhGzGUO+5oOXOxVEnEfK2+3GLwzp02Tmq
         8oj+tUGgaRfaslz3vHAULp8/lJWMVVV/x90x5kvF3c/RC4o+5COoW+UmjLSiWKR2ZHpj
         g1bg==
X-Gm-Message-State: ANhLgQ3YY6+5YmQgDz8Tmlt4NQ6hc3OoypSjU1HEWDhR0sFQzB7vmD/X
        i1saTTHTSLgSAkg4WP0NRpPwO6lHmOI=
X-Google-Smtp-Source: ADFU+vtQX6AgLn/ilsvkGpf8R2Braooqufkbkhu7QjG1ypfPxJPMQDzdS1N4dIBmwrnNMf8q3wTDww==
X-Received: by 2002:a2e:b701:: with SMTP id j1mr2795557ljo.6.1584637213833;
        Thu, 19 Mar 2020 10:00:13 -0700 (PDT)
Received: from localhost.localdomain (188.146.97.196.nat.umts.dynamic.t-mobile.pl. [188.146.97.196])
        by smtp.gmail.com with ESMTPSA id h22sm1785027ljc.15.2020.03.19.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:00:13 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/vmscan.c: Clean code by removing unnecessary assignment
Date:   Thu, 19 Mar 2020 17:59:38 +0100
Message-Id: <20200319165938.23354-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously 0 was assigned to 'sc->skipped_deactivate'. It could happen only
if 'sc->skipped_deactivate' was 0 so the assignment is unnecessary and can
be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index dca623db51c8..453ff2abcb58 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3093,7 +3093,6 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	if (sc->memcg_low_skipped) {
 		sc->priority = initial_priority;
 		sc->force_deactivate = 0;
-		sc->skipped_deactivate = 0;
 		sc->memcg_low_reclaim = 1;
 		sc->memcg_low_skipped = 0;
 		goto retry;
-- 
2.17.1

