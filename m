Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9651C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1FE20702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgA2MeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:34:04 -0500
Received: from [167.172.186.51] ([167.172.186.51]:34014 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgA2MeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:34:02 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3042CDF181;
        Wed, 29 Jan 2020 12:34:12 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R0r1wEm87LDv; Wed, 29 Jan 2020 12:34:11 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 980FEDFDFF;
        Wed, 29 Jan 2020 12:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YF-rmr7QY_o5; Wed, 29 Jan 2020 12:34:11 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CE1E4DF181;
        Wed, 29 Jan 2020 12:34:10 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] checkpatch: check SPDX tags in YAML files
Date:   Wed, 29 Jan 2020 13:33:56 +0100
Message-Id: <20200129123356.388669-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a warning when a YAML file is lacking a SPDX header on first
line, or it uses incorrect commenting style.

Currently the only YAML files in three are Devicetree binding documents.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d20..e2976c3fe5ff8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3087,7 +3087,7 @@ sub process {
 					$comment =3D '/*';
 				} elsif ($realfile =3D~ /\.(c|dts|dtsi)$/) {
 					$comment =3D '//';
-				} elsif (($checklicenseline =3D=3D 2) || $realfile =3D~ /\.(sh|pl|py=
|awk|tc)$/) {
+				} elsif (($checklicenseline =3D=3D 2) || $realfile =3D~ /\.(sh|pl|py=
|awk|tc|yaml)$/) {
 					$comment =3D '#';
 				} elsif ($realfile =3D~ /\.rst$/) {
 					$comment =3D '..';
--=20
2.24.1

