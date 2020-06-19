Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87346C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6282B2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584681;
	bh=w0pont9YxTvzq6A02FpwioLyzwEFmcqCrB0EfSaeds8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1lKEK7c/xAOKMKger7ZloObpQIpgF3dzq+4jw2Rh4nQC9WhtzrOmWD0W3639kSEW
	 aAzU1tWwSo+s74vdbnucLuM2YcLYZMiNIiz846cRD6gxnhU6ndwXEnMs+rPftNUhur
	 Ti55lcyvnO6diBRpYajl/Y6mYBiWrlXOFyIKa3uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgFSOr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388007AbgFSOrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:47:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906FA20DD4;
        Fri, 19 Jun 2020 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578055;
        bh=w0pont9YxTvzq6A02FpwioLyzwEFmcqCrB0EfSaeds8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/bu26+05sNYEk9EkwSY1ZNyA7OyTtVD3S/U66zaO8JA60wfHhuGwFuqcGLzXdEXK
         Q0SHJrVd2p6pO5C74UGsEs42DPXN4939ykB5iZfeWaha+lufOcr15oeDfyfavgDmwG
         Qy/C+JMchIWK2CE+UlDGrT4xISbJ/wl5UxqALWAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 034/190] crypto: cavium/nitrox - Fix nitrox_get_first_device() when ndevlist is fully iterated
Date:   Fri, 19 Jun 2020 16:31:19 +0200
Message-Id: <20200619141635.252419295@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
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


