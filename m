Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D9C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104F324686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgA1JYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:24:15 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:40302 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgA1JYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:24:14 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iwN6P-00081e-UC; Tue, 28 Jan 2020 09:24:10 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iwN6N-00056c-9c; Tue, 28 Jan 2020 09:24:09 +0000
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml updates for 5.6-rc1
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        johannes@sipsolutions.net, linux-um@lists.infradead.org
Message-ID: <aaf07936-6fd2-be40-15dc-f87e8e84091d@cambridgegreys.com>
Date:   Tue, 28 Jan 2020 09:24:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I am sending this on behalf of Richard who is traveling.

Please pull the following uml updates for v5.6-rc1:

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

   Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.6-rc1

for you to fetch changes up to d65197ad52494bed3b5e64708281b8295f76c391:

   um: Fix time-travel=inf-cpu with xor/raid6 (2020-01-19 22:42:06 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Fix for time travel mode
- Disable CONFIG_CONSTRUCTORS again
- A new command line option to have an non-raw serial line
- Preparations to remove obsolete UML network drivers

----------------------------------------------------------------
Brendan Higgins (1):
       um: Mark non-vector net transports as obsolete

Johannes Berg (3):
       um: Add an option to make serial driver non-raw
       Revert "um: Enable CONFIG_CONSTRUCTORS"
       um: Fix time-travel=inf-cpu with xor/raid6

  arch/um/Kconfig                  |  2 +
  arch/um/drivers/Kconfig          | 81 ++++++++++++++++++++--------------------
  arch/um/drivers/chan_user.h      |  2 +-
  arch/um/drivers/ssl.c            |  8 ++++
  arch/um/include/asm/Kbuild       |  1 -
  arch/um/include/asm/common.lds.S |  2 +-
  arch/um/include/asm/xor.h        |  7 ++++
  arch/um/kernel/dyn.lds.S         |  1 +
  init/Kconfig                     |  1 +
  kernel/gcov/Kconfig              |  2 +-
  10 files changed, 63 insertions(+), 44 deletions(-)
  create mode 100644 arch/um/include/asm/xor.h



