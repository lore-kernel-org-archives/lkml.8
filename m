Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630C2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4011A21527
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322775;
	bh=ehGZLwBStwiNoBJPxCADAHxsq8vyqACAuHk60HMadMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCqP77KRhxVznSdOTymnZmqauGZKX4Qa+P1XZ9SCTIIUqPyQkpMoX60xw1hQp+FPV
	 tlD90m8dTd8zADAbMKEHZO9P5JRHLMI92KmHyXD0Z4YoFLb8AcXQfuFYAfxRZyNbCz
	 7VgBg+QObcXOCL/B1COKbsZjqaObfXCloD7fFzEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgFPPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732813AbgFPPwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:52:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5934D21534;
        Tue, 16 Jun 2020 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322768;
        bh=ehGZLwBStwiNoBJPxCADAHxsq8vyqACAuHk60HMadMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffseDg6qwoG0ruDJxqEiCrDHEZi/Rqm721V4nRv2gQ0/13iQc5FRRkd11Ck59GD+1
         7dY4Ez2R+FdkioGZEivSr+2KzvRRNC4y71nza9nL4NSKCTuv4OAs89uU3J4Pcbh1C0
         uR6FJIXl3p+aMy1feGeX7/5j/QWhUE8aHZs4VsdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.6 095/161] crypto: cavium/nitrox - Fix nitrox_get_first_device() when ndevlist is fully iterated
Date:   Tue, 16 Jun 2020 17:34:45 +0200
Message-Id: <20200616153110.904427046@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
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
@@ -278,7 +278,7 @@ static void nitrox_remove_from_devlist(s
 
 struct nitrox_device *nitrox_get_first_device(void)
 {
-	struct nitrox_device *ndev = NULL;
+	struct nitrox_device *ndev;
 
 	mutex_lock(&devlist_lock);
 	list_for_each_entry(ndev, &ndevlist, list) {
@@ -286,7 +286,7 @@ struct nitrox_device *nitrox_get_first_d
 			break;
 	}
 	mutex_unlock(&devlist_lock);
-	if (!ndev)
+	if (&ndev->list == &ndevlist)
 		return NULL;
 
 	refcount_inc(&ndev->refcnt);


