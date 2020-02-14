Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52028C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F2524676
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581660610;
	bh=Kc2vb5ztTSiLTpw3SoX3wXVs2ZKMS6lfB2nsHx4fKT4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RhyJOE0fD/1KkUA43gf0DDf3Uhse82Zb7RYW6Y/Q6vcTn5BZHVGmaCuEJS2BhzEaN
	 Cl9QxR0YmDBhu43xl89R6Hj1JK+U5A/l4jHukyfuPhMQojpGX72lYXNcnJ/o7qogG6
	 lhDX5izXLdSYIFmxGL31AjRDA/yF7t8E979PqzI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgBNGKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgBNGKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:10:09 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4B8222C4;
        Fri, 14 Feb 2020 06:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581660608;
        bh=Kc2vb5ztTSiLTpw3SoX3wXVs2ZKMS6lfB2nsHx4fKT4=;
        h=From:To:Cc:Subject:Date:From;
        b=meaeyX/E6WWGJsMTMfOx7+/Aj71hrpHp7m+9lqvX0r2tE97c1M+73DrRikm9erWw0
         iZVrwWtk1CpRvPSnwnedxvuWTrp862DtxrnUFBqDWuOgqw7RzuQrtGeIAH6pC0u8mr
         Vfi9a69CBTFudu4y19fKZdaxm25yd6zHhRljK4Uo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/3] random: add random.rng_seed to bootconfig entry
Date:   Fri, 14 Feb 2020 15:10:00 +0900
Message-Id: <158166060044.9887.549561499483343724.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series is bootconfig based implementation of
the rng_seed option patch originally from Mark Salyzyn.
Note that I removed unrelated command line fixes from this
series.

To complete the support of UTF-8 for rng_seed, I added [1/3]
to support non-ascii chars on the value (user can use 0x80-
0xff at the value of bootconfig).

For [3/3], I updated to use bootconfig (xbc_find_value)
instead of command line. Also move the documentation under
Documentation/admin-guide/bootconfig.

Thank you,

---

Mark Salyzyn (2):
      random: rng-seed source is utf-8
      random: add random.rng_seed= bootconfig option

Masami Hiramatsu (1):
      bootconfig: Support non-ascii characters in value


 Documentation/admin-guide/bootconfig/random.rst |   21 ++++++++++++
 drivers/char/Kconfig                            |    1 +
 drivers/char/random.c                           |   10 +++++-
 fs/proc/bootconfig.c                            |    4 ++
 include/linux/random.h                          |    7 ++++
 init/main.c                                     |   41 ++++++++++++++++-------
 lib/bootconfig.c                                |    2 +
 tools/bootconfig/samples/good-non-ascii.bconf   |    1 +
 8 files changed, 73 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/admin-guide/bootconfig/random.rst
 create mode 100644 tools/bootconfig/samples/good-non-ascii.bconf

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
