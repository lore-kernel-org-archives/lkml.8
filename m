Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D4AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C9722B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UqrCq4Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgGTLbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:31:42 -0400
Received: from mout.web.de ([212.227.15.3]:50595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgGTLbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595244671;
        bh=cYzITtEeK1kf2NysDmQQ3pMD3YOklL03gDz5e3roIxg=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=UqrCq4QyVfsQfsaM0Ae0Uke1boBYUCmJx2rsWsMqypWofMg3VCPMo2E6J56khrQU0
         aLhI6dtJaXzNEFpNFMrOtkb27hqnvF3byCG4TjTxI5cPnlyxIsKxzsOridrD485dT1
         6APG4HYHhn0ljatwR7lrE8EAs9B2LrAlUhZ41jWU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.85.87]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1kSRJ62qeZ-00eg6z; Mon, 20
 Jul 2020 13:31:11 +0200
To:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: Avoid memory leak on
 cc->cpages
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6074306e-e909-e17f-900c-320245a8f869@web.de>
Date:   Mon, 20 Jul 2020 13:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qS6Ki2pPFEFn3L3mVusKmmUHEqyXrThQj+7rXqF6KlUNHWU8nrM
 W6yBK6uaR0pZ4uINLqsHqtZRPCuLex4T1vqGYDOb7DBf9sOzCOmL9Yt+LGpjVQC+utmegNQ
 xw1hFsutBZvt0vWoDk22wZS7n44pTej1gLbsjr6BrQmBWxpte6Xx+wiV3mvtApbou0xxWKh
 Gs5MXzedkdCUTiInebukg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cbxEJgWr6yM=:tvfU1UjPmuAQXfgxpJwD/E
 1ZYkczhdl/DLkd7ouLOJQ7HY1FyDnfJiNyaM10g8Ae9UhOyKcnN2sqnqycxLB1BbQqNamffmH
 vdL/yQbE6bVZat61MtQWlDkDJNnNcOtKiKhiPlrvfpNHPewpGJoFdnUzlCq3QGgY8bB5thJYB
 NC1y7eSbBtvfz3hG+cwMwBtz8Xtwa15bmGkdtYkd0CQ7QZNS89mKb0IuMKAO4tyvcg+RhN31X
 LV+QujxV9yZEFgkeZ06LwsxO3wbbZvZkxqw/8o6DODb6wU9Ul2rLJ/EJXV7vL7Bg6/iB18Evm
 eQg1QeehNe0cDDnzxIx3r/S+Z0WJjYhRCE9sfhzD545BvtN5hPnSGuX3YSkhajGtWsyhEC2mC
 7568Nk0mPprKBXNMQOOU+eBlv/q9oWxblIJtWMQcr+izhRFTPtIu6nEpDnZN7VwZYutfADK92
 cT+F49NDdnFM1iZuHPHqNc0Xi+pnqPh5paYBg/9F60X+RoyaQ+Zxx0HYFPnzRciY34MT7MAJm
 iB7FcpBO+plPkd7ovk0hbniY4tYJgL//br/pgB5y9vJ4r7x3G0kBD4TNivzd1ADz1sPRjTNmz
 ZqB0WORFjqXhXU5bV3aH2LvAIWxOcv7MxtJCoh3ak6/NPwFllzeDxcpDIGppBFywx3rM/Oign
 wLb6P0AyRLRLI1eVE+OIBUFYdj8WJx4bSL8e7MW8qmecfH/wSYarfX0lWqQ7tyVmr0V7CD1dt
 v5b9NU08XwHyO4qZNhG+ckSXn/40Zi6Igos8u+VjvaZXGuFS3l8LoQu6S+Y+E3iPcJm5MYlt3
 DzcOVtK212aqiPPVFYp9uxJjgpCeBg7D1gjKscOgCfsS4jkgo5kadvte1GYReLy3A+e6iFkm3
 A4TFJNL/oKviMDTULDSPfiMob/EqhN9O6RnXiw8MciHihXodfUGrPt1xPc9y2szrTGXxhmV1H
 A5+uVCLeAK33FwEjLX6Pn+cnECsNU8XjcygYnuxNtUu6N/a0T5Esef46p/Dayj3YA1jh3xCLb
 wbA7tc2lu79DUU9J/7IeB2TiYrkfx3htBBDpmdFnQRDnBlyqEBP5yQxWb/Fniqrd6s9oYu5rE
 8PGhy4Jo2kxKaJCeJpZbn3OgRd1PXeNfhdvgEWsRIhmfIPy5G71QWaOUh9EO+uCUbwRZl+Mi/
 bonlgWUs76W8j4vL6oerkgJtHrcjfrrdcwsYnu72KiQv3sxv0+W5ZSpHC9AVuTPGQbs5Wsdjr
 /z99phraujzFDGUbFxqYGJ7gA9BlyNQgeKX6Eig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Memory allocated for storing compressed pages' poitner should be
> released after f2fs_write_compressed_pages(), otherwise it will
> cause memory leak issue.

* Would an imperative wording be more appropriate (without a typo)
  for the change description?

* Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit messa=
ge?

Regards,
Markus
