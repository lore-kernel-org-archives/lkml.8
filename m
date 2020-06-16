Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A340C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17FDC20882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592331324;
	bh=U6SVQrYdpf3H64Y1wEHug/hOhG566b3UUfUaO0UkwUM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EtoPp0Mpw0zUQvHMYd8dOyjdh8dFGjQ7W4Zt+rR99CIPtXyMwnOLpbNj5bvxf7ARt
	 +O5DWuzAMDuPOAIv8tStrZHwy1zlUB0FF40Rr+soB2Om+B5sHltiu4RwwAmaZh+Ey3
	 sdnwYZIkVFXiySeEFvP5FOxpN5eywBtEVMCKI6UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgFPSPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:15:22 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5328B2080D;
        Tue, 16 Jun 2020 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592331321;
        bh=U6SVQrYdpf3H64Y1wEHug/hOhG566b3UUfUaO0UkwUM=;
        h=Date:From:To:Cc:Subject:From;
        b=Z22lz4ucpDlx7104ED8yFNClfc/DJZRnYjbrC5Vj8nauicrfTbNM9QL/BXVFiL0e3
         Fqm68PHlBHdabTZmLxzQdAMi6nUjWLofIOFUaWDfPZXf5r47bNxkShSkN+kD6X5DU9
         8LYJ/7toJJhqY6QhwM85MoMDeurzMmoo+O5LeozA=
Date:   Tue, 16 Jun 2020 13:20:41 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] kexec_file: Use array_size() helper in memcpy()
Message-ID: <20200616182041.GA30841@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() instead of the open-coded version in memcpy(). These
sorts of multiplication factors need to be wrapped in array_size().

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the pointer variable type is
changed but the corresponding sizeof that is passed as argument is not.

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/kexec_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bb05fd52de85..2bbb001cd505 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -910,11 +910,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	 * The section headers in kexec_purgatory are read-only. In order to
 	 * have them modifiable make a temporary copy.
 	 */
-	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
+	sechdrs = vzalloc(array_size(sizeof(*sechdrs), pi->ehdr->e_shnum));
 	if (!sechdrs)
 		return -ENOMEM;
 	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
-	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	       array_size(sizeof(*sechdrs), pi->ehdr->e_shnum));
 	pi->sechdrs = sechdrs;
 
 	offset = 0;
-- 
2.27.0

