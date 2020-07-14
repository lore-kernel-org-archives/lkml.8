Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C74C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CB122518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594748403;
	bh=ie+V0fQiEeLtoc7KjUdBC+Kd90jAwscL7G+GUJ3Hgns=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GAl2hkkT5nRgGkWVeXnYukLWaNplG69PR3ZtfiD5xIdl7OBQ58I+kxV5BOSavF3X1
	 TP2d6GryhiTRHD+LsmbAn+ktf+zPrpCzKpuEoLugumX/Pv6R9PRTB0MpKuzApTCfSQ
	 FUqq9phqcJ+CLERQ6FLmEhnMeJGmcV5Fr6bdAsHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgGNRkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:40:01 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:40701 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:40:01 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 06EHd5VO022065;
        Wed, 15 Jul 2020 02:39:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 06EHd5VO022065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594748346;
        bh=VSlrCdvfnyOvmg1z7jLB1HmUkH/aJAVl+cYuH7oRhd8=;
        h=From:To:Cc:Subject:Date:From;
        b=oUQKHpngLvTQI1Jaf8u0Rr53oK6ABUWQivPYf4GEOcK/nWwSLfSBjmbokIMGte55U
         j6zYSG4QlSp5BQOFimsdol8t1KDXBnJznVElB90zKxIr0M8DpyPrD1uYw/H6EPYfrw
         3W8qN8av79j3LWFu1f4nA9ntkU8eYrPwqLkdG4kk1+p/WOLdh2r4L6HHRwCBxJ3132
         x7W1n5nhPVriO1jcLQPuyqcwruE+6aulF7K4BscNY29SO0ZcQU+Whs4MY0q/lwyO8u
         O0jgkXieXZaQJRZS/N4gneHc/4t0MJ/1vVu28TMF+DYqbZuamXoi7nvZw6PKWFTLEi
         bnMfVmwwLyX+Q==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: ativic32: constify irq_domain_ops
Date:   Wed, 15 Jul 2020 02:38:57 +0900
Message-Id: <20200714173857.477422-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is passed to irq_domain_add_linear(), which accepts a pointer
to a const structure.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/irqchip/irq-ativic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
index 85cf6e0e0e52..476d6024aaf2 100644
--- a/drivers/irqchip/irq-ativic32.c
+++ b/drivers/irqchip/irq-ativic32.c
@@ -92,7 +92,7 @@ static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops ativic32_ops = {
+static const struct irq_domain_ops ativic32_ops = {
 	.map = ativic32_irq_domain_map,
 	.xlate = irq_domain_xlate_onecell
 };
-- 
2.25.1

