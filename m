Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5E7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801DC20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588751227;
	bh=Gy838ztyqCG5xOQTV55+0XD3VL4icmY3tcw8oDEYSe8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PqfZ7KXAypbHlEfFH9pxwOOS2Ch8+67WgGRfvFmLjihPuBimbzo/OkP5j8ndZH7Js
	 4XfRiiXFEsaF5ykzi9M3GpMkkRNabVRr/4Iyjul2kSY5bg2Sw1gVn+98zFW5Yyptkc
	 fDjGQf2VQVfdmqKJaFOFzIutbLQ6huHoUa7mgfp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEFHrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgEFHrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:47:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCAA206D5;
        Wed,  6 May 2020 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751226;
        bh=Gy838ztyqCG5xOQTV55+0XD3VL4icmY3tcw8oDEYSe8=;
        h=From:To:Cc:Subject:Date:From;
        b=TJzSurVFZBHYjYPslkAFJl8bZoHDihSXjN5If4Wyh1L3BM4s/Aihe7fxiG6U30NvW
         4Mfjx64/at/+615BiVDDJCdCvTZBi1zdnDdnz5FHOJMpel0pZ5/CQfLz0lVuZ1q7zg
         WAMAM8Vye2aLljQt9M/rCPc5vYdFuifml9MGfJH8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 00/10] Various clean ups to ib_cm
Date:   Wed,  6 May 2020 10:46:51 +0300
Message-Id: <20200506074701.9775-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Jason,

These are intended to be no-functional change edits that tidy up the
code flow or coding style.

Thanks

Danit Goldberg (1):
  RDMA/cm: Remove unused store to ret in cm_rej_handler

Jason Gunthorpe (9):
  RDMA/addr: Mark addr_resolve as might_sleep()
  RDMA/cm: Remove return code from add_cm_id_to_port_list
  RDMA/cm: Pull duplicated code into cm_queue_work_unlock()
  RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait
  RDMA/cm: Add a note explaining how the timewait is eventually freed
  RDMA/cm: Make find_remote_id() return a cm_id_private
  RDMA/cm: Remove the cm_free_id() wrapper function
  RDMA/cm: Remove needless cm_id variable
  RDMA/cm: Increment the refcount inside cm_find_listen()

 drivers/infiniband/core/addr.c |   4 +
 drivers/infiniband/core/cm.c   | 239 +++++++++++----------------------
 2 files changed, 85 insertions(+), 158 deletions(-)

--
2.26.2

