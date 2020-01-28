Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25922C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309D2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220527;
	bh=mMVHWPhGVr12UQgiIwOVH1+KWsDTW8eU+eNqwVQThDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fag7gYeNL+T+K/sdjdKI6+XET9VW6hwH6fcq49E82mxJ+nmaMVnr3X8C1w3vjjCcQ
	 61uk8bkeRAj9NOja402bSbIyZMY3NZr38wkIF3yMwCwt5rSFiPsnMi6BZzUeX6wPF+
	 IOU5fTOKP0IGt3CQfNif1w9g/pV3pj2OMhL2rojQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgA1OIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgA1OIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:08:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA242468D;
        Tue, 28 Jan 2020 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220511;
        bh=mMVHWPhGVr12UQgiIwOVH1+KWsDTW8eU+eNqwVQThDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGXfdCGNTN9nqIIAqGA9jM/y1yOibEtIQJt0HQAi0o/M1BLGl2G+8DoK1PYVHmYcB
         Vg63mFg1I6LibAhYIJOMph0f65EXAUcoffsaRm3M/ntoSF4PJ6q3aSzZ0iBWTvWpWB
         C0dwh82AU47U8uNDQUWyux3hx+Gc7SwVc12KocKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 008/183] pcrypt: use format specifier in kobject_add
Date:   Tue, 28 Jan 2020 15:03:47 +0100
Message-Id: <20200128135830.459415522@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1e3874c75ab15288f573b3532e507c37e8e7656 ]

Passing string 'name' as the format specifier is potentially hazardous
because name could (although very unlikely to) have a format specifier
embedded in it causing issues when parsing the non-existent arguments
to these.  Follow best practice by using the "%s" format string for
the string 'name'.

Cleans up clang warning:
crypto/pcrypt.c:397:40: warning: format string is not a string literal
(potentially insecure) [-Wformat-security]

Fixes: a3fb1e330dd2 ("pcrypt: Added sysfs interface to pcrypt")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/pcrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index f8ec3d4ba4a80..a5718c0a3dc4e 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -394,7 +394,7 @@ static int pcrypt_sysfs_add(struct padata_instance *pinst, const char *name)
 	int ret;
 
 	pinst->kobj.kset = pcrypt_kset;
-	ret = kobject_add(&pinst->kobj, NULL, name);
+	ret = kobject_add(&pinst->kobj, NULL, "%s", name);
 	if (!ret)
 		kobject_uevent(&pinst->kobj, KOBJ_ADD);
 
-- 
2.20.1



