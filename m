Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB6D217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgCBPnJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:43:09 -0500
Received: from mail-oln040092253078.outbound.protection.outlook.com ([40.92.253.78]:55005
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727608AbgCBPnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:43:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3IhocMVoZ8YdTenqivjpjDVBw0NmVuA4zZJOg/6B8rGjnNwVxMTFcdj2sBp2pamaR0kcuAkooZcQBWZ/HHVJP839DldYId+TforQp8xqq6/mVh7ksTEv2jj+8EVNPm+6wE5pDzZxvwlcqGtULACGY3yw6ZT6NLEbeEQs/UtwNvliKPNu7zYfGyYea/KhFkTlUdweXHVt5l1qwonqZsVETdWeA7M9g6+cyX5xsrBkAkh3mp8+x1/5GbCI1LJsLOCxCV0o9MXT/hvaJf7Nqwgb5uHarNOIXD8jBh/PBei6xrZVoKQM1SWhv1YiaRM/ZvmtR+UxRex6Rddc1+UFcGE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9qVlhsyDKCq9mjIeijB3fDgvsCLVXHxhbpLdE57J9Y=;
 b=ku3GlGASsjzkyP/4DJaQekhEQvSd54/E7ZC1jLb1zvjSaX/GgB+3zxU7c59ei2NlgK50NFprX99mixGo5Ed39/ZOF7XTQlWvFPX+7YLBZEE+8zdsdw29UAHMUrnZ20fAitbby0ewas+m8wA1vTEXG/xNxt/fyfnTmkKBk8oNefNxaflVsfW2Ciuzgq9pu7PlLr2sXiTKnFH4ZyAQUAMExgKEHzKvJ3Q6pVygSAcaPBaYsSf8RW0q7y3o+5ZrXwJETxDWpB9IyAL6DEl0YydixfDmz4Qxwcky7biBiN/gpXpYIAEz0Z93fF8M4BjwFEimn4fy18CTAgMjOCmLW1dhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::35) by
 PU1APC01HT012.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::85)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 15:43:02 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:43:02 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 15:43:02 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:44cc:a624:8145:fa79) by ME2PR01CA0060.ausprd01.prod.outlook.com (2603:10c6:201:2b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 15:43:01 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 2/3] nvmem: check for NULL reg_read and reg_write before
 dereferencing
Thread-Topic: [PATCH v2 2/3] nvmem: check for NULL reg_read and reg_write
 before dereferencing
Thread-Index: AQHV8KlCqOzxWYRvokel+qEls5/4vw==
Date:   Mon, 2 Mar 2020 15:43:02 +0000
Message-ID: <PSXP216MB0438A1EEBF56DF852F18F14580E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0060.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::24) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:FD4BB06BD94C428BD5E7BC1EA9D663B71EF8BC335086E27AE3F99DA966EFD05C;UpperCasedChecksum:4109A4679E310BC9E2731DB7B87A24745EE3297D280C8578D681656E2076BC8D;SizeAsReceived:7849;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [OSAjFprNiLGj1wgwmfSBnc9rCXGYlsR9phDwiLtY2T+Q8q0Xj460IGB40bCNlA6N]
x-microsoft-original-message-id: <20200302154255.GA480989@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 7577f359-ea81-4d88-ec16-08d7bec06475
x-ms-exchange-slblob-mailprops: gjx25WM8ZNWYKaTQvYk/UtONeFal8oaUmDy8yat1o2nH675ykozxvOx5x1cairscCok630zng6YjFn9EaBVhK3kEJ9JdBCK8gOvs2OYVbowxzPkq41TLB4fQM3O9BkkC5g5VsZknLhmyQ4Yy3f96UXXbz3/XYShHWpeJDjx2EvkYtn4TUzLylTNJ97UTuDBD2LEDFgcT5QmjZq7nmS4mxUjVU2DoV6Kc30T0b764NNqnX4dZCkgQNnybw4ro/b672mII9yBuvmavjdvZcBc5UAn/lnr2bBky5gnc6Zsg0vDKQqzygjCI33lyHoAL88FGLhugoZRu/zNJGPeEs8hbEU0oJmGgw7V68ctjGSeQpnW/eEP2cnINzADubEcrZo2Rj6Idz+q3GnIR/jpa8UbyiFcOfi/3czCTUTjz97xWX8vnTRndqex5Q4JNqDp1rDt4TfSHzPo/HsBe7eGinxYNA5jMewW7CLGzwpQN9E0hYe1zbm09g96dJkGP6XWZYdoX7RYw5WoUDaJEutw8pS2Ct1fxU2OOV8foyxBgKX83k/qXZtYqCvS18ORYaljUj1WLE++9dSsMrBR5kx3AhxS3abla79oDuT3fvy8NEzTDHj9HvPv+pfni79CrK98L2DsO+4pkXZ+qAfI3glxKz7FNVFOKdGMeFhvG1NZAx0epebS4oyf5gQvCnqYD1eaIXziGO5gKfdokXKVLGjbA1DrTJXjcVpQG83N9YmQcjl1jbRw=
x-ms-traffictypediagnostic: PU1APC01HT012:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8NnWKKqq3fXwvWIfcNrmx9Z8tu0GKkBVUrGsH3WpubKayn7fA2+O6MdNX8dAoojBNQlML4NMldUBeXTIDQuCmvZ9xDGJKe9MCRAqd9snSNGTK/LgnvObuozCtpLpzGr+2Zcs5jsiiUlWzK/xdTw+rfFtF3+PbckEsQKS1idlROZrEHp8lDzkny2f+V+6IJZd
x-ms-exchange-antispam-messagedata: CJudsI5TVs1hnpXa/R54lvNntkNJ49ed/F8Z5dwqgU+gBF0LKaMBBTY4v5HBzMKlmncbjGNF0FW9xvhJILPkYP2BVd4Ffigr3SJp5CN4rV6DPf/cwY5bBUD6WyLUJc8CbOR3f7bTmtijXYOA/obDVs1i9K1mMPmNbHKEs+F0lPIydo3YbVfyk8DI1Yg2qbJSe4jsLAPhNU9OnI1wP03SPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8AE9AD44D481C429663FB7FC8105A1C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7577f359-ea81-4d88-ec16-08d7bec06475
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 15:43:02.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EPERM if reg_read is NULL in bin_attr_nvmem_read() or if
reg_write is NULL in bin_attr_nvmem_write().

This prevents NULL dereferences such as the one described in
03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem file is
read")

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/nvmem/nvmem-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 00d3259ea..9312e1d6f 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -56,6 +56,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
+	if (!nvmem->reg_read)
+		return -EPERM;
+
 	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
 
 	if (rc)
@@ -90,6 +93,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
+	if (!nvmem->reg_write)
+		return -EPERM;
+
 	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
 
 	if (rc)
-- 
2.25.1

