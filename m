Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA02C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A167A2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578511;
	bh=w0pont9YxTvzq6A02FpwioLyzwEFmcqCrB0EfSaeds8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CFjLbu2WiZmvqFejETApOAaBdhIbfT4lYC99GiQ4Grpx4/WAExEF59jVvH2O9kHGA
	 QqR8PE7HiSfzM54Q6LM1k15H6ygPIGslPPEsdqupVioe70xFraz0pK/Cppbgl4EDlk
	 6RoAaosPTXwbPCJpBmpwPvJsEbKFup4tY7b1Z8pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbgFSOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389924AbgFSOzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14D821556;
        Fri, 19 Jun 2020 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578505;
        bh=w0pont9YxTvzq6A02FpwioLyzwEFmcqCrB0EfSaeds8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PejAPDsuDi28jMqefeibj0nd4/WkzecNGItUuc3aYJc/PCRnbzWunR+ol91xt5HC3
         qVs+iFaXSyRAEgg9MW5nGR4cPnJzLUq25MuzR7Am9bAxSh6h3cU7CrJrKNTACVGafO
         dVbNlDY502MZ+4QNZkVuiS9vWxxbwV28v7Fr09lc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 047/267] crypto: cavium/nitrox - Fix nitrox_get_first_device() when ndevlist is fully iterated
Date:   Fri, 19 Jun 2020 16:30:32 +0200
Message-Id: <20200619141651.147958843@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 320bdbd816156f9ca07e5fed7bfb449f2908dda7 upstream.

When a list is completely iterated with 'list_for_each_entry(x, ...)', x is
not NULL at the end.

While at it, remove a useless initialization of the ndev variable. It
is overridden by 'list_for_each_entry'.

Fixes: f2663872f073 ("crypto: cavium - Register the CNN55XX supported crypto algorithms.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/cavium/nitrox/nitrox_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -183,7 +183,7 @@ static void nitrox_remove_from_devlist(s
 
 struct nitrox_device *nitrox_get_first_device(void)
 {
-	struct nitrox_device *ndev = NULL;
+	struct nitrox_device *ndev;
 
 	mutex_lock(&devlist_lock);
 	list_for_each_entry(ndev, &ndevlist, list) {
@@ -191,7 +191,7 @@ struct nitrox_device *nitrox_get_first_d
 			break;
 	}
 	mutex_unlock(&devlist_lock);
-	if (!ndev)
+	if (&ndev->list == &ndevlist)
 		return NULL;
 
 	refcount_inc(&ndev->refcnt);


