Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F88CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D77206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Pe7/LpSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFWNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:13:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:45231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgCFWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583532797;
        bh=S4IS6EitCKpmisQJ5dxqWets90VjJrjS0LSvf6G2itM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Pe7/LpSPVgDAaMGEWbCU43coCJ2UKP7Cis+u4r6T0Fec6T/3Y3X9iKDrdMD0F3uWS
         90T0ISNPk//oEtWF09/X161D/JS3qkTvVyVDQrUNoPNqb9enB8p6yYSHMWtv0GSnJo
         In+Gu+pr4/x53jNWzylTI/kUvsUzYVDYJmbEm8LE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.95.203]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1izHVc3zAG-00OCwy; Fri, 06
 Mar 2020 23:13:17 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] parse-maintainers: Mark as executable
Date:   Fri,  6 Mar 2020 23:13:11 +0100
Message-Id: <20200306221312.11199-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mRZCUseITqLNn2G3Sl/L19CXIqvZ3+LeXvceEvpViN5a1O1/hj4
 rnwn30/8rqJoKFakVMOaKCyeSExauQnQ7kCJo195kHXoTsxTTHfZxExokGWi7vIyO8BZm7C
 4E3HCcmCmPsxRY4p4AUIapKI5gkv4ksikQZo9hYYzwHdYyHiDv6yatggOPWzh+AhMwwWD9o
 QyOzA9XSYwxyRC4YCs4ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ayfMVewBxwc=:DFxwngZlGn9288WHp+tTFW
 tRzE6I6taQ1kfGKbX6xuJ/OSI+O74n3ncDWfQE9f5khKBepBl2WeYGI3BZF7l3iD4WizaLenT
 +Uw9Ohe8+B7XDMh1TqQuNOi476QnwV3q6pSVENNbInuJFMIQ3fPG3UoTK67syZTGggnAomjCV
 XAcJBL8awKCZxOzQCmjVzbnuuSxJQb35sTx0vBiX916I7ReefP8oJiNB0kduR9Zk8xGA6rz1g
 OJOeCaFS5+0irMwREaUzmU0b+/kudWvqVCEojTU1/SMuPWQz47cAeLL4PfqNfDeGY/rU4rJ9l
 mk5Dxq08e39bA7iXyMEomiKVzwDfSIa/HsQ1Wq8U9r3crKJrkznyDKqH5z4xiZk994AOc/WiR
 nyAD7l3GdBz1CGuwUCIS1q9K1FUXvEQGWvGlJ4+JvydAGbYe8EbISZXM9cz7TtF9N7/0E7+Io
 q25hu3V0ZyxsxOoFT9VyWgL42AdskdWMSTJ7UccWIcSrUiaITyLWqIA9y+lYNgcow1Xs/CAAi
 wkRw51ycFZmLcLtUVxEYdq5eRbyYF0B2sY0D9sNU1c2jLdNmCp4FPaE6ZybW1ZqP9uR1XqBtH
 3zhb83I/50JZcf0tsy+BdtvJ7/kGk7UXhlVHSWoNnikG91EUGdODT4P4ts3oU3I8oRu7JtTRO
 mLL/FAdv2rQmzIymqlTc/tu8TNFO8/2FWq9a2YG43vwM1WAyWKUPPXpVwu16GLziv6nbscjKO
 ElsU3gkWlkFCVO2gfaC3mh1/1yCfZ7iOx0slL3sUNeo2kxKzi/s1DMsQj0Vko2ow5DmXkUpJn
 wK0mwPgWrAOz0j5uFV+aOHf6gS1yonBvb4WzdZRQfk+B+C4AnSwkWGR+yygHs/tOTloB4r2Bu
 rgx4qtwO3WL2VkSpLdZ1gDSkggr504syjoHgttKEKALNXLrtG3f4f6x98I7Ba4M50yj60PGHJ
 NGa47Ad98sV8UKXouWicEdnwEuVjHIh0c9kGYP4f33FOsIo31sj4rikk4Pd/D5v+/+BsJgBgR
 4KMbMtoGKIWqNEW4OD9vp1t9ZDkiwWcjLsuqFRV8ekMF0JauQy8tYQS5Nwoor0z4e7Abd2Lem
 yfHxkV8egnqc81s0npkr+hxVZD1Q4ju5FscH7xoE1DLmC2rbjoW+Mw4ueuifLvRZWNh9nqF8P
 GWouNDrvTwHWFYL22QPq5d2p3LP8S6zXgo7pCHxYCwNGXn50qHae5zdXIcH8yb6kOSotu1Oru
 38YNTZBx+vrjAKN11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the script more convenient to run.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/parse-maintainers.pl | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 scripts/parse-maintainers.pl

diff --git a/scripts/parse-maintainers.pl b/scripts/parse-maintainers.pl
old mode 100644
new mode 100755
=2D-
2.20.1

