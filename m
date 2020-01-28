Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89F207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222434;
	bh=TvamCyUd28R9hJdhA5UPtzhsrUyhV0i/yZDmMMumUAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HmSr6lM3tPegymT3bQzanvCV618qvtM/l0UIdXcY1OGGtchNCR2uerXcgBNhS3+Gy
	 37vL0yblqRCPW4Ar6bnfnCtZC1r066kIT361i9kQDpd77CPEBDvK/pHRImw4YXQez+
	 eo2V8UAJpZCVy1pHpc+ZVEboq2qmvKs5TMA1iD+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgA1OPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbgA1OP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:15:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D35224681;
        Tue, 28 Jan 2020 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220928;
        bh=TvamCyUd28R9hJdhA5UPtzhsrUyhV0i/yZDmMMumUAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZjWtpKaEU+gtNs+xoy35E3RVgzxMj1NtZW24DTuLMzJ4RFNl4+AVmjWCHh1fuLxw
         5fTU9NJb/3/qpYpKlm5o5acU9qBUzVfJRAkaOwPaqsbItHsJc4xfjsjeCqcQ6WdYIE
         HBC5OzLN3YVrXQmpnZl44ieKAcx2BvnjRXLOHFRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 002/271] powerpc/archrandom: fix arch_get_random_seed_int()
Date:   Tue, 28 Jan 2020 15:02:31 +0100
Message-Id: <20200128135852.601343291@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit b6afd1234cf93aa0d71b4be4788c47534905f0be upstream.

Commit 01c9348c7620ec65

  powerpc: Use hardware RNG for arch_get_random_seed_* not arch_get_random_*

updated arch_get_random_[int|long]() to be NOPs, and moved the hardware
RNG backing to arch_get_random_seed_[int|long]() instead. However, it
failed to take into account that arch_get_random_int() was implemented
in terms of arch_get_random_long(), and so we ended up with a version
of the former that is essentially a NOP as well.

Fix this by calling arch_get_random_seed_long() from
arch_get_random_seed_int() instead.

Fixes: 01c9348c7620ec65 ("powerpc: Use hardware RNG for arch_get_random_seed_* not arch_get_random_*")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191204115015.18015-1-ardb@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/archrandom.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -27,7 +27,7 @@ static inline int arch_get_random_seed_i
 	unsigned long val;
 	int rc;
 
-	rc = arch_get_random_long(&val);
+	rc = arch_get_random_seed_long(&val);
 	if (rc)
 		*v = val;
 


