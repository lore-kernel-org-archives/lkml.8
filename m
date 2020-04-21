Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E8CC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CF4206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479497;
	bh=luwbTwtGXShN7C9OMTgXycWd4bY3m03E8h+UHSYfI8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLS292FxhWpo/xHR1zI7nofz+VtNRrJtLRI8INnyc/gRS5/TBoJRitwtmgqC5qX6t
	 ZJOpQiSzOhZ6rXmurMNJNHSqd82t9u/P7bmJzKGQmxllgGHWso0ZbuOGS3qoNWXNaG
	 BbO033ShLTRtEj+9JQz4/3Vi5PWtY+5OEOuv8u9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgDUObg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgDUObN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:13 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51592206D9;
        Tue, 21 Apr 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479472;
        bh=luwbTwtGXShN7C9OMTgXycWd4bY3m03E8h+UHSYfI8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+FjEv2Y2e1X30oclruApi8lz3QJVKH1rct9fNFI6W0G+Rfez8Cs56jg1TgA6jAzc
         QdgfAvWTHGmU967+PedleY2r0goaSr/VSjXqNtnFDJGPeVUYWs/HWCb1L8YS73Skyi
         VdGVLsqPss26dwfjnyjnADbWSBSVSO4cVue6vEUo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQtva-00BkqU-IK; Tue, 21 Apr 2020 16:31:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/5] scripts: sphinx-pre-install: fix a bug when using with venv
Date:   Tue, 21 Apr 2020 16:31:08 +0200
Message-Id: <aa622ff71bebf6960fc0262fb90e7ebc7a999a02.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When python3 creates a venv, it adds python into it!

This causes any upgrade recommendation to look like this:

	/devel/v4l/docs/sphinx_1.7.9/bin/python3 -m venv sphinx_2.4.4
	. sphinx_2.4.4/bin/activate
	pip install -r ./Documentation/sphinx/requirements.txt

With is wrong (and it may not work). So, when recomending
an upgrade, exclude the venv dir from the search path, and
get the system's python.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 938b65d40fc8..987aebf7e3a0 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -148,6 +148,24 @@ sub findprog($)
 	}
 }
 
+sub find_python_no_venv()
+{
+	my $prog = shift;
+
+	my $cur_dir = qx(pwd);
+	$cur_dir =~ s/\s+$//;
+
+	foreach my $dir (split(/:/, $ENV{PATH})) {
+		next if ($dir =~ m,($cur_dir)/sphinx,);
+		return "$dir/python3" if(-x "$dir/python3");
+	}
+	foreach my $dir (split(/:/, $ENV{PATH})) {
+		next if ($dir =~ m,($cur_dir)/sphinx,);
+		return "$dir/python" if(-x "$dir/python");
+	}
+	return "python";
+}
+
 sub check_program($$)
 {
 	my $prog = shift;
@@ -814,6 +832,8 @@ sub check_needs()
 
 			print "To upgrade Sphinx, use:\n\n" if ($rec_sphinx_upgrade);
 
+			$python_cmd = find_python_no_venv();
+
 			if ($need_venv) {
 				printf "\t$python_cmd -m venv $virtenv_dir\n";
 			} else {
-- 
2.25.2

