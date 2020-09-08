Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF13BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2932078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588933;
	bh=PNEcaQnF359NXQheKId83+7GCoF5t3rRV8n1Xzw/K/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rh3WWIKsMyoUBMobCTBva/g/TLpiXJYByOD9D+Fs0vtBP73b3t9gwknJPLoNheUQj
	 b8KZXOOZKTlvk+zNsuhahVtTNyMFPPVoGuqXTNOcGWTu6PMEo8DQ2WpRZy8E6LLI/h
	 ZFNCwJMKXl4WxckTQu+iNnEofsXvvLjYFs1diPn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgIHSPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbgIHQLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311B02477A;
        Tue,  8 Sep 2020 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579719;
        bh=PNEcaQnF359NXQheKId83+7GCoF5t3rRV8n1Xzw/K/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+guFlvrQB8CW7i7y+0pk95N3MjaYAApCygXb8Cu2vdmsDzU9pOr65aF6cW6Zi23p
         /IK9msCJUXjioXwM7gWHJdeu4Gj2cszGs2sLGhEmmcKUhmKYbVD/rzFmsQ0ot2nGid
         TO9uvKW8AInxLnSZKZDf54zOWQkZz7vc0iRDN65M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mrinal Pandey <mrinalmni@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.8 180/186] checkpatch: fix the usage of capture group ( ... )
Date:   Tue,  8 Sep 2020 17:25:22 +0200
Message-Id: <20200908152250.397742499@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mrinal Pandey <mrinalmni@gmail.com>

commit 13e45417cedbfc44b1926124b1846f5ee8c6ba4a upstream.

The usage of "capture group (...)" in the immediate condition after `&&`
results in `$1` being uninitialized.  This issues a warning "Use of
uninitialized value $1 in regexp compilation at ./scripts/checkpatch.pl
line 2638".

I noticed this bug while running checkpatch on the set of commits from
v5.7 to v5.8-rc1 of the kernel on the commits with a diff content in
their commit message.

This bug was introduced in the script by commit e518e9a59ec3
("checkpatch: emit an error when there's a diff in a changelog").  It
has been in the script since then.

The author intended to store the match made by capture group in variable
`$1`.  This should have contained the name of the file as `[\w/]+`
matched.  However, this couldn't be accomplished due to usage of capture
group and `$1` in the same regular expression.

Fix this by placing the capture group in the condition before `&&`.
Thus, `$1` can be initialized to the text that capture group matches
thereby setting it to the desired and required value.

Fixes: e518e9a59ec3 ("checkpatch: emit an error when there's a diff in a changelog")
Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Joe Perches <joe@perches.com>
Link: https://lkml.kernel.org/r/20200714032352.f476hanaj2dlmiot@mrinalpandey
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/checkpatch.pl |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2636,8 +2636,8 @@ sub process {
 
 # Check if the commit log has what seems like a diff which can confuse patch
 		if ($in_commit_log && !$commit_log_has_diff &&
-		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&
-		      $line =~ m@^\s+diff\b.*a/([\w/]+)\s+b/$1\b@) ||
+		    (($line =~ m@^\s+diff\b.*a/([\w/]+)@ &&
+		      $line =~ m@^\s+diff\b.*a/[\w/]+\s+b/$1\b@) ||
 		     $line =~ m@^\s*(?:\-\-\-\s+a/|\+\+\+\s+b/)@ ||
 		     $line =~ m/^\s*\@\@ \-\d+,\d+ \+\d+,\d+ \@\@/)) {
 			ERROR("DIFF_IN_COMMIT_MSG",


