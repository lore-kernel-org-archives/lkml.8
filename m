Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62232C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9292193E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580599;
	bh=WHgTvjH7AEpgelzZyZAMrgUwBlctbZebQ7G3v7LkfUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Czp1dKflYh0jb9FpZupQPtWafFs7wUHxU1oLkpCkFHlBo+4qQtXpJbgEMCwyJKC3
	 fQKIgyymWwaUowloFKWpPiie404jXRDdeNQElGG7v1Pvh8Hz+SZKe3wyCD7USVP58s
	 r9deqwU9Ccqp/6+zngvyy0heYmDgEreYbJoj2qsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404748AbgFSP36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390143AbgFSP3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4CF21919;
        Fri, 19 Jun 2020 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580587;
        bh=WHgTvjH7AEpgelzZyZAMrgUwBlctbZebQ7G3v7LkfUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KI1nYC0zvyQNd/vZTJ9a3uzinLG48KDrFrxCgCJAmWy+XDSM6TMBWnRScox37emkr
         IEV8KdHoEf5YaEpNKO9W4XrJIRxZq9I1AdRvUCE18R41ZR0ciwcUxviY5MHjWK/ceE
         MLGLGgiLP0Ren9IR00Xvj9UybHTYL8DcvPXW1W4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.7 279/376] evm: Fix possible memory leak in evm_calc_hmac_or_hash()
Date:   Fri, 19 Jun 2020 16:33:17 +0200
Message-Id: <20200619141723.542913035@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 0c4395fb2aa77341269ea619c5419ea48171883f upstream.

Don't immediately return if the signature is portable and security.ima is
not present. Just set error so that memory allocated is freed before
returning from evm_calc_hmac_or_hash().

Fixes: 50b977481fce9 ("EVM: Add support for portable signature format")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/evm/evm_crypto.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -241,7 +241,7 @@ static int evm_calc_hmac_or_hash(struct
 
 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
-		return -EPERM;
+		error = -EPERM;
 out:
 	kfree(xattr_value);
 	kfree(desc);


