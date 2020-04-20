Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49910C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5FD2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZm2UUq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDTNUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDTNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:20:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:20:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so10992828wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbALYnvj9b7TiRQ6HAqBN8J26z1aInuwy6QTO8EMY+I=;
        b=jZm2UUq2zjNKVHP1+m+OOsr9+zzuILrI7wjwY/9JrBC5piC62jvTTbtdcvDr9INl5c
         6icvBQX98bCQRu4iSJsSZApWvmr9ZbCLWZibrXkn7wS5xb4e4C/ICOiHI1nfJqBWgp0d
         4qTYn9ur/ZTZBgha/eYrZZSX66bQhU0MdiEZKMgkLZrNeMzerZlHcijPpDLb8OH2pXNx
         D3WmPygjrnuLAc4GkBS6NRVvtMcyThcUucBOLoxUz8vZzhlNREGq0ZRcrkPfcjJJv4tP
         ZopbxiAhBhhg+RoiiIfB7G0QZc3GfPTkCE7VrzT6ma8YlFY0I6lDZkttm2Cc4A0j7zZC
         Wwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbALYnvj9b7TiRQ6HAqBN8J26z1aInuwy6QTO8EMY+I=;
        b=IWNsrhv5Iz85u/qeVC9FAPtf2pE20SwFk4hnUC2oaR2DXffZAQOxMqXpxGsdRjgR1A
         Zdvkkw4zOg+QAcY4+gco91gI95BnbdEtWRMffCQ9WmlQlxWc751WZioaqCH+SqECdl3I
         iI4t+AYP6yagVUOgofAqyU/vzU3BE6NjoWeu1WvN4EAE/Q9WHaB3D4MXW6kqKkaa0aZH
         V7q2ig8hT52H965q7kIOcp//3UYiyfqS/z8JVZzULhc0m5nvlO6GEuDHkeeIaMc/2rDW
         nIIn1ZIzhot3FzrRhwjxXhwIQfdoE64Y4CsYAXBIMWqaTnT95dmHNoNlJ/WaKyrN9Fyp
         nkYg==
X-Gm-Message-State: AGi0PuZedDNi18l31C8iaBh/ejO32pL0LAR7RJbw8NmrvAKWC/67nNrw
        cCl28dA5DIeP3ARc6q23xAqnz9/x
X-Google-Smtp-Source: APiQypJ3sBXuI4PxATAUoiduk4LKotXHhIwDCjwHAeKuon8DwwJa/VWAxVcq9SgNV9e+kI3dEVCx4w==
X-Received: by 2002:a05:600c:2c04:: with SMTP id q4mr16987057wmg.7.1587388802106;
        Mon, 20 Apr 2020 06:20:02 -0700 (PDT)
Received: from PC192-168-2-103.speedport.ip (p5B05E57B.dip0.t-ipconnect.de. [91.5.229.123])
        by smtp.gmail.com with ESMTPSA id z76sm1545815wmc.9.2020.04.20.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:20:01 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, david@redhat.com, mst@redhat.com,
        jmoyer@redhat.com, pankaj.gupta@cloud.ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [RFC 0/2] virtio-pmem: Asynchronous flush
Date:   Mon, 20 Apr 2020 15:19:45 +0200
Message-Id: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Jeff reported preflush order issue with the existing implementation
 of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
 for virtio pmem using work queue as done in md/RAID. This patch series
 intends to solve the preflush ordering issue and also makes the flush
 asynchronous from the submitting thread POV.

 Submitting this patch series for feeback and is in WIP. I have
 done basic testing and currently doing more testing.

Pankaj Gupta (2):
  pmem: make nvdimm_flush asynchronous
  virtio_pmem: Async virtio-pmem flush

 drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
 drivers/nvdimm/pmem.c        | 15 ++++----
 drivers/nvdimm/region_devs.c |  3 +-
 drivers/nvdimm/virtio_pmem.c |  9 +++++
 drivers/nvdimm/virtio_pmem.h | 12 +++++++
 5 files changed, 78 insertions(+), 27 deletions(-)

[1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
-- 
2.20.1

