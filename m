Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97FF20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy2yoU3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEFFet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgEFFes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:34:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DFC061A0F;
        Tue,  5 May 2020 22:34:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so167863wrx.10;
        Tue, 05 May 2020 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NgWAlvnGXDmO0eEhhszebxW0OV0q/gUyVYXiRgeW/8M=;
        b=iy2yoU3JHvdpSiZul4x3UQhvD/HWf+IqXjC96oAsSCQK/g0zML6kZM48ft+ddc14j5
         Gi1KMLAUBhfFlMd66VwVOx7sdtNSxQIdJIRCaIqKvL3C3JAZ4bIYx8Pdaz5oPo9iz6Ef
         qWa6qHoPN5W4y2L/uzZClZ5c8Pb1i1T0Q++dKtV7V1B6TqN0xrgdQQhXWgW3wKt2mlHa
         KSQCX0S/O9Nz/UHYZTUnmD6YKGOuJLU+TA+hukdEj5uLci0JDkUXozlqUOKEAKd/sO5a
         boiypu5WWDHgNiv1yt1K1UNqYxDVkzTByuRkMROkI65AZsDOEw21qiFavUgTw8IzAjUn
         9PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NgWAlvnGXDmO0eEhhszebxW0OV0q/gUyVYXiRgeW/8M=;
        b=lQgY/zcwzTXNTFKTDuC99Yzcxr522ptKfslCUvV+LhmIlkR+zyQ/HBj0ymYZZBCelb
         aoNoJ/olsmSf0I2oIdbHkHy5vr23cmyoM+kwR4QyIjdlr9ZTM0iGr4nO7LXQkyX/5tt9
         yLpRiW6OCqsBsUTKeSDw2gcG2zFDmHJ3emk98H4zLkAjc3F9dRmYnb3MWIF+Py8XvmKC
         I9LY/p792YnnpnosaIyCOVNfIAqHSmwFQWHRTgZFd1x9Fs+2L5fIQsPr6G6PA2gdpaOH
         RK6eegkR1OS58C8yY+PWV9v6S8/ADDLuuIfMN5UOdFU6auW7ZECoUkYe7rjSDfSFsV+0
         fsvw==
X-Gm-Message-State: AGi0PuZzf2aZNPp0e253weWxWKWFjSUaAR3kKXbQXybRErROVWkjJpRc
        2NQlS+aPrJK2aZyeqxUo5i4=
X-Google-Smtp-Source: APiQypJYiKXI14TW+7ZrO/B+v52diF4s9uz6KDF1/WeL4zHPV8YiWC26PvqtosoUqsfUz23jLhlCWA==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr4384816wrj.300.1588743285536;
        Tue, 05 May 2020 22:34:45 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df1:2500:bc2e:80a7:2be5:2fcf])
        by smtp.gmail.com with ESMTPSA id y3sm897691wrm.64.2020.05.05.22.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 22:34:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 RESEND] MAINTAINERS: rectify MMP SUPPORT after moving cputype.h
Date:   Wed,  6 May 2020 07:34:31 +0200
Message-Id: <20200506053431.7464-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
added a file entry that does not point to the intended file location.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: linux/soc/mmp/

Rectify the MAINTAINERS entry now.

Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jiri, please pick this patch.

v1 & v1-RESEND: was ignored.

v1 -> v2:
  - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
  ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
  ("MAINTAINERS: sort field names for all entries").
  - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.

v2-resend:
  - still applies on v5.7-rc4 and next-20200505
  - asking for inclusion through trivial tree, as maintainers are not
    responding.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..a0fef0c33ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11327,7 +11327,7 @@ S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
-F:	linux/soc/mmp/
+F:	include/linux/soc/mmp/
 
 MMP USB PHY DRIVERS
 R:	Lubomir Rintel <lkundrak@v3.sk>
-- 
2.17.1

