Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BCAC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F122071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kKTYEEUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDYMj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:39:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:38035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgDYMj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587818361;
        bh=m3U4uimyg+MbzfiVunDprrIZ+RQ8+IS/ddgDXvp1lnM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kKTYEEUf7OTS921DTxH7zvuXAvRaURDhFC8gVtwyxisyj6y9SANqAD7wjWhJNGj3s
         4Y6IqdywBQ2mnHr8qGLQsvLoYsR+RlD8Vu/QvukkNY5d9cfBb+GynpLImCpezTD0Aa
         z533jvesH6fEhiPMo2Im5QfzAdVjeD2ku0Of3CrA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MxlzI-1jGyxz2x4A-00zBSr; Sat, 25 Apr 2020 14:39:21 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Refactor the vnt_rf_table_download function
Date:   Sat, 25 Apr 2020 14:38:41 +0200
Message-Id: <20200425123844.7959-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuV9f5orkEU4A9fw1F4ikazpy/lirGkniEyNHdHLkFR6lX1Wk0/
 GC3szca4vaY8Lls7BPPAuWZVsVfVtwI65jrZCvQtLj4UZUXykUpLXITnlky3UPhsLxvfLPi
 QOb+1rQCkWnTNAnzr1FORcBcVnU/022/SL1l4I8QwLGTm6Lx4VHU84URSQ5IHTgZ8acRmX4
 DLrRe3fW8zieG9Rtkhn2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EnXu2ekfWr0=:chzhdA1ml4OrwcaGKxV9YQ
 hO4fPHzGtK3okl7u8Zf4DoGabpj4tVGWjZpe3ymu67NUQuMsW9H4ovzW08TjW4YWe0fzNWckw
 Wvr91LTX2l0MNcmzO+eJTLsONLAGC4iJgo8Dy+KJkkDJ64FMI9U96XJLH8Rd8B3V2S+M5JYBx
 EohKFzxwv/riy0boEgln2wckOfMciwrb0956DF+I4yBeAMae1wRk7wQmGgkk1zWcjFYR+EsJJ
 NwJE7bLJRAuX5mm9GPuTgEsSyjNxgTBlIg3oaMKXHvlGbD9JDqIjpCNAX9hiFOIDsBhzY4A/c
 KCRDBilPHfRvCSyM7nS9aZdO9vOTQXytPMpsFqYXiaUp3p0r6dpZPOkG/yMdQHo15UNzBqLxm
 I8NlZYDn8W8qNuNv//Pvp9FC5SLo3A/MdA07TETgmczihFf/sStnXFIcStw8Wda5i2vbI4Ptg
 iQAvouv5CdMycpWXcXD5I+496sIgQHCz8uUqA6I7lpmQa4ahJz3IhXRRkTZK+QdbE2tw4s4Vp
 R3XQmkAWUQiSFxc7ZJ8eFhQl1dlJvMU5E26x9MYJMwbBO8CBoFn8lJGN3PpbZLwWHUxEj5Gde
 agsd/87xwa3zUDK8yeNC4Az8zHn1j/tKKMsp/fE8+AyPLHaVfbQ6+Yz1B3sM/0wGe0wgKoJaR
 LfNiOt8NGvJwla3HuRAtCSOF9u6zfNxe1UqWMUStgp629Rr9iIlIcIn1FcnWzdkjixOEE+yZv
 /UGcmaV00jQcE1f5bX9dIozkn90A0VTOGyjZp0pMbFIBFtr5U3f6nG3UnoZ74yWfaXzvSIDKF
 8dRHOGfnN0TTdR0eNfZ7ZciSN7s+VrFWLeMVUcKXpdpgzAJ7H+cVAWm0UqLq/W/2wnekzPiiz
 zVJO4j3WUszUOfOuiWC+n+jMaeMcmV16QrT8UGxHGlz3J14NntN8iY5R6tub5w8dFyju1Begd
 9IumMEOA2gIkEI9BtI3bWpxAM1Il0a6g2ze8vGjFx9E5cBIno00PNnpUqziALoE3wB9KZSFbV
 fA60UzAv+1jofgt5m00Gjg2ULw1cB2uW4ocpkuspEYhcLnL7JE0rC/dmTsBIYu9uad5oOkJ3j
 1bJ3jd9l6PQSHDbo/kbH0rcpGIFsYV6tt/07CmQ5THoEW1gQJDTeWAKxBtVjypN1ePPvB1Opt
 yq3ezhb/r2Ja6vfGFnLNsBLIj8cX7ShIf8UkIFm1Bdt27PyvhUUagllhewMje/z9nbqG0f18e
 YEMrLpyV1LEvQ8M/c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the vnt_rf_table_download function through
tree patches.

The first one removes the local variable "array" and all the memcpy
function calls because this copy operation from different arrays to this
variable is unnecessary.

The second patch replaces the "goto" statements with a direct "return ret"
as the jump label only returns the ret variable.

The third patch replaces three while loops with three calls to the
vnt_control_out_blocks function. This way avoid repeat a functionality
that already exists.

Oscar Carter (3):
  staging: vt6656: Remove the local variable "array"
  staging: vt6656: Use return instead of goto
  staging: vt6656: Remove duplicate code in vnt_rf_table_download

 drivers/staging/vt6656/rf.c | 85 +++++++------------------------------
 1 file changed, 16 insertions(+), 69 deletions(-)

=2D-
2.20.1

