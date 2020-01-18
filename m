Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA62C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 10:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010C22468D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 10:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgARKx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 05:53:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:61335 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgARKx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 05:53:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 02:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,333,1574150400"; 
   d="scan'208";a="220976111"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2020 02:53:24 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isljI-0003BG-9w; Sat, 18 Jan 2020 18:53:24 +0800
Date:   Sat, 18 Jan 2020 18:52:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mike Salvatore <mike.salvatore@canonical.com>
Cc:     kbuild-all@lists.01.org, Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] apparmor: build_aa_ext_struct() can be static
Message-ID: <20200118105227.clmarnx4evv7sdox@f53c9c00458a>
References: <202001181831.bFmypzrR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001181831.bFmypzrR%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 policy_unpack_test.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361c..dbcfeb12a019f 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -48,8 +48,8 @@ struct policy_unpack_fixture {
 	size_t e_size;
 };
 
-struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
-				   struct kunit *test, size_t buf_size)
+static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
+					  struct kunit *test, size_t buf_size)
 {
 	char *buf;
 	struct aa_ext *e;
