Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729E92074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aPACDWOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFJU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:56:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A1C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:56:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so1425428plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2Lnh4V59N4p1gtj8FV4HhHXE7+kW0jjj1uw/jJ6dyyI=;
        b=aPACDWOGjAvaFcgHrtsYocoxS96QkQ3WCMSJLBkp7l6P8O4GiwqIp8zEIcc76CzIv1
         2/M+0XNEfEtObeNfHMh/fZC+m1w3gdwKZgftP9WJTaBt3BAcCZ0wtGxu7GD4V3Dadx6n
         e509nzPytvXjKDXtPOMYNWGce8O5IUtLhObuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Lnh4V59N4p1gtj8FV4HhHXE7+kW0jjj1uw/jJ6dyyI=;
        b=mVf9aw2nA9PfWsva/i893VRpRytOaCzSVb8q7vwSLBStz7Ur4X1DoQJ3WDy1DWiqwg
         DbTkzfyx3Nenn22UK89Z213TgxS9lfLtphwFbFy6BwxYlz73p6aJf80ZVgYPCw7ZLVlM
         fR1IEtUc3GNyJWIhsX7p0+7zj4BrINcLOxrMNTWGKbdxJi0nULeJ0lSNOLOmOSiFS1YR
         x2nnSdWC0WDUiTafdgGcsTA9YAOKf4hr9iT3PtchlF1Gdx/3xvROVHHX4jKVFIte+oqS
         IlrJCFxy8zqL32Ka2UHLVc3ccdXFQPO4E7FQPuy3l3FuPlbLvgmGzBO90weooyDuTbku
         beFg==
X-Gm-Message-State: AOAM531d5JsfAkH7FFobsYN28BQiasib7gwQne0zK47ttM7j0ggqjXZu
        wBZ9GmjABvktk+t+LG+6mAaNvQ==
X-Google-Smtp-Source: ABdhPJzGxe/OPizay4WXHrURY8mq5z5JLDSuozTcilKpxdW/5vPj654d/ruUWQgqv7uqkRbPm5YveQ==
X-Received: by 2002:a17:90a:890b:: with SMTP id u11mr4824552pjn.233.1591822583585;
        Wed, 10 Jun 2020 13:56:23 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m20sm855462pfk.52.2020.06.10.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:56:22 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] checkpatch: add --max-file-size option
Date:   Wed, 10 Jun 2020 13:56:16 -0700
Message-Id: <20200610205616.9965-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --max-file-size option (default off) to limit size of files
that checkpatch processes.  Such an option is useful when checkpatch
is run automatically during checkins to a source control system and
someone acccidently or purposely attempt to commit massive size files
to the system.  If the checkpatch script runs on such files it could take
a long time to run and limit the server's ability to perform other
operations.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9fa90457b270..5f0304a9f013 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -53,6 +53,7 @@ my %ignore_type = ();
 my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
+my $max_file_size = -1;
 my $max_line_length = 100;
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
@@ -99,6 +100,7 @@ Options:
   --types TYPE(,TYPE2...)    show only these comma separated message types
   --ignore TYPE(,TYPE2...)   ignore various comma separated message types
   --show-types               show the specific message type in the output
+  --max-file-size=n          set the maximum file size, if exceeded, exit
   --max-line-length=n        set the maximum line length, (default $max_line_length)
                              if exceeded, warn on patches
                              requires --strict for use with --file
@@ -219,6 +221,7 @@ GetOptions(
 	'types=s'	=> \@use,
 	'show-types!'	=> \$show_types,
 	'list-types!'	=> \$list_types,
+	'max-file-size=i' => \$max_file_size,
 	'max-line-length=i' => \$max_line_length,
 	'min-conf-desc-length=i' => \$min_conf_desc_length,
 	'tab-size=i'	=> \$tabsize,
@@ -1061,6 +1064,15 @@ for my $filename (@ARGV) {
 	} else {
 		$vname = $filename;
 	}
+
+	if ($max_file_size > 0) {
+		my $filesize = -s$FILE;
+
+		if ($filesize > $max_file_size) {
+			die "$P: $filename: filesize:$filesize > $max_file_size\n";
+		}
+	}
+
 	while (<$FILE>) {
 		chomp;
 		push(@rawlines, $_);
-- 
2.17.1

