Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6883EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A112208B8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iO4S+ArA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgFEJ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:26:10 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:39765 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgFEJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591349168; x=1622885168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6B6Tnzu3jtZ/RshEoNxGPE1rQ9DjLk4r5yTIvbGNx7s=;
  b=iO4S+ArA+gejJd7owt5xryfO5b4OnFaQQmhledcUfMbHnBjcf5+YWOcp
   5r5HvWVrV6hTzX1bqfULzzwXwdOKvT2MLP0St5cwZT9KWVQ/uqPETjYLT
   n2bjXbMuIkJfEw+5/GdELOtBfJgtGxO+gz7OLVa5+NoNO+3Nddd/RphX4
   I=;
IronPort-SDR: KjIoxxJb00zsEQY5N0jHC/jnAZr9jpUe0SyJ0MqwJAKn0J+tjHWvv2mtXAVFgOFS883wV7JA3i
 ev00Fy9J+qVw==
X-IronPort-AV: E=Sophos;i="5.73,475,1583193600"; 
   d="scan'208";a="34615536"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Jun 2020 09:26:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 3719DA1CD8;
        Fri,  5 Jun 2020 09:26:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 09:25:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.200) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 09:25:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/2] scripts/spelling: Add a few more typos
Date:   Fri, 5 Jun 2020 11:25:02 +0200
Message-ID: <20200605092502.18018-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605092502.18018-1-sjpark@amazon.com>
References: <20200605092502.18018-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D32UWB003.ant.amazon.com (10.43.161.220) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds typos I found from another works.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/spelling.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index d9cd24cf0d40..c45e9afaab2d 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -59,6 +59,7 @@ actualy||actually
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
+acutally||actually
 adapater||adapter
 addional||additional
 additionaly||additionally
@@ -249,6 +250,7 @@ calescing||coalescing
 calle||called
 callibration||calibration
 callled||called
+callser||caller
 calucate||calculate
 calulate||calculate
 cancelation||cancellation
@@ -671,6 +673,7 @@ hanlde||handle
 hanled||handled
 happend||happened
 harware||hardware
+havind||having
 heirarchically||hierarchically
 helpfull||helpful
 hexdecimal||hexadecimal
@@ -845,6 +848,7 @@ logile||logfile
 loobpack||loopback
 loosing||losing
 losted||lost
+maangement||management
 machinary||machinery
 maibox||mailbox
 maintainance||maintenance
@@ -905,6 +909,7 @@ modfiy||modify
 modulues||modules
 momery||memory
 memomry||memory
+monitring||monitoring
 monochorome||monochrome
 monochromo||monochrome
 monocrome||monochrome
@@ -1010,6 +1015,7 @@ partiton||partition
 pased||passed
 passin||passing
 pathes||paths
+pattrns||patterns
 pecularities||peculiarities
 peformance||performance
 peforming||performing
@@ -1256,6 +1262,7 @@ shoule||should
 shrinked||shrunk
 siginificantly||significantly
 signabl||signal
+significanly||significantly
 similary||similarly
 similiar||similar
 simlar||similar
@@ -1371,6 +1378,7 @@ thead||thread
 therfore||therefore
 thier||their
 threds||threads
+threee||three
 threshhold||threshold
 thresold||threshold
 throught||through
@@ -1410,6 +1418,7 @@ tyep||type
 udpate||update
 uesd||used
 uknown||unknown
+usccess||success
 usupported||unsupported
 uncommited||uncommitted
 unconditionaly||unconditionally
-- 
2.17.1

