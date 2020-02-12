Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97932C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5EF2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyisWvF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgBLUVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:21:49 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:48004 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:21:49 -0500
Received: by mail-wr1-f74.google.com with SMTP id o9so1298211wrw.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xrAVzSt3UNPeZ7YpW4vFYovDZZzDHICcFwGU53dmNwI=;
        b=eyisWvF/PZOeu2CSMmxeD5tE1yDIDrPp6bq11YZWAfzccZBgfdmCBJD2+9VNXnrRMn
         s72O96T8S3vC+GvyLW5JeoFLENOymvb1jLTfNFGCJHzGOqs3RLwHQ5oB6NhRplQumPd/
         +PrlTuKc0AExFnjSJLnZi6f+N9pTIvh0Wuq34RZT26NcQYJuNLSTdwoo1hO1SVgVNr2U
         zdMs7PryyH7jwy0Tx4Hiv28MG/+uj364AbcSN9a9GEcsB5c6V/H8jOCwAiZR8cBWSPOw
         ZXdLJtbWZ1GtbLjmbzdcZxN3QxHtHg6R5koiOARvwUT5jzX8X9DaGaMYlQdT4tSFCXup
         /Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xrAVzSt3UNPeZ7YpW4vFYovDZZzDHICcFwGU53dmNwI=;
        b=P93bSoVOEeK6rwO/jvazbmQs73Bz11FwODICzIdsqRDnT7n3+bjsyGzXx4PXfEDIKI
         zvPALK+wVU1f89fX++kiIrG309dXApbIQbCiacmqhA4KGcPbxbAdIEr8+EUSyvyIgOXv
         RMzFiKQhJuJqkfMO6NWw5pYUwQUbJUUNz38HxIdeS/6K93EtP9+h0hujslY5z1BywAuI
         KRDGr4EsCZS/d6ohoxlcF/VjdyjRH+PSMS3G6EZdfWHexcsLlQJARt4VEEnU5xG0HCv2
         dTD47ircv2RUxL0MdtcRb05Sc9KZZiFKsWvc+b4i0kDIeQaDGgeL6Wvm6vIGnIw1EUvE
         gf9Q==
X-Gm-Message-State: APjAAAWdscFLQB+NNsiSFmqjCnIlOGsUEeimWpqupmvJEVxo/PRMVuRd
        IiDBqCusrfBibUV6ZO2Nqb7wnq9FkLAZ
X-Google-Smtp-Source: APXvYqwasWnt4Co42/o9ziybszjrGiHpPM8oZ28OzLaoM1FP5xqNkmNu/ifpDHjwxXX3HwqHZyWa6CEcYvEy
X-Received: by 2002:a5d:4085:: with SMTP id o5mr16673093wrp.321.1581538906039;
 Wed, 12 Feb 2020 12:21:46 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:21:38 +0000
In-Reply-To: <20200212202140.138092-1-qperret@google.com>
Message-Id: <20200212202140.138092-2-qperret@google.com>
Mime-Version: 1.0
References: <20200212202140.138092-1-qperret@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v4 1/3] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYMS
From:   Quentin Perret <qperret@google.com>
To:     masahiroy@kernel.org, nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com, jeyu@kernel.org,
        hch@infradead.org, qperret@google.com
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
Kernel Image (GKI) for all vendors, which is a first step in the
direction of getting all vendors to contribute their code upstream.

As such, attempt to improve the situation by enabling users to specify a
symbol 'whitelist' at compile time. Any symbol specified in this
whitelist will be kept exported when CONFIG_TRIM_UNUSED_KSYMS is set,
even if it has no in-tree user. The whitelist is defined as a simple
text file, listing symbols, one per line.

Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 init/Kconfig                | 13 +++++++++++++
 scripts/adjust_autoksyms.sh |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index cfee56c151f1..58b672afceb2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2210,6 +2210,19 @@ config TRIM_UNUSED_KSYMS
 
 	  If unsure, or if you need to build out-of-tree modules, say N.
 
+config UNUSED_KSYMS_WHITELIST
+	string "Whitelist of symbols to keep in ksymtab"
+	depends on TRIM_UNUSED_KSYMS
+	help
+	  By default, all unused exported symbols will be un-exported from the
+	  build when TRIM_UNUSED_KSYMS is selected.
+
+	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
+	  exported at all times, even in absence of in-tree users. The value to
+	  set here is the path to a text file containing the list of symbols,
+	  one per line. The path can be absolute, or relative to the kernel
+	  source tree.
+
 endif # MODULES
 
 config MODULES_TREE_LOOKUP
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a904bf1f5e67..93f4d10e66e6 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -38,6 +38,10 @@ esac
 # We need access to CONFIG_ symbols
 . include/config/auto.conf
 
+# Use 'eval' to expand the whitelist path and check if it is relative
+eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
+[ "${ksym_wl:0:1}" = "/" ] || ksym_wl="$abs_srctree/$ksym_wl"
+
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
 cat > "$new_ksyms_file" << EOT
@@ -48,6 +52,7 @@ cat > "$new_ksyms_file" << EOT
 EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
+cat - "$ksym_wl" |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
 
-- 
2.25.0.225.g125e21ebc7-goog

