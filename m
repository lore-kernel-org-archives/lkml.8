Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A13C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299142072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584044780;
	bh=L6THbxbpph8IpXk+VCYu9esbzAMpoBUjjQyA3jdIFbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXob6M4PFvwLfpqMdUz0isuPe1qTT12SkyYmtoKVl6F2CD13L6/5SC0Kn4yAXT739
	 7dFR9/G7lPlkr5v8IZU1XyAMKR4ryXTH2yzfXrFn1Qc/GvVYPZcB7gO/G09rd0xbBc
	 p/YcqIXaNurTzshIHtHneoW2Eo10ajes29t894R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgCLU0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgCLU0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:26:11 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63D220724;
        Thu, 12 Mar 2020 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584044770;
        bh=L6THbxbpph8IpXk+VCYu9esbzAMpoBUjjQyA3jdIFbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuleeduDblgu+tcTTwXnhTHVDn8oSBKsjMOgWI/0GaepVS65w56rkBWreak3cEvEj
         NpBa98Q7/NOF1JzOwnbw7LQ+qKkBRumbjY+O6piMW1SdEkw14eEEb3nHohMfjb4rhd
         zPDfyvUj2U+Xc4DEJqZVe5uU87VoAg+v0UNZBW+s=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: [PATCH v2 3/4] docs: admin-guide: document the kernel.modprobe sysctl
Date:   Thu, 12 Mar 2020 13:25:51 -0700
Message-Id: <20200312202552.241885-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312202552.241885-1-ebiggers@kernel.org>
References: <20200312202552.241885-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the kernel.modprobe sysctl in the same place that all the other
kernel.* sysctls are documented.  Make sure to mention how to use this
sysctl to completely disable module autoloading, and how this sysctl
relates to CONFIG_STATIC_USERMODEHELPER.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 25 ++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee9..454f3402ed321 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -49,7 +49,7 @@ show up in /proc/sys/kernel:
 - kexec_load_disabled
 - kptr_restrict
 - l2cr                        [ PPC only ]
-- modprobe                    ==> Documentation/debugging-modules.txt
+- modprobe
 - modules_disabled
 - msg_next_id		      [ sysv ipc ]
 - msgmax
@@ -444,6 +444,29 @@ l2cr: (PPC only)
 This flag controls the L2 cache of G3 processor boards. If
 0, the cache is disabled. Enabled if nonzero.
 
+modprobe:
+=========
+
+The path to the usermode helper for autoloading kernel modules, by
+default "/sbin/modprobe".  This binary is executed when the kernel
+requests a module.  For example, if userspace passes an unknown
+filesystem type "foo" to mount(), then the kernel will automatically
+request the module "fs-foo.ko" by executing this usermode helper.
+This usermode helper should insert the needed module into the kernel.
+
+This sysctl only affects module autoloading.  It has no effect on the
+ability to explicitly insert modules.
+
+If this sysctl is set to the empty string, then module autoloading is
+completely disabled.  The kernel will not try to execute a usermode
+helper at all, nor will it call the kernel_module_request LSM hook.
+
+If CONFIG_STATIC_USERMODEHELPER=y is set in the kernel configuration,
+then the configured static usermode helper overrides this sysctl,
+except that the empty string is still accepted to completely disable
+module autoloading as described above.
+
+Also see Documentation/debugging-modules.txt.
 
 modules_disabled:
 =================
-- 
2.25.1

