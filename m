Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC7BC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597E520A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg3dU4wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTJkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:40:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED45C061A0C;
        Mon, 20 Apr 2020 02:40:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so11233774wrs.9;
        Mon, 20 Apr 2020 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=3GA3bluwRYjqG3fWE2X65VtHlib+JO5/bzStrmWlQNw=;
        b=Yg3dU4wpaAO0TS2Ew2ddgljjfTP9Nf1COso2lOv9kE4hkbovKCjdtLEDRLjTU/IfN9
         TkcY6tEV6SQPPl3z2lzpJNw5JVTA4iXhodte7lrtSeCcgxbrQDAkTe5CHO24FgasmG6o
         LpXIDUgFCP46XuAK2EIS6HJUhBFCq3jiJvOEL1SKSyS1dhGZ3FbEtSwEYaf9VAGRAWzC
         3cSn/2c2BnsI6Ui0grwJ/nHB82wzv90hZCG+GBOUPwlYxOwCkG/Up+1UYT9MaZHucJYx
         tXmjg800ONpPFBmhgA+GrUdaXLholnKu5LP4F2tSteg1Qy1dogk4ZzTDhcvxVlXLRCof
         iz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=3GA3bluwRYjqG3fWE2X65VtHlib+JO5/bzStrmWlQNw=;
        b=D4lW/Du9Ge3QJj6uivJENpHzAbhX8lKpnDxjNpjR1Mp3W7zqTFu2Re0yooVTPHrZz5
         wA1imXflae+41KsthSdvrgTA0fKDu2YOgHNFhrUtT0vI3O3tK6OZspWN1gmCEUTE5Gew
         /207FCSFCEaaA1wNXdvQt/p5tns6jpQUuTjflSALtFtfUmofhyWGNZKl/P7dgJtcU101
         PgquGBtLvmWwVLhnbM3utDbL2CrW2YuCVNEOQ779BL08kXsGMW5xjSxFdU3ELclFO7rk
         GD+NIceffV8nBIiyhortJXgw4aJV1VXAVkNn2ArhJ8Zu+LRpyflwcQ210/aVOl15yxD4
         Dk3A==
X-Gm-Message-State: AGi0PuaXkgCqBDJrfojSKLbasdBfaagTTeBKic8uGouOGliRY/fAtOrG
        zVs90RCAPocOmWPYlwiVPj8=
X-Google-Smtp-Source: APiQypIeRYOd8lPA5ceHyWhzpqedImL7XDEnyevslbtKPv7LHPVjbIZ0m7HgNUVyB5ePXClUNydAYQ==
X-Received: by 2002:adf:8441:: with SMTP id 59mr18623827wrf.237.1587375610140;
        Mon, 20 Apr 2020 02:40:10 -0700 (PDT)
Received: from felia ([2001:16b8:2d8c:a200:646f:8a6f:3448:4e5a])
        by smtp.gmail.com with ESMTPSA id 5sm574347wmg.34.2020.04.20.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 02:40:09 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 20 Apr 2020 11:39:10 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Hadar Gat <hadar.gat@arm.com>
cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Wrong ordering in CCTRNG ARM TRUSTZONE CRYPTOCELL TRUE
 RANDOM NUMBER GENERATOR (TRNG) DRIVER
Message-ID: <alpine.DEB.2.21.2004201122490.9739@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hadar,


with your commit 3c8e0bd10503 ("MAINTAINERS: add HG as cctrng 
maintainer"), now visible on next-20200420, ./scripts/checkpatch.pl -f 
MAINTAINERS complains:

#3908: FILE: MAINTAINERS:3908:
+F:	drivers/char/hw_random/cctrng.h
+F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt

WARNING: Misordered MAINTAINERS entry - list 'W:' before 'F:'
#3909: FILE: MAINTAINERS:3909:
+F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt
+W:	
https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family


This is due to wrong ordering of the entries in your submission. If you 
would like me to send you a patch fixing that, please just let me know.


Best regards,

Lukas
