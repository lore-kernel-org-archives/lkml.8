Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5302C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5A22072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217891;
	bh=KGDcDbAGyfFPVnBKXB4mUdrlWdRDNcL4M6TEXQLB4eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqdshmqDIVR6M5nARPIffrLZaWYkKr020CcAANDzCLAVwWntsEHeGhtjSKeX1W9uh
	 R3jrrhPVbmT0JFbtE0HeXb6rP312CZ1LXHMKNajZA9S/O8/g1yepbpMqWm1nLh8ri6
	 nqsRLeqI9iqTVugpwy2QUe6BO++uGSJrKYI2PA40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391327AbgAPX3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391305AbgAPX3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:29:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0555920748;
        Thu, 16 Jan 2020 23:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217376;
        bh=KGDcDbAGyfFPVnBKXB4mUdrlWdRDNcL4M6TEXQLB4eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opHpqAupR0jO+1ozatLWkcLHWetf6Z520TkjvgNKVARQlyAmI9+auPmb0ROqnuLRc
         mHKSUqG9t2/rwbm3QzAKOqjWhpAlLaGMQZgInBf4ZTavrbK8aHgy6s0co3TAhymVS0
         A4GwAdGA/qMHNgRJfKHCImcfBYMdQQ+bIaOWRmaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carsten Jacobi <jacobi@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Todd DeSantis <atd@us.ibm.com>
Subject: [PATCH 4.19 31/84] afs: Fix missing cell comparison in afs_test_super()
Date:   Fri, 17 Jan 2020 00:18:05 +0100
Message-Id: <20200116231717.380111014@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 106bc79843c3c6f4f00753d1f46e54e815f99377 upstream.

Fix missing cell comparison in afs_test_super().  Without this, any pair
volumes that have the same volume ID will share a superblock, no matter the
cell, unless they're in different network namespaces.

Normally, most users will only deal with a single cell and so they won't
see this.  Even if they do look into a second cell, they won't see a
problem unless they happen to hit a volume with the same ID as one they've
already got mounted.

Before the patch:

    # ls /afs/grand.central.org/archive
    linuxdev/  mailman/  moin/  mysql/  pipermail/  stage/  twiki/
    # ls /afs/kth.se/
    linuxdev/  mailman/  moin/  mysql/  pipermail/  stage/  twiki/
    # cat /proc/mounts | grep afs
    none /afs afs rw,relatime,dyn,autocell 0 0
    #grand.central.org:root.cell /afs/grand.central.org afs ro,relatime 0 0
    #grand.central.org:root.archive /afs/grand.central.org/archive afs ro,relatime 0 0
    #grand.central.org:root.archive /afs/kth.se afs ro,relatime 0 0

After the patch:

    # ls /afs/grand.central.org/archive
    linuxdev/  mailman/  moin/  mysql/  pipermail/  stage/  twiki/
    # ls /afs/kth.se/
    admin/        common/  install/  OldFiles/  service/  system/
    bakrestores/  home/    misc/     pkg/       src/      wsadmin/
    # cat /proc/mounts | grep afs
    none /afs afs rw,relatime,dyn,autocell 0 0
    #grand.central.org:root.cell /afs/grand.central.org afs ro,relatime 0 0
    #grand.central.org:root.archive /afs/grand.central.org/archive afs ro,relatime 0 0
    #kth.se:root.cell /afs/kth.se afs ro,relatime 0 0

Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Carsten Jacobi <jacobi@de.ibm.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Jonathan Billings <jsbillings@jsbillings.org>
cc: Todd DeSantis <atd@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -356,6 +356,7 @@ static int afs_test_super(struct super_b
 	return (as->net_ns == as1->net_ns &&
 		as->volume &&
 		as->volume->vid == as1->volume->vid &&
+		as->cell == as1->cell &&
 		!as->dyn_root);
 }
 


