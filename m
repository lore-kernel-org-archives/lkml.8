Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00404C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE40B2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgERUWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgERUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:22:51 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:22:51 -0700 (PDT)
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04IKMo04026701
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:22:50 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04IKMjnh017574
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:22:50 -0400
Received: by mail-qt1-f200.google.com with SMTP id p31so13302476qte.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=HCM0z9rljt16BROVf1iAlmj4G0K4AH3m18Cka4/RF1w=;
        b=MsRiau7PALj/oYCM8XvVIDvxPzXjE2r372t8qKToQxq/+pqcejc2dh2jKsmGbeLX9M
         YHp+65OYy49rcY5cc5R4qX59OUNzGOF9r9yhx78Xmlu9H20MmKW4LdcnoOSdFFjdEWMr
         x0OXN3sS65gAwS4IY8EsIROQvtUtC5MfO86Js+0NBCSdeXZO6nH/tjiRwPrmb4ufamss
         Iom/qfxMEzMCENqJJAJxjjCjw7uhTaPSPQQyA9+vboXaXcjWPZD8rjfgiW23ZXeSvnRL
         +tbNtsHfeEH7H3d7Xy1djvV3GLEe2y7vrtFt31AnQuaK6PagMi40Aq07Sy5Z0+lFdzjb
         F0OQ==
X-Gm-Message-State: AOAM530YoV3PstQdHOxPJVVNMWNTJPJPIa7ozpDw7RpYvqCv8UQKotQS
        FWjlPkRyjMp96ddCbLQ+M1MYZlDL4Y7KKSN6ydvhu9GEc8R2uApshkuMeoiDYuLNbEr2WGqU6Ui
        rawroLG7CdzZFss24WP/auLiFUDowXXqIBO0=
X-Received: by 2002:a37:6547:: with SMTP id z68mr17705296qkb.197.1589833364997;
        Mon, 18 May 2020 13:22:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5CNdFEQSK8WWfGbjtmZd6EWpYQj4GLJIi6JCfHh7zXZY77TsLFbZ8OUETO75hTZ3buwp8tw==
X-Received: by 2002:a37:6547:: with SMTP id z68mr17705270qkb.197.1589833364681;
        Mon, 18 May 2020 13:22:44 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id h12sm10341360qtb.19.2020.05.18.13.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:22:43 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Hannes Reinecke <hare@suse.de>, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: next-20200514 - build issue in drivers/md/dm-zoned-target.c
In-Reply-To: <20200518164449.GA24518@redhat.com>
References: <367320.1589627953@turing-police> <7bb0d1c8-b164-d5f3-0218-5c71047c3a8c@suse.de>
 <20200518164449.GA24518@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1589833361_31675P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 May 2020 16:22:42 -0400
Message-ID: <74618.1589833362@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1589833361_31675P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2020 12:44:49 -0400, Mike Snitzer said:

> Unless I'm missing something it was fixed up with this commit last
> wednesday (13th):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.=
git/commit/?h=3Ddm-5.8&id=3D81a3a1453ec4e5da081e1395732801a600feb352

That says:

author	Nathan Chancellor <natechancellor=40gmail.com>	2020-05-13 01:45:22=
 -0700
committer	Mike Snitzer <snitzer=40redhat.com>	2020-05-15 10:29:39 -0400

So it didn't make it into next-0514, which is why I got bit by it.  It's =
in today's linux-next
and life is good. :)

--==_Exmh_1589833361_31675P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXsLukQdmEQWDXROgAQJj2w//XgM9u5d10BsMq/vpw2IiM1yGckHbK/ar
oGAc7biiwgohYKxuoVDjWaqvxLyWjRKKY51HLw1hW0iW+s6GRkXmJMOiCUIYRUgl
cBJmUKzAUnHuWN2aXTRMk2iMR2cT76ymT/JCgdhl/ohiBIgHg3nhF9+eNLgxme+C
PT9jC+TzcaMMpxwkAgpEVVpYsx+4S+4Y0iIKH/tsTbfMlGaUtBRKx/uiEcnugIP8
VpOGjU6aUwpWNQpztpya2Be8E63mTkHv+QkjIMzt+B8Oo3NzqT4hFkr6X8bQ2Xsb
b7Pd7f5ca2r6g2Y7JOvK2yawZTVoKt57Y3ri/fvaHLL1gk3Nj66D/XLEWtioiEq4
hw4hmCIinwKg1EmWomkgHzaGEylZZIMWRuKcX00JhVqqtM6BEG5rSFC5b67LxARr
BEkrlRCYM4PIaNYGnh7lbwdiwAORk/60JXmlzVq8DyRJXjmNjAGUL5aAIVRsACzN
VY8FWX/KGblmvyp6mkq2CUEa3HAIh2BlUccA+wWJtwQbCtsB87obhcyd60iHso55
apXGB/y3HCKAmyuET/GPGfRPb84RwZR98ylJbhvkU9KHNImaNpQcIJe/kGZUqqWd
5tvPtuWstOixl3czNpAym0S1QGvgqebzKZQAeJPdRNmg8/WSt/LdOXt7Snt8AOss
gikLBdM2Rzs=
=24y2
-----END PGP SIGNATURE-----

--==_Exmh_1589833361_31675P--
