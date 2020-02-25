Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E54C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B919121556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cIrW0Pac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgBYSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:44:30 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52759 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgBYSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:44:30 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so82313pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=1CE9EkzllE22YSZQFXrk7AEdGrXn0xLSmb4MyQM/dV8=;
        b=cIrW0PacpFrEunWwPMJQpcxefvyCDLw9uZMnGlwc8cfk6ZGnFu30zLYkZYVqpbbDyR
         d4FQPk8YSzKVG3YU27u7hjGlDRWqdCAbfl1pnOLyjJOqqEiv+jvxzQWV4UbWL3bARPcF
         r5H+CPsNRDfXWbQFInKE+SKzTHiUgYBfhJKp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=1CE9EkzllE22YSZQFXrk7AEdGrXn0xLSmb4MyQM/dV8=;
        b=aPd8e6WJDsIWu/CkWWAZV1bMTDwAmJ4gQt/XnMSJDDfijbRHRp58v2hP1fx2+Ujlti
         /Sw5m2cWjGOSVRBIeZ9Lj7DEcKjqdboBrcMyI0/0hbr6pxRGel35YAyDuLibJoywj01K
         M85ma9AoqKT51Ez+cuPdo1Iq08jiz7fxUlBGWw4XDWqRlcwh5T2rEqAnWfBAJrsU+v89
         7Q6uv3kOdHUjYXi61QorBwnmtdFXI+2KDQNN80z4pi/FFuUFwGcTqdpRNOno0SQh5puS
         WwGT+MGrNtZHp45112tiPbn+7zSAS+sFcLzgL4TZsnp1N9TNseKEMqXk6znlPh73XgNl
         xdrA==
X-Gm-Message-State: APjAAAVtZUPWbgiit/dpmprml79ScGxX0Fwn5z8YSXKq+tC8tiw+94G4
        4OyVEi86eKwpTshTUbsCG/7uxw==
X-Google-Smtp-Source: APXvYqza5a3NT6TpX//kqpYcrzwyVsvWZhehiWD3dIUtwZHKQKxsUPhAHkcexY1C9MlqwHfOCUMTMQ==
X-Received: by 2002:a17:902:6944:: with SMTP id k4mr57380356plt.214.1582656269583;
        Tue, 25 Feb 2020 10:44:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7sm17341197pgp.44.2020.02.25.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:44:28 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:44:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Igor M. Liplianin" <liplianin@netup.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc] altera-stapl: altera_get_note: prevent write
 beyond end of 'key'
Message-ID: <202002251042.D898E67AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

altera_get_note is called from altera_init, where key is kzalloc(33).

When the allocation functions are annotated to allow the compiler to see
the sizes of objects, and with FORTIFY_SOURCE, we see:

In file included from drivers/misc/altera-stapl/altera.c:14:0:
In function ‘strlcpy’,
    inlined from ‘altera_init’ at drivers/misc/altera-stapl/altera.c:2189:5:
include/linux/string.h:378:4: error: call to ‘__write_overflow’ declared with attribute error: detected write beyond size of object passed as 1st parameter
    __write_overflow();
    ^~~~~~~~~~~~~~~~~~

That refers to this code in altera_get_note:

    if (key != NULL)
            strlcpy(key, &p[note_strings +
                            get_unaligned_be32(
                            &p[note_table + (8 * i)])],
                    length);

The error triggers because the length of 'key' is 33, but the copy
uses length supplied as the 'length' parameter, which is always
256. Split the size parameter into key_len and val_len, and use the
appropriate length depending on what is being copied.

Detected by compiler error, only compile-tested.

Cc: "Igor M. Liplianin" <liplianin@netup.ru>
Signed-off-by: Daniel Axtens <dja@axtens.net>
Link: https://lore.kernel.org/r/20200120074344.504-2-dja@axtens.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Resending with Greg in To:
---
 drivers/misc/altera-stapl/altera.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index 25e5f24b3fec..5bdf57472314 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2112,8 +2112,8 @@ static int altera_execute(struct altera_state *astate,
 	return status;
 }
 
-static int altera_get_note(u8 *p, s32 program_size,
-			s32 *offset, char *key, char *value, int length)
+static int altera_get_note(u8 *p, s32 program_size, s32 *offset,
+			   char *key, char *value, int keylen, int vallen)
 /*
  * Gets key and value of NOTE fields in the JBC file.
  * Can be called in two modes:  if offset pointer is NULL,
@@ -2170,7 +2170,7 @@ static int altera_get_note(u8 *p, s32 program_size,
 						&p[note_table + (8 * i) + 4])];
 
 				if (value != NULL)
-					strlcpy(value, value_ptr, length);
+					strlcpy(value, value_ptr, vallen);
 
 			}
 		}
@@ -2189,13 +2189,13 @@ static int altera_get_note(u8 *p, s32 program_size,
 				strlcpy(key, &p[note_strings +
 						get_unaligned_be32(
 						&p[note_table + (8 * i)])],
-					length);
+					keylen);
 
 			if (value != NULL)
 				strlcpy(value, &p[note_strings +
 						get_unaligned_be32(
 						&p[note_table + (8 * i) + 4])],
-					length);
+					vallen);
 
 			*offset = i + 1;
 		}
@@ -2449,7 +2449,7 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 			__func__, (format_version == 2) ? "Jam STAPL" :
 						"pre-standardized Jam 1.1");
 		while (altera_get_note((u8 *)fw->data, fw->size,
-					&offset, key, value, 256) == 0)
+					&offset, key, value, 32, 256) == 0)
 			printk(KERN_INFO "%s: NOTE \"%s\" = \"%s\"\n",
 					__func__, key, value);
 	}
-- 
2.20.1


-- 
Kees Cook
