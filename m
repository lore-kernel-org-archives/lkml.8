Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8F3208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXxsLfjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgIDTlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:41:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726221AbgIDTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599248491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LfMo0bPH1qwF7NhkKROPvBHvn6aBWYvqMe0We0V1A0=;
        b=HXxsLfjBYjbu6NGky4ZQ0HHmqN6pgZ7Fn9BdIClHifGWuoqpfHiqCMSvdhrTJuuOnZ2Hg3
        QNRNd4Sz+RlRTaWLwcvD0RNbkdpI1pP8XSC4RarEvNYHUIh/5TXA/ObzxaC8SQe/RaERwA
        eMYl6AZ9CfDm8Thpp8yRxPnfaApXdWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-6gBDPg3gMXel9fFtSjWU5g-1; Fri, 04 Sep 2020 15:41:29 -0400
X-MC-Unique: 6gBDPg3gMXel9fFtSjWU5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968D71DE13;
        Fri,  4 Sep 2020 19:41:28 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74735C1D0;
        Fri,  4 Sep 2020 19:41:24 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 4/4] integrity: prompt keyring name for unknown key request
Date:   Fri,  4 Sep 2020 16:41:00 -0300
Message-Id: <20200904194100.761848-5-bmeneg@redhat.com>
In-Reply-To: <20200904194100.761848-1-bmeneg@redhat.com>
References: <20200904194100.761848-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the IMA policy a key can be searched in multiple keyrings (e.g.
.ima and .platform) and possibly failing for both. However, for the user not
aware of the searching order it's not clear what's the keyring the kernel
didn't find the key. With this patch we improve this feedback by printing
the keyring "description" (name).

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/digsig_asymmetric.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index cfa4127d0518..14de98ef67f6 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -55,8 +55,14 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 	}
 
 	if (IS_ERR(key)) {
-		pr_err_ratelimited("Request for unknown key '%s' err %ld\n",
-				   name, PTR_ERR(key));
+		if (keyring)
+			pr_err_ratelimited("Request for unknown key '%s' in '%s' keyring. err %ld\n",
+					   name, keyring->description,
+					   PTR_ERR(key));
+		else
+			pr_err_ratelimited("Request for unknown key '%s' err %ld\n",
+					   name, PTR_ERR(key));
+
 		switch (PTR_ERR(key)) {
 			/* Hide some search errors */
 		case -EACCES:
-- 
2.26.2

