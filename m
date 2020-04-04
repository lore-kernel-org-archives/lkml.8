Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E55AC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09261206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pvdKLVti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDDOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:01:51 -0400
Received: from mout.web.de ([212.227.17.11]:34693 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDOBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586008860;
        bh=H0vkiTgCKnYCuaGP12O85bf8El7W8KW1ykrDUOP9l3Y=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=pvdKLVtiW5jjTtLAhgMt0unXutMIVXMWctoAW31RK+sEqrJ2xht+xWm+xRZybuZg+
         v5PIRhqxCeoPSNvSCr8eB5BsxLOcL+jw3u067qHoSMSK4liPf3B7rvk6VE4CVKKsAV
         FSVvX+ykZhBi1L4Oxpo7XyjI5BMh+UxHoFO7yccM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.181.229]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MduIT-1jfy3l0hJN-00PcRz; Sat, 04
 Apr 2020 16:01:00 +0200
To:     linux-arm-kernel@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Enrico Weigelt <lkml@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ARM: pxa: ssp: Delete an error message in pxa_ssp_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <524ae90a-a7cb-feee-6107-743c52c2b1e4@web.de>
Date:   Sat, 4 Apr 2020 16:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eJecsmyuMS0z/s3rvAPuwEJ883g8TsLTYyJbyQquMFB4+gqDqiT
 EY9iI4pjCC/eKt6K8c+4TbiKGcNNa0gyfo5loAZ5wlyIgFJfiogvfDh91K6e1L15gl2BBRh
 U1LWF+BjYUMCp//ZiVR15JMf/OD2M0dvSC4ACI6Yi944NmGaiI12kJf7d20TWqARvFaDXon
 g0PSiltgWKFf6Rqa1Y/mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9WDe8tLOqvU=:OSnH1IsagOv+oKMzFqbmes
 SuTwZV+0HbTMkT5P9a+vMJWCgsWJR2QGI4V5giH9JvCu7clVQcxK3qIVzrVUzjpaMJf0W7oWp
 K6giwgBLBLxVWXbs5fMPUorsmk9leJPDrfAKPN4KjX9iA+GI0aWiwJnzXOLv9y1oexz/k2SlV
 1ijYpMjFR9ZoTV0FV7u+DORUFGf1PXUwozGDz6Ycdm6VOXn357bK14sCK6AdPk6mx/a1/bQ10
 cfPVeiP9DbDODVXoQJbkUi3EjtGnlD0cvMBHc08CmsOLfCwJq0oqxWOcT5bWJGTx9nRAZeBl7
 RHNTZCDBppk37CdwiKUAqeLHZ/Uo+IvztkEX6rRYibha5GvRTa+lyKN7VWY/ZBk0DOdaWNQqC
 hq4b71lpkmzGPhP8yuX3qXCETYHS3vW2W/lXXKl5jKFD1TxMM6FaEKspwd38d38xykTTPt2GR
 4B+0QJ+wTx9ndxSped2CNj67guhcgF17/15hSa+FGxbQHtOTHMLd1uLLD2NwSbExYsXSoPY5n
 xcOHf9CvvwAGUvM2SuzJMrbeBYgdgNq9vin4UHq8cnJ/TbpEkCVq9jQKi65/NpW6eXBlYeIEU
 lVQWKSYNUCBgRZwKqm2Kr3L6T5nNAMnT73kqVgS4hM++qb1HXHzV68eAgJkUUuolvrT3HLIwd
 /u9s7Tot7LSCshZg70gIXYx8BeCAnFaUbCv7gmuCdpGIJe5DZBeshmkKy70Rpo1UKUpXXwQ3E
 uh055S20+TKq+PKBVK7Q8RL6hFbF1q7TAUV7puOLavGFRyiE+SRAKYiQlzRIa3Rojr8kUs0OT
 GtY3UVWqhhs05YaqoD7ZjFqJruPNP2akjsVVV5cO3SVFpW21hoRVF/6hIrKQer09H+W2BeXbI
 MDo20xxmlIg7S3tI3vpE9uhBkFAe9lir4H0jZr+vtAJ9eZaOoVYKBtLvvo3kccoYp8XyE6a+j
 MToJK5FH1mORdly8QcYiIkF3OO35Zk4kHvIMPIG/UDH/0nwzNNjU/13IN2z+J+fJYbDw5ZZe+
 htDLDqgPXgtIJPvKGdOqYEfpef6ko/SeePkWj4KLksZD/Z+BSIx27+kL1LBlskOFULWw6DEBM
 54T3Ut5L0vU+WTubDQUtjqg50bSZyLxUQAkbkJl8sKZw0q3PrEddICEFhz7C0+CNltNdcVSpt
 Nf717+kb6FTdGNhxMdoptrz2Z0A0y3jWeYiJB7zfnCFO90jwn0PPhGUhJTMAW0f7p4WWEu2Rj
 a7PZ3/MPGWZO0oi9H
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 4 Apr 2020 15:50:10 +0200
Subject: [PATCH] ARM: pxa: ssp: Delete an error message in pxa_ssp_probe()

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/plat-pxa/ssp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 563440315acd..9e77b3392c1e 100644
=2D-- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -146,10 +146,8 @@ static int pxa_ssp_probe(struct platform_device *pdev=
)
 	}

 	ssp->irq =3D platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (ssp->irq < 0)
 		return -ENODEV;
-	}

 	if (dev->of_node) {
 		const struct of_device_id *id =3D
=2D-
2.26.0

