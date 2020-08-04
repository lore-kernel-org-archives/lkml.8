Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F269207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Bf8tFFD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgHDPDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgHDPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:02:01 -0400
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D65C06174A;
        Tue,  4 Aug 2020 08:02:00 -0700 (PDT)
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 4B55E50E031B;
        Tue,  4 Aug 2020 18:01:45 +0300 (MSK)
Received: from mxback10q.mail.yandex.net (mxback10q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:b6ef:cb3])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 488A461E0011;
        Tue,  4 Aug 2020 18:01:45 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10q.mail.yandex.net (mxback/Yandex) with ESMTP id jNSF9J3USj-1iAKrFnP;
        Tue, 04 Aug 2020 18:01:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1596553304;
        bh=SPkeXqwcTMvQACiNmVSSb8F9FpqteU2Kb+2386F8/50=;
        h=Date:Message-Id:Cc:Subject:To:From;
        b=Bf8tFFD/1SAPi2ycyp+x+y/rrwZkk7ySdvFv/5a01wWG/MphcjJhSgC83HfIj8Epz
         PGE5k3A7D1MbJOFycNyBN2hh+Ci1wyuEmFhBDpPjuklUfKK+Zn+8TuiM6OXNVBc71F
         pj+FrUPhp3yaQJ8FtivQuOh5GdjUXACDA+HWwKsg=
Authentication-Results: mxback10q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-8300199a0c8b.qloud-c.yandex.net with HTTP;
        Tue, 04 Aug 2020 18:01:44 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project-org <ldv-project@linuxtesting.org>
Subject: media: ddbridge: potential buffer overflow in open
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 04 Aug 2020 18:01:44 +0300
Message-Id: <4321596552833@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddb_open() accesses iminor(inode) of the ddbs array that has 64 elements
at most. There will be a buffer overflow if iminor(inode) is greater
than 63.

Found by Linux Driver Verification project (linuxtesting.org).
