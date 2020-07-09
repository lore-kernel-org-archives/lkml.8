Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4538020739
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594275977;
	bh=F7aPXub9LE02vvU3SyEnusI3qQFCQ4n0EiRRFuHLlG4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IspgI4tgfDMDpMWadVTA4mJZPW8Njr4kIrV6hJ7gVYMlLE/KyuE52UoB7dB86iOKS
	 4LhrnjYhIzuvDFMvtMpKwyYnWhwuWilLZttAWEuHi0yUw9b5gIw7ec8l/sCkCsHJ2W
	 Tx5gLpUQ1FFYkd/6eobOMZTH2YRUf4SrGBt/QI0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGIG0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:26:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43007 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGIG0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:26:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id o11so1030125wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NZSnpbUFjk+i8hote9Z3Fy5fgxJodX2Ccl1BtVgBd0=;
        b=IrQbDeolmkNk2z4S8sQRCmpJ0Nd70CJY/OgOZuOZt4RSXHWTAhT2QmEl5t1Q371Yty
         JN9HAXz38j2oAX+b30YxQ35Dq7yEyJ/qSbE5sxP+SJNk8NjzlXfQ8R9H9fpeEcpKSSG4
         DLCISZnPdUgdoESTfdnfWNbEgHVMSY63EpYG+/+AdIc38opOHj06jncc2uKk1gUG+Tlz
         eGFhx1Ts2RBt/ySJ0tN8FT53zBU+CaDsJy2rYHP9Hd1+S76Dmx5vcRotALyDMu574rIK
         TxJKLhxiFGscHixA0M9nSj499KOenL3HPZlb4mQ8WAtY2wEqCi/q0FZg8Z0GF7gC5Q07
         WmpQ==
X-Gm-Message-State: AOAM531DBZbFZi64ZHJYvD6Icb3RNkMn4R6wIfoV4M3vQ5XA9D3Coxn5
        BIGYDz2tmA21xBkEyzBnBPU=
X-Google-Smtp-Source: ABdhPJy7ugljC0DnC3ZIv4+2YPOT272vsRSiHRQoTmrazlXb8N1ABAxSsVpR4RM3eSd+B4/y+alPyw==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr59134849wrs.287.1594275973500;
        Wed, 08 Jul 2020 23:26:13 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id p4sm4178410wrx.63.2020.07.08.23.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:26:12 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] doc, mm: sync up oom_score_adj documentation
Date:   Thu,  9 Jul 2020 08:26:02 +0200
Message-Id: <20200709062603.18480-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

There are at least two notes in the oom section. The 3% discount for
root processes is gone since d46078b28889 ("mm, oom: remove 3% bonus for
CAP_SYS_ADMIN processes").

Likewise children of the selected oom victim are not sacrificed since
bbbe48029720 ("mm, oom: remove 'prefer children over parent' heuristic")

Drop both of them.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 996f3cfe7030..8e3b5dffcfa8 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1634,9 +1634,6 @@ may allocate from based on an estimation of its current memory and swap use.
 For example, if a task is using all allowed memory, its badness score will be
 1000.  If it is using half of its allowed memory, its score will be 500.
 
-There is an additional factor included in the badness score: the current memory
-and swap usage is discounted by 3% for root processes.
-
 The amount of "allowed" memory depends on the context in which the oom killer
 was called.  If it is due to the memory assigned to the allocating task's cpuset
 being exhausted, the allowed memory represents the set of mems assigned to that
@@ -1672,11 +1669,6 @@ The value of /proc/<pid>/oom_score_adj may be reduced no lower than the last
 value set by a CAP_SYS_RESOURCE process. To reduce the value any lower
 requires CAP_SYS_RESOURCE.
 
-Caveat: when a parent task is selected, the oom killer will sacrifice any first
-generation children with separate address spaces instead, if possible.  This
-avoids servers and important system daemons from being killed and loses the
-minimal amount of work.
-
 
 3.2 /proc/<pid>/oom_score - Display current oom-killer score
 -------------------------------------------------------------
-- 
2.27.0

