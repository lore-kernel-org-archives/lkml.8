Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D177C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B35220732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQUAZWLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgDMIfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgDMIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:10:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635FC008616
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:05:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o81so3042425wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pF3os/zIvJX+FxOE+3LXE7wUPykZDFerUtI/+GJzXq4=;
        b=eQUAZWLFUuw+i5lPKOUDRRGyhb4POIW1/mU/kKyDEUPZakUEZYiYBl9io2BD8+fUQc
         8s9XF4/u392LD16GU6Zf8IiW2322rtyc4y/YIBfUdDDRj+6zh/fTbILbG84lQiiC9Dmk
         AhPQChC6pumuVGguYWznU5KAP1KwgS7k68x09Jef7LlFdIVbALgGNB1uuzmQ7VeTIo7y
         puluWgntI/gSdajBI2t9AcV2wXJHeqvbFLXQYhMW+a16Mu7eBEyIpTMEZ1yELCI2A/8M
         6ABws4YNAmC3lqXYesPlebDNTLNWT5dJa1GsYyzipIO3wy7ntLjgcI9A8Ey+5nYFUXuH
         k9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pF3os/zIvJX+FxOE+3LXE7wUPykZDFerUtI/+GJzXq4=;
        b=SszZI7y0W8yBVtUfOgwTj3PsKhVgHH21uwRt7a8E6CjACYcUU2ORqaegMAvv+4CBkI
         Mzo19A5DE+ncU8Oh2wz1SDLyOAGq24SAmgmn5GeAhgvzdUKSlloZN1Y8gLCeu2C1bVQQ
         TUhWGU4v5vfm8pMzh1Jcop6uJS20E2GSEailctgsj54tjlAnQs8q+tqYw9Z+CMuZgzFc
         3PIaCJVk/YmaY77vTFzTEcooIPnLzHHqHgZ+9aECns9bxBij+dmJR58LiULQuZUmlrk+
         2+GWrMapbtur+99REIGCkiYGmElsdXWh8hIgbk6Gf5lCVsrOJ4BSd3vYc0xKO9s8oPEf
         /rzg==
X-Gm-Message-State: AGi0PuZZCUHarxRZgICt6XzcKdyACac7Pzj7RwKWoeyMhrTlifmRKeuL
        t0F/oxAUaBJgEUsikfRK9XSHl/Lw91+fqQ==
X-Google-Smtp-Source: APiQypLNndLmyzXn/0Rdm9JTfoVXrXepFBHuEFg9lZbLD1HxF7imHbvanJtQQ4bhSGkLyndLHsN53w==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr17348218wmd.88.1586765156226;
        Mon, 13 Apr 2020 01:05:56 -0700 (PDT)
Received: from localhost.localdomain ([31.4.236.192])
        by smtp.gmail.com with ESMTPSA id k3sm13669900wmf.16.2020.04.13.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 01:05:55 -0700 (PDT)
From:   carlosteniswarrior@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
Subject: [PATCH] Staging: Comedi: Drivers: das08: Fixed some coding style issues
Date:   Mon, 13 Apr 2020 10:05:55 +0200
Message-Id: <20200413080555.29267-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue caused by some declarations that weren't separated.

Signed-off-by: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
---
 drivers/staging/comedi/drivers/das08.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/comedi/drivers/das08.c b/drivers/staging/comedi/drivers/das08.c
index 65e5f2e6c122..f884f5841788 100644
--- a/drivers/staging/comedi/drivers/das08.c
+++ b/drivers/staging/comedi/drivers/das08.c
@@ -141,7 +141,9 @@ static const struct comedi_lrange *const das08_ai_lranges[] = {
 static const int das08_pgh_ai_gainlist[] = {
 	8, 0, 10, 2, 12, 4, 14, 6, 1, 3, 5, 7
 };
+
 static const int das08_pgl_ai_gainlist[] = { 8, 0, 2, 4, 6, 1, 3, 5, 7 };
+
 static const int das08_pgm_ai_gainlist[] = { 8, 0, 10, 12, 14, 9, 11, 13, 15 };
 
 static const int *const das08_ai_gainlists[] = {
-- 
2.26.0

