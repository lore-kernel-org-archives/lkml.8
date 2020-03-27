Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2774420658
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="O+5fIL/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0VGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:06:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:44509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgC0VGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585343179;
        bh=BkicKu3vszgAZYB5VVjsQBFzgHoqTmVLs6lBPNlNKRM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=O+5fIL/dZ7jLVM4bY+E7Pxc7vPhZ2wEc7RqUxUbMQlbVRUKW/E7MOd1IzmGf1FlLG
         KBNrq5XBpSRXL94Wh3VT263eOIE/KbDepp8X6vbYULIhsPh6MTt4T5/752YSiTYyd8
         ddaTn1z1hYADEAafprWePJvTWWszTHd8Lxw+9JgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.180.137]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1jngxg1NPj-00dSsV; Fri, 27
 Mar 2020 22:06:19 +0100
Date:   Fri, 27 Mar 2020 22:06:15 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] parisc architecture fix for kernel v5.6
Message-ID: <20200327210615.GA25160@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:74xy4lam6JN392Y1Z7adHT3ALcmGhlta014WpTFBjKZkGK0AlPt
 Cdq16U1bJejuePbVNyd458Mm/OuQVBgtSXcfraUbcpsimRSroIdM6hGNxr76+RXjSjK+ekq
 x4kU+kWqDNnhwbKX+a0+nHoHcRgmRC/wv6acki7d0e+qyFHKXuOsUw87QuxcRCq0bScLZEI
 LmnqKJpl45jBQefaA1x3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n8d/9FVN/pQ=:QD1e28Baaca3R5MADWPzIu
 Zwd7itVXuspvZG2o4k7iiS34tPK0085qvqq2n4B/uRvjqNnnhKQB9a+i0jsxhD28cggneKj6w
 dWfNT1ut6vcAgI6bygzvmvoZ8TI9KVZPpG4iz/0hXAneP7CzFPdfvqRAt2yHcWY8eYHAVTEA4
 L+KBUGf3+f0njWgyuUDmsGJxUITEfBl1r0lMvnXvKMRTNSNGOaibYl+lhxEQFoafyQJy/NxGq
 MLdDIriWIJUCzojQzzaS/wTjUTIlZZQ4WxXbFy8p6K+YMyPyQj0tz/2PkgWP8Wm3QUIuabSMa
 dnPJutAp89I1hbS2CCYmPwRcnDvAYGlnhzRVxG3z5gsXazKLe0i2hTlrX9QL1GuakdV76Zf9O
 3D8to1Pe91sftQ6Am5Le8vpWudW5NToJTc63xGL9q6Jgk4cJXvRvquNMJm9BG39LiKMtuoSNu
 H5AkST18RVgWUQ24AVkQ/jf2tEmnQAD283v/CjtKTSyfRW2/d1iq7L2hDN78Z6BqROXwgk+qI
 wI6WJKm9+A47vIhw6lsOcTytFaqMpu/2D2xTKU1nXhEWgc40TEw7vhz8bYFj5qqmXokgpLncm
 McmGKBbZ6njjHdZm0uZjJCzHEswhssg66EARnrgoN+VrC0oU4x++hjYFoj7J5XdA48yOzC4ly
 jIrW++DdkR9pOdxJnINGL2Vr7caGSXxa52RJ6UKpC/u646ko2tKcLPRS7im7LHnpc2Age9k6+
 iWUsnYDtKuQbM46uCdyWk5qEfFL5Gk6p4I/GyLGWdPCG1Lz/naRgVzL/pA4J+BpOKwyUuiOxv
 ObrfrJ7WrR2l2C3kxzntZsld3ovGhGrA8zYxSP+lA7WqNtlXTRWmr78dWpsegG24CqK8rxIRC
 i5G0qXeykba1yVuEYeVHRVmSxBoZJPzK7/L/bxvdpmKmL5UhMvdf0RdzHxql+7ZInB0AC1F6D
 LlebTr7mKIU4qtkAqzfUaCGDD62ht9lpBwDxfSiuDQXFIUGGqKS7qu4VBVFXrkXYvu9hrCTCb
 6dHxtmFDpzNgAS9iAWgssSNWa34YKHVCzXQ7zws118WmBOemZkchlxRskDOA6amqAULUXTUgD
 PRPyYJtSWlbKqvZtkK3g/5GeRCKDCLUSCCordlyh1Z/CZFQYM6dwuKn49eIlu9Lb2aFwiM+8/
 LYkGatfkxaU7f7IqO7wSK1f4qcJDBkT+N8FTh7GTTEu6W2WpPZSknR/+6gco8eyaIc/itfFSg
 706s00CH6w+0/j66n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one late patch for the parisc architecture for kernel 5.6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.6-2

Fix a recursive loop when running "make ARCH=parisc defconfig".

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix defconfig selection

 arch/parisc/Kconfig  | 5 +++++
 arch/parisc/Makefile | 7 +++++++
 2 files changed, 12 insertions(+)
