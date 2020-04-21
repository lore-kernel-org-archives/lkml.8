Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F4EC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB81206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587486484;
	bh=KpEi4KqsRoYZmLYN9uEHbqvwZI0iVXAOFwlpf7D714U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u7EyLyBCEEb029Je+I7SbUa786tpUXhVPKhwJR1U4rMkRTjb/NFMczt9vo2vm7eu5
	 OAo9CGwE35Q+M+hH/hjU68YyjcIRxxS4YrswvYpIIe+SJDk8aqwJRrGBOtI2xqimrG
	 w3EhKb/4q2ryFCwDcumkaqqwDc2bK3UIgJRhkYX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgDUQ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUQ2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:28:03 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE78206E9;
        Tue, 21 Apr 2020 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587486482;
        bh=KpEi4KqsRoYZmLYN9uEHbqvwZI0iVXAOFwlpf7D714U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNjW+pTpWWnvHd9gTc5hrnFWebJXzQ5dLIS+7Sxk34YOUoOB8hjz+9f5jLKvQ8OW4
         2+CcjzqDFeCxlKzVGRGzC/hQwZie6Hx7mssgp0lGJFYgrwUO/wquJkYAPKkc7R4i2l
         pySdlLGiWXxM1OptvlFHk++hOHj8Vr7otT7hBq60=
Date:   Tue, 21 Apr 2020 18:27:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1.1 5/5] scripts: sphinx-pre-install: change the output
 order
Message-ID: <20200421182758.04e0a53e@coco.lan>
In-Reply-To: <36cecf7fe19d165db8e93f8a0f6fc88ec705d131.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
        <36cecf7fe19d165db8e93f8a0f6fc88ec705d131.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the script detects the need for an upgrade, it will
print either a warning or a note.

Let's change a little bit the order where messages will be
displayed, in order to make easier for the user to identify
the more important messages.

It should now be like this:

	Detected OS: Fedora release 31 (Thirty One).
	Sphinx version: 1.7.9

	Note: It is recommended at least Sphinx version 2.4.4 if you need PDF support.
	To upgrade Sphinx, use:

		/usr/bin/python3 -m venv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r ./Documentation/sphinx/requirements.txt

	If you want to exit the virtualenv, you can use:
		deactivate

All optional dependencies are met.
Needed package dependencies are met.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

v 1.1: I forgot to commit some minor changes to the patch

 scripts/sphinx-pre-install | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 987aebf7e3a0..c680c3efb176 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -320,15 +320,10 @@ sub check_sphinx()
 	}
 
 	if ($cur_version lt $rec_version) {
-		printf "Sphinx version %s\n", $cur_version;
-		print "Warning: It is recommended at least Sphinx version $rec_version.\n";
-		print "         If you want pdf, you need at least $min_pdf_version.\n";
 		$rec_sphinx_upgrade = 1;
 		return;
 	}
 	if ($cur_version lt $min_pdf_version) {
-		printf "Sphinx version %s\n", $cur_version;
-		print "Note: It is recommended at least Sphinx version $min_pdf_version if you need PDF support.\n";
 		$rec_sphinx_upgrade = 1;
 		return;
 	}
@@ -716,10 +711,11 @@ sub check_needs()
 	check_sphinx();
 
 	if ($system_release) {
-		print "Detected OS: $system_release.\n\n";
+		print "Detected OS: $system_release.\n";
 	} else {
-		print "Unknown OS\n\n";
+		print "Unknown OS\n";
 	}
+	printf "Sphinx version: %s\n\n", $cur_version if ($cur_version);
 
 	# Check python command line, trying first python3
 	$python_cmd = findprog("python3");
@@ -799,6 +795,13 @@ sub check_needs()
 		my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
 		my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
 
+		if ($cur_version lt $rec_version) {
+			print "Warning: It is recommended at least Sphinx version $rec_version.\n";
+			print "         If you want pdf, you need at least $min_pdf_version.\n";
+		}
+		if ($cur_version lt $min_pdf_version) {
+			print "Note: It is recommended at least Sphinx version $min_pdf_version if you need PDF support.\n";
+		}
 		@activates = sort {$b cmp $a} @activates;
 		my ($activate, $ver);
 		foreach my $f (@activates) {
-- 
2.25.2



