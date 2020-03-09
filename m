Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91BBC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F8B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCIRt6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:49:58 -0400
Received: from mail-oln040092254056.outbound.protection.outlook.com ([40.92.254.56]:23040
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbgCIRt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+OtI8M0fnCcLFdmDTOL3Ggk1gbYlQpFfV1MSquHZCIe8kmo4ZEx7zcixMHXC4kHbK3Bye+wqsoY6KXtyyN11MDg4Kt9wxA6Pk7AGti7WcIY7b0aRI1Bt9/vsnlRrlk7+bZYeyfQcmvOacxvq5LsxhAcrgt0ZdvzEWxzz6RHbIvjcsO7//SNw2GzwpaZ52qpkeP2Qd4xGfLZcWv3Z9fE4IXgUBidEIfFOMh88ic3ACrzmkELmamzgsY/46FNjWqxpz/U4bWYwC0T9qHb79KcoSmsJV0zj8M92Gu0KtuozZpP/PplakDB1OUcUZX3B4Y8+3iDM6LCy7mPzJ3Iz3FmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iutEIA2SWY9qjSFAEzEvMfD6eznQADaQ6se7UaUz+Y=;
 b=TCEdiobspHYO4oW1h2uZqOrEb/1zQFgA5o6hCMHc9JD6CGU6wBBz8FDWT4Ypl6mOk3lE5rTJ24H6QcYiITRp6M83EQnsYuPgkms3N16XUDo1BcJwEhOTtH3+OGwXZcS6n3EJu7Ctl/I6Cd4d2rp1n/KjlzClIzG5arYUBqVqNa8GUaCEErOAQPjzYP5nLLnS3bDPlh65dbS7wU7oHA4/fvfK07umJ1/OOyHX/nE3ia08KiAdiWyhBQrqrNm6UGSdSRA3Chr7bsKYwCfT0tK29dSJ8L2BppmVNZTf7CzRSyZjm3zJk5DMNRNNFusi2PTKdZB9NicRHzEFgxhdlWu3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT045.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::35) by
 HK2APC01HT091.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::379)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Mon, 9 Mar
 2020 17:49:52 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.57) by
 HK2APC01FT045.mail.protection.outlook.com (10.152.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 17:49:52 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:49:52 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by MEAPR01CA0032.ausprd01.prod.outlook.com (2603:10c6:201::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Mon, 9 Mar 2020 17:49:51 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 1/2] nvmem: Allow nvmem_sysfs_get_groups() to return NULL
 as error condition
Thread-Topic: [PATCH v3 1/2] nvmem: Allow nvmem_sysfs_get_groups() to return
 NULL as error condition
Thread-Index: AQHV9jsj8o3VFlywT02UbSkoUp45/A==
Date:   Mon, 9 Mar 2020 17:49:52 +0000
Message-ID: <PSXP216MB0438C66F372D62AA71CFC04780FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438614877E3559E155F12AF80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0032.ausprd01.prod.outlook.com (2603:10c6:201::20)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:3AA3CE1CC099A4D5B15BB63FE897F630A7724CD6155072005AF32DDFC092F068;UpperCasedChecksum:9EB03BE795E6A610D5ED13C7E6661AB30F639AEB5D31EFD90F3D80258FD197C1;SizeAsReceived:7837;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [zP37+PrW3U/hZ0t+MBqtQp5vpfIaL8pCT/wWHLkgYdKQeGMSw/hWe6qhJXHgOmy1]
x-microsoft-original-message-id: <20200309174945.GA1881@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 029a42a4-ed55-40bb-a6ae-08d7c452454e
x-ms-exchange-slblob-mailprops: S/btQ8cKWiQcfd3+6+hrRLHB6wUZWCdy+2NlzUCMlrpueOscZp7XNhLmZAGGatzZvn7+JRfjNZKYx3z7DbNVa7Or/9Wh9XGu79AgE8JPDXJ5JMafRmjwlPTJ8B14sn6EUJchR0oQp4/YlctF2QNChpzDKv6KLt0WloWG34kKU51nWnn1s6XER8jUEFuWZZzZAyWdMm/7QhPg63CeQp6267azoLRffmpXF3FNF2Tn1OHzJsIzDF/pr5PPEwNVunsTp7y1y8/HeDvYeeQ3rlUelWTQ7dP83jiXnIRGfBJxS14y68em+DXnR8+7NesC7o7N/z62+BgldAedVB1ik9jp0s1iOGEw6wcVYtm5BOp4UX2qXMcT5uitbrFQrH56Pn4uli9gMumh0IQfAt5sbXLeH9UWChI7+gwW5TzDFIPBVUaE85a3oQ/eCRtv3egYzXj//dt5iLDAx/B7s36HYZuX0TIFc7sHIFIvKzrP7uqdbs8C9X7D3EoQRGzFC8Ak+mI92lC1oF5f0fqMlHHHitbpY4q+S8GOqwO2hZirYhLQcITzYA+hN3NFdPZ9rYAXzUDBhZVyBl/J5WJlpqntouVWjzZEo72rhqZYYdpS8PKnIbqjZhNvwA/mCTDGz8nZTONJ1YLntjoZWnAd2qf+0Wc54+4ibblmFtU7CSIRFxQ90cvAKQIyGYV51mnxVFRj1aMgsjL5f2QAdgGyZuW8SYGYE2DJmTnXx9FD5Gqkw1JUfx6tIhEkBsS7eB/8dZS+3M+AbumCIT9pNWY=
x-ms-traffictypediagnostic: HK2APC01HT091:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7yjCJATiZpG7Dkc5ePjy4ST/Mz7qaQs7c/IFA6HzL0Yp2mu+IGuHeKiw+f4rtcPTvuiYLneYELiW+XbVLArFzZv/Bvj0+Xt3KoEhmf5kwCJGJ+UIHFJ04L/kjvbZKrnr81xGjfdah/EAhJ5YnbLA1fCjMbLWfxhRioJwnl0gzBrB7G5eyFc42fYqhM0600Y
x-ms-exchange-antispam-messagedata: wLM/CIKrwMcXmnbKU+o5TuvQY4OefHMj6LD8J1/iIMggQID2P9++1VHzpUaYtZTFwACVdHSeftu3lRP0fsl2ZSEz8wShlGKr6V2/kh2zemWayQIJZHu+1UoBYapn3pImLAeEHjhNIeIv4qF3hU1R8u+5kDRyDDufdth2Y8T0d26lf0CAuEsSYCaBVzidm46Sq1D7pLyviHyA4Mb1mvm/Cg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1348AA52AFA20946A10A539F224DAB1C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 029a42a4-ed55-40bb-a6ae-08d7c452454e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 17:49:52.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nvmem_register() does not check for NULL return from
nvmem_sysfs_get_groups(), and hence nvmem_sysfs_get_groups() has to
always return a valid group, even if it is given invalid inputs.

Add check in nvmem_register() to return an error if NULL group is given.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/nvmem/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243..f6cd8a56a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -388,6 +388,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			   config->read_only || !nvmem->reg_write;
 
 	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
+	if (!nvmem->dev.groups) {
+		kfree(nvmem);
+		return ERR_PTR(-EPERM);
+	}
 
 	device_initialize(&nvmem->dev);
 
-- 
2.25.1

