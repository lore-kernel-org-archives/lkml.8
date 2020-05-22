Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BBC206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFR172sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgEVJRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEVJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:17:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EEAC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:17:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so4731295pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1xYKxvvZ1z74EVfTyWa+2nvhPJspgg6ccXHqA7I5bu4=;
        b=lFR172sQ2cEdHj7hwVMucNDHtLV8DAy6vN/j7W9x5leMGqmM1IRqm0xgH3fxFQbZ0X
         bB42pdtpgiTI2cV4jJ7nRlOPu9mw7/0txoLoFiCWCfgxE7UnVZ2ZyQqQz51rDFJDePlj
         GscTYfipqeM5XkGB255ziuF7hHr+PzpdJJJ7lPSjk4vslQSeHrVyXYxN9KrPN//xYTny
         MZgPCWk+b45XqPkreMPhSiuh55VwYi7xOYcP7LkgYgw+MbppOe+99HBxHkiOdv++IsrG
         GLfZAtaZpi/D8gO4yE7lsCizDjNq58I1ZAO3kxCoPlZnpqsp61H/fShw4Y3WuArFhkjR
         FUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1xYKxvvZ1z74EVfTyWa+2nvhPJspgg6ccXHqA7I5bu4=;
        b=hKD7KDH8zV97hkpAeZQS0uD+WquMKEjQ9KQ5dbCfgpbN1PYn+nJ/r0axg22d1O5Wq0
         jZvR7wU2xx24ZsyGVjL8VrO7Kh8/UEF5N/r+okrGbiHd7d9nxcQu+H8XMYzrzPPXjNhS
         G01dYssKj0a5iQvLJYIFgJ4Z7VJr3oNXBI/qQZmEfd0iQzPct+fGZBvblfzhdmvISmud
         uceNOq9wDG4YZyPIf+pCbDutcx+mTMlgXKp7f9QpeRhBgrvmu2VmJOezFUxZAsziZ/pH
         4F7lGm9lAyPOVbeE3ERAtADVPywMh+IZW0J+w5PI2sz59uL69W6duNlSxZiHI3BRHRpF
         Fz0A==
X-Gm-Message-State: AOAM533BX9tYGIDin95bOsW8ngIZ+Q5SUxXxoGuTCMyR8VZyQKG+Eq3i
        BoLCiZOEJ/oU+ekJ2qQf0vw=
X-Google-Smtp-Source: ABdhPJwpZaaNYy7SGwVU4avF7WMe3u1BYvpK/nGnVS9yBCPYBmZ24ZIDsPkMcjAJwDSwg+GQJw16Pw==
X-Received: by 2002:a63:1615:: with SMTP id w21mr8174775pgl.217.1590139025750;
        Fri, 22 May 2020 02:17:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:690:5767:49e2:74e6:c65c:429e])
        by smtp.gmail.com with ESMTPSA id m63sm6612872pfb.101.2020.05.22.02.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 02:17:05 -0700 (PDT)
From:   MugilRaj <dmugil2000@gmail.com>
Cc:     MugilRaj <dmugil2000@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] taging: speakup: remove volatile
Date:   Fri, 22 May 2020 14:46:28 +0530
Message-Id: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
Documentation/process/volatile-considered-harmful.rst
Signed-off-by: MugilRaj <dmugil2000@gmail.com>
---
 drivers/staging/speakup/speakup_decext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/speakup_decext.c b/drivers/staging/speakup/speakup_decext.c
index ddbb7e9..22baaeb 100644
--- a/drivers/staging/speakup/speakup_decext.c
+++ b/drivers/staging/speakup/speakup_decext.c
@@ -21,7 +21,7 @@
 #define SYNTH_CLEAR 0x03
 #define PROCSPEECH 0x0b
 
-static volatile unsigned char last_char;
+static unsigned char last_char;
 
 static void read_buff_add(u_char ch)
 {
-- 
2.7.4

