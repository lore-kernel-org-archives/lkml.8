Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C0C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E5206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="etwC9UVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGZAib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgGZAiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B6C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u2v0btuUs27+9chKj5MA8maE5KTIeN5cHiAZvmuqoA8=; b=etwC9UVeLF+u6Zd6kocW75bzAQ
        liAEQB7MnaQwdtR9j5C7133ZA6nn8+LlBrAiY6Oo32FjYrpMak+ycfYol1dY5a2Ha5tyPNawVGKwk
        b2GETPR81grpBn6ya8/0xJWw75WD5yI2n5rryXf3Q/396NnIaQtzDn5EbVGDQw/FRu7ro5X7ecifz
        9Wed//4V18RrFhiETjqNMbbCCGt0QRb0Bghh4YTSA971k6ldO6bABopQHYM1Huu4HUkBd0EZ66pBk
        F7mAy8TIRjxhe9x/luI3Kkt5LmCeMCXHEJU9y6+U/LWbmID8m/PfIzyo7rH3NZZirpBSAWp61DOBb
        7UnPiLsg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgG-0003Cq-5n; Sun, 26 Jul 2020 00:38:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/9] powerpc: epapr_hcalls.h: delete duplicated words
Date:   Sat, 25 Jul 2020 17:38:04 -0700
Message-Id: <20200726003809.20454-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words "file" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/epapr_hcalls.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/epapr_hcalls.h
+++ linux-next-20200720/arch/powerpc/include/asm/epapr_hcalls.h
@@ -37,7 +37,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/* A "hypercall" is an "sc 1" instruction.  This header file file provides C
+/* A "hypercall" is an "sc 1" instruction.  This header file provides C
  * wrapper functions for the ePAPR hypervisor interface.  It is inteded
  * for use by Linux device drivers and other operating systems.
  *
@@ -246,7 +246,7 @@ static inline unsigned int ev_int_get_ma
  * ev_int_eoi - signal the end of interrupt processing
  * @interrupt: the interrupt number
  *
- * This function signals the end of processing for the the specified
+ * This function signals the end of processing for the specified
  * interrupt, which must be the interrupt currently in service. By
  * definition, this is also the highest-priority interrupt.
  *
