Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8889C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34862193E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vpd863DW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGNDgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGNDgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:36:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:36:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d27so19893418ybe.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0+nyRB4FjMX87DKB086K0BKyIubl+CqEw8r/lrjQmxQ=;
        b=Vpd863DWtRje1jzZiUqY+85x9YDp4OKtuawen/XxjhstnxKOa7+DKF8jeefo/rEiRg
         cJ57qzZjMfX/dwbrFBeJeN5UN17t4L7D/nwyKuCMNMcSIok2yLJLdK3zBpo404vdBcXL
         TR98Qx9PIM8D2zbFibUMHBTV/sAFcy7UXxWF62zWnLmxFVTtxCqKMChrp41V5WbCs3oX
         mbQwZKZ7b/LteXsP8WqdbjjldWR0uBke8c+ZnY9ccAXVH/d2HenbCWCgcW0m55Ifo1bh
         +oWfC1CVcqvxshVIfhR/zZ3XKORCM3CqNWJQt7sEkW1v60Xwu7eIXake3VQSvBZ/Sz7C
         eoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0+nyRB4FjMX87DKB086K0BKyIubl+CqEw8r/lrjQmxQ=;
        b=buM+AgHYbeyuBRpOtSrJmhjUo1Yl5WBHOWYip9WctMDpJ7SwBxJZuO/tpuWwSjiYRz
         UTjxxrU7XvBxdLv9SjHs3p2qg435qDu1g+pCtecc27Bhc0cUX4xLsqB0otw3SgF8uGI7
         hYJxjE8tx5e2nqvCZHm+fbzFjjktcwCEhpnTPTqzyapmUkY+Hs27aKGnjPT31ALI4vP1
         hikCK3XApAT7NlRyyqrnv9G80/q0anPSnS41MDbzp9VMKSinRRvD0u0tyI0T/OOwPH23
         ho99SjIhOW6/7mMwv3+6hOqFKjNKG2em0PXi+Oqn3HK8BB4rkM2NB28FAuFMdxiZbcTq
         p8WQ==
X-Gm-Message-State: AOAM533g/dB0O4Omcn1fhEOYPsyXu+b945+7za6ijGVItaf8Gq+UjAVr
        i8c7as6Z/2+rP7FR9oP28Hrmqr5iWpbb
X-Google-Smtp-Source: ABdhPJypXU4xQMjv4OfZEmpngqqwsqY3SfhQH2rS2+ro4iTC+chO8wmNzvludTkKpsLR9hoBfW8VQBBqU8Ny
X-Received: by 2002:a25:d104:: with SMTP id i4mr5388671ybg.176.1594697779588;
 Mon, 13 Jul 2020 20:36:19 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:34:52 +0800
In-Reply-To: <20200714033453.4044482-1-kyletso@google.com>
Message-Id: <20200714033453.4044482-2-kyletso@google.com>
Mime-Version: 1.0
References: <20200714033453.4044482-1-kyletso@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 1/2] usb: typec: Comment correction for typec_partner_register_altmode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_register_altmode returns ERR_PTR on failure.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index c9234748537a..02655694f200 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -580,7 +580,7 @@ EXPORT_SYMBOL_GPL(typec_partner_set_identity);
  * SVID listed in response to Discover Modes command need to be listed in an
  * array in @desc.
  *
- * Returns handle to the alternate mode on success or NULL on failure.
+ * Returns handle to the alternate mode on success or ERR_PTR on failure.
  */
 struct typec_altmode *
 typec_partner_register_altmode(struct typec_partner *partner,
-- 
2.27.0.389.gc38d7665816-goog

