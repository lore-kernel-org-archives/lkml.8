Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E720663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580491404;
	bh=XPildtQFTVpy65iEB7yl2hAOgkHxHac/v8CsGQ18TNY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gdZ/DL/k86rj1vmuHQQa9I12J1dgmmTOeMrJC3KBUi5GwT1LPxC+yxYU956IdYgjf
	 PbaXe5YjY+mBjyt6n9YTWWzWaWr2lwU8nd6lQ8PZ3aH0RFji0WDo2u2j47CPoSuknD
	 un3km45XcMzW+IOq/gZctH5Y6hPev7WedoS1HY/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgAaRXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgAaRXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:23:23 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431DC20663;
        Fri, 31 Jan 2020 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580491403;
        bh=XPildtQFTVpy65iEB7yl2hAOgkHxHac/v8CsGQ18TNY=;
        h=Date:From:To:Cc:Subject:From;
        b=JO6M4f5ZEeLSJSgF8N5MPSM3UthwfbjyBMLxGt2TJsZdHAYEAlxU6u17BCEydPHZQ
         w7GgjxsMtSlE7m9had15XeysWkOwtqzl/Wd/AfND/Xdc0k6JNh4bNkGtphK2JUe6m7
         Fylpm+hF0MBrLtMBtcNSzynd2snYa7UrV/49EzsI=
Date:   Fri, 31 Jan 2020 18:23:19 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.6
Message-ID: <20200131172319.GA16783@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the 5.6 merge window.
Details can be found in the signed tag.

Thanks,

Jessica

---
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.6

for you to fetch changes up to 6080d608eeff7cb5090a2ddbaf723bfb0ff133fc:

  module.h: Annotate mod_kallsyms with __rcu (2020-01-23 18:19:48 +0100)

----------------------------------------------------------------
Modules updates for v5.6

Summary of modules changes for the 5.6 merge window:

- Add "MS" (SHF_MERGE|SHF_STRINGS) section flags to __ksymtab_strings to
  indicate to the linker that it can perform string deduplication (i.e.,
  duplicate strings are reduced to a single copy in the string table).
  This means any repeated namespace string would be merged to just one
  entry in __ksymtab_strings.

- Various code cleanups and small fixes (fix small memleak in error path,
  improve moduleparam docs, silence rcu warnings, improve error logging)

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Fabien Dessenne (1):
      moduleparam: fix kerneldoc

Jessica Yu (3):
      export.h: reduce __ksymtab_strings string duplication by using "MS" section flags
      modsign: print module name along with error message
      module: avoid setting info->name early in case we can fall back to info->mod->name

Madhuparna Bhowmik (1):
      module.h: Annotate mod_kallsyms with __rcu

Masami Hiramatsu (1):
      modules: lockdep: Suppress suspicious RCU usage warning

YueHaibing (1):
      kernel/module: Fix memleak in module_add_modinfo_attrs()

 include/asm-generic/export.h |  8 +++--
 include/linux/export.h       | 33 ++++++++++++------
 include/linux/module.h       |  2 +-
 include/linux/moduleparam.h  | 82 +++++++++++++++++++++++++++++++++++++++++---
 kernel/module.c              | 22 +++++++-----
 5 files changed, 119 insertions(+), 28 deletions(-)
