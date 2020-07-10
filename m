Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCCC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41FE207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594415794;
	bh=/s02Ps778ROINFWB6Un8s8RkpnuU+AVEyQdi+5lLH+E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nuMPQo9kK01ieS83pFp4S+n1FqL2n3+z7Jd9KT0Q0WmqYLqHU2ZBfjXC12kSRT8wu
	 faszjfDrr6HSoAwopb3wki0r7/5UCNgNPwaZtiqaHomIRYz8VCcDIyc59xdCTYWJgW
	 QsbUnHvyX6kJJL/RqtmSfpc7E7yQ0u+AyL7Fzuls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgGJVQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgGJVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:16:32 -0400
Received: from embeddedor (unknown [200.39.25.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D9820748;
        Fri, 10 Jul 2020 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594415791;
        bh=/s02Ps778ROINFWB6Un8s8RkpnuU+AVEyQdi+5lLH+E=;
        h=Date:From:To:Cc:Subject:From;
        b=VHjk0roRpeLY+5kLFhISDFYaDNiO1ZW/Qm4ShbjktijDnaVyPKrHDJY6XPo1/n9HC
         R99g/xAfDkackPzZPUIU6pI89tQosZEB68vN7LJrJ2p7+3pgTIW+xbMV8A0cSNLCYN
         UgVZmBoeXT2WqyznzQiMfR3k9ELV3d1OyAwDiHlU=
Date:   Fri, 10 Jul 2020 16:22:06 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] kexec_file: Assign array_size() to a variable
Message-ID: <20200710212206.GA29369@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign array_size() to variable _size_ and use it in both vzalloc()
and memcpy(). These sorts of multiplication factors need to be wrapped
in array_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/kexec_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 09cc78df53c6..4479d864aaf2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -883,16 +883,16 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned long offset;
 	Elf_Shdr *sechdrs;
 	int i;
+	size_t size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
 
 	/*
 	 * The section headers in kexec_purgatory are read-only. In order to
 	 * have them modifiable make a temporary copy.
 	 */
-	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
+	sechdrs = vzalloc(size);
 	if (!sechdrs)
 		return -ENOMEM;
-	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
-	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, size);
 	pi->sechdrs = sechdrs;
 
 	offset = 0;
-- 
2.27.0

