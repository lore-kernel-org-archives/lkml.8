Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B8C3403F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E4C2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V+xHiljL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgBRPDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:03:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:38477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgBRPDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582038159;
        bh=78WLr0Jh0oX941+EHl0TP1NEkR5NyE7h/+gfWtJqsqA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=V+xHiljLUpanYuvJitxOcIggYEggezMjFipHdOvHaga5Eurb3vA0pA1BYSPwCewAA
         xhhesrB6c5IEOBzBeE0cQM4irbpox/5DXxkXdLQA9WhNZspXjPuACaUwG+UdAg6liX
         mOxQJrqxVHweeik5u61bE+N9ZWHcq2T9orXC5g7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGvM-1ixtDd37Mc-00YidA; Tue, 18
 Feb 2020 16:02:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Fix path to MTD command line partition parser
Date:   Tue, 18 Feb 2020 16:02:19 +0100
Message-Id: <20200218150222.18590-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kZSahnpTKmGAZGrssfHw5TUnMAFLMXg3CFjIbXnPC0vqEdMxxPO
 uj8IUfNCN52o/tUGY9sUDPa96hkrOpsBku8upZfPHIF3K3c2bLkhEFKvWYONDL+OW4Iq6cE
 R01WX4JADvtpEj+ReLrGdt6s8xQYsYucLxXtiVDY48KQolDoVJCrvQicaqGvb0NWnzq/SHr
 5tg2gijiJoobgUzIbKygw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w85UQI942Kw=:aUKBxXiwwpBL5kKKplIrZ3
 LWSEQLuCeWmEv/OmSfmwlTuXoiPnRCqDCMlThgINYrt5ds3P9BVBkUV5w0bKqsBnXt0Ea6p8Q
 42kPF3J2pN4hJcAxIyc+xhRQQ7RSSqdMFHW3Q8JWSoMo3l7RKAZdZ5hnNCuOf68nvKxfXPxWt
 A3q5bl/b8aRcPzvrsIUwvxH9yv354iuquGyD2Q+MBGVAWE1/l4QXOxVdJwlBLkqrslhNEwcaC
 P8lPHYewUxSgwksvQgtnW/q423T75nG4AEk5gRsxKEB4mbarRz5Nsc7jwr/anhprPfYoIpPk3
 p42OEH5XuvQw7Y02YEPeAR7odryy6g7vjgKkLOAOYuoXsKQwkUr+tPLwwN1Rdu6JrKK/hWx5Z
 EbFJV5m4Je26JZmvRFPfnIp6TOLPS0BAbvo+mAqR0ZTTaq/1IgXs8BbZkGZjmcSzFHYS+vNMY
 tc0ngvduWTZ7GP0+Lyr47lTavckogL2M3tmo43nWSKLY1WX5my+ks/DMa4crrpPTP+tcKx5Vl
 A9hI8Tr4gfbKX+7D5tiUNoy6l4raBlyVxuV3SB/SuM4AF0981/v7M0fKcjEHPXRBjxncmA4hS
 AP+hS+y/0C+qwSPqh4cW9hL50y+93wh2D1D8GdeVRib/jFQg8Sy3yJDOZRK+6pKptWVusDEDc
 l6NN/k5twKnAiM0XbKOk+9sdJeQvFp//j+g8jU3hJ3NtlmZuqmDR88Jo1sT6nGowflKOp2fPG
 cA0hieFAa2nTeNx+ClRojxYoNp/V3bBMO2yA0qVrNWgmeVRENEKO/p6ZsjuffLAmH/D9eLd6D
 QZGGjxPbmeTfXzOi85XmMri9AdPF3GxDrmj3v+eCfodhj14/jwdK6a3CocyhUvdlO+NHdrcKt
 6wPGRRzokY3noYelGGYUpUCB9WwZeq22GRzlTdM8WdmpkUnr96jkJ4gzQmHHzj+p/nLioabHS
 QBaIVnwwHz7RpEU+xS+AGqF2yL1fzLIISI6Wd2igT1CSkU+YmTuv+MNNm92T/QtwLhbtqDCpv
 ndBnEemXKS4nMvohAmP39n3HR1ZHxmGZJpgfkX0PudyEhQ79x3CmHNB6HPRX7UkD99RvXyOiG
 jaO3FSkOvaNxzHzd7ehdeJw1aEzRG7CeNFAH9eKxLF60zvf/TxGPMQTN1aU3s8j8L+V4JM1VQ
 AR+wR193CGPXYwesN6jRGTsmDhcdaufGOgxEn8mUzsW8u3KKD1Xm47mu/Hx8pcREa7evZA7wq
 OIAjJqTCnZN2IdNcd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmdlinepart.c has been moved to drivers/mtd/parsers/.

Fixes: a3f12a35c91d ("mtd: parsers: Move CMDLINE parser")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index dbc22d684627..47cd55e339a5 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2791,7 +2791,7 @@
 			<name>,<region-number>[,<base>,<size>,<buswidth>,<altbuswidth>]

 	mtdparts=3D	[MTD]
-			See drivers/mtd/cmdlinepart.c.
+			See drivers/mtd/parsers/cmdlinepart.c

 	multitce=3Doff	[PPC]  This parameter disables the use of the pSeries
 			firmware feature for updating multiple TCE entries
=2D-
2.20.1

