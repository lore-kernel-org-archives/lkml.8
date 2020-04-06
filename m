Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D95C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2042072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GnOpoaPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDFUQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:16:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:55685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDFUQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586204178;
        bh=oG1yq8a/DhIc/9gEG2YsWIiXtkuwm4ES6uWA/6KSCjk=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=GnOpoaPsH58dBiAx7bZGg1akExGH7ESKyRLpT0rolkR0kWsJzcbVRbyIHOBNVM17V
         jdpdcw3dXldUjZ8DfQQD3acOHRbbpaVg+vr1JdV6nFqe0YVkIzuECfeQsfWqhKXT+3
         41lMSFvQQePw4D6boiwPJdajMURtq5p+NaGh00AU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.44]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1jSieF3dRW-00ClUE; Mon, 06
 Apr 2020 22:16:17 +0200
Date:   Mon, 6 Apr 2020 22:16:15 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.7
Message-ID: <20200406201615.GA23183@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:g0DlnhRdrNw8HmoSXCXhHF8diqMYig6+OyRgPRSdgBy2WzFL2sf
 QhQIPzC93CNQYPiuiFFWrgqZclj/Os5T2uuaslKSez1XCTecqjuk18ufYne9fR3+MwB2z7F
 C6U9ks+1CWsWUeIWW8ofZX0vIZDzdWKKeder1sU/BQSdQN763A9vNcpUVo4lcRbbwFq/7dZ
 ZMOpdXzb/DpRjSYF9lAvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDYWPsDJmIQ=:8cF9npHUYDS7HwxW6TwB7g
 nbMTjQo5wZvqL85LNIeIaB+B7bdHi7H3VpqoIvep+Kyepo+xzpDMXCicy84E5wzQoS4izj9dV
 yU7DX0g7+BjCZrDfipWJ40h76iWddApI1OHJdQmBPxCO9F3JPXSJ/r3uRSgVlLDXbc4BUzbgc
 ZVydxx4SN7lm3gzCuFzEh7uXCPxiesReMWoyP6dPNbhSQSXkX+eFUdQmN4gtYiIYUn6FO2Ymi
 mmTYYdw8ni3yp4FpavJLyfW0pTygVMalAuBY8lA5vMU2PqaJ6VPSpqEzwW38F4RgWSgZT2/wb
 KU3mLgtgFuoLR7SEHzuiJGeuNFSbNOfX+ofyFWOGhux3PAyChacN95ic/buBMzLZU45sPJafQ
 zuGTfJur5jVJQaMI3uNh/oHJGlP0Btfw1uQIhY7FPol/0BTg2BG4N3c2UqTLyPBKmTXPZKCTq
 zPjYbUiLNa7oKiwFvh4rClYIGb3+W0KzYzPUpQR50aX5PZy9DCgjGB7TLpcW/9fOHXxH9bvMy
 FEd8mi/liA29iCa8H1UjWkNJr+ely72tDQj88KvT5tpbtvmq4C4GWGEuetxjeAvXJziVjOiQ0
 V6fVkR27ILb7t6dFsXeEzqI6Sg1vK5BTJlHL7eBq2HElAYZKku1kIQx5KTN0/Mux5cqveD7qy
 37Z/GOaE4g3AP1iTGoNLK2uPj5ksP3aGuf7kNMeXJwoyakUsM06FJ2w75VUQ2iQJAilWHpn4B
 drOKajClzMTyttCD4Mm501RZN+jTD4GXg6b+/ZFnYpYgKm/DoBeVuNgWK30jn+SlUiZQkrOHW
 5ZLcaWxY+Cuh5kNxsaYVCQeZfDvWbVzCMD0TTHuiFUbCUNRGThQdjZhH1WMhXKSdDzpbsNBaj
 HrEihsj4q8VxmieJ/ZwF6XTqLXBptNE5RtFMSPS0wQxjmMpPHmQnDCkF6M1oMVXQyn7X3SuKf
 GDY4vdmUTbZl7+keaI1HbiKa+E6VMoSjm71FKFN9w1y/qdxaN6N6sfDo3OMetvMcc0mbFjrzE
 Ulcuth+AxGFLLG0ezfIsJboYGpEYWJ0Z6KI18JINL9s/oUXeU8blYeRiEPrl5xmDp7yLiUKRq
 veFvaymxXoOl9vMxq+qfYVVhifu5rXmOqmDi1fqgNr4lFXrZLS8RrYyIQWD9EjX/V3t2GM61g
 Cxtjv4nmqFH7YX5ilhRmDQ0m6/z0YYRt+JdtWXp1pUTO1ekL5HttWPOB9Uh3Tj6Z8oBroZG89
 CNT4lwA6VXyjTU/f9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the updates for the parisc architecture for kernel 5.7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.7-1

Some cleanups in arch_rw locking functions, improved interrupt handling in arch
spinlocks, coversions to request_irq() and syscall table generation cleanups.

Thanks,
Helge

----------------------------------------------------------------
Firoz Khan (1):
      parisc: remove nargs from __SYSCALL

Helge Deller (3):
      parisc: Improve interrupt handling in arch_spin_lock_flags()
      parisc: Rework arch_rw locking functions
      parisc: Refactor alternative code to accept multiple conditions

afzal mohammed (1):
      parisc: Replace setup_irq() by request_irq()

 arch/parisc/include/asm/spinlock.h        | 160 ++++++++++++++----------------
 arch/parisc/include/asm/spinlock_types.h  |  14 ++-
 arch/parisc/kernel/alternative.c          |  37 +++----
 arch/parisc/kernel/irq.c                  |  22 ++--
 arch/parisc/kernel/syscall.S              |   2 +-
 arch/parisc/kernel/syscalls/syscalltbl.sh |   4 +-
 drivers/parisc/eisa.c                     |   8 +-
 7 files changed, 114 insertions(+), 133 deletions(-)
