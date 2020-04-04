Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE603C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A2F206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G6NTYvDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDDOOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:14:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:45685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgDDOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586009670;
        bh=hRaUp3hCnZJVEG7mmUIHbMEf8Y5x3Wo+lh+jBopxi5o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=G6NTYvDuGgE/zgMbr0ldv/Vu9sQYrVu8ywLA/d9vDZKemWDAPfxfGRTrNhzdUNno9
         4nvRhrWG9aPKcQsg9x5w9JLd07PVOksqnMnelqVZl9Lv4gCcqNmM/0IbGk8FIB6Rxj
         +hhrKVlYJ6Wxm+eOrrdWz1xcQMHUZgCRxfzd/Tg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N1wpt-1j9z9b2BNx-012K2i; Sat, 04 Apr 2020 16:14:30 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vt6656: Cleanup of the vnt_get_frame_time function
Date:   Sat,  4 Apr 2020 16:13:57 +0200
Message-Id: <20200404141400.3772-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5f1uHTm3ww255qlGVet1oNDUdp7hKWqHK32lthOs6ALSdAJoQu
 kblKwI6IdyYZp1Kzbe/b4M37FZ3kNT+ZKZWZilKykKENQQ29AKix1PIL/EqtMSyzRLrU5Ex
 Fh0YGCak1hhWm8W2DsJav1/6cL57+R6NfAYY/pP80Oee14VJJuXdrmQwfKIemScDBqI3qP/
 QPDejmM4lJmUXVZIKdLdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n0kAG4Sp7Y8=:JSgDBObDv0fUbc7+5d15Oe
 KAmBf4rVzRZTXxN+HdQ1IeyThvIArBiCWedWzue+bhWQAGCo2iNq9Y9Ep81HT746HVHeQrsBF
 xy68gUBLLSNDCjzteUhMKCWTI51WoUeUYOi7NcUjE/pgrMc8qcpecmDpXgqzfuheptg2pI7yG
 ttTtnVQ9xLxqi1WTq4ArSHlz2QpxX2Av3gBqhoH5BUiHzE1GK8IYof/yyoP2/kNF2Fhjv5YVD
 WJbHKsfiRVKEjyYnenCRvmyFb3mxuoFn8fF2BgYt/+ijOIfmweNHqiLmfN2jS/iVRHtr+qt60
 Fj/gBIc6WXPjYdkG5vusaiOVXxBEFdDf5HW9Lnft56lgnBhbzjAmjf11wQzhOjwXoazPO/Eel
 I3GzdBJFnipo7o85ULHZJxtO/qJ3SpEX1aWdokYAvorgrvgOU+PayPoghDDwDEfTdidlyefFb
 gSjZz7dv1FLP9rpV4yHogvsVXDieWLhCA59zofo3xVntrKWDIcv2Kt7IqdtH1T8OFxg7rRorO
 9KuS5iO9h3Y/71xUv8iKfQo6IRnqRdgTTPV0e6NRq4EbAv+13q+Y1nuQFypuTz/c9lYs79cof
 e5xz6AqIRdX0JYXpDxDApAgGhoa1m+5FlGMERVl/lWKgaj4gdpszlK249MEj47xxDZqByTZjX
 F6PmfB49DLRrNBNlvBH5YzlbmZsq0++n7qIEI77buUG27U70h0v2Q6GnQ9N5rnRez70UEMO59
 n8XZJ3zpxnEV28Aq4CkAqkTRgp8w3D+1nsxYlGhaU0pTiyxUI7iaBBmDk6Tl543RnPwk725ce
 UNXSYtBXR6vG2yDRcbbkq5qzDOQEMNTCq2zZmoFB95Uv0ffUWHpcNdF3dPSjzbnBYkRo7i9Rj
 EOaw8M26DKex6YGgWTXaWuVFLJ0LbX5VVTVYjVCqMDAbK6jGFAI7Bg4CBc1rwJR982mdvIWvO
 XmA/q2sykeZTk3pBtwUbIdScCa+WYVAfqZdpKVRNzdKDKadqfWjRLBUagBFgi+cJD4ALtjn9b
 6xJRFyd7LvPeKmkHRaoKK3K9hx2ZhOe0CfJcIMvRIXcHAE/OucqNjmCKaql0xyy5ivXVZCKbZ
 ZAfD9yaV8tAWeLnursRqlFmW/22Es0ReV/XYjomg3QBCEMdk5jy1WLOJODSgXTsLjTvCtfxIX
 xtRYnv/07eetF5kXt60sZpwEOL72yPwIUXqmgRV0gmSR7n3AobMPv6TL/q4w3Zyu/Gg+6cxwr
 E7RgZ8LHaZ8DwadxX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes a cleanup of the vnt_get_frame_time function.

The first patch removes the define RATE_54M and changes it for the
ARRAY_SIZE macro. This way avoid possibles issues if the size of the
vnt_frame_time array change in the future but not change accordingly the
RATE_54M constant.

The second patch makes use of the define RATE_11M instead of a magic
number.

The third patch remove unnecessary local variable initialization.

Oscar Carter (3):
  staging: vt6656: Use ARRAY_SIZE instead of define RATE_54M
  staging: vt6656: Use define instead of magic number for tx_rate
  staging: vt6656: Remove unnecessary local variable initialization

 drivers/staging/vt6656/baseband.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

=2D-
2.20.1

