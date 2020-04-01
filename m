Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09695C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A7A208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zv.io header.i=me@zv.io header.b="PHr7jsq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgDAVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:46:17 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21194 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:46:17 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2020 17:46:16 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1585776653; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QvSiCxxe2w79MR2WQA6qr5ReJVNqXpDMdsAfYYgsGDXGjmQy1yPhlQfEjyl99WRYR3x2V6j06QVfVuMy9VDeQGPTQRY31PLszJFSY8GhngRpMR4KhDA5vf9b1mE8yU+7mJIwss85tco7V4Rp26Y3sNBD5frt/iBwG6vjzpzxH5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585776653; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Ovd3KQjj+XaAtRsbbcvIASUZe23NDleaSRa1Iv2OAes=; 
        b=AOZ+NHrkjd3EegnNZQVoOAjJ784s8RAanHVzrSbYYuVIuETh+rWj4jb/w5YIt5wnb6GycZr2s/+3X0cbXC5kP8XzkqX2eykhkZmH6VAv3daBkaTrq2aHsYboXT5BnK/5jKaZDWQ9s5ykQAc0Wjk9Sb1M767yPTOmr8oN3VZE1J0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zv.io;
        spf=pass  smtp.mailfrom=me@zv.io;
        dmarc=pass header.from=<me@zv.io> header.from=<me@zv.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585776653;
        s=zoho; d=zv.io; i=me@zv.io;
        h=Message-ID:Subject:From:To:Cc:Date:Content-Type:Mime-Version:Content-Transfer-Encoding;
        bh=Ovd3KQjj+XaAtRsbbcvIASUZe23NDleaSRa1Iv2OAes=;
        b=PHr7jsq44fpSmSOvXVAbNm2tX84DDMlK4B1Eq0sEBAZ/M8fjet76eBXGjU3Z0rFE
        T7qpq4X9GYr9es9IYOK7F14kJ+hulNyZybcrYcg9XHMhH5CTyc4EOqO6l0FR69DmnSo
        BxDxFI2V9ZM+RR3lxWJ/Faz6N2BlB9utrtylOI+0=
Received: from powerhouse (cpe-70-114-218-141.austin.res.rr.com [70.114.218.141]) by mx.zohomail.com
        with SMTPS id 1585776649042727.6372832244042; Wed, 1 Apr 2020 14:30:49 -0700 (PDT)
Message-ID: <a1f6271e7c72e49fd863efc4b7126be6598fd4f6.camel@zv.io>
Subject: [PATCH] um: add include: memset() and memcpy() are in <string.h>
From:   Zach van Rijn <me@zv.io>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date:   Wed, 01 Apr 2020 16:30:48 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are otherwise unknown to the pedantic compiler.
Include the correct header to enable the build to succeed.

Signed-off-by: Zach van Rijn <me@zv.io>
---
 arch/um/os-Linux/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 26ecbd64c409..044836ad7392 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
-- 
2.25.1


