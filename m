Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3881E208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YYtFOD02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGDNaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgGDNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:30:54 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C7BC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 06:30:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49zXlZ64Rcz9sQt;
        Sat,  4 Jul 2020 23:30:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593869451;
        bh=kl3Szk98khoM6Tava7Ark0liKf7Bf/9XtdkjUx8UehE=;
        h=From:To:Cc:Subject:Date:From;
        b=YYtFOD02SJ+Z95vV0SU0mcnzuEcEXFtst9RCGHimsC2xBczbeQEGppOxEc2vo5/Cg
         qWKV11xIQD1fPXyjr0RAFNrri0LyoK3evnjAI21c6hfG7CTEP3ZtwNR76mN59xqppo
         y/y4oznH/CTmardWUfbWCa0VuZxtfkMISeoPmXcwC2iTbmgOJuT4wZ+zGP7vL9mcvC
         p+kIXmoN3e75YjhaPE20GOJMDtK5CLFencgoSAbu+14/lOr61bMgrxwnAc0Y8mdQCL
         PekNEixvhO7L6O/DTA411VM75pAMzxToyg2bF52YsAm924wzMwyeuaamyUQlQUmm7X
         +/fb8zUUwl/VQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-5 tag
Date:   Sat, 04 Jul 2020 23:33:05 +1000
Message-ID: <87366776cu.fsf@mpe.ellerman.id.au>
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

The following changes since commit 896066aa0685af3434637998b76218c2045142a8:

  selftests/powerpc: Fix build failure in ebb tests (2020-06-26 12:53:09 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-5

for you to fetch changes up to 19ab500edb5d6020010caba48ce3b4ce4182ab63:

  powerpc/mm/pkeys: Make pkey access check work on execute_only_key (2020-06-29 16:17:02 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.8 #5

One fix for a regression in our pkey handling, which exhibits as PROT_EXEC
mappings taking continuous page faults.

Thanks to:
  Jan Stancek, Aneesh Kumar K.V.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/pkeys: Make pkey access check work on execute_only_key


 arch/powerpc/mm/book3s64/pkeys.c | 3 ---
 1 file changed, 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl8AhNcACgkQUevqPMjh
pYCpbw//Zuq2ibM2b4lIEYCxCeI1gh1owthd6fHAmRKLV190CTy5LlXjc/Qr1uNg
gnW5H4+/8LC9wlN+ypzm2/ZGr4GfFEZTbodXm40uF8iT06pb3arULB1Tu3YcScpE
8mwLSE4oz8rqq7f/jGc6u3Ozwr47KkiSfCRKNMIVOCGQMg6nwPLO+sbWjfwSv0W6
pi+GE+GVWe5sEyftWoO+s2FMELX1O6vOvaQId0H8JqKI/FXCGYZzHJ/SWjMx7rJ9
VJYqLOuuHp8diw4PYsfUoxKQc/uDT0EswloaDcYwi1bQu9XzgbSP1QHA15bwVBCh
uqT/+CpZN8adjWk+vHeEeJurqCYf4gkAwaT4NJFA3oQIMvV7eVEoGgUj0ssjTSAd
8qudKtBkQauXMaPXD9arN389mW45Zfzg0O313lvXr5HEWAg3vrMtLTaBTxFuMwnt
+REfBTJTS9S2hPcn2w2vK9SNOL5PAt/cTg/z7ekuw9gvDdX10ahyF1X2AQbtKN5U
tSBH74b1eR8dlg3jcvmWtRbFCvWtZRZVVQN5RzNgVz0J5cLuyLuDIlr6eVhxGzwo
OwjO/wmTmwbyJwpvg/zNhs4leKUlp3s0JYmKswYUx/rWdnqzpOmPseb1YkGujN7Z
iSIO0CPhAkQGXrdh6USuQ+ed5QhDp72NoKZUY+F4XQz+j7mH3iU=
=PJ8Y
-----END PGP SIGNATURE-----
