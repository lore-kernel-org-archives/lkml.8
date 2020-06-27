Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB37C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1565020FC3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MnP13h0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgF0MFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgF0MFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:05:45 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C6C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 05:05:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49vCBR3gbZz9sQt;
        Sat, 27 Jun 2020 22:05:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593259541;
        bh=8iU02BnBlKETNqoNubewmNCrRFHed/xM2um9pQu7aog=;
        h=From:To:Cc:Subject:Date:From;
        b=MnP13h0kp79yDlpRX7eiEYlfJdzrmM97ZAksm5Ev65v97GLKYyMkFhAdnvFoTOGbC
         CSZ2ZcJ6xArNZgUHabRhNzmjAdsAQ17COrpa56CtpZTQ1+3QnexDVROgYjuT4tIrwW
         Ero6omaHyns1CqWmgK9Qv8Y1giQjpk2wdZ3oLE85veyVlPra7LhE/z8V1ZBtjuiOy/
         jGNWx5Was9jFfmIAsmKS+Ye5L6bhjrLuGKIeANIucMHyBlAK0RDDfKPDqyB0fBeS7K
         U7gAmrzy1/bAG6qakb0lUd2sbi4OyRc6oBSS0eB5nF3qdrXN6T6WGC3Ej+1x8DqIUy
         udUMy3OcKF7rA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, asolokha@kb.kras.ru,
        harish@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, oss@buserror.net
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-4 tag
Date:   Sat, 27 Jun 2020 22:06:08 +1000
Message-ID: <87h7uwbtn3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.8:

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-4

for you to fetch changes up to 896066aa0685af3434637998b76218c2045142a8:

  selftests/powerpc: Fix build failure in ebb tests (2020-06-26 12:53:09 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.8 #4

A fix for a crash in nested KVM when CONFIG_DEBUG_VIRTUAL=y.

Two minor build fixes.

Thanks to:
  Aneesh Kumar K.V, Arseny Solokha, Harish.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/kvm/book3s64: Fix kernel crash with nested kvm & DEBUG_VIRTUAL

Arseny Solokha (1):
      powerpc/fsl_booke/32: Fix build with CONFIG_RANDOMIZE_BASE

Harish (1):
      selftests/powerpc: Fix build failure in ebb tests


 arch/powerpc/kvm/book3s_64_mmu_radix.c           | 3 ++-
 arch/powerpc/mm/nohash/kaslr_booke.c             | 1 +
 tools/testing/selftests/powerpc/pmu/ebb/Makefile | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl73NgYACgkQUevqPMjh
pYDCnBAAnKkykVKK2ylVV1wCLp8VmgfXdi3l9Ub+wUKLARGGHXfF0q07UrNJ81QM
4t0c9XaDcuQ33GMqmhY5vP3/egomplFGmPvVMjRFinMgAzuhnDLvqDrnoiXNfOqe
dxPYlX8W9baj1ByJrYD7Z4UR9E2y8aMRcw1ZClJNw3y6WTHoUjMEbVRyhv3OpPrR
e4wwvs+GHhZpDhsC3xqsKYktzOVR0r0OGoJBPVK102bZqutURJmAkXAt5NFzPopi
aYjbtCWqbalbczj+RCob/e+G2nnqnlvtmJ3N2a1hed3kxwjDkQ8rbGbTKLasiD+d
UgUu8mccl7jvU8OylBFgysg/huhMNzT3HExYpCuK8JsHVp87ihR2+1gEYBsRK3Wj
FtH7VtnABslAjxZGg05ZuSIFF1WUVWsMd35qQHn7TpWlTzgpNqyBdtyF8IOpaSFo
yDqzuzR79Bhp6ivZHbe7JMnP2po47Ne6n+v6qK5cV3Myb+elIiLAfEorbyf6OMx2
qotpvMlzD+StI8SE/7ImSVc7Mu3QU7fN6SRqf2rd1XlqSoQwA7DvwsWnbgKz3G8X
mxhme8aw6Hc6bz3NKz7gAWocVURTpS9eE5yCUzqWuv006jDqsGv0WnQIFkoPDOCN
dKHUkqvvKeQLbv7kJzczEyz0AWNAp3aLMtn4Miszr6Oji9ZmBt0=
=Z6l0
-----END PGP SIGNATURE-----
