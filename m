Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A012FC54FF1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7549C24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813155;
	bh=wUCnyP0bx4+5EbaDjMSE4OQYAilE4U7QOmG4gmb9nWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/4gxre+6+pzm5bq9cHlKqt4LTEGsg1ECuzpkDoEw2Lfz4yBMMUJtqyH8SO1Bum4u
	 88iGvAuMHvOPrGKgluz/3tM0AEjfdWmMT2PFvipm3HC8V0ebO+0YJg4hf5qYHuds8X
	 AmPy5JviBG3azSIY6+MHLmk89PmZrF+RD3a6MxD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbgB0OTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389964AbgB0OTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:19:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B52324697;
        Thu, 27 Feb 2020 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813146;
        bh=wUCnyP0bx4+5EbaDjMSE4OQYAilE4U7QOmG4gmb9nWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDdMNV7LvvXPEBaKCckMSWLtfsCmHRa2ckqjiAIwUj7VCEtqdm2mxNyt17CHTNOPa
         aYKG6MXBUkfjjdnfYaQGvj9kOHGNg8E5UNoBv694kOD+CsPGDYrey2hND1mZTReKAO
         WDF1L55wS3FioGxLLH5aBqPaQss3hym3rly2REpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.5 148/150] s390/kaslr: Fix casts in get_random
Date:   Thu, 27 Feb 2020 14:38:05 +0100
Message-Id: <20200227132254.102437223@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

commit 788d671517b5c81efbed9310ccbadb8cca86a08e upstream.

Clang warns:

../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
of type 'const u8 *' (aka 'const unsigned char *') converts between
pointers to integer
types with different sign [-Wpointer-sign]
                                  (char *) entropy, (char *) entropy,
                                                    ^~~~~~~~~~~~~~~~
../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
parameter 'src' here
                            u8 *dest, const u8 *src, long src_len)
                                                ^
2 warnings generated.

Fix the cast to match what else is done in this function.

Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
Link: https://github.com/ClangBuiltLinux/linux/issues/862
Link: https://lkml.kernel.org/r/20200208141052.48476-1-natechancellor@gmail.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/boot/kaslr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/boot/kaslr.c
+++ b/arch/s390/boot/kaslr.c
@@ -75,7 +75,7 @@ static unsigned long get_random(unsigned
 		*(unsigned long *) prng.parm_block ^= seed;
 		for (i = 0; i < 16; i++) {
 			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
-				  (char *) entropy, (char *) entropy,
+				  (u8 *) entropy, (u8 *) entropy,
 				  sizeof(entropy));
 			memcpy(prng.parm_block, entropy, sizeof(entropy));
 		}


