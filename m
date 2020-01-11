Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC0C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644842072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eS8XOCrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgAKBrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:47:33 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35326 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgAKBrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:47:32 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so3329551ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JpGgv9YXpOY23vNaDGLnGu2ZYwtNlfr2fI6wCXLF6hg=;
        b=eS8XOCrlzpPjxW1PSce3x/VyPZ0UI1WQ5mm74rB0ThP5HaiAR4TIY7OmEtTfDXRzAd
         QKu4ngof12qGPnk6of+WyvhO/HCk5pHoWifAnLMvUqYwZiikUuK3WcpWcC1ibRO70mTX
         Ujf0VSKSNldiCbUbFzBZdnWesiuw6hN9nwyu7Uiuq0KEb30VZqK9oazOqkK3E2Dvudh1
         b3eOGeONjxv/8VivJAbyFYSXmlamqsfjb7rJy36VdHFrBlr+zJq+jtveAuZVi5h57I8w
         ixULOXQVBmcmhHGNXLy1dAmrXI6zCeWa2W8CYAXA4MT0bNBgheiBMSeK6dHilHZTiCDc
         g1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JpGgv9YXpOY23vNaDGLnGu2ZYwtNlfr2fI6wCXLF6hg=;
        b=cjFP8+o4IWjClgEM0ghwICfAs7vQ2hOps/lFFKhUPqfmMNXvXM8eYlJv+Px0mlkf4X
         6xKWDO9IouxRRCKNWiwPQERR+sh+5brQ8NzViuJbRVkxEFNOQA1Ch8k6xSWQdwoLVl1L
         4OlI3TmzHAt1L/bjmF4yC6oZp96Md+4OPTx+xQxEYP6JlqpLTJ5cOMZjnF2nUYcZNyGT
         TY+uCk6xGzXVRJhHXQL2NJD3lxMqi+157IknSHTTj4CpzsCnOvuw+X20EAGSz7EHjAvD
         44cDelLnIlO2mi4dhgBXVXyyk7DphAaevLapwGsI2halqSq5T8Xac/bMnGx3fZg07AcR
         pTEA==
X-Gm-Message-State: APjAAAUV9BF8QWLnVBBe/r1Fo/oiMBNUsB2wRo3Bd+IbSid3gjZRF1Se
        a8RybVlgYY6V5gEe0Df/RsUC3Q==
X-Google-Smtp-Source: APXvYqzvTbYxaqhyu6BnLTlw8zXYSIqbffrMcP/tgEXK6y4UgsYmv2TR2ti1KFqsTKd8zJEWPnxIhw==
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr5429771ils.287.1578707251939;
        Fri, 10 Jan 2020 17:47:31 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id p12sm1237771ilk.66.2020.01.10.17.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 17:47:31 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:47:28 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.h to include/soc
In-Reply-To: <alpine.DEB.2.21.9999.2001101704440.32308@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001101746310.40553@viisi.sifive.com>
References: <1578463746-25279-1-git-send-email-yash.shah@sifive.com> <alpine.DEB.2.21.9999.2001101704440.32308@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020, Paul Walmsley wrote:

> On Tue, 7 Jan 2020, Yash Shah wrote:
> 
> > The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
> > moves the sifive L2 cache driver to driver/soc. It did not move the
> > header file along with the driver. Therefore this patch moves the header
> > file to driver/soc
> > 
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> 
> Thanks, queued for v5.5-rc.

By the way, I fixed the include guard also.  The queued patch follows.


- Paul

From: Yash Shah <yash.shah@sifive.com>
Date: Tue, 7 Jan 2020 22:09:06 -0800
Subject: [PATCH] riscv: move sifive_l2_cache.h to include/soc

The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
moves the sifive L2 cache driver to driver/soc. It did not move the
header file along with the driver. Therefore this patch moves the header
file to driver/soc

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
[paul.walmsley@sifive.com: updated to fix the include guard]
Fixes: 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/edac/sifive_edac.c                                  | 2 +-
 drivers/soc/sifive/sifive_l2_cache.c                        | 2 +-
 .../include/asm => include/soc/sifive}/sifive_l2_cache.h    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename {arch/riscv/include/asm => include/soc/sifive}/sifive_l2_cache.h (72%)

diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
index 413cdb4a591d..c0cc72a3b2be 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -10,7 +10,7 @@
 #include <linux/edac.h>
 #include <linux/platform_device.h>
 #include "edac_module.h"
-#include <asm/sifive_l2_cache.h>
+#include <soc/sifive/sifive_l2_cache.h>
 
 #define DRVNAME "sifive_edac"
 
diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index a9ffff3277c7..a5069394cd61 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -9,7 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <asm/sifive_l2_cache.h>
+#include <soc/sifive/sifive_l2_cache.h>
 
 #define SIFIVE_L2_DIRECCFIX_LOW 0x100
 #define SIFIVE_L2_DIRECCFIX_HIGH 0x104
diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/include/soc/sifive/sifive_l2_cache.h
similarity index 72%
rename from arch/riscv/include/asm/sifive_l2_cache.h
rename to include/soc/sifive/sifive_l2_cache.h
index 04f6748fc50b..92ade10ed67e 100644
--- a/arch/riscv/include/asm/sifive_l2_cache.h
+++ b/include/soc/sifive/sifive_l2_cache.h
@@ -4,8 +4,8 @@
  *
  */
 
-#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
-#define _ASM_RISCV_SIFIVE_L2_CACHE_H
+#ifndef __SOC_SIFIVE_L2_CACHE_H
+#define __SOC_SIFIVE_L2_CACHE_H
 
 extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
 extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
@@ -13,4 +13,4 @@ extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
 #define SIFIVE_L2_ERR_TYPE_CE 0
 #define SIFIVE_L2_ERR_TYPE_UE 1
 
-#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
+#endif /* __SOC_SIFIVE_L2_CACHE_H */
-- 
2.25.0.rc2



