Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59A2C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E7F20780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550262;
	bh=t3gf1WfgzA7QkhtiJsUlvysRRBiRev8FPPvrFOpxF64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jYZrpBWiQH2yCTi99E+znXt70uNRHH32Ca/Hzm7vrvCFlJ6chyhNvBdHtwUU/cp2B
	 AScnXiCGi4nSZAznNtpmq7BzGou5uDw7rQ5nfA3qZ30LZSsh8DgRsbkrNttcGTdmgp
	 fbk3ryMYivVgae5GF4aDCbxcpNd7Reh0ChPfHdbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgDVKLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbgDVKKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20892077D;
        Wed, 22 Apr 2020 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550253;
        bh=t3gf1WfgzA7QkhtiJsUlvysRRBiRev8FPPvrFOpxF64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8Mpn1yGFBz8cWRcR42ma3UYosPCpvVcaxcBNnfTrOeeGctlfjANtnw7y5apXh/DB
         yHs/CdqhQLfImRkaWkZsfHpSEHKRxMae9ydmbrjcUHY972YiUymTxU1SEjhp3Ujd9M
         Yo+IYbCP8wXaoainv63YcgU+OpVIYl56z0NhhNvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harshini Shetty <harshini.x.shetty@sony.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 072/199] dm verity fec: fix memory leak in verity_fec_dtr
Date:   Wed, 22 Apr 2020 11:56:38 +0200
Message-Id: <20200422095105.366516837@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shetty, Harshini X (EXT-Sony Mobile) <Harshini.X.Shetty@sony.com>

commit 75fa601934fda23d2f15bf44b09c2401942d8e15 upstream.

Fix below kmemleak detected in verity_fec_ctr. output_pool is
allocated for each dm-verity-fec device. But it is not freed when
dm-table for the verity target is removed. Hence free the output
mempool in destructor function verity_fec_dtr.

unreferenced object 0xffffffffa574d000 (size 4096):
  comm "init", pid 1667, jiffies 4294894890 (age 307.168s)
  hex dump (first 32 bytes):
    8e 36 00 98 66 a8 0b 9b 00 00 00 00 00 00 00 00  .6..f...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000060e82407>] __kmalloc+0x2b4/0x340
    [<00000000dd99488f>] mempool_kmalloc+0x18/0x20
    [<000000002560172b>] mempool_init_node+0x98/0x118
    [<000000006c3574d2>] mempool_init+0x14/0x20
    [<0000000008cb266e>] verity_fec_ctr+0x388/0x3b0
    [<000000000887261b>] verity_ctr+0x87c/0x8d0
    [<000000002b1e1c62>] dm_table_add_target+0x174/0x348
    [<000000002ad89eda>] table_load+0xe4/0x328
    [<000000001f06f5e9>] dm_ctl_ioctl+0x3b4/0x5a0
    [<00000000bee5fbb7>] do_vfs_ioctl+0x5dc/0x928
    [<00000000b475b8f5>] __arm64_sys_ioctl+0x70/0x98
    [<000000005361e2e8>] el0_svc_common+0xa0/0x158
    [<000000001374818f>] el0_svc_handler+0x6c/0x88
    [<000000003364e9f4>] el0_svc+0x8/0xc
    [<000000009d84cec9>] 0xffffffffffffffff

Fixes: a739ff3f543af ("dm verity: add support for forward error correction")
Depends-on: 6f1c819c219f7 ("dm: convert to bioset_init()/mempool_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Harshini Shetty <harshini.x.shetty@sony.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-verity-fec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -552,6 +552,7 @@ void verity_fec_dtr(struct dm_verity *v)
 	mempool_destroy(f->rs_pool);
 	mempool_destroy(f->prealloc_pool);
 	mempool_destroy(f->extra_pool);
+	mempool_destroy(f->output_pool);
 	kmem_cache_destroy(f->cache);
 
 	if (f->data_bufio)


