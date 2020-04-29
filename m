Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D2EC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D712064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JpmXrA7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD2PXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:23:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:32781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD2PXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588173805;
        bh=GcHRv0rAgKFwgsjelUrExs3T53xrQyyhBZEE2rZ5Dbk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JpmXrA7U6MlejyX26kR0oWhcjqRx98P0o7VFtpRO4KMuua5wPB7gkk8Ida9v/vEqo
         CV8VklOKdp1bUSOQZ2Ovu4Dt8WxjTGk1rkiXJL1J7oC9ZO5YPLY/9+3eyoBo7gVY2h
         gO0Zw+B3jtfc47f5ffls7txQlyy9nzh50+gR3gxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N8XPt-1j7UHF33jN-014RUL; Wed, 29 Apr 2020 17:23:24 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6656: Refactor the vnt_set_bss_mode function
Date:   Wed, 29 Apr 2020 17:23:05 +0200
Message-Id: <20200429152307.5871-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QTtDDKVu45EKxONkVYZ84xzya9K22bDajjAk0LxjM01tyYbrzp0
 lGf66pb7pp1RQ7xRkdPDTcZM5hzhanqt5J4V3CXmtA8MpI4LJqIhBvboJzTPnxxo7rlhSq7
 zhqjxZwL4B0xjAWlA1tkW+/5SUMn5NxIkH3IzpR08w5I4vNmw93KVxkGQxcoLj/ewRMbpwF
 odLUAZpUItxzmmonMC05w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wAGH+quArug=:OlxilicYbAMFNVJfSqGjUW
 AxhNI80+S9PUUb3zA35bTdBLWxTVcE8zJs7zslXygcr60ywrBPI4ap/AxvyT6deS3u+BpEJEQ
 BAh2pqIWXXHPk1ya+4aYNzFnoKl/CRfLNI5ByrOgN7AYps2NI4J68WgJP4OYOm5nf+7xRXsqd
 uRHsLYJFS1FrEGEa5nlCWWIZOLlZSUN2tkT1H70srn6wK0vK9Libi/2SnsKTVnzHuYaQiJ4b9
 t1JkNYzHcZ3kbhef9wGqfLx1pNdlui3ADfwcs3LuTbN1PVt+eCXy6CMpaF4/pBmYmUyWU63ng
 xxwiCTVWX22iunyrqIvcPJkgwHNUmiTnrgJsHihw5IzXBNL27r3vZ0IPGiimBseIiyak+USD3
 /tTNlV4V1zN1aNlscKKoOaweonl+Jkkfe7MTxaL88nAma4QoLB0es448ZqjtkND/vraTrPkkr
 mMZ/v31E2D/PdDPaqZPtIsh5XQK/VT8tk4TLzTjhcLH7ds18AbrdCk7lr+6lCp8V6tAbMUvhD
 mAInM0RYOaMGGs0U3t/r3nw66jS2ZdkNpx7ellOo+vnvzxLTPGv5ruSzbIwFVu87gh9g7dfOh
 vwK2IAKHPrtfMumRB5j4D/3NxmXJEghhkbqrvXtU7p5rXgnm6l2GmyIbxUOCs/r3Dnuts0V4S
 3RBj/n2LZzLhQqNW5toN/zhic3/MvG7rxhzjAvq7KOtZYiSioPo3GZVw4f+gbviWjDKDeCeR0
 ocrrkm0wXOHX2MwqSX5Tf6Vs2rkzlaoMS5lus0iMiIwAi1Usw/2RQToNAzqvRK4FUOx1JXwjf
 jsolx9pf59kqDDQ8isVetpWA6iZA0Dsywicpj1UjEyNHzBFOi0qEOfnAtHbM/+idVSA2VTNG+
 6vH6WLhqpUbZiNIPfDXJ7YBXirngDhEsPafqMVDvB0///awn3Of4mHqkIpTognMZx58sqfxQ+
 W3E7J+g75oj+Tq5OO6ygowHYFb2tWG4B/DO7hlXysjvKeCc87Wg8gaFOhZe2ZYFm2G8JLW5px
 0XiitTMlEafALqRKbuAgb/WThIIZjqVFMnUFKjCAuHYJ6tYm72UD7V46KsjqIjJTUtO5nXcDR
 sfCWIt900xW39WrOYtyIGUgdD04HtUTwXvAwxysiELagE2HRPQuKpm8o0CZvjP49ZUqtWYiVJ
 6K2wsbHorbXylFBr8JtUvEBjchWBR5yNRHiei4HTV7joF3u3Ijopw8KYJPMrJAB1dGxuYHi5N
 EeJ1iXZYhTRTyByVf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the vnt_set_bss_mode function through two
patches.

The first one checks the return value of all the functions that return
zero if successful or a negative error code on failure.

The second patch removes all the duplicate code in the "if, else if, else"
statements as all the branches in every "if" are almost the same.

Oscar Carter (2):
  staging: vt6656: Check the return values in vnt_set_bss_mode function
  staging: vt6656: Refactor the vnt_set_bss_mode function

 drivers/staging/vt6656/card.c | 77 ++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 38 deletions(-)

=2D-
2.20.1

