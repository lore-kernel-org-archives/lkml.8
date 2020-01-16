Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10493C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BEA20729
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnws+Sn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAPX5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:57:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPX5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:57:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so10742052pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 15:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zIS6PSbeU0Wk5Q/And2tq+93kIpjsUkkTCKLRvCiki4=;
        b=Fnws+Sn0kkXZ4n9FciZTKf3Yu5z3m9VwlmkPyxOe1BU9rO07SDB+XzIMcctAjdU+HL
         NVzmD23WbCDhQvjuhMuVzZt9KoSjL9B800UQ+9Ihu0XpSxR/fwSqMFQUGTGHxbwjHVbG
         24MZ0NJVwGIBIpFxYAb/sVJ2sU/C03FWbqSzCM2fRr1NsSFxXKhz4t18Y0ua1zZA4xHL
         SDZ92fNsjrssP/WgQ0wHux8MMRJLx+4uA7mpoWR8mF6cavbTf6X7pTWRQIyTFyGCeT/G
         vWydtMY8Er0smbLPQZw4ZOu29ffVqKQAaTBok/eNvbAwI8Ie2eqHSMTPhvDiG/HGbqhq
         1/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIS6PSbeU0Wk5Q/And2tq+93kIpjsUkkTCKLRvCiki4=;
        b=He2oD0eEg3teBuej270VM8d9e+aIVoGGrb6oqWzy644UDse97WctuddCBl+PA4oWFw
         CrfRrMaCg7HRHD+Q0KK4krDEGZWzMkwZ1O7TUROdRk7rTXsmAWuMXWpuZlI3Sscj9J5L
         D5zuNChczeyDg9XC0QwV7dXV/lIsDKL5jEl1/wr4sBHb5DfBt9hIrrHpV6hUXb2I0Jpl
         E2Ck5bitEmqqOdI0rhGaZWwH55IeJbjjqPMCIrwhBOLPeVxBKFa7q46j6TcdXg/Py7Vy
         7FE+zHDcxLSu5XU31wFoHy6LO7j8ytj9X8hwjk+Ljw0q58pHnvE7HYBKSZ2HQkUYONS/
         M0KA==
X-Gm-Message-State: APjAAAWwjSQVy5xTILeEp3cbVxdW5FkTUASJ8g3Ne1W/pVbtFQjaY2X3
        D3W9wSERPx5+RGpd8GdnFSk=
X-Google-Smtp-Source: APXvYqx79kLh+JxQCON/MUilEwjbnvyw8aTXnF7x7+R8Ar8YnsYuAHnKFEKROTLAwKrGPvKGI0LRTg==
X-Received: by 2002:a62:1b4d:: with SMTP id b74mr73763pfb.59.1579219056792;
        Thu, 16 Jan 2020 15:57:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t137sm24915148pgb.40.2020.01.16.15.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 15:57:36 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: VDSO: Match ARMv8 timer in cntvct_functional()
Date:   Thu, 16 Jan 2020 15:57:28 -0800
Message-Id: <20200116235731.22395-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for a system with an ARMv8 timer to run a 32-bit kernel.
When this happens we will unconditionally have the vDSO code remove the
__vdso_gettimeofday and __vdso_clock_gettime symbols because
cntvct_functional() returns false since it does not match that
compatibility string.

Fixes: ecf99a439105 ("ARM: 8331/1: VDSO initialization, mapping, and synchronization")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Hi all,

This was found by one of our customers and the following test program
below can be used to find whether the "bug" is fixed or not.

The Fixes tag is much after the arm_arch_timer.c gained support for the
ARMv8 timers, which is why it is being referenced.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dlfcn.h>

#define ARM_LDSO_NAME   "linux-vdso.so.1"

int main(int argc, char **argv)
{
        void *h, *sym[2];

        h = dlopen(ARM_LDSO_NAME, RTLD_NOW);
        if (!h) {
                fprintf(stderr, "failed top dlopen\n");
                return 1;
        }

        sym[0] = dlsym(h, "__vdso_gettimeofday");
        sym[1] = dlsym(h, "__vdso_clock_gettime");
        if (!sym[0] && !sym[1]) {
                fprintf(stderr, "Kernel does not provide symbols, check DT!\n");
        } else {
                fprintf(stdout, "Kernel provides vDSO symbols!\n");
        }

out:
        return dlclose(h);
}


 arch/arm/kernel/vdso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index c89ac1b9d28b..e0330a25e1c6 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -94,6 +94,8 @@ static bool __init cntvct_functional(void)
 	 * this.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL, "arm,armv8-timer");
 	if (!np)
 		goto out_put;
 
-- 
2.17.1

