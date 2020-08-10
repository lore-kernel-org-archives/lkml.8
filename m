Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C402312D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkk84ivl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHJPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgHJPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:36:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B4BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:36:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so5505825pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmOTjgEuP1ZDu0lZKWX+naqfKXyKychFcrx1gAlT9Lc=;
        b=Tkk84ivltV8WGDKFoFwOH+NZtYh1evX0QmqDPBNLQLUEeT28EyPX7VQV8jAuFb93q0
         1A4cdiXoRqLdCfs86HfPq6Hf2iMj4r6QrdiChQni0zUZUf478TFUAUkAEumfS/Po0fOT
         BvY/kuKLIl4jH855lu8XkSI4VTK3GdTWEzyZ6vKKoR98w0zTGdUezXuzbBnARq2lAFAb
         vlYAinFhkVcYxqwYv/3bysPdeUAj2at5b03KGLR04+fevgL5zpWbGZoR84yZpLAomVj8
         NftvQG9yatd7F2grivNLlTnq4Q5KL5JHayH4GhcCK+ebn7IamFGPEdNINRCZgoXKgTgj
         aHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmOTjgEuP1ZDu0lZKWX+naqfKXyKychFcrx1gAlT9Lc=;
        b=uF+FbsJb8Kn09dHRUqQW7tT636V76pIRuglTNZgTCy9OWlAPtx3hoqzRqEMZKlNgrC
         xRCvfy3MCM9VIfelTacZVQx7UnDA/Eir1k8nbs4G/xGrF/v5qSfB0mGlGiT81mJnYB13
         TEuePZOGopP0UPyZQvAh+oy1AbBJvt7WTpWWDlWVQEv6nxjN7cCrOE5aqCL2E4Cs3e0b
         QGvEiS+rOu1Vh5l+tD8Z6Umta63aTjWxoXGv7k4zX1XdVw8XlNsOuSAoxSJsjRYnOAAE
         FFhc8lcrXyRxlsmc7dZKr/ZtfSdCR7iOK6XJUO9eiBWRIbKYZwA96+bVqjDOvzWZXGHG
         8p7w==
X-Gm-Message-State: AOAM530JxbWG0Px7vXIJgyFsly/nmqjEZDo4RIZdKE1KyTOSSup1uUon
        mBUjJq0HGAJJLrW3P32uoV7vJZa9AI6jTQ==
X-Google-Smtp-Source: ABdhPJyG56EbPfeYubySGMgW9m+HaJgfNwHfH7QG9bdcSuS735m7MQBr1YVN5srLDSm0VDOQAMO1Kg==
X-Received: by 2002:a17:90a:e94c:: with SMTP id kp12mr23504278pjb.115.1597073815953;
        Mon, 10 Aug 2020 08:36:55 -0700 (PDT)
Received: from thinkpad.teksavvy.com ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id n3sm22020688pfq.131.2020.08.10.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:36:55 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     masahiroy@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, xujialu@vimux.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] scripts/tags.sh: exclude tools directory from tags generation
Date:   Mon, 10 Aug 2020 08:36:50 -0700
Message-Id: <20200810153650.1822316-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when COMPILED_SOURCE is set, running 'make ARCH=x86_64 COMPILED_SOURCE=1
cscope tags' in KBUILD_OUTPUT directory produces lots of "No such file
or directory" warnings:
...
realpath: sigchain.h: No such file or directory
realpath: orc_gen.c: No such file or directory
realpath: objtool.c: No such file or directory
...
let's exclude tools directory from tags generation

Fixes: 4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely")
Link: https://lore.kernel.org/lkml/20200809210056.GA1344537@thinkpad
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 scripts/tags.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 32d3f53af10b..850f4ccb6afc 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -26,7 +26,11 @@ else
 fi
 
 # ignore userspace tools
-ignore="$ignore ( -path ${tree}tools ) -prune -o"
+if [ -n "$COMPILED_SOURCE" ]; then
+	ignore="$ignore ( -path ./tools ) -prune -o"
+else
+	ignore="$ignore ( -path ${tree}tools ) -prune -o"
+fi
 
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
@@ -92,7 +96,7 @@ all_sources()
 all_compiled_sources()
 {
 	realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) \
-		include/generated/autoconf.h $(find -name "*.cmd" -exec \
+		include/generated/autoconf.h $(find $ignore -name "*.cmd" -exec \
 		grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
 		awk '!a[$0]++') | sort -u
 }
-- 
2.28.0

