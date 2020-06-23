Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501A620702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945798;
	bh=SxyvSRQdP/oBsDW8DbXBAL6YdZBkaEfAOCB+Zzit6/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DGLSkSM4MVHTwBBL/+zmIiR+8rMf1IXA+FrEavozhQ05T92z+BBAeckqIXPXli9C3
	 X83S+x69RW+FP5Qlp2bwPaSTmlNxBICv3nqa4zUP6rkzh75YW33wKj66/YXdSujYEm
	 FMkXAcOLEqNwQ2Ej3dEACyXdG855C67Xow0oE2D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392952AbgFWU4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403914AbgFWUnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C53E21BE5;
        Tue, 23 Jun 2020 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945011;
        bh=SxyvSRQdP/oBsDW8DbXBAL6YdZBkaEfAOCB+Zzit6/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilmOqijePMdGh2TilnfALM0kvZ16SXviIzX+yh4YA9vwVoH1wU54XSLHvCdAQSLu3
         9c2gvcU6UsgaqCDkqa9BMXTtKnT+KY00PIlxIGdvpdX5XzdYRYzIEP3KDJ2bWul32z
         rXxj4zhDXGoCx+km17DZB6T0Jr8tEiy85QUvesEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Gerow <gerow@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        =?UTF-8?q?Kai=20L=C3=BCke?= <kai@kinvolk.io>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 199/206] crypto: algboss - dont wait during notifier callback
Date:   Tue, 23 Jun 2020 21:58:47 +0200
Message-Id: <20200623195326.828238315@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 77251e41f89a813b4090f5199442f217bbf11297 upstream.

When a crypto template needs to be instantiated, CRYPTO_MSG_ALG_REQUEST
is sent to crypto_chain.  cryptomgr_schedule_probe() handles this by
starting a thread to instantiate the template, then waiting for this
thread to complete via crypto_larval::completion.

This can deadlock because instantiating the template may require loading
modules, and this (apparently depending on userspace) may need to wait
for the crc-t10dif module (lib/crc-t10dif.c) to be loaded.  But
crc-t10dif's module_init function uses crypto_register_notifier() and
therefore takes crypto_chain.rwsem for write.  That can't proceed until
the notifier callback has finished, as it holds this semaphore for read.

Fix this by removing the wait on crypto_larval::completion from within
cryptomgr_schedule_probe().  It's actually unnecessary because
crypto_alg_mod_lookup() calls crypto_larval_wait() itself after sending
CRYPTO_MSG_ALG_REQUEST.

This only actually became a problem in v4.20 due to commit b76377543b73
("crc-t10dif: Pick better transform if one becomes available"), but the
unnecessary wait was much older.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207159
Reported-by: Mike Gerow <gerow@google.com>
Fixes: 398710379f51 ("crypto: algapi - Move larval completion into algboss")
Cc: <stable@vger.kernel.org> # v3.6+
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reported-by: Kai Lüke <kai@kinvolk.io>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/algboss.c |    2 --
 1 file changed, 2 deletions(-)

--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -193,8 +193,6 @@ static int cryptomgr_schedule_probe(stru
 	if (IS_ERR(thread))
 		goto err_put_larval;
 
-	wait_for_completion_interruptible(&larval->completion);
-
 	return NOTIFY_STOP;
 
 err_put_larval:


