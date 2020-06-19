Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6082C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE56E20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581084;
	bh=RCzbOfWKdsuNjoZhh37a3FIUbTHPuINlTo8uqPP3G9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ix6nkejf6N+/4GgGPC0gBqG3788V8IRnEjk/y98Dd+Ly17nPyBgoWKWpZt8IyAica
	 MTTIe5LNLuZ7B+Lp4XYoYm31AaWI6b9LNpfDX/ZibZdRrWLFiyFqE7xwhTticU5nZ/
	 vhBSq7M7nSQJTkfwWhmY0OcEP2fux9PH3S+6nf78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393684AbgFSP3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404312AbgFSP3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF7B21927;
        Fri, 19 Jun 2020 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580558;
        bh=RCzbOfWKdsuNjoZhh37a3FIUbTHPuINlTo8uqPP3G9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xqfi3KmfZM8NzVK66zZwWn1WOR0m1cxr/ug20lnw/fcIKFb3NqyrGLP0n9jPE7+CP
         Ss5ogzXvC6M+QvRu9EqlB13w9oB8YhK14DSlVEYHH1+cbFjAxWlUw+wNSti45cE0qx
         noSEwVSOuGUbli/GJbdQJU8huo7CtzwPPZWkDa1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 5.7 278/376] ima: Remove __init annotation from ima_pcrread()
Date:   Fri, 19 Jun 2020 16:33:16 +0200
Message-Id: <20200619141723.494348122@linuxfoundation.org>
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

commit 8b8c704d913b0fe490af370631a4200e26334ec0 upstream.

Commit 6cc7c266e5b4 ("ima: Call ima_calc_boot_aggregate() in
ima_eventdigest_init()") added a call to ima_calc_boot_aggregate() so that
the digest can be recalculated for the boot_aggregate measurement entry if
the 'd' template field has been requested. For the 'd' field, only SHA1 and
MD5 digests are accepted.

Given that ima_eventdigest_init() does not have the __init annotation, all
functions called should not have it. This patch removes __init from
ima_pcrread().

Cc: stable@vger.kernel.org
Fixes:  6cc7c266e5b4 ("ima: Call ima_calc_boot_aggregate() in ima_eventdigest_init()")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_crypto.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -645,7 +645,7 @@ int ima_calc_buffer_hash(const void *buf
 	return calc_buffer_shash(buf, len, hash);
 }
 
-static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
+static void ima_pcrread(u32 idx, struct tpm_digest *d)
 {
 	if (!ima_tpm_chip)
 		return;


