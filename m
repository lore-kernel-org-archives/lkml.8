Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F0CC33CB2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1522720722
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJUBvIPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBAByF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 20:54:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgBAByE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aK5HMxJWe9BbxviT1wbx7h4LJPrrlS0wbe9GNcZNOIY=; b=YJUBvIPczp3UISQFBphrC2dVF
        9mfFWG5EIxdBnG2rkPwzBximLbAveSQe3vCEZpmMO/rTUiow39n54m5kFoL6TAUvoBbkCIISP2UJg
        UkCQMUi6LsrxGNV7oCW3kt/a2JCsytCIcmsq2tSLwpSqeg1a1hRVcCxmKSOEEtCW+oiK2p1gXjSA2
        jdu7B/ANYnPa4ZipLa/6jVbGMUzTV71LTYpGQRvk2PYnp7KHjcn9c5Hx+MOsfVEC3b1/O54o2DF6Q
        LuVw/fBmedPSDntmy4HlQqUCKv22aYOwwd0TRsActl10c0E+JONsTQfIniHuH7naYFW2dVs8aR0PE
        ziRY9OpWQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixhz2-0005wI-G6; Sat, 01 Feb 2020 01:54:04 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/hexagon: fix punctuation in SMP help text
Message-ID: <09765113-6064-9be3-c1f9-19947e2afa4a@infradead.org>
Date:   Fri, 31 Jan 2020 17:54:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

End a sentence with a period ('.') in SMP help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200131.orig/arch/hexagon/Kconfig
+++ linux-next-20200131/arch/hexagon/Kconfig
@@ -105,7 +105,7 @@ config CMDLINE
 config SMP
 	bool "Multi-Processing support"
 	---help---
-	  Enables SMP support in the kernel.  If unsure, say "Y"
+	  Enables SMP support in the kernel.  If unsure, say "Y".
 
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP

