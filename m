Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778BAC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F902075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GWvb0Ms4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgDWPjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:39:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:37171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgDWPjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587656348;
        bh=tVK9wHiOkp+HiJDasb5SXHVH2+WN8NOIYB+YERfKM2Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GWvb0Ms4UUk6kdlp/H1p0bUqoyWCpOnrpdbfcbSi9FW0otuyiMcsHuuRd/1JSnI/i
         6mGbvzSx6G0pEccZSZ1gJ8RNPdSrbqP4nGK9Vehr9ddvcx/HmOT4EcJlLuPf3pLDOd
         HdfkymzpEUveOZaRIMmAH1L3fQpBTcIhKIGzRc2k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M8ykW-1jXfY53sUI-006Aja; Thu, 23 Apr 2020 17:39:08 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] staging: vt6656: Check the return value of vnt_control_out_* calls
Date:   Thu, 23 Apr 2020 17:38:34 +0200
Message-Id: <20200423153836.5582-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ez+aTspjR2dwAdEjcGrDYLjesRrwRUyke9QkGrpBfCvigvJ043Z
 qS0MkZ/xtlErRc4ca1V8ECZk9HZrm8qDs4EzJvkk5jC+N9Mgd7l3SFyRR2jNE19yl+HEe4L
 KROKFC14FAW5tefsb2dIdQ8ujwPjmmtZGMxL8F309qwl3Jte8rM5VMvYfSDy9ICQifGdZ0b
 Ho4fZmLSm76L34RFkhuAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lu4RGMyXhlA=:dTwuxiosGMrAjqHWh5IGMk
 BFVKJDbE8Ks+3EiWIJZT8O9+DxVpMEqGfH33ti4lzgGi4q2+I664jobM1JW+W69uEsjhV6hv3
 8Q6vVbFPwbVu1o/IbUb/t2wdf3NbZUcSIrNeReN5tyahlMJi44ivp22uAXEDF4DDtTTgGaf/e
 +lSnYZtymMLzIPAVa2j8i+9YCImdZojmjA+aOjQ+xyL+GWujFRSncVK+bl84TcFrXNmifmRNK
 +1UfQ8mB/tQbLpPw2Fn/mCdpwzD9t+5k+PYuffuTlOvP7gJ1+PFbziI5b6FZ5e9b/t23rcHdt
 NsJmAY30YT6OiMlivAyBGjF5k1uDUmwn6EoC5xfyfRjCyhjGblBGhAFb2LIRHP47gt6XF7Duv
 HGZjJpIQnYZy60cR5suDWd1jxEWHkGrvGl29gJ1lzExokaAQpGdaY7YllYOXb2KKDtqwYn2lj
 3ZIKvXygN56md2ltKUDemalaRukKG8caA4qtim4D408mjzXAUtWjS6h0b5NFTv4ztaVKtw16Z
 MoytBmNQJZfLJ9fV+tIr5g9k8/hf0ADUz5GT4hYXuxmOLq/GAWqZB4D8yCY0oRZLzorPRTeR8
 vLsgzbP+24jgLIkQ2qhiRTbfKDAIDIDY3r9z3RyWE6kLcKC+ZDMiGJT8WnQdfBy4TtT8SdQIj
 BDIviYEQhxGVajgpaLShLniUDPWR+jUyOn47Dv8KBVUEsf5zscWVrL9LWGfSfnSNmtmyDkl9G
 QBoewJ//+TEGNXB3cxdxZRld2jsCb/VPhUtSFE1+xKcUF+5GZTzRgvv2cCWkLHxurA9LHf5ND
 lxICoUxIyJdXu6RlA3ZC4XVttm+ICWm7irLdGu28k7f3oT5Fo9mzRX7xEOTmL56LD0aiw47wL
 p19WwaWUATHaPvkfdbuV66by/xcYLjCdorK1iss4zCCcsmm5qrSO9WvUz8mwrZ7ysfq2UMji3
 hoGrEQfa2aR2S6i84GF1zDSNPrBYlbSo5t5P1UsD2hSlc8YdJ/GLDPE09NMx0vNK7ordRLlvH
 8BHNwJKibEVWfHIffCZst0GAClZGB56BK64q/avDX+KsbNDWTEAKbEvX7smcMvkpanlQP+vjM
 ENCq6OSvh4X6cQRItG60gX2oiUV/TZ6Zkoj/KuVrB2lQZCI3/XZhmSO+mWqYPbjKCquphLic4
 eFenVdJHK7ep295Ns+EVe9FxBOvcXGrZ19M+hAe/iLTRkFXzTha9EvnlNzLZU8fms/snA8mhy
 01mo2rkBxULu9AVmF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series checks the return value of vnt_control_out_* function
calls.

The first patch checks the return value and when necessary modify the
function prototype to be able to return the new checked error code.

The second patch removes the documentation of functions that their
prototype has changed as the function names are clear enought. Also,
the actual documentation is not correct in all cases.

Changelog v1 -> v2
- Remove the function's documentation instead of fix them as suggested
  Malcolm Priestley.

Changelog v2 -> v3
- Rebase against the staging-next branch of Greg's staging tree.

Oscar Carter (2):
  staging: vt6656: Check the return value of vnt_control_out_* calls
  staging: vt6656: Remove functions' documentation

 drivers/staging/vt6656/baseband.c |  35 +++---
 drivers/staging/vt6656/baseband.h |   4 +-
 drivers/staging/vt6656/card.c     | 176 +++++++++++-------------------
 drivers/staging/vt6656/card.h     |  18 +--
 drivers/staging/vt6656/mac.c      | 128 +++++++---------------
 drivers/staging/vt6656/mac.h      |  26 ++---
 drivers/staging/vt6656/power.c    |  22 ++--
 drivers/staging/vt6656/power.h    |   2 +-
 8 files changed, 156 insertions(+), 255 deletions(-)

=2D-
2.20.1

