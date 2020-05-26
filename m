Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA822084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519716;
	bh=sBLqJNShOHXmDNNNqOoNbAAziCT3Qah9po5LF4SpzVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wg5fXvKMwZ7w0qGNii0s2pgf4ImH2D3v3Hnq00k+98Z9eZvvg3RYvROb6qT17Sd2U
	 0hHugtynrxkb/8CckHNSDSW3JV9QltzUDwd+rJ0zNoJcRi8pzAZn8tlIPnaYZTwqcl
	 +PuT6JkKIifJySJYSgHLikcAzL/8H39ApB8w+LhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbgEZTBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403807AbgEZTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:01:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8992084C;
        Tue, 26 May 2020 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519711;
        bh=sBLqJNShOHXmDNNNqOoNbAAziCT3Qah9po5LF4SpzVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGyyZ0/6ssFOxkUFKVWvfUKoJwbOsRwRDizfCXK5GaUiTigseJYO4IvBDRIYy2k70
         3km5mGxI8z86tHQaqFReRY3SkYuSMsjxoDSTOwqT4zAdHKz/W6WBRaeD2+xVWUPJWZ
         DBIAwFE2Wcq1AvYx4CzRswiHGV71/aGhd5A8av7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/59] padata: purge get_cpu and reorder_via_wq from padata_do_serial
Date:   Tue, 26 May 2020 20:53:14 +0200
Message-Id: <20200526183917.791170399@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

[ Upstream commit 065cf577135a4977931c7a1e1edf442bfd9773dd ]

With the removal of the padata timer, padata_do_serial no longer
needs special CPU handling, so remove it.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 6d0cdee9d321..f56ec63f60ba 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -323,24 +323,9 @@ static void padata_serial_worker(struct work_struct *serial_work)
  */
 void padata_do_serial(struct padata_priv *padata)
 {
-	int cpu;
-	struct padata_parallel_queue *pqueue;
-	struct parallel_data *pd;
-	int reorder_via_wq = 0;
-
-	pd = padata->pd;
-
-	cpu = get_cpu();
-
-	/* We need to enqueue the padata object into the correct
-	 * per-cpu queue.
-	 */
-	if (cpu != padata->cpu) {
-		reorder_via_wq = 1;
-		cpu = padata->cpu;
-	}
-
-	pqueue = per_cpu_ptr(pd->pqueue, cpu);
+	struct parallel_data *pd = padata->pd;
+	struct padata_parallel_queue *pqueue = per_cpu_ptr(pd->pqueue,
+							   padata->cpu);
 
 	spin_lock(&pqueue->reorder.lock);
 	list_add_tail(&padata->list, &pqueue->reorder.list);
@@ -354,8 +339,6 @@ void padata_do_serial(struct padata_priv *padata)
 	 */
 	smp_mb__after_atomic();
 
-	put_cpu();
-
 	padata_reorder(pd);
 }
 EXPORT_SYMBOL(padata_do_serial);
-- 
2.25.1



