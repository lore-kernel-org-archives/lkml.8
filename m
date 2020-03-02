Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5678C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739B724699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PapF6bcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgCBE2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:28:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42672 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBE2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:28:04 -0500
Received: by mail-il1-f195.google.com with SMTP id x2so8130651ila.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eA866NsUcoe47QybbX2bbWbiIRZ+UOyy5FFG5tOcF3E=;
        b=PapF6bcTlsn1ICnhH4a9YZ/+FjgFYkajDqXa7rhM3bhnt4Lj9w0cbylZY0/qZA/czp
         dKDL4yTeyJwDvPZNUH7cAGRrr4JSGyY+hFU1qTy90TJ/nVZqmtkvm6NY6rlSbTJt9/Uf
         G2jViYgN+QC4Emnc+i++eMYJYjF3mi/X9vklpnM335T9Y110W6UPc2+NnE65BHBgx3oz
         GJXEWMhJHHPlHGSTYi9xd/NEGZGdvQ9+Gd4cTRvpcbyFUlwEetPIJ9HJhhl+IhL/5GRs
         bahS72M9cEvxuuk4DhvCxix1ky3dpOXax5bA+Y2vw01EsZC3Nv8mp3lrxyfuKPNa5WUM
         cTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eA866NsUcoe47QybbX2bbWbiIRZ+UOyy5FFG5tOcF3E=;
        b=XfA44+nqQ+5pH5LoEWnQrjAthC691pLQi5iZc9NmOrGZYaNGS6w3pZ590Q+k2bhil9
         tGonVziortJo1EYzYOpFSpJS3qtlOQ/B+/vJbizuUzTqYW3LTBMg6l6cqpW44v5KNF4A
         ZnXbL6PdOGmez16IGP+lK5gYnqpSe+MdzEb00bkQadcusoO20qBp4vkSgTugAypbUVYQ
         ugADSTVRaIxsQIP/fGT5hxf1QehjhNbEWSCC6VeI5D+BZxYDSYxlMroS4pCneZGBv/Es
         fQ82oMJDWNAeto1Q72Fh19Uhb0yQ5OU7WPkIhBoh6vg39zx6XfB7dswTQXtA0hwuXBsV
         iBgQ==
X-Gm-Message-State: APjAAAXbL1ZO/1jWM327vqMiO5gvbKD9D7fvyAbY2ct4HWYqVHFwTH/m
        PqkoOsaso25m13P/+dRiL4BiFHra
X-Google-Smtp-Source: APXvYqwcsWl4E5Pe0hgt1RxST4ycr0bhb79N2JKLchDYgAiKsQohlr9wK3urVyBqTPZp4+Zqk7VamQ==
X-Received: by 2002:a92:8fd7:: with SMTP id r84mr11843557ilk.83.1583123283469;
        Sun, 01 Mar 2020 20:28:03 -0800 (PST)
Received: from bifrost (c-71-196-210-244.hsd1.co.comcast.net. [71.196.210.244])
        by smtp.gmail.com with ESMTPSA id m26sm1402564ioc.75.2020.03.01.20.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:28:03 -0800 (PST)
Date:   Sun, 1 Mar 2020 21:27:59 -0700
From:   Cody Planteen <planteen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
Subject: [PATCH 2/2] rslib: test: Yield to prevent RCU stall messages and fix
 comment typos
Message-ID: <a309f09e07374e62a77bb84c70e6715efd288448.1583122776.git.planteen@gmail.com>
References: <cover.1583122776.git.planteen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1583122776.git.planteen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, running the test leads to lots of annoying
"rcu: INFO: rcu_sched self-detected stall on CPU" messages with stack
trace.

Signed-off-by: Cody Planteen <planteen@gmail.com>
---
 lib/reed_solomon/test_rslib.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 4eb29f365ece..aa61ac7715de 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/random.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 
 enum verbosity {
@@ -169,7 +170,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
 	memset(c + dlen, 0, nroots * sizeof(*c));
 	encode_rs16(rs, c, dlen, c + dlen, 0);
 
-	/* Make copyand add errors and erasures */
+	/* Make copy and add errors and erasures */
 	memcpy(r, c, len * sizeof(*r));
 	memset(errlocs, 0, len * sizeof(*errlocs));
 	memset(derrlocs, 0, nroots * sizeof(*derrlocs));
@@ -327,8 +328,11 @@ static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
 		pr_info("  %s\n", desc[method]);
 
 	for (errs = 0; errs <= nroots / 2; errs++)
-		for (eras = 0; eras <= nroots - 2 * errs; eras++)
+		for (eras = 0; eras <= nroots - 2 * errs; eras++) {
+			/* yield to prevent rcu stall messages */
+			cond_resched_rcu();
 			test_uc(rs, len, errs, eras, trials, &stat, ws, method);
+		}
 
 	if (v >= V_CSUMMARY) {
 		pr_info("    Decodes wrong:        %d / %d\n",
@@ -385,7 +389,7 @@ static void test_bc(struct rs_control *rs, int len, int errs,
 
 			/*
 			 * We check that the returned word is actually a
-			 * codeword. The obious way to do this would be to
+			 * codeword. The obvious way to do this would be to
 			 * compute the syndrome, but we don't want to replicate
 			 * that code here. However, all the codes are in
 			 * systematic form, and therefore we can encode the
@@ -420,8 +424,11 @@ static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
 			eras = 0;
 
 		cutoff = nroots <= len - errs ? nroots : len - errs;
-		for (; eras <= cutoff; eras++)
+		for (; eras <= cutoff; eras++) {
+			/* yield to prevent rcu stall messages */
+			cond_resched_rcu();
 			test_bc(rs, len, errs, eras, trials, &stat, ws);
+		}
 	}
 
 	if (v >= V_CSUMMARY) {
-- 
2.20.1

