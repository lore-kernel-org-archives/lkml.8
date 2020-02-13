Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E74C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590072173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="Jwdmpirn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgBMCv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:51:57 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:35808 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbgBMCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:51:56 -0500
IronPort-SDR: 4A3tzvnQZtKv2Qs2TJAY4mA771AaDVXBib9tY19gFFam/flp19m7sjCEQVuZgc/1RqRaqTUKFM
 ntchfxeBQdgxdJNczVlHrZG52lEVpOjoWRfiLaSBBdoOmd1IOTtyrMapxlDYFl08jNXPhBAgqG
 rjNKchZygXP7OTQeQaSsW4Zl8AvYLN4LsAOpJf1ITfBWFL+i5+5lqbtGZWGjFYgx5dPWLtL328
 YXMDii3fbBK/QOQ9bYiudhtiGj3DfXRT2CCf0QjXy7OEXgIoFLgpLSH9VgAIyHqAWxAp9y/ilI
 r7c=
X-IronPort-AV: E=McAfee;i="6000,8403,9529"; a="18366123"
X-IronPort-AV: E=Sophos;i="5.70,434,1574089200"; 
   d="scan'208";a="18366123"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 11:51:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyh/fNbaBuiP6H41DCFigu8XdBk9eAD0SdV8KQ1B7K0BCM8mCJAkDTvMSnIWdfoOzrsB6hWKjwrQwbeVf/TSLkqsyhB9DVxP1dIskBnG6ZnTlfTrFmT4Q/J8KMMmyTwjfkAVC6cOqWv/+/MDmcCnFSxbkwo7TkUfdlpOJZNFOlQm/rNBDMQEURQf6nIR23XiNKKg0Ve4W35gcs2dW/NEzlxzF3FLawE+77nSzsg75sTKQ8eq7tsFCuAlAiIpT1NxnFykFzgZ5+ArNMayr+zMcpF58FmjHnl/lGfkzthELF7fYGZgZBVcSHiB6BaQKHq/PiUqgcIhwvZhahOazHGU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPLfde6zdjHfElXPu7jIY7ob0bBojcOOzSt5YAU8Xk0=;
 b=b88suOSv+THm4NKLCdguc3EyQuWYkztrz+VFoDaoMCtMzKncnNdiTGwoWu3b12cVmpLcOO+BThN6uz2HF4434ITl4+T4gJygzLZUD8CrUoiEAkkKsRf73jAVaCygbpD+rLa/i9qkAKjomCJSUkvGDDepXnHWBcnlGMR50O9LUYRLYedKZG5Q7zbk0r4iNn20YTWoo+7Tg+r1lic1ADvCnUAD4bs33NMAqT5vaI4cW5IjGa7sa1EBuJ/gbDAqGdwOfe6IxPymp/jykEwbzs2FzD39LehqYJ9ZU8y9JgA/PyVVdtjB/Ilu1ezRKQhibOTRmVOEfjIsn7gvry7MMuoZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPLfde6zdjHfElXPu7jIY7ob0bBojcOOzSt5YAU8Xk0=;
 b=JwdmpirnsF4Bfs78k53pF3inh9Igrr8BX2w6qA5NE5PM6eNTh1ywFq3Gr8bvz14D6BCHLvV5CmdKKo03mP46ZEq43IYCYkqfgwyWzR1guqB8IDOXWs+8EiokZqvt19vmS86lvNpLfudVFIYczVvbjQ8FjgVZfM4S4+COA0rRRow=
