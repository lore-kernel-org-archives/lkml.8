Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D313C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD465206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479479;
	bh=4GhksQHgG85m34bWPa/6HXrwdvgqDJ6sDHmC/jHvmYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OO/IYX3y2eW/pePF3DBSYM5XcZ4i9zn24RDJJ3AJ3qJVOoLm+GBg7motdGPnknVFr
	 xWjj+29cnwALxYJ+PC9ZSnwPpthivP4khu7+k2jvUj0xhwMtmooiyTK3N6wxfQtC55
	 w98iC9ebr1Ow6gfxiuJdkmzy1DR+DxUhuPV+biWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgDUObT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgDUObN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:13 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD24206F4;
        Tue, 21 Apr 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479472;
        bh=4GhksQHgG85m34bWPa/6HXrwdvgqDJ6sDHmC/jHvmYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1ktIuVSNh0w6XajMPzT5T1vB9gtU3kkn9H0x358MIuZfEbeQPp6VnccNKOHN+4UF
         MkZSPQNpoEQudB1gEEAEPX8NFehguavSOCzFny6cqBeakl5kyjcmsYk35lFnCkiTM6
         e0hdJnGatO3lNxrlFzuDR7a2lzvPbITn4Vt6+ZhA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQtva-00BkqI-G1; Tue, 21 Apr 2020 16:31:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/5] scripts: sphinx-pre-install: only ask to activate valid venvs
Date:   Tue, 21 Apr 2020 16:31:05 +0200
Message-Id: <d11a00d88514e8a0357e1b0a05ebd518952a1d39.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a venv doesn't contain Sphinx, or has an older Sphinx
version, ignore it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 53 ++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index d4dfe1e59989..249edb3932af 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -231,6 +231,27 @@ sub get_sphinx_fname()
 	return "";
 }
 
+sub get_sphinx_version($)
+{
+	my $cmd = shift;
+	my $ver;
+
+	open IN, "$cmd --version 2>&1 |";
+	while (<IN>) {
+		if (m/^\s*sphinx-build\s+([\d\.]+)(\+\/[\da-f]+)?$/) {
+			$ver=$1;
+			last;
+		}
+		# Sphinx 1.2.x uses a different format
+		if (m/^\s*Sphinx.*\s+([\d\.]+)$/) {
+			$ver=$1;
+			last;
+		}
+	}
+	close IN;
+	return $ver;
+}
+
 sub check_sphinx()
 {
 	my $rec_version;
@@ -266,19 +287,8 @@ sub check_sphinx()
 		return;
 	}
 
-	open IN, "$sphinx --version 2>&1 |" or die "$sphinx returned an error";
-	while (<IN>) {
-		if (m/^\s*sphinx-build\s+([\d\.]+)(\+\/[\da-f]+)?$/) {
-			$cur_version=$1;
-			last;
-		}
-		# Sphinx 1.2.x uses a different format
-		if (m/^\s*Sphinx.*\s+([\d\.]+)$/) {
-			$cur_version=$1;
-			last;
-		}
-	}
-	close IN;
+	$cur_version = get_sphinx_version($sphinx);
+	die ("$sphinx returned an error") if (!$cur_version);
 
 	die "$sphinx didn't return its version" if (!$cur_version);
 
@@ -765,10 +775,21 @@ sub check_needs()
 		my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
 
 		@activates = sort {$b cmp $a} @activates;
+		my ($activate, $ver);
+		foreach my $f (@activates) {
+			$activate = $f;
+			next if ($activate lt $min_activate);
 
-		if ($need_sphinx && scalar @activates > 0 && $activates[0] ge $min_activate) {
-			printf "\nNeed to activate a compatible Sphinx version on virtualenv with:\n";
-			printf "\t. $activates[0]\n";
+			my $sphinx_cmd = $activate;
+			$sphinx_cmd =~ s/activate/sphinx-build/;
+			next if (! -f $sphinx_cmd);
+
+			$ver = get_sphinx_version($sphinx_cmd);
+			last if ($ver ge $min_version);
+		}
+		if ($need_sphinx && ($activate ne "")) {
+			printf "\nNeed to activate Sphinx (version $ver) on virtualenv with:\n";
+			printf "\t. $activate\n";
 			deactivate_help();
 			exit (1);
 		} else {
-- 
2.25.2

