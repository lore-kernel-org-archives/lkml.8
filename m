Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C7DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015821739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsLS4wu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0RwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:52:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40278 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0RwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:52:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so2004009pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOGmPW2hH3nTIkVoQNHklTGWEESx79H9If9kDoWLKYI=;
        b=NsLS4wu7780fV23Box5dzbKPGJcyuTdRTs8hN//CWEvnRCmjYZQWNdWvHL9Cbh4lIm
         8wURA7I1pG0DXjaTAcQPsW022JTJpvLLG7mvYANiEfe0c/EoEFSLPTuOpN+t8T+iXrG5
         57roJI3QLlBKPmAPt33C+qdDkPRWQOeKjkJFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOGmPW2hH3nTIkVoQNHklTGWEESx79H9If9kDoWLKYI=;
        b=XD/AKSuu+cCQLZ3+e6H4RbeSl47ZzbLRsExELcoSmfWmlsBvmna6mnFRn9fzYwbmHH
         lcLCtinzmbzz2IYqOECTr+02SWPN4o5xDN5V1na9rBnrsQf9/5EQMxEp3xsDSJLn1S4D
         5JHo/gdeRmWxocpTkEwxcYtoEYHyb5fizq9islymlWrbf1CSBqkGVpUK7loukKBzCThj
         KSqatPWrC9Pc1aWpHNWdNJYdEDwHXqrYvslSERQ9OaL2OmqzfH5TRqgqdV2RvijbOs5H
         T1AdDSbRaaQ8OCyjZElK2aLNyzqDEXt/b325hnnZNJqGuTOxBlp9DzN+O1s/WZqJrruw
         v3eg==
X-Gm-Message-State: APjAAAWk43v1KEDO/IYZJKP0yfUyLSS2+reCPq+e0U+IUkDFWspBt/MC
        XkOky8DsYdNwPSRIe+JHrAeoGqbz4PY=
X-Google-Smtp-Source: APXvYqyeezwFNYo066aBqqzlZ+dHbX+dtfRZjrRniEn/3Ohzh5txiaPSuTL395bYB4JAn2/z3yoi/Q==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr18742315plo.28.1580147536757;
        Mon, 27 Jan 2020 09:52:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 3sm17000932pjg.27.2020.01.27.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 09:52:16 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scripts/get_maintainer.pl: Deprioritize old Fixes: addresses
Date:   Mon, 27 Jan 2020 09:50:05 -0800
Message-Id: <20200127095001.1.I41fba9f33590bfd92cd01960161d8384268c6569@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I found that get_maintainer was causing me to send emails to
the old addresses for maintainers.  Since I usually just trust the
output of get_maintainer to know the right email address, I didn't
even look carefully and fired off two patch series that went to the
wrong place.  Oops.

The problem was introduced recently when trying to add signatures from
Fixes.  The problem was that these email addresses were added too
early in the process of compiling our list of places to send.  Things
added to the list earlier are considered more canonical and when we
later added maintainer entries we ended up deduplicating to the old
address.

Here are two examples using mainline commits (to make it easier to
replicate) for the two maintainers that I messed up recently:

$ git format-patch d8549bcd0529~..d8549bcd0529
$ ./scripts/get_maintainer.pl 0001-clk-Add-clk_hw*.patch | grep Boyd
Stephen Boyd <sboyd@codeaurora.org>...

$ git format-patch 6d1238aa3395~..6d1238aa3395
$ ./scripts/get_maintainer.pl 0001-arm64-dts-qcom-qcs404*.patch | grep Andy
Andy Gross <andy.gross@linaro.org>

Let's move the adding of addresses from Fixes: to the end since the
email addresses from these are much more likely to be older.

After this patch the above examples get the right addresses for the
two examples.

Fixes: 2f5bd343694e ("scripts/get_maintainer.pl: add signatures from Fixes: <badcommit> lines in commit message")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm no expert at this script and no expert at Perl.  If moving this
call like I'm doing is totally stupid then please let me know what a
more proper fix is.  Thanks!

 scripts/get_maintainer.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 34085d146fa2..7a228681f89f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -932,10 +932,6 @@ sub get_maintainers {
 	}
     }
 
-    foreach my $fix (@fixes) {
-	vcs_add_commit_signers($fix, "blamed_fixes");
-    }
-
     foreach my $email (@email_to, @list_to) {
 	$email->[0] = deduplicate_email($email->[0]);
     }
@@ -974,6 +970,10 @@ sub get_maintainers {
 	}
     }
 
+    foreach my $fix (@fixes) {
+	vcs_add_commit_signers($fix, "blamed_fixes");
+    }
+
     my @to = ();
     if ($email || $email_list) {
 	if ($email) {
-- 
2.25.0.341.g760bfbb309-goog

