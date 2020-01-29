Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5741CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D052064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b89C2vjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgA2SPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:15:45 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:51932 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgA2SPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:15:45 -0500
Received: by mail-qv1-f74.google.com with SMTP id e10so347991qvq.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8OmDOl+HzY7kcK871zVejMIspdUpfLqTD5KCeutuWtI=;
        b=b89C2vjAvi8rn6ke4cMrbzWhPNxthh3YpogsX2uEkpXypteStYFa0eHE/vbKpyKJ7c
         kWBwggD5XvuNwYUWI3HuS2xE8BtlawGJaAre2+1dfgETw9jFkKK6veUMfpnsJgwGEvS2
         ewiUCzMI+c7/iBJZ8k++QCDfVxrlW41Rxy71EifgoDosJUOQnNzS2Qu5dfJHfZYldD3U
         kqYxC9hGbFd+k+7wkbuxYBxMxuFdnt0siR959H1OQ2ZgvBwY85FaMSAPHb0mkKviUm+V
         jooaRPM1l29+Kfwou3Aigf5v39axWr8UVxi1lWm5JGeUFN4uv0P8fFv+4VJOQHiVLxhF
         xZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8OmDOl+HzY7kcK871zVejMIspdUpfLqTD5KCeutuWtI=;
        b=keN2owWw5yGJKCvq3YS0pTUYhgCYe7cHYUz0CAv0hKaEpO71vJcQsYZosv2v3UIuS6
         jLqlo4+DBI85PSPMa/6r/ar/ZBHzXpjiaM6hNPxKwUDEqN3xc8/fQKuaRX7RTaZsFhpn
         mh2gjFYOG/Jdi6YKZih1IDmrxQtfgG570KBoFaOvKF8bhrcjONqGLDmpmPtiZCcGPawa
         s/k0T5xqj5oHMYzKOLnyGWSpd/GwCMZHtMFoBmjhXsDF5q95gmuisTs/vnFvyzq3xxA6
         5yySUKF5wj6x21P58so/+vXcMC2XKXFL/E/8jctm67uH7uGKxLHaFmkKL2ztBdFuwkQe
         cCLA==
X-Gm-Message-State: APjAAAXfT8TznNnzF7+SSw+hWLJICS816b4K6ktmfqw6i943+UddKszS
        gn0lJC+qNWZPjBJ4KDc2mUrBsmmnBihb
X-Google-Smtp-Source: APXvYqwN3ACQ2noJKaiSC9xLyVQkZaRwlbZlPfvTuolBVWN/pWc4or7pdoyNb13qvrWpG7kKbhq6JsmksPdy
X-Received: by 2002:ac8:1385:: with SMTP id h5mr461391qtj.59.1580321744050;
 Wed, 29 Jan 2020 10:15:44 -0800 (PST)
Date:   Wed, 29 Jan 2020 18:15:41 +0000
Message-Id: <20200129181541.105335-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYMS
From:   Quentin Perret <qperret@google.com>
To:     masahiroy@kernel.org, nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com, qperret@google.com,
        jeyu@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TRIM_UNUSED_KSYMS currently removes all unused exported symbols
from ksymtab. This works really well when using in-tree drivers, but
cannot be used in its current form if some of them are out-of-tree.

Indeed, even if the list of symbols required by out-of-tree drivers is
known at compile time, the only solution today to guarantee these don't
get trimmed is to set CONFIG_TRIM_UNUSED_KSYMS=n. This not only wastes
space, but also makes it difficult to control the ABI usable by vendor
modules in distribution kernels such as Android. Being able to control
the kernel ABI surface is particularly useful to ship a unique Generic
Kernel Image (GKI) for all vendors.

As such, attempt to improve the situation by enabling users to specify a
symbol 'whitelist' at compile time. Any symbol specified in this
whitelist will be kept exported when CONFIG_TRIM_UNUSED_KSYMS is set,
even if it has no in-tree user. The whitelist is defined as a simple
text file, listing symbols, one per line.

Signed-off-by: Quentin Perret <qperret@google.com>

---
v2: make sure to quote the whitelist path properly (Nicolas)
---
 init/Kconfig                | 12 ++++++++++++
 scripts/adjust_autoksyms.sh |  1 +
 2 files changed, 13 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..d9c977ef7de5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2180,6 +2180,18 @@ config TRIM_UNUSED_KSYMS
 
 	  If unsure, or if you need to build out-of-tree modules, say N.
 
+config UNUSED_KSYMS_WHITELIST
+	string "Whitelist of symbols to keep in ksymtab"
+	depends on TRIM_UNUSED_KSYMS
+	help
+	  By default, all unused exported symbols will be trimmed from the
+	  build when TRIM_UNUSED_KSYMS is selected.
+
+	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
+	  exported at all times, even in absence of in-tree users. The value to
+	  set here is the path to a text file containing the list of symbols,
+	  one per line.
+
 endif # MODULES
 
 config MODULES_TREE_LOOKUP
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a904bf1f5e67..8e1b7f70e800 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -48,6 +48,7 @@ cat > "$new_ksyms_file" << EOT
 EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
+cat - "${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}" |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
 
-- 
2.25.0.341.g760bfbb309-goog

