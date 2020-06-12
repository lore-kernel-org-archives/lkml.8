Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713EBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304C120723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hb9fxq.ch header.i=@hb9fxq.ch header.b="m6WTNBfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFLUfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:35:06 -0400
Received: from sw.superlogical.ch (sw.superlogical.ch [IPv6:2a03:4000:9:189::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BBDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:35:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66A2FC22FD;
        Fri, 12 Jun 2020 22:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hb9fxq.ch; s=default;
        t=1591994095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wROdf8HBRYGjci+FcVWPhwOc9p6yIiBON7n20xZn4+Y=;
        b=m6WTNBfxbZa77BWcHve2lgxpX6gH/O36ljv05GMeame+CGhnmyQ7qNjEn6I0zt5maQJxI9
        Bf+FtO0GTf7I+WknbOS8G65oAl4zfWZahZU61J4RQGXR7b5Yyj1N7ZBOvVGslYzl6ZRT3b
        3MvrS7J0wZ808pcBzhKMH+VD+HINYbOqslPtLKt4neshNH8ppZ3xesVrza1ogwYXL6TT8d
        dQGv09gVoZ3zLbkr7JiWNME5GikfbWxH1fbJuTbcwRKedCrfDhcDOjXEEzxkGb3cqT2V2H
        1ZTgWjU1PyWW/X/TA5F5macxWFiWq6az8A51h1PiVOYDxg9mWBtut5wJ49S24Q==
From:   Frank Werner-Krippendorf <mail@hb9fxq.ch>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Werner-Krippendorf <mail@hb9fxq.ch>
Subject: [PATCH] dh key: Missing a blank line after declarations
Date:   Fri, 12 Jun 2020 22:34:58 +0200
Message-Id: <20200612203458.13517-1-mail@hb9fxq.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a "WARNING: Missing a blank line after declarations" issue found by checkpatch.pl

Signed-off-by: Frank Werner-Krippendorf <mail@hb9fxq.ch>
---
 security/keys/dh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index c4c629bb1c03..5515f51e62db 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -161,6 +161,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 		if (zlen && h) {
 			u8 tmpbuffer[32];
 			size_t chunk = min_t(size_t, zlen, sizeof(tmpbuffer));
+
 			memset(tmpbuffer, 0, chunk);
 
 			do {
-- 
2.20.1

