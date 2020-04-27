Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859CC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10FF205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnX5x9L/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgD0QBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727084AbgD0QBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:01:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA5C0610D5;
        Mon, 27 Apr 2020 09:01:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a31so5730469pje.1;
        Mon, 27 Apr 2020 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=9VOe6zfbZtbjAZlq2qI2KNild4EAONAC/y5eieLjgk8=;
        b=BnX5x9L/dv8XVZnTgnpgDNjk70souLU3wwPPv/bitTN6PWwuVeieuBdqa6dFBgWNWp
         EKh2SgxyqXL5KUhI+Z60uWqbAQijklGf3dlZLMmIfdHtiplKxrI6Of6Ll8x5VjLD5Bpl
         Wo3/2H3OLF+zKDxXrkpt3KtuBoy4jxNZGpF+H7ki9eBouYSmMg7J+Pr3Ao9Bfcqzgyf4
         e8jsOVyDY1hsfym8YFHxOmkoMMAexOsu1rvEAxfWoRYraKDeWt+/ENVlWJEpGfk7jcPB
         hSpcKEO1NtgNFqvr1B/kfrvd9wo6D+gNv1TeQ2hVZLIniumVIzz3bRRSuUdthh6IDVVL
         tQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=9VOe6zfbZtbjAZlq2qI2KNild4EAONAC/y5eieLjgk8=;
        b=relE27VpFudYD5Y6BVtbMRmT02QscMztRxO2VQLLF2NkXevey4N58oqIpi0nuxeVLz
         okMDLjn4jFID2u+FZNNkxzQoPawG5GC0dmx+usOsioiETHELsxkEM6SHX0d4KF5VmnCI
         kH0oYU3vCOiBRxOaGDgL5H0lu9AbYqIWfGxi8IyEhOIpMRgY7hbZOSBHfdXqc4x5c3B8
         gstdg8f1bb2jiS151yQ9goryh8V28ycrcT8zM17lEn1/NqfAIe7c74vk7nvScXxQE/Ul
         n71XsohIgrFVALzdGcJ0PyP3yI2M6zIr+eWj3q2QXRal2kXAWrP+vVOiyVUhCWVgzekZ
         jJ9A==
X-Gm-Message-State: AGi0PuY1W30iQOXDrPTfu8EYUq2JwO5Wy5jisOkdCU6UOay98BysNrcb
        Vyfmr0/s7/LLwXDiW8ONQNU=
X-Google-Smtp-Source: APiQypJxjdKJUkibD5FvbEyQw7orSRPWuGaVTPgLdl0DmNd67CJVKb2yIpTTT3nfi4xd/XZUSa0Wrg==
X-Received: by 2002:a17:90a:324f:: with SMTP id k73mr25155177pjb.195.1588003295930;
        Mon, 27 Apr 2020 09:01:35 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id p16sm11578519pjz.2.2020.04.27.09.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 09:01:34 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 03RErdMI019234;
        Mon, 27 Apr 2020 22:53:39 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 03RErXiK019233;
        Mon, 27 Apr 2020 22:53:33 +0800
Date:   Mon, 27 Apr 2020 22:53:32 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de
Subject: [PATCH v2] checkpatch: add dedicated checker for 'Fixes:' tag
Message-ID: <20200427145332.GA18830@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, joe@perches.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to submitting-patches.rst, 'Fixes:' tag has a little
stricter condition about the one line summary:
"
Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts
"
And the current 'Fixes:' checker in "# Check for git id commit length and
improperly formed commit descriptions" doesn't check for invalid commit id
length, so this patch adds dedicated checker to fix these issues.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

 v1-v2:
 1: Reword commit log (Markus Elfring).
 2: Allow more than 12 characters of SHA-1 id (Markus Elfring).
 3: Update the error message according to reflect the second update.
 4: Add missing (?:...).

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23a001a..d74683a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2820,7 +2820,7 @@ sub process {
 		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
 		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		      $line !~ /^\s*fixes:\s*(?:[0-9a-f]{6,40})\s*(?:.*)/i))) {
 			my $init_char = "c";
 			my $orig_commit = "";
 			my $short = 1;
@@ -2979,6 +2979,13 @@ sub process {
 			}
 		}
 
+		if ($in_commit_log && $line =~ /^\s*fixes:\s*([0-9a-f]{6,40})\s*(.*)/i) {
+		    if (length($1) < 12 || $2 !~ /^\(\"(?:.*)\"\)$/i) {
+				ERROR("FIXES_TAG",
+					"please use the 'Fixes:' tag with at least the first 12 characters of the SHA-1 ID, and the one line summary(no across multiple lines)\n" . $herecurr);
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
