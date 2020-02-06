Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FE3C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0533220838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgBFEOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgBFEOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:14:00 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9B620702;
        Thu,  6 Feb 2020 04:13:57 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.6
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <70537bf1-51e2-e668-4d82-7e4ab73abbca@linux-m68k.org>
Date:   Thu, 6 Feb 2020 14:13:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

A couple of changes. One to remove old CONFIG options from the
m68knommu defconfig files. Another to fix a warning in the m68k
non-MMU get_user() macro.

Regards
Greg



The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

   Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to 8044aad70a1fbd66376cdb2a13e536db9dd6c132:

   m68knommu: fix memcpy() out of bounds warning in get_user() (2020-02-03 14:43:35 +1000)

----------------------------------------------------------------
Greg Ungerer (1):
       m68knommu: fix memcpy() out of bounds warning in get_user()

Krzysztof Kozlowski (1):
       m68k: configs: Cleanup old Kconfig IO scheduler options

  arch/m68k/configs/amcore_defconfig   |  1 -
  arch/m68k/configs/m5208evb_defconfig |  2 --
  arch/m68k/configs/m5249evb_defconfig |  2 --
  arch/m68k/configs/m5272c3_defconfig  |  2 --
  arch/m68k/configs/m5275evb_defconfig |  2 --
  arch/m68k/configs/m5307c3_defconfig  |  2 --
  arch/m68k/configs/m5407c3_defconfig  |  2 --
  arch/m68k/configs/m5475evb_defconfig |  2 --
  arch/m68k/include/asm/uaccess_no.h   | 19 +++++++++++--------
  9 files changed, 11 insertions(+), 23 deletions(-)
