Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ADCC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C12080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="apwvEkca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgIGRYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:24:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:12951 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgIGNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599486102;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Message-Id:Cc:Date:From:Subject:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=MwIdbaPYiuhfuwrYB2GIYx9w+k6GaMOESpdYWjOsjeQ=;
        b=apwvEkca/96ZGp7QQz5P9scvXKOwzoM0aiKlonrJZ1Ag8/E0Nxuuv2Oo9g4NVFfmit
        tBlip8fkhLszacPfsLTQpss2f10zGWvXXn/7b6u/RRX6QyafiOwkTWAgqnhlJ1cBOXMs
        kjqLqyPofZIpDsQPZCrU+qAsztdj1cy9s76TMdzvMntzyloG4vQ3bbxx5+ycWT5l8EQt
        y3ovn8o2DZdPFqyrYA29kLhWRFogBkL39uOWkBeE7OutQKyEz+6pmcALAk1Ri3rG8rCT
        wSs8CBiF1YQwLvlAceGiVE9IMpZjsAPb3I/w4rFMPHtPHExn/103iSCziX499mbMrkQg
        TiKg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMiw4/p9Q=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id n03b0dw87DTePNS
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Sep 2020 15:29:40 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [BUG]: KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Mon, 7 Sep 2020 15:29:40 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3750C774-62A4-4D02-8C07-6C98304F32F3@goldelico.com>
To:     David Brazdil <dbrazdil@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
it seems as if your patch

34f379956e9d7 ("KVM: arm64: Fix symbol dependency in =
__hyp_call_panic_nvhe")
[ Upstream commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 ]

fails to compile in v5.8.7 for me (using an aarch64 gcc 4.9 =
cross-toolchain to try
to build a kernel for the PinePhone):

  CC      arch/arm64/kvm/hyp/switch.o - due to target missing
arch/arm64/kvm/hyp/switch.c: In function 'hyp_panic':
arch/arm64/kvm/hyp/switch.c:904:2: error: impossible constraint in 'asm'
  asm volatile("ldr %0, =3D%1" : "=3Dr" (str_va) : "S" =
(__hyp_panic_string));
  ^

I can find the commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 in =
upstream
but not the affected file. There is also "KVM: arm64: Split hyp/switch.c =
to VHE/nVHE"
which does a cleanup and rename and v5.9-rc4 compiles fine.

With a git revert 34f379956e9d7 on v5.8.7 I can compile without =
problems.

So something seems to be incomplete or premature with the backport.

BR and thanks,
Nikolaus Schaller


