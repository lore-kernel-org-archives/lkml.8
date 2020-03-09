Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBBC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157332146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCIVwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:52:00 -0400
Received: from mail.v3.sk ([167.172.186.51]:46822 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbgCIVv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:51:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BB0B9E01A2;
        Mon,  9 Mar 2020 21:52:16 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kmu3_uheh0bv; Mon,  9 Mar 2020 21:52:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E3B29E019F;
        Mon,  9 Mar 2020 21:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O3nIKDN6wsol; Mon,  9 Mar 2020 21:52:15 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 81046DEDF6;
        Mon,  9 Mar 2020 21:52:15 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] checkpatch: check proper licensing of Devicetree bindings
Date:   Mon,  9 Mar 2020 22:51:53 +0100
Message-Id: <20200309215153.38824-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Devicetree maintainers (see Link: below), the Devicetree
binding documents are preferrably licensed (GPL-2.0-only OR
BSD-2-Clause).

Let's check that. The actual check is a bit more relaxed, to allow more
liberal but compatible licensing (e.g. GPL-2.0-or-later OR
BSD-2-Clause).

Link: https://lore.kernel.org/lkml/20200108142132.GA4830@bogus/
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Downgrade severity to CHECK when running against existing files [Joe
  Perches]
- Add --fix support [Joe Perches]
Both changes are taken from here: https://lore.kernel.org/lkml/3904265706=
7088e4ca960f630a7d222fc48f947a.camel@perches.com/
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e2976c3fe5ff8..642e897f46e5c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3111,6 +3111,17 @@ sub process {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herec=
urr);
 					}
+					if ($realfile =3D~ m@^Documentation/devicetree/bindings/@ &&
+					    not $spdx_license =3D~ /GPL-2\.0.*BSD-2-Clause/) {
+						my $msg_level =3D \&WARN;
+						$msg_level =3D \&CHK if ($file);
+						if (&{$msg_level}("SPDX_LICENSE_TAG",
+
+								  "DT binding documents should be licensed (GPL-2.0-only OR BSD-=
2-Clause)\n" . $herecurr) &&
+						    $fix) {
+							$fixed[$fixlinenr] =3D~ s/SPDX-License-Identifier: .*/SPDX-Licens=
e-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
+						}
+					}
 				}
 			}
 		}
--=20
2.25.1

