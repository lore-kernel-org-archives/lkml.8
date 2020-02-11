Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7858DC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3730E20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlcYBoQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBKA0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:26:11 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:40498 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBKA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:26:11 -0500
Received: by mail-pj1-f74.google.com with SMTP id ev1so660654pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HpkmKDHicHDmtN7FR/CAsd7jrGUK0Ch8LLHTELEcaI8=;
        b=WlcYBoQN/UUVFckJDb98wgrYBIMpqWfe4YPOk623qSX1nuLl2QCee199r3HRf2PXaV
         vB4qCCPeRVg6DAL58TUwJbNEx9tUFk/hT6ln8v1QXgYUw0HczC3qR3jATdNIYf8jkt4l
         R8HRlys6HV34vo03lz8Dp5F3rTIHS1wfYLJbL/Rh58kVGdkb9KA5fi7rvCoj/pwv3xhe
         Nqle/Cu3ywo//U3/+vjuQcZVJMPYtymaK7DSRDBCO4Qhg6ucp1IcrH+7Jk/WxjyyLtA5
         ++VP8lx70bn7CM175UqAd8bDn6O3I3zmlJAjdwFi47sjVUlgh/uCReNLlwtwHDSXYBTE
         mBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HpkmKDHicHDmtN7FR/CAsd7jrGUK0Ch8LLHTELEcaI8=;
        b=r5k2tvsHZjDiy3w1JFfk9PpiwYri3Aek3FZiZwNn2crVQGR/X4Hg8FIuxVQSizT86h
         7xegN/TqKHtmKDfIwGWyeoUEk3aVqUddt9sDErw7QZhHIoj/+eMxdOfJ2/9IvshQWql1
         j9zMNmYZbNSvdfcNG9ZPgpRTtP71lUSRQGd+2LQMdNhQ3xtoHoDk9MfSVzM681x5dLLX
         BLK1tBqQCcARTnnFVKm3OSqvfX5lUEP28zKsyu49Di0aa0ceul7u2Z277yiPinKYgOu4
         mOsknNGP6rTn4EbEPqQaakcRdjoDW/aa1XNzuPZ8b4FOzvGZHOOR6VnAzzADkK+kXpX+
         T6Dg==
X-Gm-Message-State: APjAAAXLHloOa3P7pn5sd9tU7OcXWgeKHpBg57oaR7d0+QyJYVnuN7h5
        5dcseYAocW3GCaq34Uu6gyekzI5esXN1OcSj
X-Google-Smtp-Source: APXvYqwfJ//FL4XeWE5K0KVKUilnpBT2yJ5Ok0NBAzyqjqJgwQ/24jECDHHQUh+bfzZBXM2UBb1vEKSK5qgEjANW
X-Received: by 2002:a63:5a11:: with SMTP id o17mr4313739pgb.60.1581380768895;
 Mon, 10 Feb 2020 16:26:08 -0800 (PST)
Date:   Mon, 10 Feb 2020 16:25:51 -0800
Message-Id: <20200211002551.147187-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kunit: run kunit_tool from any directory
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented small fix so that the script changes work directories to the
linux directory where kunit.py is run. This enables the user to run
kunit from any working directory. Originally considered using
os.path.join but this is more error prone as we would have to find all
file path usages and modify them accordingly. Using os.chdir ensures
that the entire script is run within /linux.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 tools/testing/kunit/kunit.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e59eb9e7f923..3cc7be7b28a0 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -35,6 +35,13 @@ def create_default_kunitconfig():
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
 				kunit_kernel.kunitconfig_path)
 
+def get_kernel_root_path():
+	parts = sys.argv[0] if not __file__ else __file__
+	parts = os.path.realpath(parts).split('tools/testing/kunit')
+	if len(parts) != 2:
+		sys.exit(1)
+	return parts[0]
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
@@ -114,6 +121,9 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if get_kernel_root_path():
+			os.chdir(get_kernel_root_path())
+
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-- 
2.25.0.341.g760bfbb309-goog

