Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8661C38A2E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57A2206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FVVsQjWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDRMhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:37:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:36075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgDRMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587213447;
        bh=0i/Wz1llh1JOZqgylVTquYfWudmh4cFW62cFUXvwLDE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FVVsQjWiDxrPBsm0UJtstJ6Jm/1Or6n8OFy+Ot6NJXK5L39oHoIXxLBcqu8RXkmt2
         ciiAACTBhPpzKv41DByK8gP4opXDBm52JXZFJuYgzB4knLlpyVNfmDcU1oMupMZK1T
         koWQaIqMHKowJOCwoNCM5OSFJSR269Zm9aVahTfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MGyxN-1jTrTI09jf-00E6CB; Sat, 18 Apr 2020 14:37:27 +0200
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
Subject: [PATCH 0/2] staging: vt6656: Check the return value of vnt_control_out_* calls
Date:   Sat, 18 Apr 2020 14:36:57 +0200
Message-Id: <20200418123659.4475-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oHlXilqcAogjPYcNvsKaQo1op9W4zPB+NOtoYbdz9XTTX7lvo0Z
 aBEh9Dtgohr+QMLgRhMGkUfUPRwa++UUtvVdt+BDi6IvD6gZ+kf4jPJNMWT0Zlfe6plQ8ty
 NCtV35xEEmj9Hx4QVpQl6CwsjB897/GgXbAs4akASpRCVQviZF5M/i3T1OlftMOQv1KxeH3
 LzUV+rGtkSougqSnCZOhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJaPwoWp/lk=:hM8LfiBBdcnb0n6aCBj9Ur
 15vcMOUG7JRgSp8JroL4CO/dThgU+80pU183sFVz6maYQei5r1Ail4y3Qf46cSAO3PHxp2Mzn
 P2DSFqZPqAxAgZEAN7dt+aWpEuulh78eGuW56VbKtC+7WH1SAftvERxmRDqQYENlYLc4l10MZ
 r6qW8aUnLKdPJnvYHP/LEfrL6inROjslHlxkb/UvV5/vKb5Sii1/X5f4otj18mEXmC+Wp5Dl9
 q7wJDgkG+5t4cabZ+pLcQRsy4CpK1M4DrkPFNyO6YdFhVBeYV0LuG7ZKwYs9OFQEzl8TIQGyv
 ksIJfRJpSVpw/1fQmjLVvhjzAYBbr5Wx7EA4AdqhCDqn0rWhFZcPyS3THPBWj566UZqmiIUeO
 ktB4/vNUf8u5/eYjyi8N0Tgn0nKXqpdr/xQZiG7CiLjW7Oxz/kuemeLyW9ID9wdO8eWx5ijRy
 Cvr0DV7ykJ4DUUDdiylxNx1gTuM3vbNHVGHO61/7Az5MEb9VDpaRgU0naZg/aSMd/C1pmRlCX
 WzpjG3t5JQFDyTeuxlZaAD7nC2HvE+3hRYWYsx/BMYzZ3QG4gbdH8ey97VhKKKJcVrpy3gq5Z
 wBGgzoHwcU+qCfPg/6sjTBWb2zUqtbTv8HqPaPwRU/dHWlNgPW/SCa3aEay40xszP0RI31eRE
 RqHC4bh2nMlQXDHms83yeZJLZqcoggfsjiT24onQlsAkSirqSlKo3UGr+D2ANCs/B38wldCo0
 5jsuDs6sdxzB+Dvw0fI5sy7ItKnbwiFebsh0khRO9f9WinviF8GZWmKBwBZi/ynHRzlYUZ2CZ
 PE3UOdCIQwsZCSuwN/PtTt+SU4mwjbXoXcKmgTj2QScOTT/5dxEWUBDXcqhyKQwp9vEpYYJci
 w1ULHfAPB28Ri+lYjGjlbHsm7BUv0XDDAKxnq0vPLGoYnbJp6Pw5NGzhAAM7v2ysqyO1ZHek0
 cuy7Qvoze8J72qxXh6owh92PVvIMULTwGsrsqXCneH/FFyFWZg7rFNkQTcfKtqJry892mXqsI
 1lN4B3uZy35oyhq7B7E4skpmLSZttZhKjuzpUUIQvL/hYL5WVhM/2rFg4/BYzhWdt+FepPHgX
 v9YUMCykLZDEcqGnxTnG8gbDcJ5eO7s4V+5IN427o3jB2I+6IBUbYzF2M2vJM9wHHy4PSdfz6
 esuYDAERlSGBKVksy8l6YoOAjL30bg4sAhBrsnhu5a5iwRRx9HYwL0gO1AKI5tRmLgnnYcYsc
 2A+SBiyafrSt0QkAF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series checks the return value of vnt_control_out_* function
calls.

The first patch checks the return value and when necessary modify the
function prototype to be able to return the new checked error code.

The second patch replaces the documentation of functions that their
prototype has changed by the kernel-doc style, fixing the parameters and
return value.

Oscar Carter (2):
  staging: vt6656: Check the return value of vnt_control_out_* calls
  staging: vt6656: Fix functions' documentation

 drivers/staging/vt6656/baseband.c |  35 +++---
 drivers/staging/vt6656/baseband.h |   4 +-
 drivers/staging/vt6656/card.c     | 198 +++++++++++++++---------------
 drivers/staging/vt6656/card.h     |  18 +--
 drivers/staging/vt6656/mac.c      | 143 ++++++++++-----------
 drivers/staging/vt6656/mac.h      |  26 ++--
 drivers/staging/vt6656/power.c    |  24 ++--
 drivers/staging/vt6656/power.h    |   2 +-
 8 files changed, 217 insertions(+), 233 deletions(-)

=2D-
2.20.1

