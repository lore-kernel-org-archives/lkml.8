Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFA1C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E20120708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339461;
	bh=mzdjs+2HjVphOcK4CSN3hLYnd9zBpyrzM4m11ddEtJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=11Eym/Z6TYODdhzAkCda2OdZ8iEXv9ysn02ZbFgsjSJz/RWtFV2cuayqgBvqx70Fi
	 jvYCCoiMjAOwtnW32ookYrnB4/JWU2cQvP4r8XPjw13ijZSHl2wvkyVcGk8giqF+hi
	 /c7UUD2S39N520dYr5/xM4OE3yl83Pqmf5ndB4zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgBJMl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbgBJMip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:45 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B6920733;
        Mon, 10 Feb 2020 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338325;
        bh=mzdjs+2HjVphOcK4CSN3hLYnd9zBpyrzM4m11ddEtJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iz1Uu74Q7x/Jo6EwuXvjeFaNWT1usFO8omldeFofphXNvqaoTSzFycmulj5EoQloy
         j7YqZvoaK1w14lpUXpIiVMfkXPlWPR+0AE9WawBzkWkKhnSjupv1y5fS63u9oz1lC+
         zvwUG+8B88z1tZwSuYHNkIJ86XYN2hfPVzb9zl6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.4 260/309] ubifs: Fix memory leak from c->sup_node
Date:   Mon, 10 Feb 2020 04:33:36 -0800
Message-Id: <20200210122431.609894741@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

commit ff90bdfb206e49c8b418811efbdd0c77380fa8c2 upstream.

The c->sup_node is allocated in function ubifs_read_sb_node but
is not freed. This will cause memory leak as below:

unreferenced object 0xbc9ce000 (size 4096):
  comm "mount", pid 500, jiffies 4294952946 (age 315.820s)
  hex dump (first 32 bytes):
    31 18 10 06 06 7b f1 11 02 00 00 00 00 00 00 00  1....{..........
    00 10 00 00 06 00 00 00 00 00 00 00 08 00 00 00  ................
  backtrace:
    [<d1c503cd>] ubifs_read_superblock+0x48/0xebc
    [<a20e14bd>] ubifs_mount+0x974/0x1420
    [<8589ecc3>] legacy_get_tree+0x2c/0x50
    [<5f1fb889>] vfs_get_tree+0x28/0xfc
    [<bbfc7939>] do_mount+0x4f8/0x748
    [<4151f538>] ksys_mount+0x78/0xa0
    [<d59910a9>] ret_fast_syscall+0x0/0x54
    [<1cc40005>] 0x7ea02790

Free it in ubifs_umount and in the error path of mount_ubifs.

Fixes: fd6150051bec ("ubifs: Store read superblock node")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/super.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1599,6 +1599,7 @@ out_free:
 	vfree(c->ileb_buf);
 	vfree(c->sbuf);
 	kfree(c->bottom_up_buf);
+	kfree(c->sup_node);
 	ubifs_debugging_exit(c);
 	return err;
 }
@@ -1641,6 +1642,7 @@ static void ubifs_umount(struct ubifs_in
 	vfree(c->ileb_buf);
 	vfree(c->sbuf);
 	kfree(c->bottom_up_buf);
+	kfree(c->sup_node);
 	ubifs_debugging_exit(c);
 }
 


