Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7146AC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B26920702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgA2Md7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:33:59 -0500
Received: from [167.172.186.51] ([167.172.186.51]:33988 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgA2Md5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:33:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 21A9EDFF12;
        Wed, 29 Jan 2020 12:34:06 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NVnRtgc6NWnL; Wed, 29 Jan 2020 12:34:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 06D3FDFE79;
        Wed, 29 Jan 2020 12:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KWl5di2ouIIZ; Wed, 29 Jan 2020 12:34:01 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 541BEDFDFF;
        Wed, 29 Jan 2020 12:34:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] checkpatch: check proper licensing of Devicetree bindings
Date:   Wed, 29 Jan 2020 13:33:34 +0100
Message-Id: <20200129123334.388530-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
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
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e2976c3fe5ff8..ac93e98cddcee 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3111,6 +3111,11 @@ sub process {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herec=
urr);
 					}
+					if ($realfile =3D~ m@^Documentation/devicetree/bindings/@ &&
+					    not $spdx_license =3D~ /GPL-2\.0.*BSD-2-Clause/) {
+						WARN("SPDX_LICENSE_TAG",
+						     "DT binding documents should be licensed (GPL-2.0-only OR BSD=
-2-Clause)\n" . $herecurr);
+					}
 				}
 			}
 		}
--=20
2.24.1

