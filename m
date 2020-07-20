Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04152C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DBC207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261675;
	bh=B3Bb4Lnno2qpjP9vt8hrDEQ574TUdIAISvH8Q5nSA0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJ247VBwFqv9KMujmhDlMNX6SuDLhl3+tL2AxbUKcOB8gNKRv7uqkPPNnLrbcojvB
	 hTZc5W4eMixXpcM4j5hJnjrYmNn1bhF/gk++PGDpjz3PqaHqwqUxKS0SfLWfb8hJnc
	 9LMfkkwuKsm50p5S7dRUOkh0JmI70SE0UbXujZTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgGTQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388278AbgGTQOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98B5207DD;
        Mon, 20 Jul 2020 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261672;
        bh=B3Bb4Lnno2qpjP9vt8hrDEQ574TUdIAISvH8Q5nSA0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Ken8zqCVGm7mI1taZdBDFEaGvoIlLxFiMLLxI1orSZ2KLTSpZohBhO9UIXTzPERq
         0mHZj29t1st1/S+VniBGzMl9fnZg2yyyX9/9cMgS9wU+WLSw3eUPzovlBtvhewhlt2
         32Et4Z5PrOoJ6/1ZdupBUKAJ48fV8o6Q9CsncnW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.7 200/244] powerpc/pseries/svm: Fix incorrect check for shared_lppaca_size
Date:   Mon, 20 Jul 2020 17:37:51 +0200
Message-Id: <20200720152835.360523689@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

commit b710d27bf72068b15b2f0305d825988183e2ff28 upstream.

Early secure guest boot hits the below crash while booting with
vcpus numbers aligned with page boundary for PAGE size of 64k
and LPPACA size of 1k i.e 64, 128 etc.

  Partition configured for 64 cpus.
  CPU maps initialized for 1 thread per core
  ------------[ cut here ]------------
  kernel BUG at arch/powerpc/kernel/paca.c:89!
  Oops: Exception in kernel mode, sig: 5 [#1]
  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries

This is due to the BUG_ON() for shared_lppaca_total_size equal to
shared_lppaca_size. Instead the code should only BUG_ON() if we have
exceeded the total_size, which indicates we've overflowed the array.

Fixes: bd104e6db6f0 ("powerpc/pseries/svm: Use shared memory for LPPACA structures")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
[mpe: Reword change log to clarify we're fixing not removing the check]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200619070113.16696-1-sathnaga@linux.vnet.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/paca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -86,7 +86,7 @@ static void *__init alloc_shared_lppaca(
 	 * This is very early in boot, so no harm done if the kernel crashes at
 	 * this point.
 	 */
-	BUG_ON(shared_lppaca_size >= shared_lppaca_total_size);
+	BUG_ON(shared_lppaca_size > shared_lppaca_total_size);
 
 	return ptr;
 }


