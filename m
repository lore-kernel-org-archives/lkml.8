Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEFDC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4674E206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="jTX0D2LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgICUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgICUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:19:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22215C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:19:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so2934179qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/4sQnk4LDU0vEMICLGI8YxUkH7zUmXMxzaLJO9DsUE=;
        b=jTX0D2LBXHRBcuOwqcAasj+KSaNnjkEJZm90jn7kGvrXT3thDR4BsuVPXCXWJc1r4G
         MUfQz2Ireo5Y1SuHNlQlI37x1cgni4bnoLOGNOoWk4NfSVg7IWcNZDTCqe2n/1wdzU6u
         VeLOEFERqXzxA4RnAisGksUbyVhSTtHWglogE7iZCkf90ngqBejKI/QWQ020B913aGtY
         z2QN1ettqEOH/CAzUC5gkBRWwWY0Qmwme1pZxqn64bieqHtrfD2tjVlbKdUL/expWyym
         QXGa6ojP5o2pP/m3EM1i+OH7JhYbrQKEdsbm/e6/Nh8UclFQgRjVTCkP+sDPY2DKRiJa
         AY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/4sQnk4LDU0vEMICLGI8YxUkH7zUmXMxzaLJO9DsUE=;
        b=sFyhYBUlkcnryqegFrd8KN1OH6REoipkZWoZ+oeX1SM8sCA5r+GaQgClhfkW8dQBlG
         CWb2ZObt2S5KYomNCcgGEcUpCBOt45Y2pSnzSP8x+Gv0tGJziykRCdKdCH6t8k8zhCgt
         3uIVjMnHalTy1FepV0ArekqYVpihnDMrcAldenVPfqEuDeO6cgiv6BBGn2Y+4nf7Pq6V
         br2em53/Fh+lVtxtJWCYbC1UeInsKxBVKIZROBQZxKaJzDnsZbxPPWgxOehu/gBda5oM
         JDAauRrEePNov21EPwZ3rUX1BnIlbgM2lcDwOiUmAE1aq2EERQ07O3hRF4+FVdkORq4y
         I3Yg==
X-Gm-Message-State: AOAM531jLl1eVH+6gj9ehrhGvdeF/hkU9Ib1LNC+Y4m8h0oYbrWit1mN
        pTmR+tjNo+VIyptOtcZ1I49Iwzx8Xq/Ijw==
X-Google-Smtp-Source: ABdhPJza5VhQenwItzg0Zm+cN6BPSuCX6Nay7DN36KO2xgXqJ4aPd8+o5/LZkXB4gPTqBOocgl5YTg==
X-Received: by 2002:ac8:178d:: with SMTP id o13mr1281828qtj.103.1599164372346;
        Thu, 03 Sep 2020 13:19:32 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
        by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:19:31 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] Convert the intel iommu driver to the dma-iommu api
Date:   Thu,  3 Sep 2020 21:18:32 +0100
Message-Id: <20200903201839.7327-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts the intel iommu driver to the dma-iommu api.

While converting the driver I exposed a bug in the intel i915 driver which causes a huge amount of artifacts on the screen of my laptop. You can see a picture of it here:
https://github.com/pippy360/kernelPatches/blob/master/IMG_20191219_225922.jpg

This issue is in the i915 driver and is caused by the driver not respecting the return value of the dma_map_ops::map_sg function.

We talked about this in this microconference:
https://linuxplumbersconf.org/event/7/contributions/846/
and came to the conclusion that we should add an attribute to disable combining sg segments in the dma-iommu api (in the __finalise_sg function). This will work as a temporary fix and allow us to convert the intel iommu driver to the dma-iommu path while we wait for the i915 driver to be rewritten to respect the return value of map_sg. I haven't done this work yet and won't have time to do it. If someone else could take this on that would be great.

To allow my patch set to be tested I have added a patch (the "DO NOT MERGE..." patch) in this series to disable combining sg segments in the dma-iommu api which fixes the bug but it doesn't fix the actual problem.

As part of this patch series I copied the intel bounce buffer code to the dma-iommu path. The addition of the bounce buffer code took me by surprise. I did most of my development on this patch series before the bounce buffer code was added and my reimplementation in the dma-iommu path is very rushed and not properly tested but I’m running out of time to work on this patch set.

On top of that I also didn’t port over the intel tracing code from this commit:
https://github.com/torvalds/linux/commit/3b53034c268d550d9e8522e613a14ab53b8840d8#diff-6b3e7c4993f05e76331e463ab1fc87e1
So all the work in that commit is now wasted. The code will need to be removed and reimplemented in the dma-iommu path. I would like to take the time to do this but I really don’t have the time at the moment and I want to get these changes out before the iommu code changes any more.

Unfortunately I no longer have enough spare time to continue to work on/rebase this patch series. So this will most likely be the last patch series from me for the intel dma-iommu conversion.

Change-log:
v2:
-Rebase on top of the latest staging branch
-move the freelist parameter to iommu_iotlb_gather

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>

Tom Murphy (5):
  iommu: Handle freelists when using deferred flushing in iommu drivers
  iommu: Add iommu_dma_free_cpu_cached_iovas function
  iommu: allow the dma-iommu api to use bounce buffers
  iommu/vt-d: Convert intel iommu driver to the iommu ops
  DO NOT MERGE: iommu: disable list appending in dma-iommu

 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/dma-iommu.c   | 169 +++++---
 drivers/iommu/intel/iommu.c | 805 ++++--------------------------------
 drivers/iommu/iommu.c       |  10 +
 include/linux/dma-iommu.h   |   3 +
 include/linux/iommu.h       |   8 +
 6 files changed, 222 insertions(+), 774 deletions(-)

-- 
2.20.1

