Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EAA20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJrSE5Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCLOVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:21:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35359 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgCLOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:21:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so7370147wrc.2;
        Thu, 12 Mar 2020 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gncaKHlGYMiKjX4sUuFMWjZl82hyQMZIVGetmMWGMr4=;
        b=GJrSE5JljgPIy7GJ26yd0y69d3urc3B9e8ZWqQEF8muD6z8T86/uC92s8gY3SRNiG4
         bpP9CSPY/neoaIaf/Wj4nm18otZKJGlS6Owg5WkauwFOxKQfp/x4DDua2s0/8VuVXUZg
         lSiPs+GTfg7aWqe0aIJhw73J6Cud9m4lVT5iCnrRXCUh6EfdUogcJVgfqti2u/1KD2dD
         flmSu/zkWFgpjRNd3Ul1sGD/G2YyI1QG54mVgSHjG8BWPrkn6L7sWNSfvMm396Y3J3mt
         pmUx7xva5B7NV3d5sUQXRoau2daPsbFjqO8OCLsv9f6N1K6pxchGgfDu8hQIrjh1Mop/
         t8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gncaKHlGYMiKjX4sUuFMWjZl82hyQMZIVGetmMWGMr4=;
        b=Z/uQVJ6o0IinG21/s5aKg7QeP/b1ahSpSjATA9RVCl2oyIfRCU205oyEiaPkOG0ekk
         qyZwBnJl4YkjXBKkWkwVDs5YoLI004b+jcMR0t2qpQrFC127rdeAXCWWqCMQ1/iXS8GI
         TBJd3zDlMW0z046Sye2piI7zTRcf3NjquWTFpsL0uvMnVekmqZ+5vUhbazZw+dX1V/eR
         gWlLySwtrgjqOfuqjXH8XujjYj9iHQiMinf0Up8dqG5dyAabfn0zS8DzTmLRI/ZYSlG+
         B25/EA2VY7a5CBWuXDawuD5KBpF285SzM4JFq+SQLQxshJbrjzRcfI1ZGl26vPSm9Iv4
         TU6w==
X-Gm-Message-State: ANhLgQ0g7qE6S662amvpb37FKrsPciC4vT3DGRkRgtpH2f5qc/4+k+DE
        bgIBycHQHh7phxhbHc4vxNE=
X-Google-Smtp-Source: ADFU+vsK0fbeyDur5IWtE1LylMm8T3bgSUztJQb/MaRc0NjUZle/FrXWbXUSZRSZYuWqWVNvPuwm7Q==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr10660139wru.323.1584022910595;
        Thu, 12 Mar 2020 07:21:50 -0700 (PDT)
Received: from gabrielDell.schule.local ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id w4sm23911030wrl.12.2020.03.12.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:21:50 -0700 (PDT)
From:   Gabriel Ravier <gabravier@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Ravier <gabravier@gmail.com>
Subject: [PATCH] gpio-hammer: Avoid potential overflow in main
Date:   Thu, 12 Mar 2020 15:21:42 +0100
Message-Id: <20200312142142.1846910-1-gabravier@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <38cbabe3-151b-1fd6-9d36-f27e9c9aa414@gmail.com>
References: <38cbabe3-151b-1fd6-9d36-f27e9c9aa414@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If '-o' was used more than 64 times in a single invocation of gpio-hammer,
this could lead to an overflow of the 'lines' array. This commit fixes
this by avoiding the overflow and giving a proper diagnostic back to the
user

Signed-off-by: Gabriel Ravier <gabravier@gmail.com>
---
 tools/gpio/gpio-hammer.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/gpio/gpio-hammer.c b/tools/gpio/gpio-hammer.c
index 0e0060a6e..d0be21af1 100644
--- a/tools/gpio/gpio-hammer.c
+++ b/tools/gpio/gpio-hammer.c
@@ -135,7 +135,14 @@ int main(int argc, char **argv)
 			device_name = optarg;
 			break;
 		case 'o':
-			lines[i] = strtoul(optarg, NULL, 10);
+			/*
+			 * Avoid overflow. Do not immediately error, we want to
+			 * be able to accurately report on the amount of times
+			 *'-o' was given to give an accurate error message
+			 */
+			if (i < GPIOHANDLES_MAX)
+				lines[i] = strtoul(optarg, NULL, 10);
+
 			i++;
 			break;
 		case '?':
@@ -143,6 +150,14 @@ int main(int argc, char **argv)
 			return -1;
 		}
 	}
+
+	if (i >= GPIOHANDLES_MAX) {
+		fprintf(stderr,
+			"Only %d occurences of '-o' are allowed, %d were found\n",
+			GPIOHANDLES_MAX, i + 1);
+		return -1;
+	}
+
 	nlines = i;
 
 	if (!device_name || !nlines) {
-- 
2.24.1

