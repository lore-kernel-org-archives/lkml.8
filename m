Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D8C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E388E21927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxex5n5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgBYBe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:34:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44630 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBYBe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:34:58 -0500
Received: by mail-io1-f68.google.com with SMTP id z16so625752iod.11;
        Mon, 24 Feb 2020 17:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sMy0D4t4BEz+I62Pa6Ixc/TtcpxG23tmRPXSx/fbdfA=;
        b=Bxex5n5ihE8BOt/P+mikL+dJSM3ex/S8YWwgHIsDlsA1WPxMfiLLNQGYgzQogWVLQn
         Gi7ZSTeKYZZE9dNXK45XteWf1sBSrKMWxweXs53uvh2YfipDvEG6GyFIYNXq+0Se+E6l
         RjxvD+dSSShWAOWtQL7HoSlP3H0NUzgLafBfHVo//WYWHMqbWo8rwo8JzNda95FOSRYz
         2e4TCvUlic4ZNMC1qQrenVWc/0FFsLcRHkfqLD950fON+K3S630px2DclwsTxFQR5ARz
         b2EVTue95HQS4eG3crkYAbuku93JWC1wRnmABjTaihH3XOavNvL1SzCvxxI4y0qVp63d
         wggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sMy0D4t4BEz+I62Pa6Ixc/TtcpxG23tmRPXSx/fbdfA=;
        b=K2MrbAtrXnu/dxPma+ZSoj02JZmYyZvxVkrBx7B5XZyyy8SvNAq70o+mWvx/I1PRsM
         dfrLzGUU5/x7/u/l21hDrg2VopB7wAFGNiMXzxy/LMdtLISuQJRlG3Y41e2FCxI1OdTb
         p2vYQGEd7JXjni8k97gQmMu5xFEURbPFpUEezQM7Fyy+hVkvDSGcL4F1S0QPneegUHpd
         a1rHAFnJR2y/F8lJZUMp5BhL2Dos0NNcLWYAAqAReIOk8gONVtEQwsDcymKdnfdxUtwF
         osnKflmoMp8T7O8pbEn+nPSoFHGggNDaOCUIkBFXoytyCW21mJPPKLjKMlS3FrSB3ey+
         BzHg==
X-Gm-Message-State: APjAAAXhvWSv/A+5e/Gsru4YVTCJrm+GAPbeaGImKd/uhAkk728ns9qR
        YtyMNC7BkwiGzyZEZaPn5eA=
X-Google-Smtp-Source: APXvYqx7ANfXYY3vlxOfYrESs9/zK1XANM1oYSy6o5tVQHylmMMevdRVd+EiNYUXGYDFn1Lfvd/Zmg==
X-Received: by 2002:a6b:1490:: with SMTP id 138mr3357877iou.8.1582594496980;
        Mon, 24 Feb 2020 17:34:56 -0800 (PST)
Received: from timdesk.hsd1.ca.comcast.net ([108.165.36.110])
        by smtp.gmail.com with ESMTPSA id b1sm4888798ilc.33.2020.02.24.17.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 17:34:56 -0800 (PST)
From:   tbird20d@gmail.com
X-Google-Original-From: tim.bird@sony.com
To:     mchehab@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tbird20d@gmail.com, tim.bird@sony.com
Subject: [PATCH] scripts/sphinx-pre-install: add '-p python3' to virtualenv
Date:   Mon, 24 Feb 2020 18:34:41 -0700
Message-Id: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Bird <tim.bird@sony.com>

With Ubuntu 16.04 (and presumably Debian distros of the same age),
the instructions for setting up a python virtual environment should
do so with the python 3 interpreter.  On these older distros, the
default python (and virtualenv command) might be python2 based.

Some of the packages that sphinx relies on are now only available
for python3.  If you don't specify the python3 interpreter for
the virtualenv, you get errors when doing the pip installs for
various packages

Fix this by adding '-p python3' to the virtualenv recommendation
line.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 scripts/sphinx-pre-install | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index a8f0c00..fa3fb05 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -701,11 +701,26 @@ sub check_needs()
 		} else {
 			my $rec_activate = "$virtenv_dir/bin/activate";
 			my $virtualenv = findprog("virtualenv-3");
+			my $rec_python3 = "";
 			$virtualenv = findprog("virtualenv-3.5") if (!$virtualenv);
 			$virtualenv = findprog("virtualenv") if (!$virtualenv);
 			$virtualenv = "virtualenv" if (!$virtualenv);
 
-			printf "\t$virtualenv $virtenv_dir\n";
+			my $rel = "";
+			if (index($system_release, "Ubuntu") != -1) {
+				$rel = $1 if ($system_release =~ /Ubuntu\s+(\d+)[.]/);
+				if ($rel && $rel >= 16) {
+					$rec_python3 = " -p python3";
+				}
+			}
+			if (index($system_release, "Debian") != -1) {
+				$rel = $1 if ($system_release =~ /Debian\s+(\d+)/);
+				if ($rel && $rel >= 7) {
+					$rec_python3 = " -p python3";
+				}
+			}
+
+			printf "\t$virtualenv$rec_python3 $virtenv_dir\n";
 			printf "\t. $rec_activate\n";
 			printf "\tpip install -r $requirement_file\n";
 			deactivate_help();
-- 
2.1.4

