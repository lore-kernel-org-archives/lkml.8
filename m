Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2F0C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C66207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2eMOiAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBRHBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:01:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39680 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRHBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:01:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so582222pjr.4;
        Mon, 17 Feb 2020 23:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yh8ep9gNRxe++6137Mgm10a6D9w4c5jPeBlJuaZxcZA=;
        b=V2eMOiAKF72gwUEuH7p6XRTElP7ocxjgHZocnwMH5eF1qSUs6UX2npOE4+YdJUAoKx
         0Zp9mUe+Rm6AFZWixvEgMQbrMy3KjuMgZPczWtlHJjaGDxyrefNMVjtg+RUVCeDIM2sx
         gwNn6h1nt9JJFP/QvYjRZFHhtgzK+fqh+YRKWbdFzXu3HLFkaE1XGfVHMxDUxv2oOAnr
         iWNN400G+JMikJvftTftqEo9Uoxux5+B1IULNfUqeuJMbQqVi/+UVXHKyUfKu8qn25Yn
         ruAxMqj7lE5T/J2KakBeCneQk6tiPTMKusNtoMvsixh596FEIYTX6XRpTSm4xhFD6k+t
         LSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yh8ep9gNRxe++6137Mgm10a6D9w4c5jPeBlJuaZxcZA=;
        b=PSvS0nX1FjIY2aIIa9itrav8pHt8uIY9mBAeQlJBG0V4HZeBcZQru7UoxbGXq6r2N1
         YzjT4qwXfuSA6TAl60wv4OUSp/vB58xO/N/RfuSnEN3z/w/9+urvbak0F5GLidsu/tYc
         ZaqyPCLdlBFA5GfCGgp/qgoof+uN6TErfZYfihwqIfKu6dXu2x2A9DMQvmn1yT4s1TcK
         PX1cw2q2S8+fgsdsZ7l0Z3DUZtS5FuF1OscYZhx6x4dLRx3X8czsVZvWi0E8sH/Mc6HN
         gpKm7eleS4zEa8eyrCDGb9TO0ynjAk77O3U8831HwxCcbPC/+nKsGzPpRSXCWImwOsRa
         QsOQ==
X-Gm-Message-State: APjAAAWicnVl59lqET1isha7R/AgXqIlk61NM9iJgQyMv2s1/zizr1Gc
        SabHxYcTyoNwZHbTbiSsHU4=
X-Google-Smtp-Source: APXvYqwlLvkPUqXEWnYVfQarWFj/PrcjIut8GZl8vw95gsfK2HGSJCSmcu0IzizTmT0u2U90FqMb5w==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr19309706pll.136.1582009312456;
        Mon, 17 Feb 2020 23:01:52 -0800 (PST)
Received: from localhost.localdomain ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id h13sm1756680pjc.9.2020.02.17.23.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 23:01:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, federico.vaga@vaga.pv.it, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Replace stale url with active one for Mutt
Date:   Tue, 18 Feb 2020 12:28:54 +0530
Message-Id: <20200218065854.13152-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will replace  dead/stale url with the active urls.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/email-clients.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 5273d06c8ff6..bf8b4c9a4efe 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -237,9 +237,9 @@ using Mutt to send patches through Gmail::

 The Mutt docs have lots more information:

-    http://dev.mutt.org/trac/wiki/UseCases/Gmail
+    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail

-    http://dev.mutt.org/doc/manual.html
+    http://www.mutt.org/#doc

 Pine (TUI)
 **********
--
2.24.1

