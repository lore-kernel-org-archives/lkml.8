Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFEC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3D2214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598790580;
	bh=wHGR+e2YQ6p1W88wyu41jeFfclK5kDp8flK1giHFHYg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kyqRR7UJVPtgrDoiorW+oGpUFLi/Vt854qbbyheDlMO1VFMQVi/nh2Hwf81513EQZ
	 /MQKqeVMmvyyeCsW8Ne1UndjtcC2GswkK9VvmBuMsAWiM/HAwDBdXz2/+AtWjYvUuc
	 gai7zyFmpPi/SEQ4/awTXnP6hwJBNhuzPKujTT8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgH3M3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 08:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgH3M3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 08:29:34 -0400
Received: from localhost.localdomain (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C773F214D8;
        Sun, 30 Aug 2020 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598790573;
        bh=wHGR+e2YQ6p1W88wyu41jeFfclK5kDp8flK1giHFHYg=;
        h=From:To:Cc:Subject:Date:From;
        b=STqM98b801VPdgcgmaoo3AOrK6HLCEwWehddZA40KegL/d+QnNLECkwNfuYRGNO0i
         IdvYgpRc8peun4GhLZiE0LNhmWzKqmJaJm5QmlPzvSUE//OJtOCttpqO/D/MK2enG/
         Yzc4PrJ9Di9QEI3gFq9WnQ6/FRlXrgoXiwLGmhUc=
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] get_maintainer: add email addresses from dts files
Date:   Sun, 30 Aug 2020 20:29:22 +0800
Message-Id: <20200830122922.3884-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINER file will get bloated quickly if individual section entry
is created for each .dts/.dtsi file.  Add the email address from dts
files to get_maintainer output for saving unnecessary patching on
MAINTAINER file.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..b8e104028359 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -436,7 +436,7 @@ sub maintainers_in_file {
 
     return if ($file =~ m@\bMAINTAINERS$@);
 
-    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
+    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
 	open(my $f, '<', $file)
 	    or die "$P: Can't open $file: $!\n";
 	my $text = do { local($/) ; <$f> };
-- 
2.17.1

