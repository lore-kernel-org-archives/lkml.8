Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DF4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77AA20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgGBWWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgGBWWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:22:06 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7735820780;
        Thu,  2 Jul 2020 22:22:04 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.8-rc4
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <85548a92-b917-08e2-e89c-833bf5cb97b4@linux-m68k.org>
Date:   Fri, 3 Jul 2020 08:21:59 +1000
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

Please pull important m68knommu fixes for v5.8-rc4

Regards
Greg



The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

   Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.8-rc4

for you to fetch changes up to c43e55796dd4d13f4855971a4d7970ce2cd94db4:

   m68k: mm: fix node memblock init (2020-06-29 23:58:05 +1000)

----------------------------------------------------------------
m68knommu: mm fixes needed for v5.8

Two critical mm related fixes that affect booting of m68k/ColdFire devices.
Both fix problems caused by recent system init memblock changes.

----------------------------------------------------------------
Angelo Dureghello (1):
       m68k: mm: fix node memblock init

Mike Rapoport (1):
       m68k: nommu: register start of the memory with memblock

  arch/m68k/kernel/setup_no.c | 3 ++-
  arch/m68k/mm/mcfmmu.c       | 2 +-
  2 files changed, 3 insertions(+), 2 deletions(-)
