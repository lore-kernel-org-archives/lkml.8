Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A22C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FC8206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBUsjush"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEETE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:04:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgEETE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588705496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gcXMyD41pZbNM1SUCbRbLelE1XAUtFal40kiUaUajmk=;
        b=GBUsjushM9ZRCuu/xy6AiAd5C5l9syl7q14CmdCJ66+gy+Ekpo8PAvgR4Mb1YkySlFNQ2k
        /8GGpL/Rfwv3CWE6UKPKSY9dr0CJvd9Vu/RU8xlRa+rE3d15MB1tU4edYNdcfAbFAztWe2
        p6EVL1rw6Zoo/XGEmm6fVmb8nHLqysQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-HBYx3K1EPymYyKcvq_a7eA-1; Tue, 05 May 2020 15:04:53 -0400
X-MC-Unique: HBYx3K1EPymYyKcvq_a7eA-1
Received: by mail-pl1-f198.google.com with SMTP id c4so2703131pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 12:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gcXMyD41pZbNM1SUCbRbLelE1XAUtFal40kiUaUajmk=;
        b=An9HEK1mYYthGvToBN01wPFyczxAtwqzr9B9PFvoPysWH1I7nVsQ8pk5mwyW+R6Pt+
         kO9w5zCHBVruv5+WAdnNoB7cWuUfo+NxOE+lsSJpMGCSPtQPsejgqaTu0aEEOyS7r9QT
         LLnF3DkoRujwO8/ON2vHp+326MSG8KkjA4jAxjS0uhJXOSL22swuN0u4iWj/SNTLwl3T
         w/jDOLIKniSiRwhQzyP78r8uiI5vve8eRUS/ooaLTxydz7fg+DJUX2BrwK4qIWeUTa/d
         HKaf5XAgTgC4Xfbc4qrhXCfAZjc3ts4wB9HIqv7vKK9ySPukDiejmOUol4FbDV3g4sA8
         Ozfg==
X-Gm-Message-State: AGi0PuZz7M5hazl3BgDf+YRMVwgGSpJZVzu3sn8r96sQlb/N6eHtQfGM
        b/brA/w1+8pluUiAoSLB9JmqPpSnPL0IFQ/Hrqyr7XLTORJGHwiL+K6Ln7PQG6xc3zvoL6wV2SI
        KA07jYjGUHcpJKmauIZe71eL8
X-Received: by 2002:a63:6e8a:: with SMTP id j132mr3534775pgc.301.1588705492032;
        Tue, 05 May 2020 12:04:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypKBraGUIDcFG9XSdThqRw+1cdaikZ4rNFXMH+U0+iXdoy+oY/wIGdJj6n4cm/tV5WzKDyO/OA==
X-Received: by 2002:a63:6e8a:: with SMTP id j132mr3534746pgc.301.1588705491674;
        Tue, 05 May 2020 12:04:51 -0700 (PDT)
Received: from localhost ([122.177.124.216])
        by smtp.gmail.com with ESMTPSA id o30sm2032230pgn.12.2020.05.05.12.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 12:04:50 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        manishc@marvell.com, davem@davemloft.net
Subject: [PATCH 0/2] net: Optimize the qed* allocations inside kdump kernel
Date:   Wed,  6 May 2020 00:34:39 +0530
Message-Id: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kdump kernel(s) run under severe memory constraint with the
basic idea being to save the crashdump vmcore reliably when the primary
kernel panics/hangs, large memory allocations done by a network driver
can cause the crashkernel to panic with OOM.

The qed* drivers take up approximately 214MB memory when run in the
kdump kernel with the default configuration settings presently used in
the driver. With an usual crashkernel size of 512M, this allocation
is equal to almost half of the total crashkernel size allocated.

See some logs obtained via memstrack tool (see [1]) below:
 dracut-pre-pivot[676]: ======== Report format module_summary: ========
 dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)
 dracut-pre-pivot[676]: Module qede using 65.3MB (1045 pages), peak allocation 65.3MB (1045 pages)

This patchset tries to reduce the overall memory allocation profile of
the qed* driver when they run in the kdump kernel. With these
optimization we can see a saving of approx 85M in the kdump kernel:
 dracut-pre-pivot[671]: ======== Report format module_summary: ========
 dracut-pre-pivot[671]: Module qed using 124.6MB (1993 pages), peak allocation 124.7MB (1995 pages)
 <..snip..>
 dracut-pre-pivot[671]: Module qede using 4.6MB (73 pages), peak allocation 4.6MB (74 pages)

And the kdump kernel can save vmcore successfully via both ssh and nfs
interfaces.

This patchset contains two patches:
[PATCH 1/2] - Reduces the default TX and RX ring count in kdump kernel.
[PATCH 2/2] - Disables qed SRIOV feature in kdump kernel (as it is
              normally not a supported kdump target for saving
	      vmcore).

[1]. Memstrack tool: https://github.com/ryncsn/memstrack

-
Bhupesh Sharma (2):
  net: qed*: Reduce RX and TX default ring count when running inside
    kdump kernel
  net: qed: Disable SRIOV functionality inside kdump kernel

 drivers/net/ethernet/qlogic/qed/qed_sriov.h  | 10 +++++++---
 drivers/net/ethernet/qlogic/qede/qede.h      |  5 +++--
 drivers/net/ethernet/qlogic/qede/qede_main.c |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.7.4

