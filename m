Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A059C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3363B2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360826;
	bh=fEH5MARuDeBm7xykHMdOvvg3KVJtsODv97Cvb7xeU/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xRTjbyzQMO5qy2GXEm8f4kqqmNDLYNFEQ9o3oAoqtT7wI4G+vWqyqPBK+1BaeBoUw
	 dYnmqjEE8+T2id65xsjH2yJeL267lHFYZkdvMEUW2HC9/drjG3PngM72uHzz4KHMd4
	 nzuKNMBbRWoLr0M8ekKeh8KyJ7ZAw4WPhFFjE5sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgDHPrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A4220936;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=fEH5MARuDeBm7xykHMdOvvg3KVJtsODv97Cvb7xeU/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZITt0PBjJEATt9S90x8hP+JMoPOAEyhwpg6R9WZEHuXo7zP+bw0NQ/Npdx+51AXty
         GWVn7hnrtJaOlxrEQ7UwWo56SVXy7O01WGLtyIDYYbPcBF/+FBfU9LrBtR9ASrT5DZ
         Naxdza3tK1yYLjq7b/FymKsXGnA3YUzZyL5YC/ao=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBr-RF; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 20/35] docs: scripts/kernel-doc: accept blank lines on parameter description
Date:   Wed,  8 Apr 2020 17:46:12 +0200
Message-Id: <b7f5bf6cf16a4b7b4e1e4ab028fdcb8d5633599f.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx is very pedantic with respect to blank lines. Sometimes,
in order to make it to properly handle something, we need to
add a blank line. However, currently, any blank line inside a
kernel-doc comment like:

	/*
	 * @foo: bar
         *
	 *       foobar
	 *
	 * some description

will be considered as if "foobar" was part of the description.

This patch changes kernel-doc behavior. After it, foobar will
be considered as part of the parameter text. The description
will only be considered as such if it starts with:

zero spaces after asterisk:

	*foo

one space after asterisk:
	* foo

or have a explicit Description section:

	*   Description:

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index b019d8db6502..41ed4202f4ad 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -331,13 +331,14 @@ my $lineprefix="";
 
 # Parser states
 use constant {
-    STATE_NORMAL        => 0, # normal code
-    STATE_NAME          => 1, # looking for function name
-    STATE_BODY_MAYBE    => 2, # body - or maybe more description
-    STATE_BODY          => 3, # the body of the comment
-    STATE_PROTO         => 4, # scanning prototype
-    STATE_DOCBLOCK      => 5, # documentation block
-    STATE_INLINE        => 6, # gathering documentation outside main block
+    STATE_NORMAL        => 0,        # normal code
+    STATE_NAME          => 1,        # looking for function name
+    STATE_BODY_MAYBE    => 2,        # body - or maybe more description
+    STATE_BODY          => 3,        # the body of the comment
+    STATE_BODY_WITH_BLANK_LINE => 4, # the body, which has a blank line
+    STATE_PROTO         => 5,        # scanning prototype
+    STATE_DOCBLOCK      => 6,        # documentation block
+    STATE_INLINE        => 7,        # gathering doc outside main block
 };
 my $state;
 my $in_doc_sect;
@@ -1957,6 +1958,12 @@ sub process_body($$) {
 	}
     }
 
+    if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
+	dump_section($file, $section, $contents);
+	$section = $section_default;
+	$contents = "";
+    }
+
     if (/$doc_sect/i) { # case insensitive for supported section names
 	$newsection = $1;
 	$newcontents = $2;
@@ -2010,18 +2017,21 @@ sub process_body($$) {
 	$state = STATE_PROTO;
 	$brcount = 0;
     } elsif (/$doc_content/) {
-	# miguel-style comment kludge, look for blank lines after
-	# @parameter line to signify start of description
 	if ($1 eq "") {
-	    if ($section =~ m/^@/ || $section eq $section_context) {
+	    if ($section eq $section_context) {
 		dump_section($file, $section, $contents);
 		$section = $section_default;
 		$contents = "";
 		$new_start_line = $.;
+		$state = STATE_BODY;
 	    } else {
+		if ($section ne $section_default) {
+		    $state = STATE_BODY_WITH_BLANK_LINE;
+		} else {
+		    $state = STATE_BODY;
+		}
 		$contents .= "\n";
 	    }
-	    $state = STATE_BODY;
 	} elsif ($state == STATE_BODY_MAYBE) {
 	    # Continued declaration purpose
 	    chomp($declaration_purpose);
@@ -2173,7 +2183,8 @@ sub process_file($) {
 	    process_normal();
 	} elsif ($state == STATE_NAME) {
 	    process_name($file, $_);
-	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE) {
+	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE ||
+		 $state == STATE_BODY_WITH_BLANK_LINE) {
 	    process_body($file, $_);
 	} elsif ($state == STATE_INLINE) { # scanning for inline parameters
 	    process_inline($file, $_);
-- 
2.25.2

