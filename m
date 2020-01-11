Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357AFC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0620842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737858;
	bh=ULEHRFKuKintFlbXwxDMzFw2qiaGlBfmVx+49HXc6Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7MjptktFxtRdGCA91yJ8XUpB+ahL1H3Be3UzO6uXCJ9bUYwxlo0jATKUR+XoqwGy
	 ecM9aPAHD/udpyL0jWvTyhw2KRp2+Drl0xXU+1k0UvLQ1i0avop2iQDZgMMKqi1n86
	 B3LfnGaW9OwM8neEIZDpTd08DTGybmG0vdoG0SS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgAKKRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgAKKRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:17:34 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCB920842;
        Sat, 11 Jan 2020 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737853;
        bh=ULEHRFKuKintFlbXwxDMzFw2qiaGlBfmVx+49HXc6Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRT7gNep/FGQtPjy/hG2oeqB6upq701Nt/rpDdyaKZkE+74tmDmT/1i6b3FWKKHLn
         pBB3he3EJwIJBZOagsF2+BwN4F8/jbaGlitE0LCBA7YH41fW818Yn/hx+zWEi2P2P2
         ofmn82+kHM/vjesCVJLjlWqFdUPIV1o2fSFabo6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH 4.19 61/84] powerpc/spinlocks: Include correct header for static key
Date:   Sat, 11 Jan 2020 10:50:38 +0100
Message-Id: <20200111094909.129295013@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 6da3eced8c5f3b03340b0c395bacd552c4d52411 upstream.

Recently, the spinlock implementation grew a static key optimization,
but the jump_label.h header include was left out, leading to build
errors:

  linux/arch/powerpc/include/asm/spinlock.h:44:7: error: implicit declaration of function ‘static_branch_unlikely’
   44 |  if (!static_branch_unlikely(&shared_processor))

This commit adds the missing header.

mpe: The build break is only seen with CONFIG_JUMP_LABEL=n.

Fixes: 656c21d6af5d ("powerpc/shared: Use static key to detect shared processor")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191223133147.129983-1-Jason@zx2c4.com
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/spinlock.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -19,6 +19,7 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
+#include <linux/jump_label.h>
 #include <linux/irqflags.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>


