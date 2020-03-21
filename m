Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2643BC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E532072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dgZxoTwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCUMyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 08:54:53 -0400
Received: from ozlabs.org ([203.11.71.1]:43877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUMyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:54:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48l0wV5jdgz9sPR;
        Sat, 21 Mar 2020 23:54:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584795290;
        bh=LlPQAM4u1cDMEUFfteTOzt6qqPVorDOttCGFfUhK4H0=;
        h=From:To:Cc:Subject:Date:From;
        b=dgZxoTwNtdleZgkdNNVLiuAtznvtqHFziAswpD/A0G9nlX+otXlCPfoPXxtUSbmFY
         tF+KscAC7vdgh7pwSiBUuURBsaWHt13Bl4OxvDS9rKnUDGAlzStK2UdbcniGK0q0vM
         S0+FzowV3bbrcmk+ur5SNfHXlyXlmSj6qPxvItHkPdnZSVqimc/uUsv7o5wIAp32uD
         cojarwsDEwium5HX/I57sM9pNUojDTF/lVkYCJ7koBdqAbwJ75X8DfSDWBYkPfgxkt
         os8KiWO+53+bmCovYOHjY48IDmfz1XGZTR9rcqDV+gTmDJoplfysRyTJpGXDCDcyRC
         esDFFoBw9r58g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@c-s.fr, groug@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-5 tag
Date:   Sat, 21 Mar 2020 23:54:54 +1100
Message-ID: <87fte1dg0x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull a couple more powerpc fixes for 5.6:

The following changes since commit 59bee45b9712c759ea4d3dcc4eff1752f3a66558:

  powerpc/mm: Fix missing KUAP disable in flush_coherent_icache() (2020-03-05 17:15:08 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-5

for you to fetch changes up to 1d0c32ec3b860a32df593a22bad0d1dbc5546a59:

  KVM: PPC: Fix kernel crash with PR KVM (2020-03-20 13:39:10 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.6 #5

Two fixes for bugs introduced this cycle.

One for a crash when shutting down a KVM PR guest (our original style of KVM
which doesn't use hypervisor mode).

And one fix for the recently added 32-bit KASAN_VMALLOC support.

Thanks to:
  Christophe Leroy, Greg Kurz, Sean Christopherson.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/kasan: Fix shadow memory protection with CONFIG_KASAN_VMALLOC

Greg Kurz (1):
      KVM: PPC: Fix kernel crash with PR KVM


 arch/powerpc/kvm/book3s_pr.c          | 1 +
 arch/powerpc/kvm/powerpc.c            | 2 --
 arch/powerpc/mm/kasan/kasan_init_32.c | 9 ++-------
 3 files changed, 3 insertions(+), 9 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl52BiYACgkQUevqPMjh
pYDwqhAAsiBYfVZiof+3JQM1Qaf2nnrYHMCLgwT6BJ6l8IxcjPih/4tcWAhe9plX
8xAa44leV0I+HpO0gxFOcfmPTtMmgdk8elUq8NEN7NBQgCb0vDyhjRBPuotwFqvx
U5Hiztra4c87NSL3A/h9JXxtRQBTw5Eg3NuxVPHV6seMtUhBkJThfYWFY7DWvolX
v8poLVZjO2Tq+QuEwJuC1lFTCqT1u1V+IdxEbNrBWy3yNqvb9p4gAlvB+0s/xe30
SFmTyNWUdW4KCE+8Vvbpgr9+s7m6CCvysjlmPra+m7pgFe+X6qcRFLWz+L+8MSSj
+mSmFuyI6KYOxRRY3Er4Q7gnssfiNlcxr5I/jvhiXWJNwS3inv4OinlEfV4pW/eT
++Uy7JCwqel1JZANh0oqcydeuGdU8emozsi5LuRKLB6Mm5mFymzYRc+W6MEpUwM6
b+2rPAagOwY44DN517Ixkc/jdad3BCiLeuDWqzx1BVUHgEKNvu3RWhrHClM1kEey
AaH6u1KGQ81XuKqYrODFaLkOoCumPzUgK42CcjblAQcea1PpYl5myCVNILLBQjJK
kTa1CzX9JG0z9mWLjQwJSpYKB7MOQxBGy0BmxOdjjUBD9DkhGm0Pt7NGz1Xo0n9s
hCSVtCV9M1cfaPyvCDICbDtR+j8SQTfjFk9fDwWcnrssbhtac3c=
=3KDP
-----END PGP SIGNATURE-----
