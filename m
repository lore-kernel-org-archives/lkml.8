Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A63C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD04520769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361340;
	bh=1neY0kmwY6hoJ7M2Brvc4eQ5g5tye/F2EH9oVSPmfWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PGm55CkjDHUcq58kEpuPpkG2rSAq6t0VlPAofHt0Y8oKMc18ixN7yuLZwPHsJ/kft
	 P4RSup6VBvbixRySXVFAgYrJuWNz7uuY1cUUQb/SxPpoZR/k332QuK/B4eieV6LgC4
	 Bu9DrIRT8qVhMCymOA2fPvzZTAxMHS0pc2n9j40c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgDHPza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72FD206F5;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=1neY0kmwY6hoJ7M2Brvc4eQ5g5tye/F2EH9oVSPmfWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDuZWeCytHC7wO1Je1AZJ9Yy0hBqChfRXpIRBCMZLwiKijH5v2xFZyRftaLDVpvvW
         jJEGqaiMnbvWWU1MPFNxkz7UUDb1HDRBlJ6+PXLLPB2gljzWLHhG4TT/hpnCViTvL5
         1fd5zcXPS2+sXGHTGmHOAO1jufB3SgTJg0MO0Dbo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD30-000cGk-UT; Wed, 08 Apr 2020 17:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 1/6] scripts: sphinx-pre-install: improve distro detection check
Date:   Wed,  8 Apr 2020 17:55:20 +0200
Message-Id: <2f22c8a80a4740176fabdee0d0cd23dbe7395b03.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586361086.git.mchehab+huawei@kernel.org>
References: <cover.1586361086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arch-linux detection is hit by catting /etc/issue, whose
contents is (nowadays):

	Arch Linux \r (\l)

It sounds a little ackward to print such string, so,
instead, let's use the /etc/os-release file, with exists
on lots of distributions and should provide a more reliable
result.

We'll keep the old tests before it, in order to avoid possible
regressions with the other distros, although the new way should
probably work on all the currently supported distributions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index fa3fb05cd54b..c2071a1c69ea 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -780,6 +780,24 @@ $system_release = catcheck("/etc/system-release") if !$system_release;
 $system_release = catcheck("/etc/redhat-release") if !$system_release;
 $system_release = catcheck("/etc/lsb-release") if !$system_release;
 $system_release = catcheck("/etc/gentoo-release") if !$system_release;
+
+# This seems more common than LSB those days
+if (!$system_release) {
+	my %os_var;
+	if (open IN, "cat /etc/os-release|") {
+		while (<IN>) {
+			if (m/^([\w\d\_]+)=\"?([^\"]*)\"?\n/) {
+				$os_var{$1}=$2;
+			}
+		}
+		$system_release = $os_var{"NAME"};
+		if (defined($os_var{"VERSION_ID"})) {
+			$system_release .= " " . $os_var{"VERSION_ID"} if (defined($os_var{"VERSION_ID"}));
+		} else {
+			$system_release .= " " . $os_var{"VERSION"};
+		}
+	}
+}
 $system_release = catcheck("/etc/issue") if !$system_release;
 $system_release =~ s/\s+$//;
 
-- 
2.25.2

