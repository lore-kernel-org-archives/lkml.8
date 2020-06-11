Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F080C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7514920812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFKFVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKFVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:21:36 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9292074B;
        Thu, 11 Jun 2020 05:21:34 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.8
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <3dc0ca7e-9c44-adac-a3c4-53ab6e0288e5@linux-m68k.org>
Date:   Thu, 11 Jun 2020 15:21:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.8.

Regards
Greg



The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

   Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.8

for you to fetch changes up to 9e2b6ed41f8f99c97b13c9d15cbef235dbd97fb6:

   m68k,nommu: fix implicit cast from __user in __{get,put}_user_asm() (2020-05-30 10:55:54 +1000)

----------------------------------------------------------------
m68knommu: collection of fixes for v5.8

Fixes include:
. casting clean up in the user access macros
. memory leak on error case fix for PCI probing
. update of a defconfig.

----------------------------------------------------------------
Bin Meng (1):
       m68k: Drop CONFIG_MTD_M25P80 in stmark2_defconfig

Christophe JAILLET (1):
       m68k/PCI: Fix a memory leak in an error handling path

Luc Van Oostenryck (2):
       m68k,nommu: add missing __user in uaccess' __ptr() macro
       m68k,nommu: fix implicit cast from __user in __{get,put}_user_asm()

  arch/m68k/coldfire/pci.c            | 4 +++-
  arch/m68k/configs/stmark2_defconfig | 1 -
  arch/m68k/include/asm/uaccess_no.h  | 6 +++---
  3 files changed, 6 insertions(+), 5 deletions(-)