Received: from TYAPR01MB4014.jpnprd01.prod.outlook.com (20.178.136.213) by
 TYAPR01MB3182.jpnprd01.prod.outlook.com (20.177.102.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 02:51:49 +0000
Received: from TYAPR01MB4014.jpnprd01.prod.outlook.com
 ([fe80::cdda:fb4d:b21d:7216]) by TYAPR01MB4014.jpnprd01.prod.outlook.com
 ([fe80::cdda:fb4d:b21d:7216%5]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 02:51:50 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     "'corbet@lwn.net'" <corbet@lwn.net>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] docs: admin-guide: Add description of %c corename
 format
Thread-Topic: [PATCH RESEND] docs: admin-guide: Add description of %c corename
 format
Thread-Index: AdXiGH++86q2vg0NSRSBub98IzcQqg==
Date:   Thu, 13 Feb 2020 02:51:49 +0000
Message-ID: <TYAPR01MB4014714BB2ACE425BB6EC6B7951A0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=d.hatayama@fujitsu.com; 
x-originating-ip: [210.170.118.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c02d35f6-e33a-4c0a-f332-08d7b02fac7c
x-ms-traffictypediagnostic: TYAPR01MB3182:
x-microsoft-antispam-prvs: <TYAPR01MB31825A4BAE37302FD154A299951A0@TYAPR01MB3182.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(110136005)(2906002)(71200400001)(316002)(8936002)(33656002)(478600001)(26005)(81166006)(8676002)(5660300002)(7696005)(86362001)(66556008)(66946007)(64756008)(55016002)(186003)(85182001)(66446008)(81156014)(9686003)(6506007)(66476007)(4744005)(52536014)(76116006)(777600001)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:TYAPR01MB3182;H:TYAPR01MB4014.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4TOCNbaXpyhm15HP7xkkZE1S/d7NCOP5P3UoPYlBRCDPadDwLqiQwOQVQE85J3YpltEpgZ2u0F5fGIeI8roTtE1AzDjDi63SO9E2zJxKY6ZeXGBwx6XROxVIIiMD2sPOEK6zB5Wmj9Pj1QdWDpEEc/cVi8Wb7XyqSDc2NuwOOU1ut24URiHLlZ38l+pjYe2FFXRhu8IgBpBEUS4OpdoAW3H2TSeeIDWyqjhvSOBK7ZMfDZqRvTgNJxez/4ktN/PtzdLKQCJqox0DVwA+/7qxnFaZxgDkZrpwxZfTsb6zNaG9SUbQ2G9dCrVwqbO66S1zRuqGAI8PsycD/IHo37rQjZU3/3O7qzKC6tHUUk04oBy1mG1CUdjP2dGn69RlbgqcOWgWQ+WM6xAg9Ih10zxMBhzkVfKXm+TXQhaRyHzNZ/EZJwZ1C76RmqW3nv/7wZlJ3zs1Ujjo9/2gSzjAQ4gVFuFuUA06bvCVgg8og5jRyBKnNXY/+IadYS/crsvYtvF5
x-ms-exchange-antispam-messagedata: 9nGFFrKKthKvk+/xOZjo20FMocI1itCfjB6Sod9WNcwjiJWXHOy2rbNrs5tq8JHaLSfYVEhwsSDeM1WiCcnUSrRdzTjOUCjOxKu9mxXtXm8Q6WawOhRzTlaaAnBDKoR5v7wolQXzHaiS39iOQ2WWjg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d35f6-e33a-4c0a-f332-08d7b02fac7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 02:51:49.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7NjocTpdFcgym4vffayDdnpDkN/IX3jAO3mlv9bKuDJ6UhmZpCgUgMg95vYleL8OzviYfJy8oOtScetK6Xl2z0FFnSqjbKnK0DovBH1tMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is somehow no description of %c corename format specifier for
/proc/sys/kernel/core_pattern. The %c corename format specifier is
used by user-space application such as systemd-coredump, so it should
be documented.

To find where %c is handled in the kernel source code, look at
function format_corename() in fs/coredump.c.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index def0748..4557907 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -213,6 +213,7 @@ core_pattern is used to specify a core dumpfile pattern=
 name.
        %h      hostname
        %e      executable filename (may be shortened)
        %E      executable path
+       %c      maximum size of core file by resource limit RLIMIT_CORE
        %<OTHER> both are dropped

 * If the first character of the pattern is a '|', the kernel will treat
--
1.8.3.1

