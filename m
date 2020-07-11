Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0047C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7042C206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QgPVAto0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGKLsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:48:16 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DD3C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 04:48:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B3p7t6VJpz9sRR;
        Sat, 11 Jul 2020 21:48:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594468092;
        bh=dKeMPZ3coLq1t8Os4YUhMXsxVwacg9mcb6Um7+nbyMM=;
        h=From:To:Cc:Subject:Date:From;
        b=QgPVAto0j6mboSpyNKkOHIg8wO9JF4IADPuieLiPwIrMP2FbdryVnD8LcLbW4qg1U
         iN/+V221zlRheQ11w1bQdv3czDd5LLJzrfgKoxkRrXYdM5bH+1eYG6uMZZ7Og5a8Ng
         Plw9PScJqaTppcY94gVfZN8fJ/etNju2ci0aych9cf8poRtj49R94tf/YX+ZRhxDJ3
         fXIb1CP5Bf4k//8kMJBi6SWD83XsP/qgVbge0pyrvIdiHduGeIi3whlYEb+L4mPXHy
         SYSW/yjHvNqkVTHaTGnThhkWUEDXflOv1Rxjetq6FYzCq/JVsEE6LCRrp6M1VeC3Kl
         FDqw2iem7rn/w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-6 tag
Date:   Sat, 11 Jul 2020 21:50:20 +1000
Message-ID: <87v9iuuv7n.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 5.8:

The following changes since commit 19ab500edb5d6020010caba48ce3b4ce4182ab63:

  powerpc/mm/pkeys: Make pkey access check work on execute_only_key (2020-06-29 16:17:02 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-6

for you to fetch changes up to 4557ac6b344b8cdf948ff8b007e8e1de34832f2e:

  powerpc/64s/exception: Fix 0x1500 interrupt handler crash (2020-07-08 20:41:06 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.8 #6

One fix for a crash/soft lockup on Power8, caused by the exception rework we did
in v5.7.

Thanks to:
  Paul Menzel, Nicholas Piggin.

- ------------------------------------------------------------------
Nicholas Piggin (1):
      powerpc/64s/exception: Fix 0x1500 interrupt handler crash


 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl8JpzUACgkQUevqPMjh
pYD5Zg/+JSMK0phSPCEpBusdlwIeuP5JwQzMCPZgiz7wGsOl6OMF/pMekvQmYzsD
/9VKTWejulkn1Q1Gz3dhEEaVRJhjErPN0xb3tdrXmzyK2s67kwbkd+PhkmXyzRJ/
ByEHmg8K3kKhB3FEC/BimNzcjAhVy2bIqBR1+4gTjF/PDc9heugv9iOpnw2uvhGu
/DoYyQScWnC01PgOd8/dFDykELj98s/p4hKNx6JnteGi5cjrWClqJGJYCBc4xhs/
rPSA5ybUzuN+CbMZbvDi7sJPw+w4AYIC5kVYsZqRuJVGYGh0y4qcxSYK4BL0FDO2
UWdCLUFOkZqHtGhOUMn886YQnhPFukxVOVfLCIlkWcYeXK3HwQld8LrfzHUoMjBk
ao06xwccNyzGlRUn0lYKuRFRGyEtWXNDqLQZ9L4Klowwe9BG5HdYRzrNxLsyi7p0
yom6hevA5w2Sw9rZJrtImWevrsIp7ZexOcVBdfCGwCt9WlWHvT4C5iT0kMFGBh50
Tx/nKAaBWVN9p8OLX4qsmUlRIeAGQdV18HiAaLo5YubUSJ9Ne5ZGcTTZ42VwxvaM
1VCMUfexdr/oljy1BUP/ZTldcj8dF6saaWDb+yWWh8sUmKdsduXJP/5640au9FxS
EBofwuyiU0u8aoV9oH4km+Tqp2WtFhMtrgTNNgHtPix7C8ck2Y4=
=u9rR
-----END PGP SIGNATURE-----
