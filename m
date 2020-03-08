Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46288C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1942D206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN+evST5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCHTvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:51:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35771 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHTvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:51:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so8501472wro.2;
        Sun, 08 Mar 2020 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=va/5kDgzicKNJcf6deuBNFPfL5yL1B6zjk8vK2SAYqg=;
        b=jN+evST5603L9i65VpeFvYKdZt9X6LM0Mrk7Qop1teEOFvO9SEQM/C1arNnknX2+UK
         yW6qN4GsUpN3Oh9PUa0V0RTB2Hb4CsRpdAdnrBgcLtuqAUZrpAGlLRnza7hbZ3AphT5k
         /U2QfyVeikM8HHTP5lqDQ6cjci3HDNubFhruBkMdnsbbmQNbgcDVeACHzFOSWcC5zPJJ
         mbp0G9PGfV/S7gdOFgWHZJ8vZLxh1flxv9Qv0yJEXbTANoVfpm9fCY4UgHQqBvFYKJBE
         c4NIhv1H1GPU3Az56s76QxRJb5m8x2aISQm9q5TUZotdf4yEzTIcneq8+4oNnvVQ9gT/
         keHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=va/5kDgzicKNJcf6deuBNFPfL5yL1B6zjk8vK2SAYqg=;
        b=HjwIcAidOUbXQzAZgzFEbDFYd8NUHsQE/fxs+4I3oSLY61JzTBKp1mjTIx4eLsFIMx
         La240Ks/V2GbmV8AwXs7BiqnDtokBm+c5lv9R084yqAx6L4Z5/ONe33UJz4ujrh9Rblg
         hRxCzd3wrJ6xvk0baiogmS5XYZHcT2rULv6a7ZsYN3QITvkhLTAoUqxp6WUSUYfLjCum
         dPeNK3wiir9+YqF6Wez8Iin3jr3ajGeMKF0tDmrsG2WMbH5ErjrE7tl8z8iJnMFcjnK6
         i4jWvdwcKooWzgEETcpPXkLW/UZK4mQ9Xxhm0pRvIMlROxNqjSrpcyO7AdJi4dLFBwOD
         a4xg==
X-Gm-Message-State: ANhLgQ3PlBsqRrBp7FcfiHha5aEiMJAaWeLpt4k6cwiOSuxw//bpOYj4
        N6B5KBSMvNCzCsNqGlkkZBpptWN0YWw=
X-Google-Smtp-Source: ADFU+vuDwnAe/gtet0wO/NzJ8JcVQtvvKkVPjNdRolC/fbRnkpkzDlD1jgg5ocL531JJHTQa2VDDAQ==
X-Received: by 2002:adf:f087:: with SMTP id n7mr15782115wro.328.1583697101955;
        Sun, 08 Mar 2020 12:51:41 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dce:4a00:35ca:ddfb:aba3:f544])
        by smtp.gmail.com with ESMTPSA id f207sm26095392wme.9.2020.03.08.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 12:51:41 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Cc:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
Date:   Sun,  8 Mar 2020 20:51:16 +0100
Message-Id: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All files in drivers/firmware/google/ are identified as part of THE REST
according to MAINTAINERS, but they are really maintained by others.

Add a basic entry for drivers/firmware/google/ based on a simple statistics
on tags of commits in that directory:

  $ git log drivers/firmware/google/ | grep '\-by:' \
      | sort | uniq -c | sort -nr
     62     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     13     Reviewed-by: Guenter Roeck <groeck@chromium.org>
     12     Signed-off-by: Stephen Boyd <swboyd@chromium.org>
     11     Reviewed-by: Julius Werner <jwerner@chromium.org>

There is no specific mailing list for this driver, based on observations
on the patch emails, and the git history suggests the driver is maintained.

This was identified with a small script that finds all files belonging to
THE REST according to the current MAINTAINERS file, and I investigated
upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a0f8115c92c..ed788804daab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7111,6 +7111,14 @@ S:	Supported
 F:	Documentation/networking/device_drivers/google/gve.rst
 F:	drivers/net/ethernet/google
 
+GOOGLE FIRMWARE
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+M:	Stephen Boyd <swboyd@chromium.org>
+R:	Guenter Roeck <groeck@chromium.org>
+R:	Julius Werner <jwerner@chromium.org>
+S:	Maintained
+F:	drivers/firmware/google/
+
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.17.1

