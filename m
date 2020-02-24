Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BEC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33D02084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBXRnJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:43:09 -0500
Received: from mail-oln040092255027.outbound.protection.outlook.com ([40.92.255.27]:21548
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgBXRnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:43:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyaku0XpgUTcJEpJCxJzMxJONjujvjJRNDk+8fkNGxCOclXedFNjYYq2vrJR5k7u28Xs/QAf36lTCGWZ30T22i0KpdrBcWTxljery1QJElhe9FyDjgll21OfSA35OuJ+0apv62qDmn5JfW8L7l7Dh1dX8xQxnm47OJPCVJYEY5ZhgqlPEpIavuFD4s0qWZI0s1NzM8ECHrJcvrVTqkILXu2ahozGWSIFcAQAYoHHg82nVVNrqjxkwX+khZot++BKVy/Cg9/gzsCcWf6qYKeM7HbOxyEkqai/OGMi4JhfG57Fbkb8mYLYtOgweEPF2Qlwpw2jzAJt88SybkVI8XKRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoNt00Dz1U9txfezKwuPMxf8mH5OuLikz4Wyli3KKEg=;
 b=O7sKuFEQRDQPNBpXjvpqHUdt0W/1SWbhIwoUG8LW0ZZjjMUybZJA88dPBGJ+XuyE9fMYAwrQOia6RH4DWPSSYNuM+GT8IjXgs+uPLh7vPgqeI6urikM2HYy4C/eZfRkpnDS98qZnRz0wLlAnvREKq2VaK1A5RF34lLFDWJC99HBo6n53MXyCuQ8zlSFidn/9K949g8zQ2deRR2ejvS4LIfabzj0Ras8D/fc0EAzO9eldXzw/V9i4///P1rJY6utEqhfQXRsz7xZgyjq1rvuitsOP1e6wFke4fmx0m6Z+HmkL5QFiOwIbgKHWmBII5VoSIN8QZmzdFAmyA3/gJ1DfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT063.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::38) by
 SG2APC01HT106.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::366)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.19; Mon, 24 Feb
 2020 17:43:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT063.mail.protection.outlook.com (10.152.251.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:43:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:43:05 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0154.ausprd01.prod.outlook.com (2603:10c6:201:2f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:43:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 2/3] Revert "thunderbolt: Prevent crash if non-active NVMem
 file is read"
Thread-Topic: [PATCH v1 2/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Thread-Index: AQHV6zneI6K1RjwByk+TFt04XZDxaQ==
Date:   Mon, 24 Feb 2020 17:43:05 +0000
Message-ID: <PSXP216MB04383751C15C4D66B59335DA80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0154.ausprd01.prod.outlook.com
 (2603:10c6:201:2f::22) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:C3A4FCBDB387BF5357A5AD9FD670AED30365E44CE792280C9385701C1CE0A2C2;UpperCasedChecksum:7F5BC7A6A528A3A72598BC24787F2E29425BBEDC50A4315023B0334FA3302532;SizeAsReceived:7867;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [czyv/UOv685oq3ayHrxjKBeZJlpqr9KLY/8pdqvvRRPBsbEKQMNUvIQ4n9z8RyKt]
x-microsoft-original-message-id: <20200224174258.GA3710@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4b4e2e4b-8bbc-4235-6ddd-08d7b9510071
x-ms-exchange-slblob-mailprops: S/btQ8cKWiQ49J5BJCPnD1KCcv5sn3/T7P5RGvkzcojczoitXjjVIhuEtby89pX2e6zyTWADoMdox+F9jAsSwTg4WK7c+9NVBtjkRKi5rcrXDEogmbaekmTf8+y/n4epU8HQgFwooJ3ey5seFCowhOw3vGsGXg0TusxTRZ1UkK+UuMGDZgKqjoPYH71EZKeGUCO5IkakOKXoHPzezi6BPJtLn8bMvUQeJ3DW5jbsqxQxEmYTGzdvxuOqejHhw1Dil2sjNToRaOFRiFdlFkxIonHQGzQTu1WKIYGJJkrVPKfdRVSnUgIdyWDedTxUMmOsciRRTGH1gQ3tS3IA2QY+I1usNXBJBPVl8JfGC8VeTP9v7LcQHFlH5gDgOrLf33uukD8Q/Im6eWE9tptV/iXBoT+r3g8dPU8z8YnxV47P5LAgDMdE8yr58AXgLsiKFMZvKrPWdHFw04j6E83+6jzTltxRMpqGE+/LPl+dJny0N7UOwxRemUNhROowo8YPJF2n9zAoZrHmsbb4gm8qesLGNofBZgM9Q1TgjbJ1jHd/4dH2vs7TLrjxfSe9DDYgOyBByOjUC3adhDLDIpNunkOij1kp3Mym5pSVCELULndTt/dbuz8PVCRXfLkpScQGTI0HUhTHNh1Y4hmpuTusFPA59MhL9f2JCGtQ9c3EUZh20VWcUID/LoBsJ1Qet5ACLnhcz9j3XSephQoh3a9q1wx7xEODKwoycZ+d9gMhhmQHfd7UW6wY1anozDGr61ra1W1ZzKLMQWWfVGw=
x-ms-traffictypediagnostic: SG2APC01HT106:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Acc9ZsRnqRQ/PqxIO20IPcdVzlk1NldD+UZZnn9maa+N5ZYdR3DxT1eNmKcINqqe27XsToybxPrGQuGCH9C3XX+ztdkv0VN8/E5viQ/KVUgNJJNhGTwIdnqg6zZN0eQjsSkybxw9LMtQEoivInEkeKwoO8ll3ZgUUsTjimHMSUDxaPEkl4OlmkX/OQNS6Bbg
x-ms-exchange-antispam-messagedata: 2oS9UA//WLb3zucmreX6y7H4DlAfT4Q5vDsMxXlVl5m12y7gijpE9zRpb3SmRjbfI7jhT78TW2ZJ2zwk1UQMl4E/yGdL3/4iAlqyaXVUYrQoIcz7pQsyUpCSOVQQV6N1ZwySCfqsBgYjPkFH/5tBZwQT4uyRa2CXS5Q0vQGgWkF+BhlXZoJKCWhf0KWtZCBPNwSuF+0YinKILW40dzU3Rw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <452437A0162F9D46977E94FBDE64C95D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4e2e4b-8bbc-4235-6ddd-08d7b9510071
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 17:43:05.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.

Since commit cd76ed9e5913 ("nvmem: add support for write-only
instances"), this work around is no longer required, so drop it.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/thunderbolt/switch.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7d6ecc342..ad5479f21 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -348,12 +348,6 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 	return ret;
 }
 
-static int tb_switch_nvm_no_read(void *priv, unsigned int offset, void *val,
-				 size_t bytes)
-{
-	return -EPERM;
-}
-
 static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 			       size_t bytes)
 {
@@ -399,7 +393,6 @@ static struct nvmem_device *register_nvmem(struct tb_switch *sw, int id,
 		config.read_only = true;
 	} else {
 		config.name = "nvm_non_active";
-		config.reg_read = tb_switch_nvm_no_read;
 		config.reg_write = tb_switch_nvm_write;
 		config.root_only = true;
 	}
-- 
2.25.1

