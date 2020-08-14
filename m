Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F9CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5874A206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597400240;
	bh=tDbXWVerMAt2vjvC+x0gHEGyEhYx1t9KNHKj5mxL/F8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=z1MxL8ZmZFKrCvHs2oq1/VW7lVVV+UrNwEuXOod+hAP9wRcca7pdyWKduSORnyuJJ
	 FYoTD4mCONNr4inNRLNepIMc9bCTCi3P2Bi0PIguKsIy1/Nyk3mPfYc4pWzgVUGu0c
	 iOU3blhrfdn0yXZ4yECSRNRNOqXNd3//xndq4stU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgHNKRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNKRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:17:18 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11244206DA;
        Fri, 14 Aug 2020 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597400237;
        bh=tDbXWVerMAt2vjvC+x0gHEGyEhYx1t9KNHKj5mxL/F8=;
        h=Date:From:To:Cc:Subject:From;
        b=Zkr2JzbN8DWPmzw4ecUEfwbw2tOPKadI4VKIFKmB7FCzEE1zL+QyclAimXfPGNY//
         tHF0q5NwuElgwBiy0XIr1uWGR068ezx9jcfEUFW8HBiDQuHKCaDfwSefwghuIFIL9F
         7fDsOghhm7Txc0XiAARkKk+Hlb0kyg26aFtitS4o=
Date:   Fri, 14 Aug 2020 12:17:14 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.9
Message-ID: <20200814101712.GA32330@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.9 merge window.
The most important change would be Christoph Hellwig's patch implementing
proprietary taint inheritance, in an effort to discourage the creation of
GPL "shim" modules that interface between GPL symbols and proprietary
symbols. A recent example cited from the discussion can be found here:

   https://lore.kernel.org/netdev/6376CA34-BC6F-45DE-9FFD-7E32664C7569@fb.com/T/#md514322fdfa212afe9f1d3eb4e5f7eaefece36eb

Thank you,

Jessica
--
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.9

for you to fetch changes up to 262e6ae7081df304fc625cf368d5c2cbba2bb991:

  modules: inherit TAINT_PROPRIETARY_MODULE (2020-08-05 10:31:28 +0200)

----------------------------------------------------------------
Modules updates for v5.9

Summary of modules changes for the 5.9 merge window:

- Have modules that use symbols from proprietary modules inherit the
  TAINT_PROPRIETARY_MODULE taint, in an effort to prevent GPL shim modules that
  are used to circumvent _GPL exports. These are modules that claim to be GPL
  licensed while also using symbols from proprietary modules. Such modules will
  be rejected while non-GPL modules will inherit the proprietary taint.

- Module export space cleanup. Unexport symbols that are unused outside of
  module.c or otherwise used in only built-in code.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (8):
      modules: mark ref_module static
      modules: mark find_symbol static
      modules: mark each_symbol_section static
      modules: unexport __module_text_address
      modules: unexport __module_address
      modules: rename the licence field in struct symsearch to license
      modules: return licensing information from find_symbol
      modules: inherit TAINT_PROPRIETARY_MODULE

Randy Dunlap (1):
      modules: linux/moduleparam.h: drop duplicated word in a comment

 include/linux/module.h      | 26 +++-----------------
 include/linux/moduleparam.h |  2 +-
 kernel/module.c             | 60 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 47 insertions(+), 41 deletions(-)
