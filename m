Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24335C54FDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FAD246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813085;
	bh=sevjY8YSiEJ4WfRWOh772n1GYlFHoWmY89hx6uednB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wPwdFQPnyJeYeU43Db0DijmZK6vJ/cFTcARvOy6EB2dAhau6/ak6BoR7JoHW05sac
	 hglSFPVdC6gXy521HjzaZubvgMpFu09laYYuzcoC+CgWMLDY7CTGLZKcxLL+dCl8EZ
	 0KnjTtWQZGpRxj7CWRAwA5gq1DIUOcDb/tjRRUKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbgB0OSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389254AbgB0ORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:17:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B75246A4;
        Thu, 27 Feb 2020 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813075;
        bh=sevjY8YSiEJ4WfRWOh772n1GYlFHoWmY89hx6uednB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuTTpcC5203f8pTHjWPK0gOTe+7Z2xMPgj+8BSWfOBvWJSBJKYZ0PmXYp9xq0gBCJ
         p67+NbUHCGoiR9aJ3ZEuIgRqPjDXdOxhNFtRkv89MDGjbHzYM5+CXGrMNtcJnld32F
         Ta2AOp7r8q0XdBLNP3gEtHlSYyZtTs+aS4kWra78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 5.5 127/150] ecryptfs: replace BUG_ON with error handling code
Date:   Thu, 27 Feb 2020 14:37:44 +0100
Message-Id: <20200227132251.383291850@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

commit 2c2a7552dd6465e8fde6bc9cccf8d66ed1c1eb72 upstream.

In crypt_scatterlist, if the crypt_stat argument is not set up
correctly, the kernel crashes. Instead, by returning an error code
upstream, the error is handled safely.

The issue is detected via a static analysis tool written by us.

Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Tyler Hicks <code@tyhicks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/crypto.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecry
 	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
+	if (!crypt_stat || !crypt_stat->tfm
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
+		return -EINVAL;
+
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
 				crypt_stat->key_size);


