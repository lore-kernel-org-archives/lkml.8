Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26209246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myogx4da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgB1RUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:20:30 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:35887 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgB1RU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:20:28 -0500
Received: by mail-vs1-f74.google.com with SMTP id f9so285424vsh.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LdZsVkuGKO8To6YvZKUxQ0ySkhklX4pxNiwqLlI7Xsg=;
        b=myogx4da1gzBYmUfOd833bu0VuYW6vsQ7+dKUlg5YtI4+tVSNtWRe6RHJM5OlrmqRw
         gbF8VeBFtfhsWuZs1Rz3quMCeXrmS0QLi9FiD5JQoXkh0eKOa8mExriGuNuIf5kDmeue
         7Qu0teoeReX6zEq9s9BZbLsbBlcLflZkKMLgcxYpAJXf8s24rQmn0q412qUln3jM6N1W
         lzIyoqO9vvm5FKtxmi/dMEcgJ1XSonL3U+Irm/uEj+rZMQllpQoys4RyCZGGlVbZefow
         CyaJSwt3DllydIGNGy7lnM0G45ffnLNzWSO0NyIRo484sjQ1w4m/hqmyElOJ7B0mgVUV
         4D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LdZsVkuGKO8To6YvZKUxQ0ySkhklX4pxNiwqLlI7Xsg=;
        b=Rs9YifsiJUxWeWDYg3WwV33qzcFFCHXzsE7mrjBxC+IouOZqmA2Ao3M0FFImGyuIPL
         tYSRF6LAz/HuRbI3IdoWNvZRjlEOGSSF7S62uUzhRNDjTGYqOwguyPxr2wvNqlHWAfXZ
         GwUzHYe9Z4WNGypElO8gknnWxNmYpRI2CzXZw23FS1boW+ssHaVl/gWS0QtE5919SOzN
         2u3B+x7Auz1CIQER2sLJj5urnPMdC2mEytrt8VDcxovxyjDi8HgBJFn5AcQUQOtQmDIN
         MF4BGJONNvyjE+dOSVqvYBAsEUsD/lFDo2QCVsbRR1/DfgKHyQv8A8+C2ZpFfqVoxdZ3
         LH6Q==
X-Gm-Message-State: ANhLgQ2keSmGIh5vF7hZAWBi2OCdn+oWL0esDyCfLSMtyG8OfWWTM2yd
        E+hE2V8/mfDrF8x0H8N5JIIMywHHLRpd
X-Google-Smtp-Source: ADFU+vv2m0EN19UVgDJ4CmsQ7TM/NRDXlpL8igf/hEBZF6pFa2/V3es84Fh6kfMz0fiyZPa1i/l6OILnQ5/1
X-Received: by 2002:a9f:2612:: with SMTP id 18mr2513889uag.76.1582910427002;
 Fri, 28 Feb 2020 09:20:27 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:20:15 +0000
In-Reply-To: <20200228172015.44369-1-qperret@google.com>
Message-Id: <20200228172015.44369-4-qperret@google.com>
Mime-Version: 1.0
References: <20200228172015.44369-1-qperret@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v6 3/3] kbuild: generate autoksyms.h early
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

When doing a cold build, autoksyms.h starts empty, and is updated late
in the build process to have visibility over the symbols used by in-tree
drivers. But since the symbol whitelist is known upfront, it can be used
to pre-populate autoksyms.h and maximize the amount of code that can be
compiled to its final state in a single pass, hence reducing build time.

Do this by using gen_autoksyms.sh to initialize autoksyms.h instead of
creating an empty file.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Tested-by: Matthias Maennich <maennich@google.com>
Reviewed-by: Matthias Maennich <maennich@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 Makefile                 | 7 +++++--
 scripts/gen_autoksyms.sh | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1a1a0d271697..c690a838d537 100644
--- a/Makefile
+++ b/Makefile
@@ -1063,9 +1063,12 @@ endif
 
 autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
 
+quiet_cmd_autoksyms_h = GEN     $@
+      cmd_autoksyms_h = mkdir -p $(dir $@); \
+			$(CONFIG_SHELL) $(srctree)/scripts/gen_autoksyms.sh $@
+
 $(autoksyms_h):
-	$(Q)mkdir -p $(dir $@)
-	$(Q)touch $@
+	$(call cmd,autoksyms_h)
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index ef46200c366b..16c0b2ddaa4c 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -39,7 +39,8 @@ cat > "$output_file" << EOT
 
 EOT
 
-sed 's/ko$/mod/' modules.order |
+[ -f modules.order ] && modlist=modules.order || modlist=/dev/null
+sed 's/ko$/mod/' $modlist |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
 cat - "$ksym_wl" |
 sort -u |
-- 
2.25.1.481.gfbce0eb801-goog

