Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB675C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD73F20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135653;
	bh=FHtrfojDjWvO9f6DayfxB+2Dkz7ankW9QigDjj4aI4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tbLr5WRNN3ZoIVWo1vA54onGsN0I0qy8G+0meaqdWShLmQq8I6OghcJnM+eUV6UnT
	 lRK+vn0IB+lAfJlGPMZdBFA/invv27saLQS/WTC/elKZL2lX/LVkrbmtbW7rlKVhhI
	 A9zVlf6NX/EFwn3D5o/lbfx2dtEcX5rqQ/eQq0CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgGGP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbgGGP1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:27:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3527206F6;
        Tue,  7 Jul 2020 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135640;
        bh=FHtrfojDjWvO9f6DayfxB+2Dkz7ankW9QigDjj4aI4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4pvfV16rQqtL+ZhRqwNY2N6gZruDMcIL+UpBC0Vvb5K71+FGFj1SP3wMo0jJn3Vg
         p2fM/VbgN0bJK/v7LBG/y0GCO6wx5+UOyBoITPTgj1loBk/RuWvZC+/WKDYINOE5TQ
         vEJAPiLDCkxZ555appCuOgXQZ4TtvFHhQLlJ658o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.7 088/112] padata: upgrade smp_mb__after_atomic to smp_mb in padata_do_serial
Date:   Tue,  7 Jul 2020 17:17:33 +0200
Message-Id: <20200707145805.166669818@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

commit e04ec0de61c1eb9693179093e83ab8ca68a30d08 upstream.

A 5.7 kernel hangs during a tcrypt test of padata that waits for an AEAD
request to finish.  This is only seen on large machines running many
concurrent requests.

The issue is that padata never serializes the request.  The removal of
the reorder_objects atomic missed that the memory barrier in
padata_do_serial() depends on it.

Upgrade the barrier from smp_mb__after_atomic to smp_mb to get correct
ordering again.

Fixes: 3facced7aeed1 ("padata: remove reorder_objects")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/padata.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -260,7 +260,7 @@ static void padata_reorder(struct parall
 	 *
 	 * Ensure reorder queue is read after pd->lock is dropped so we see
 	 * new objects from another task in padata_do_serial.  Pairs with
-	 * smp_mb__after_atomic in padata_do_serial.
+	 * smp_mb in padata_do_serial.
 	 */
 	smp_mb();
 
@@ -342,7 +342,7 @@ void padata_do_serial(struct padata_priv
 	 * with the trylock of pd->lock in padata_reorder.  Pairs with smp_mb
 	 * in padata_reorder.
 	 */
-	smp_mb__after_atomic();
+	smp_mb();
 
 	padata_reorder(pd);
 }


