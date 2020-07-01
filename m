Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB61820702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CS5d67gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgGAPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:02:32 -0400
Received: from first.geanix.com ([116.203.34.67]:51104 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbgGAPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:02:31 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 9ADE32243294;
        Wed,  1 Jul 2020 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1593615419; bh=gCnFMBzqMfwjPj7r0668yNWisz+NpBlEdV9Xo3xozlc=;
        h=From:To:Cc:Subject:Date;
        b=CS5d67gFQ/HH4lrp7Gz5aONwtD0bqiGCHysAXHJhNh/SbTF41PAEfSm/tzd7qQ3GX
         PCgnNYoN9oJaMBqi1VdL1T+2Ja+TydwHmDKqDFXfNXJgcMT+8HQ4maQ3FMVikWoL5U
         dYs6Sr8JocAI1p8qZLhGxRZmh4vedwhUq3mXBzL9GWGxpqJfbIlWa4irA9lULwTsgj
         HGMz04TBewug8UCVRUaIoKeycq/YKLGYZlbvJKWkq27jeRf7o6b3pG3mmvWf5s83QL
         knbMsmHA0MDDnFhu59ayZhfq84zQWbeZxanzcZsoo4GIXqJptMvT55KWoSMfyuvNNd
         9qBRTBIV9s34A==
From:   Esben Haabendal <esben@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] uio: uio_pdrv_genirq: Fixes and support for non-page-aligned memory
Date:   Wed,  1 Jul 2020 16:56:56 +0200
Message-Id: <20200701145659.3978-1-esben@geanix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series inlcudes two fixes for issues when using uio_pdrv_genirq
without device tree, and support for using uio_pdrv_genirq with
non-page-aligned memory resources.

Esben Haabendal (3):
  uio_pdrv_genirq: Remove warning when irq is not specified
  uio_pdrv_genirq: fix use without device tree and no interrupt
  uio_pdrv_genirq: Allow use with non-page-aligned memory resources

 drivers/uio/uio_pdrv_genirq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.4.11

