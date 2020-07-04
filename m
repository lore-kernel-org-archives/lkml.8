Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C82BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312A02075D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593868130;
	bh=98il11lSKYnc6reB2D5/q6+UpWByF7ffGS9nQPD/AAI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=o5Bm3CCEMNPa3tDtqHZ6JQp+SnuEjwyv1pI1hlgH7MyP6Zgnt0UCU81bG+qr88zwQ
	 vfmrIhPuz1uLz3DbTuoM4Gz/fPiVLfoMFJkemCp0mTNa41KxiqRfDz3rc1ZtFkxz04
	 Ml7j9CrtDaCG43uSX0Llnw+fYPqE2Zu0g1NUk6os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGDNFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgGDNFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:05:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5A320885;
        Sat,  4 Jul 2020 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593867909;
        bh=98il11lSKYnc6reB2D5/q6+UpWByF7ffGS9nQPD/AAI=;
        h=Date:From:To:Cc:Subject:From;
        b=yEXrj49d55WiKuwOfEUjhtWJlMVeETbFL+soMenZH8vX/vOukEOMB8DEBjhtPpVwb
         r87y033cK2/a2rkPbttUN+shwJajL8Tz/455J8J51eCYf8jOKGMjJagwWPb9VnF53a
         Kes3CEOLdWG4t9rZ3uZWG3aaxYI6PUoYpIo6czQ4=
Date:   Sat, 4 Jul 2020 14:05:05 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20200704130505.GA21333@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc4. Nothing Earth-shattering, really;
some CPU errata workarounds (one day they'll get it right, ha!) and a
fix for a boot failure with very large kernel images where the alternative
patching gets confused when patching relative branches using veneers.

There are some vDSO and ptrace fixes floating about, but they need more
review and testing if I'm going to send them for 5.8.

Thanks,

Will

--->8

The following changes since commit 108447fd0d1a34b0929cd26dc637c917a734ebab:

  arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist (2020-06-25 20:18:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 9b23d95c539ebc5d6d6b5d6f20d2d7922384e76e:

  arm64: Add KRYO4XX silver CPU cores to erratum list 1530923 and 1024718 (2020-07-03 16:39:16 +0100)

----------------------------------------------------------------
arm64 fixes for -rc4

- Fix alternative patching for very large kernel images and modules

- Hook up existing CPU errata workarounds for Qualcomm Kryo CPUs

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/alternatives: use subsections for replacement sequences

Sai Prakash Ranjan (3):
      arm64: Add MIDR value for KRYO4XX gold CPU cores
      arm64: Add KRYO4XX gold CPU cores to erratum list 1463225 and 1418040
      arm64: Add KRYO4XX silver CPU cores to erratum list 1530923 and 1024718

 Documentation/arm64/silicon-errata.rst |  8 ++++++++
 arch/arm64/include/asm/alternative.h   | 16 ++++++++--------
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 21 +++++++++++++++------
 arch/arm64/kernel/cpufeature.c         |  2 ++
 arch/arm64/kernel/vmlinux.lds.S        |  3 ---
 6 files changed, 35 insertions(+), 17 deletions(-)
