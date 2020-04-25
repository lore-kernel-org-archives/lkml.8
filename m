Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BDC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFC020661
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bclzM9w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDYNnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:43:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:39533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYNnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587822209;
        bh=F4k0zl5YuytqaKhKKfGkEmxzH9EdfgCDn9zR9dDO458=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bclzM9w1gJP6B6o4fvnI3JEAspz32bIy9G0tcjl7KtVhcNa2SpIVHhomSueRL9YtZ
         WQJ+vyr2Vn+kUwZaUG71Sfo0ga1upxC2evbyZhID2yilrBNEe6ntbXkIXEBSNFo3Sq
         UHmJLm1qNhTVc/V+HnPwcTNstlPnjg6VWmINKvS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MAfYm-1jLhGK3u1Y-00B4DQ; Sat, 25 Apr 2020 15:43:29 +0200
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
Subject: [PATCH v4 0/2] staging: vt6656: Check the return value of vnt_control_out_* calls
Date:   Sat, 25 Apr 2020 15:42:55 +0200
Message-Id: <20200425134257.4502-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:URSGQf31W8t2vC+124LfT2jdGxXZpkjVu6xG6qwbv5Fi33rUSWg
 /hBqk0OJlQAOKtGtLx0KxEBGNVrP1J6+cNS/tLcI0uYIPq4M4xHfs6R4E91o7oPaC1JN+FZ
 Eq6Ut6Ql4cMSQ2ISp9kp2St73LPvNeBLwynI6fGW8BP5C1mPgG05GTvg+JuZAGDaOv7aRUc
 DV46e8lOp2iaMBWqKj9Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UHGDVHN0vVI=:18fo+ciUKitQTMJ2rnE180
 cabaSCZnPV2GG958sZ97+pORsUqLEgLSuAAlwjjTrkmMYWJTkOgEJDkKjW+IBqJsZIbuSS/xE
 Z5RLjujy7DnCg7jBxrFn/TIuhRVb9ytRaB/6t7AYzvOjFmBKj9aC330xfM0er8bMJ9xe0Y9QC
 QjOtaxzdbreSk1w38zcA7UzEu+v/5ldqgk7SLvyZ1wt05f7CkmyB+GzzcBFo7QTh20of7WD/J
 3kg6dwr6i/dP5FIENFx8iGtPUquCfPTi5YutzZT2bl8MYGJexCdunuTblkpzWF8Pbp4I3GniR
 nB7q+cwc2nNDLztcSmS3jM+IyyFi6XwLI87GzHr6asdnf9xtArvNkJvf6kaSIAaidiwMTrDdp
 REHNN74roULwOoKGVUDKgSff70NsWQSk7L+n117n6bYPEQYDRf/pA4BTaUV9dg1wzzOzmoTQW
 fy9V81Tm7fr4kyWPs48MYzCy6ZT4eBY1h5/OMZwNqz12uKBJFjJ9MBTUqGAxoXPqZtHehGUeb
 whBKUL4rLnkfNQjBNh+2s8TfXW2UAAS8vrqSwFT4urAgplSXswbq+ObZYIxslEfsR8fDCuZ/A
 QwKPjUJNmo/IoqysGau3A80iRxh9nIwewIu9QSqt4EjSfCVdo+t4SMRKSXKiEo1/gL7JFw+mv
 DqOyf7dv/pH+ga+2RQ590MOAreLIaHdYIinmtBrAn5dEIZnLq+wOCqPTBm5by883xOHay0PP2
 zH7MAQP3tGH0EHI/m1IxmmlagyTHz8GAshFTwnML71ZXZUlCfSBTyqk458KmMMzt1DSi5VVCY
 V70jcp2ID2jBiaZTgZAfnhaPuZbZjvN03r6FZnWDjoPMcd2+N+v1F7UwJQUbhVyhXkdijPk6G
 33GmaDtiiLRM8kcIoQ9rU7J4cw3MOvo8N1/wpA2znhGXgcyiLMAOI6nsYRAIyr6ZfAbbGDTqU
 fHa1amX7XlfYYQrQhZYHH6GZ/EAIyn47enJTtkvakJTUkkVnk/JFqMfCkNQ5BMcMbbS3S050z
 KiJmxCQc6VpbZrGtXY345bYzh9Gr88Quu+N4bFA23GphWXC6Z0sduKgwKDHSmm9xPiEKcTGSo
 uAPZhO7pcXq5DTOZJMX152PX0mUyfc3M6+czjHXlbHuBJu+79rbeKycv57bp7UFFa7RNUqPAl
 lehABpW0CuqgcF1ARG+cbpfidAAN8uZBZWDV907BYZEdDnwPswbYMSKtyLT7IoD/VDb4T8r/m
 vbgcZWMB/IGA0pprE
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

Changelog v3 -> v4
- Rebase again.

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

