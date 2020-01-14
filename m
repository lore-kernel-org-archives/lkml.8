Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E1B2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Sqtu40xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgANST3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:19:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:55767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANST2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579025954;
        bh=tWjpTk+H6GvEnLmuMcHnLvbN3JXd02kL6n72B49k4LA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Sqtu40xvQwSLzAtYU07FZV6VJD31l/m0DlK9XtKSk3d8CUa2+gD82gYsmLuwqKbWG
         bXFabPDy+ciLF1VPqc6BFIKRrT76S4hpfaUlXxSLPJx2Awe5qo+YgcBwwjdfceLN82
         lnNxr0iAEf2/4tE3Va6p46p5TM6ILuKyt+P115xM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.171.104]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1jE5KW21Mc-00UGD4; Tue, 14
 Jan 2020 19:19:14 +0100
Date:   Tue, 14 Jan 2020 19:19:12 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.5
Message-ID: <20200114181912.GA30159@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:7G/1/YYaD1DwN58s7AkOYuj+w6J6OdJEEESB3W6TpmGIPXdijHU
 nhixReZv+SnJprg/Tqd7cBtNt4XvSvCDpFHzHn1DpfDnrIy+/TvDw0xE5XXl7Y+UNnWz5W0
 pHh8wcTmt19ZzYHf2FczC5B+rSprDTp6m4A/81gOBqe19cXiT96/Z0fGDq7sUlhcjk1MSzt
 95MMfm3IGC1KuWzX73q7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qr+4CE9Y65Q=:JqFzIwSzhepUQcHNlNE28i
 dT+Mjzefyo6F7gCaZo9v5hJ0Kk6Gebrq0jV1qkYuneVVqCrzwzcU5kpbQ0i1nR/gIsmfDahFY
 symCXe5bY4Zzo+yldVY3G5GGQEb+SH4CTtREbaHhVq9y2tVgHaBTikyTtiSKsPJmMx8JLqqxs
 hm9MlYvW4KwecoCodZSyJxoFuGadUL2LLn5J2wzpJe5UhMMj7nQIGFbLOWOCDtfcgk8IX7/47
 X7TP6OCjoH+qEhl/0G/LMW1n7kwvgmzhmAPRW0caR5D7vGMy5ZdYHJ83WEsi4471gPQQ5NtuT
 UUAB9i+bkhGw8s5rM/qNChPn7XOzOM4LjziIQaokgQAErL8ocnXjno9JLa6Oy4zSXMYDuOb+x
 kk/ls31KbV6lZtu3tkb8vHjXlkMjdHoYFgQkTB2OejQxj2WT8kRgb7/oY+3nK+zcrCEMbGcqy
 cvNxJXw3G+vRUei66u7rjnhiim4oCiZ9zDaqUadqlh2vBNjCgK9rP5Mjjo/ZLjzxUram3busJ
 jHfkcQT101kmAux0b1iS9oe60K9kTqiCFPavULV/XWlEpKSHafpWHw1xtE1ULRxu6THZ/c+QU
 II/Xvrw39dKoF9MYSE00g/+P6x/NqXv3h5zBqkHu30kj1Rkk1eMKRFE4wC9xWu4lV7o5YDsfx
 ETI21wS6vDcBsLH9K9eA2taq+2/8RD5sQem4sKC5bL61PfmxkRFFxT0DPEjIiIOkI/l1FI6qQ
 2d7yLB2ajcIr6fRu8ndM54BDOnGKrES/MZyKl3QiiP8IlUf0PlcbM7bvUyQW80HlzockQUpxw
 MfutrjcfS3ZRsvbdZr3A7zuUPYTNZ2gOTMBaVH05CyTLqGPsHHrzMhi7snBRbzq/SwAtzIbAW
 AlYZdfRf68EO2O0HqbPtMoZoMFPLVcSvb7AzV5vshn3uZ+zjSs15/+UisDFBOkAWGc3rLY6UZ
 o7ahqDYEVlwja7FE/L1P3V/+5yRrUxbiQ00FtZoioZGjcjzg3pIb/xG2n6yLLfWQ5v6MPYfMM
 gXhLOnZcoYp3L355OUPSL5jXIvqaeiFADPaPobnEXDJYxUZ5CnDNpkwZMPRwr1CSMG7Ywdtb5
 ukhMNFeCHDmZBMbRMfTD13e9enamoqC/u+Z1N60HxR31VyH6BQpaOsVRghJq8e+ZBR/W7eOuE
 3pEV3gzUjRpkm1B1X5Qj7r5WNxxTCdzTHyZhnIlfl2xi5ycnE0yoqQIc+u7gAwM1GOr1qFIIK
 PdanWx6tQqvtPataT7CsB0KOIsjMQCUH8Bf2MAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two fixes for the parisc architecture for kernel 5.5-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.5-3

A boot crash fix by Mike Rapoport and a printk fix by Krzysztof Kozlowski.

Thanks,
Helge

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      parisc: Use proper printk format for resource_size_t

Mike Rapoport (1):
      parisc: fix map_pages() to actually populate upper directory

 arch/parisc/kernel/drivers.c | 4 ++--
 arch/parisc/mm/init.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
