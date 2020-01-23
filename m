Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB24C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D586F21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gb6MZiJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAWPrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:47:25 -0500
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:11032
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgAWPrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:47:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0/DFInD46MWXeBbLGz+eJkzXyw3QLM8uOZjcQ4SMqFQNDkf2ikugFz4nXekyQzXT38f783NJ5DPcNGJSf47P+gmyexDbcBGLVKUXdTSx5laFWlmCLENm+K6zl4smGsoHKaLZDGqTMJMpziLQW6LPkHgzQ0pE8C//9LKYZXxGK8xzLzkosIL04Y9ZXn6hJfwYZRq8HW3cpuTZrxSbAaXb8teZRU5rDt2snXT8JMFzuErJgriZs3gJkyjIrmmJtFuELmtJorGZu1H4/BCo/7NJB1WeDZqMwgu+RcoIoqB5I+C5iELOhe6TGeiFHPlWG5aLNOq5xcexKqAsKLH1kgm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/r3WI9DB1p4944UQX3PPrtWdqhM99swilJX9QaqZpk=;
 b=Wk6Gp/eOZ4YrpfAJ1vrD1D91EME1LWeBNzngWSJRthFSXfvkK3qjWE1aShNaZNkoW3vnYIrLyW17DLm+0hS9H4urSTmccmkTmvWUuVqEK8VIBsDeyLRQvetl6jzGWaL/yP9c+SC2TFMlr2DEXe5NL9HvZEJv2oV0DVNJrcjAHAqTFmgCkgtHrJrxdV4ZqgVpAOilU/rZT7tBaLaICkovStErI/kY0dvSzBd0WxbIkdR94DFRM1znyWpENZyLPms3+r/q8nIkYxGzATE1y2+A1FXIk4p3cXQaXTuah3I+jtY+4FEqnZW1iTwTc2u04YvcT+RA2iEBUYr0xPZD5CaLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/r3WI9DB1p4944UQX3PPrtWdqhM99swilJX9QaqZpk=;
 b=Gb6MZiJjxI6bUEwRQPzePRCKzmkfVjg2jYtX42gjKFDtFFkF2pih+qxQlM3bQSt+RCR5YthmIjsicBk+avIkH+FQ/2IMjJNOjBbTDz6OceMJtGW0ZWLCVPFU28pL/HzGs2PIz8Dqk/WyUOzvPHutbO3qQVNPPY3oa6f33mDF8Ak=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB2942.eurprd04.prod.outlook.com (10.175.23.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 15:47:22 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 15:47:21 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM0PR0102CA0024.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 15:47:19 +0000
From:   "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "ztuowen@gmail.com" <ztuowen@gmail.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] lib: devres: Export devm_ioremap_resource_wc
Thread-Topic: [PATCH] lib: devres: Export devm_ioremap_resource_wc
Thread-Index: AQHV0gRljAGUSxVBdUWb9RVfR4pSLw==
Date:   Thu, 23 Jan 2020 15:47:21 +0000
Message-ID: <20200123154706.5831-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::37) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fe3c3f0-b577-4889-3768-08d7a01b8843
x-ms-traffictypediagnostic: VI1PR0402MB2942:|VI1PR0402MB2942:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2942B55F652257F632DD1FF1B80F0@VI1PR0402MB2942.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(189003)(199004)(66946007)(81166006)(81156014)(1076003)(8936002)(6486002)(86362001)(6916009)(6512007)(8676002)(956004)(2616005)(66446008)(64756008)(66556008)(66476007)(6666004)(71200400001)(186003)(54906003)(2906002)(4326008)(26005)(16526019)(478600001)(6506007)(316002)(5660300002)(4744005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2942;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mx7oogtSTXNYUmS56DfP5vE8b5xL434TEFE86l8tn4h7g2E38EXXhAmXHCrtI0BC06kVPVgTNFlXJbD+YtaUK0hCQbMJUUpF15oQxaF6AUvol9BeQwyHUGmp0JZlmI+ENNJWYO4rViY/ZM7kmPwc4H3NIWkgHo/oMv4iXrpnhvmyb7USSKMqFMFi4Jh/zIYn9WDayoEzeGXT9Q/lIr78/feEArzW6IslxgwDn3v6PuiySM5RBdXcqobGAGjmzpMF7k2QM7hQajGway8SMaD0lASpeTKNBNAUTINIAh4IethqkVsaLIvClqVthrkzmIwseVAqi7d6duD3NK6uCx+tputhP7bA/aWjLsO4cmdia4MHji/utAL+cQ2WRTUJLaPdWH4nf6sWs1qeX8feROtNZ+O/e+weMOXG6bBvLpVrIz5iv6Elm691uJa26KmjE/Yi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe3c3f0-b577-4889-3768-08d7a01b8843
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 15:47:21.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOFJhh90smhNKZw4mGA04Jd2r3LBhM3X/zlc5dPu4KPzHsGQUhLgehcf8h+PWOVYadF2dQDdFeHinLHLNv5R5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

So that modules can also use it.

Fixes: b873af620e58863b ("lib: devres: provide devm_ioremap_resource_wc()")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 lib/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/devres.c b/lib/devres.c
index 6ef51f159c54..7fe2bd75dfa3 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -182,6 +182,7 @@ void __iomem *devm_ioremap_resource_wc(struct device *d=
ev,
 {
 	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
 }
+EXPORT_SYMBOL(devm_ioremap_resource_wc);
=20
 /*
  * devm_of_iomap - Requests a resource and maps the memory mapped IO
--=20
2.17.1

