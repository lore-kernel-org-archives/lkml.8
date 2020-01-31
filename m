Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDAAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012212173E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyrHFHmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgAaUxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:53:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAaUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:52:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so10226113wrt.6;
        Fri, 31 Jan 2020 12:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=228UNdFagu9MDgez5Gk2D4b+WKiLhk5rhvXeTp2xcp0=;
        b=NyrHFHmc5U5Y5+Qb/m9Iy3pousXuDaNTY4lm8wFpOTZMlcy8M3xEdHBZbSf05uUsAk
         SGtsruAGdeMn9Qyeal33ZAgNfChb+vHg8DKxBevAjHgbkT92fevo1R+XPCGMD0ntXMHi
         43+Zn20EbZ9WLmM/PfM+pRXCTgaXYhA6a6oiglSO6foStme1B+BskBqFtyYdWrcGC9Ba
         1RC5iEBM1v/QbO0VaSXYvhZvuSQHmxqBN+xphhIZJlGrB1mO/MnTvkUiaXWCcw7j0e82
         uZ64SZ6OnqsPmncvnTUzCXbemEbCZbuchJpwAuFvigLC2aQPXdpq3FcYI4L3LF+FVZ97
         A3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=228UNdFagu9MDgez5Gk2D4b+WKiLhk5rhvXeTp2xcp0=;
        b=jcqwa1nPDVyNXh+uJUEfoXV35qxfKOuw23cwr4sYKG284AAKhu0ZIUAwUFQXp1B1YB
         B9Bm27N0eidyvBlbckLZt2XdzoiEfwIW6HZ2DGAILPJQit50YzwoaWfYSWMq3+Apw3i3
         u16v3FaFyd8aXNN15w+JEWyFJsueMf1ncd0+a72KdfN3wPhoZ0lYo/K1Djm4Y8hLqgga
         dO9lutIgstKNkDSV3af/gxeDQFLukbsCeW1wH9M7zqeVQHuvdvANDNGYpLYA4LWsPAAi
         Uzv1v9AsioN0aa+yHYRbUiBFiyyI+8fUpS/rzUjqfOr6lKZQzRZ0tTk1EIrx24C2oF1M
         grJQ==
X-Gm-Message-State: APjAAAXyNCAzuUdtvd9ufCOnXkuaeOk/TIAYLbgNeYgpvlu+1ZVmnVZx
        GVjaFGcqlSlNASAx2BV7wPk=
X-Google-Smtp-Source: APXvYqwIxos97j+vRbbKMhELEeRZ1/GuHTSNRcybhHC8DNGgrL4MirnUKM/iG5HWBtOkDarkxwE6bQ==
X-Received: by 2002:adf:978a:: with SMTP id s10mr231352wrb.69.1580503973944;
        Fri, 31 Jan 2020 12:52:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id z3sm13483738wrs.94.2020.01.31.12.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:52:53 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] docs/ko_KR/howto: Insert missing dots
Date:   Fri, 31 Jan 2020 21:52:34 +0100
Message-Id: <20200131205237.29535-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131205237.29535-1-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index ae3ad897d2ae..6419d8477689 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -1,6 +1,6 @@
 NOTE:
-This is a version of Documentation/process/howto.rst translated into korean
-This document is maintained by Minchan Kim <minchan@kernel.org>
+This is a version of Documentation/process/howto.rst translated into korean.
+This document is maintained by Minchan Kim <minchan@kernel.org>.
 If you find any difference between this document and the original file or
 a problem with the translation, please contact the maintainer of this file.
 
-- 
2.17.1

