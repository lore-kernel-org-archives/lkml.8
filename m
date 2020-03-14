Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EFC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7A7205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239085;
	bh=60nbem/GmL/SUs8mZbdKlCVVcvFz4J/mVsG+CUpqtqw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wjg4J/9lmustcGQi1jUjyprLdhcYbijfmCg+cxubezvHAInhVRFKkGrNkL/jD9U+K
	 PC+bmy0c1aTITbttOJmrW1ELioJVymkFwMpuc8VGulctN9CiecOvz0K3588FtddLpp
	 O9gvZTPJR9L7+Fq1jOq/ITyMYP3zNxR9O6hIKW0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgCOCYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgCOCYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CC1207BC;
        Sat, 14 Mar 2020 21:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584221807;
        bh=60nbem/GmL/SUs8mZbdKlCVVcvFz4J/mVsG+CUpqtqw=;
        h=From:To:Cc:Subject:Date:From;
        b=TVfzwx5wGzNDXZmVFW2Cinfzx7abf6RhRsO9DAr9vVHuFRN+U+/h/UFYha86eGb0v
         seqEwqcZK8WDOMcDt4e2NsZfPnPBYkXIvX0m/Awvoun/hnLHa1x6ba1FVA393CNSnD
         EEVMItDFS5h9sgvMKori0VyPy99z3XX0RAHLVC9g=
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
Subject: [PATCH v3 0/5] module autoloading fixes and cleanups
Date:   Sat, 14 Mar 2020 14:34:21 -0700
Message-Id: <20200314213426.134866-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a bug where request_module() was reporting success to
kernel code when module autoloading had been completely disabled via
'echo > /proc/sys/kernel/modprobe'.

It also addresses the issues raised on the original thread
(https://lkml.kernel.org/lkml/20200310223731.126894-1-ebiggers@kernel.org/T/#u)
by documenting the modprobe sysctl, adding a self-test for the empty
path case, and downgrading a user-reachable WARN_ONCE().

Changed since v2:
  - Adjusted the new documentation to avoid implicitly bringing up
    module aliases, which are a more complex topic.
  - Split the selftest patch into two patches, one to fix the test
    numbering bug and one to add the new tests.

Changed since v1:
  - Added patches to address the other issues raised on the thread.

Eric Biggers (5):
  kmod: make request_module() return an error when autoloading is
    disabled
  fs/filesystems.c: downgrade user-reachable WARN_ONCE() to
    pr_warn_once()
  docs: admin-guide: document the kernel.modprobe sysctl
  selftests: kmod: fix handling test numbers above 9
  selftests: kmod: test disabling module autoloading

 Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++++++-
 fs/filesystems.c                            |  4 +-
 kernel/kmod.c                               |  4 +-
 tools/testing/selftests/kmod/kmod.sh        | 43 +++++++++++++++++++--
 4 files changed, 68 insertions(+), 8 deletions(-)

-- 
2.25.1

