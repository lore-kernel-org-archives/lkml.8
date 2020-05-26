Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4DCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A214F208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521588;
	bh=V/sfiQpCncPkYxfnFXx1t4SCQlwZ//Kxz1si0PlRpq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LA0cKFsQH+9xsm5RMdpkAL6duqzVmBjSJ5seJMTc9AXsgBw33p+P2xoNxS+XG5DH3
	 bntO/A6bOucAIKm10NI0kl9z0+ZQ7p4wKZuF/91BbJjF1MjXQ+/muYfHmpJ0cR05qy
	 NEw6fxmta4oqsjnF2usGkvpXywRcQmp46bFspBbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbgEZS40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389806AbgEZS4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:56:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F57D208B8;
        Tue, 26 May 2020 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519382;
        bh=V/sfiQpCncPkYxfnFXx1t4SCQlwZ//Kxz1si0PlRpq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kMsWE0XN0+jJ5OLsEY91PH0a4rrlML3qmGSEFZdPfPsg8N3afr5EErJ7hoOdFcz7
         4ohowL2jE3guYVcf/SA/b0DEHd6SBFj8iUcToamU5jRcQE4J4tJSePNZ/nP+9T9MvF
         l8CT7Z2CqdX40Nmfm7ljjQGmNR4GYd0Aa44TF470=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 06/65] evm: Check also if *tfm is an error pointer in init_desc()
Date:   Tue, 26 May 2020 20:52:25 +0200
Message-Id: <20200526183908.421289701@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 53de3b080d5eae31d0de219617155dcc34e7d698 ]

This patch avoids a kernel panic due to accessing an error pointer set by
crypto_alloc_shash(). It occurs especially when there are many files that
require an unsupported algorithm, as it would increase the likelihood of
the following race condition:

Task A: *tfm = crypto_alloc_shash() <= error pointer
Task B: if (*tfm == NULL) <= *tfm is not NULL, use it
Task B: rc = crypto_shash_init(desc) <= panic
Task A: *tfm = NULL

This patch uses the IS_ERR_OR_NULL macro to determine whether or not a new
crypto context must be created.

Cc: stable@vger.kernel.org
Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
Co-developed-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 461f8d891579..44352b0b7510 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -47,7 +47,7 @@ static struct shash_desc *init_desc(char type)
 		algo = evm_hash;
 	}
 
-	if (*tfm == NULL) {
+	if (IS_ERR_OR_NULL(*tfm)) {
 		mutex_lock(&mutex);
 		if (*tfm)
 			goto out;
-- 
2.25.1



