Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F8FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5872151B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X5Xqbt2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2Nzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:55:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:53291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2Nzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590760538;
        bh=vOtlPo+kxfaF5urOoy4ajGIymjW7MTeGTHHQTTgEVBM=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=X5Xqbt2H/G12f0IMXLBJOm3ZOVxEbiNuaQBaQu6O33pJvPP0b81oJC/83ATzwua3y
         Vk6/P44VlxnPFU8vEcvpkx1gNUja7trUsjvfBWiGiFL66R8iwiMFsBpesI0UWoOq+N
         kEVXIbKFx5Ez4svVXcu+DrBr/jSC4cUJf9YmMpqY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.188.156]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1jIRlQ3yAD-00MK0h; Fri, 29
 May 2020 15:55:38 +0200
Date:   Fri, 29 May 2020 15:55:34 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for kernel v5.7
Message-ID: <20200529135534.GA14973@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:wSUFAOI6IrImdYFaheneOISf2zfhYBBP1qqZ2gMe2fNTem7WcWm
 2bDGumueEAQUUw3uKbvIxr3R8tiuT4oRwnXPqq/k6vLlBwvwDb/wwJKKy0QGRe/FG+aOkf3
 tyeVvy/WBnRahmi+JwDtrYgpuIv2cFS0qqaa+JM6Wn8rYOXvo3Eo6u9SlxG/wTKbldxIdcR
 JHIsZ/H6Xm83G2qODf9nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+cKNOiL8onU=:Bhequgb2EgK7DGcNSBrxX5
 PtnabGeNQOvBxD7p0tg5LpfqwUZj96k+QH5kXo7bhsx5GDPWNpd8TK4Avk5ojg2zojNuI9LR/
 Z9W5tvIAkEgiSA+cadAjEiZrS74Gjtct7v1Vn8XNHWUFiuXFdocQcSgwnLz/YxnM1IKsYhgfF
 j66Bb/VX7S4+z885XPLXLb3QtiBURNSKn9tid8beFcYwMsA9CDM3fX66t2/uBX8eV6OrBNGHK
 fsL4RVoVXIvTrcKo+uQkWkB7TxDvB0fkjARqTf4IB956QcriLqZLYt20/Vn6ODND/+CO4X4QR
 Zf0U30OfWF/12G2cffSaFhz1BCIejHB+xXSyOaOoQfe86LyXWedJSRn9TBR+7CEiT3cHISBzf
 7FlTfRqFTWUpwq1uWSTLgennNMzAzUsjijPUtOqbAS9DSV39phfv7VSXQAYULNjeR6abQOukj
 JqL9ouPTs0Haz+uhCZaLPgemoHQ778cfckGjAeE99nL/Vp+2NuPFgaEuNaeVm9yQgv9SrHn8S
 3I46ZYW23dL92mhvNFpmzwOX8AmnUkSPiVJVSkeSnHMGTFce5yXPSgSGhZEVEcn9+f2qBFTDL
 pZlKIj8vn07dB1vRgTdKmmjuQKJB2XBM2vv5GJP5Qlfh+pOjuYM6JUch4ZeyO35pi14rp4B96
 rc1WLpQSEj7hB+jWKjFC8laupi+fshALPsFNv3YLU+eW2ZAWmjc7NJpcGdycOaE6A5EgFda9x
 +MMERt+F0MhQMvCfaZVLrM56I0tL4+CShceUZUL4Ot4Ed2jMGXztrkCVR+0Npmj3eOVqNjM0y
 Y+0G5eMUso/PvV+gXXABwNBk/ihOo1F7UFJHM2pqWn7KtEm0W7KZ0Y4WEVtTfsPvp6fTiS/4O
 6fPsJhyIkBICSS+6AW1viJWaa9peuCbMqJcnhLXc3D79qre/ADUJhCbCWCBf2ZkbX9/qFNgtS
 5TLOKBwD+FgqsOCPmZZvkQg+1dhziJRQGYIja1e3HZRzKv5iHUy6UWFR6aG/dM8MvpHLxgR/Y
 XdKCm2qToJVD6PHLkYPIP+mWJroOh0wp4WYKU/XYNhCFko94H3WbnyZ0NBrQAUAM1Hb/ZWkNk
 07eY6pDMcWi4p5bPm+4YgCSB8bv8/it2Pvh0G0YZ56WlgVhpAnOxSchoi21gEQ8g3kUG++ltU
 oyMDjKKiVuaMvi+Uj8s2SOHfswPJz8xps/v1930L7dIXCMtqsDhM7agt3BlSu6vKNe6fd+vlo
 azgxWYFQWt+7D07UC
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a kernel panic fix for the parisc architecture for kernel 5.7 =
from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git pa=
risc-5.7-2

Fix a kernel panic at boot time for some HP-PARISC machines.

Thanks,
Helge

=2D---------------------------------------------------------------
Helge Deller (1):
      parisc: Fix kernel panic in mem_init()

 arch/parisc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
