Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54152137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593367;
	bh=8NdyMr0qdCkBqkHhbsdLzyk7q5G2WaeawI26KLzIdkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bIXXRX7cj8wjlxHtYEpTV9VyX2Lyx9t+BZUdikQm7PuJ/W/oYo+DOAnae6efmDrB9
	 UQAgEW1qAd7qP0zYx5srPkTdxuBQ8KzS/9zLeF2sn/PavuXb5SWtHrz/PeA9tgaCnr
	 zy16twypgXaE8zQWp6/LIclQ6Q1FfDfEt1e5vvuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbgIHT30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFF6246F0;
        Tue,  8 Sep 2020 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579626;
        bh=8NdyMr0qdCkBqkHhbsdLzyk7q5G2WaeawI26KLzIdkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huTy24YQU8zcGoPGUQoPScqVn8Op+wxuPAAXxrrrOMdq8I7m+aGqRopuaj5za5GRr
         2PP023RefNpy24tKPLzo8NYTG4V4EhAxCwTfLoPc5X9NsoBfSOuMv0KfM+f6b0AWxc
         4Uo8QxipIVer/m447LdgLr2SsiQLpu4muxrqOQoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.8 156/186] s390: fix GENERIC_LOCKBREAK dependency typo in Kconfig
Date:   Tue,  8 Sep 2020 17:24:58 +0200
Message-Id: <20200908152249.222776843@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Farman <farman@linux.ibm.com>

commit 114b9df419bf5db097b322ebb03fcf2f502f9380 upstream.

Commit fa686453053b ("sched/rt, s390: Use CONFIG_PREEMPTION")
changed a bunch of uses of CONFIG_PREEMPT to _PREEMPTION.
Except in the Kconfig it used two T's. That's the only place
in the system where that spelling exists, so let's fix that.

Fixes: fa686453053b ("sched/rt, s390: Use CONFIG_PREEMPTION")
Cc: <stable@vger.kernel.org> # 5.6
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -30,7 +30,7 @@ config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
 config GENERIC_LOCKBREAK
-	def_bool y if PREEMPTTION
+	def_bool y if PREEMPTION
 
 config PGSTE
 	def_bool y if KVM


