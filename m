Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009CC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E639920720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="opUbTulR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBGLIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:08:23 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:16773 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgBGLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:08:22 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 06:08:21 EST
IronPort-SDR: SY5hAT5za79qQlKTdG/SZDoLhaEaHgGZWN0RxJE8fyzRi9HqB5YjLX5/ZsKHyHxF8S4PAsLLlX
 mFqDwuiUF8h037OTecDBuO/W60IrLxMEL/VlH0HJGO3NFqrsqEYSehXDqzsJHyGGuKu4STshlU
 w3Q5HCs0V77UMBlIQmvLC5VclAW8zMxen3ibpQT5JMthPI6X/GL6ODaeJPXfltOh3WmTZO3ZMh
 sF2jy6XrCbk694eKaPI9qCvD/pmZse2/VhLHj+0HgLktxX2pNRqwp7rQIsmqhznolLfSQ1QuBO
 +/w=
X-IronPort-AV: E=McAfee;i="6000,8403,9523"; a="18137640"
X-IronPort-AV: E=Sophos;i="5.70,413,1574089200"; 
   d="scan'208";a="18137640"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 20:01:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD2+sxpi4XNpI6YdprZ4dKlxomeSZf0tEbtsxlXRqRHraOyywtNlBFw8qoNhKEMA8lbJmad/9jcJsKs6skLuCUwakqyFFWk1/7GE6rR5eoAxvhzEdzN3usK6L0bFwhepN9IfncH3NZnfZmv/roYnl7jhGkh554wpDE9K4Rd27VUK/iNOEeOmFgeMjfCmeqLFnDhBT1pOz6xt/1pyA5C9h7YfO/3t3quBSAZV+QPrprJvl6mnetHXE7N5yInJZyu3XjmrS/hr/mGwjawDh6Xl475mQAO+dIXsEA/D+P6nKdwOhJDVZXQCuiIZnlV7FHzc+usa7nARYQKVQ2I2p88Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPLfde6zdjHfElXPu7jIY7ob0bBojcOOzSt5YAU8Xk0=;
 b=kMcqpz+7KMnMC7oTp0M6aA4Q868KrXcJrQGYXy/Cm1pgnNSMn0IS0QQcn9tjzKIaFVD5j2TEptcagLasZDbb80CHJWU+9P7EJpof54Xjnydd1V6jXNO9q8bLxOu/D/Fbp9VAbWZw9I59uDzzAIprsIYvN1lpFnQH151gTuhTW1C3mxuvkj0QstNqfHBYlhWkjiHPmdI+TsL9tqu2SzjvbDMKet8JQ5BdRFWU8I9mCA3isR58mOqrrbsg2NFl2yolOetybqayyG1xx1J30/kYxW0iAzqvkzr8m9/HE3cz0y5xphdf/I3FGOjtPDl8KYG9/3i9cX2qvSAUXHfb5BrmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPLfde6zdjHfElXPu7jIY7ob0bBojcOOzSt5YAU8Xk0=;
 b=opUbTulRgu094QUUtoCPCfb3s1E6d4ieAv97Rmnj2VYnnOLZgbF4IDvxv008AAIS5AxvhzaxFs1pcy728NBIcfu8dljBVZa/msoPLkavVL9nhZqaccck1oy7Xyol/UUzDZ8WTly7z0rRRfyMgC31Kj3/v3lwAR0Yzium/pWA/a0=
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com (20.178.98.151) by
 OSBPR01MB2472.jpnprd01.prod.outlook.com (52.134.251.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 11:01:07 +0000
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::1c51:734d:bcc3:8626]) by OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::1c51:734d:bcc3:8626%5]) with mapi id 15.20.2707.020; Fri, 7 Feb 2020
 11:01:07 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     "'corbet@lwn.net'" <corbet@lwn.net>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: admin-guide: Add description of %c corename format
Thread-Topic: [PATCH] docs: admin-guide: Add description of %c corename format
Thread-Index: AdXdpXEjPYYAtxVET9OBtFqSQhkV0A==
Date:   Fri, 7 Feb 2020 11:01:07 +0000
Message-ID: <OSBPR01MB4006A82736539529EDC8EB37951C0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=d.hatayama@fujitsu.com; 
x-originating-ip: [210.170.118.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b992a750-feb3-41ce-3aa7-08d7abbd089b
x-ms-traffictypediagnostic: OSBPR01MB2472:
x-microsoft-antispam-prvs: <OSBPR01MB2472C31493E312D4CF61306A951C0@OSBPR01MB2472.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(55016002)(76116006)(9686003)(8676002)(66946007)(85182001)(81156014)(81166006)(71200400001)(86362001)(8936002)(186003)(478600001)(110136005)(26005)(6506007)(316002)(5660300002)(64756008)(33656002)(52536014)(2906002)(66446008)(66556008)(66476007)(7696005)(4744005)(777600001)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB2472;H:OSBPR01MB4006.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TT4F94AN7hTeUhPwZ3MqbqFTcFX8EkkZp79F04n/dJnZvjbQnPUiTW9nnq22hAMj1+6cnR4teaYbNdPiNHROoh/FxIT1YE8wHN1OVVjhPxrfba0pr+ggBmuiSTM0513q/M5F+TrYJ83aPG7ReVkLTEOs2YnNTJUQn+lSwsBVLpcCh75W6vAd3MjLvjnlHkVRKcYtEisEk2SzKLrocFORbaD0lTPkbnZuB4400XxzVTOMe6CQVu/HdfFAS47E8UfA/5n2LmlAPZ2i/SrTUNwI1aSjQZNPPssdeey70jMEtTK2Rg7he7ZewEW4nfd1zTc20LHP4D9pJ9nGXKJdgvrSkxAE4eoYQkEvzuEDelqC2KyibYYwHfus2CPIosHxvvpHafkm61f7Gtg23vCpBLurdo7V5MSXgt4BtqymqRcy2KzcKjnLZ8t04sd2X/9Aw1lAR/UQGR3xfPKd0PS+BHaTI7qnDSkAxJldCu92MXCSZdrkVCAAx/P8BN8jV9Jatga4
x-ms-exchange-antispam-messagedata: d6BmxvagUyuVm+B7h2KgjGZJfyrlErE2qIaszZwBXuWlL0z/t6JwWTBlm4KwIgs95FN3OqsuzyfYI84NnpwsCzzTRm+uIOgqBP8SvNOnkqKaJSBHFlSAxabksr1ElWCCSs3ferE8iEuDYhRIIZ003Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b992a750-feb3-41ce-3aa7-08d7abbd089b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 11:01:07.6854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLIJsOLvLzXLgBGOJ8+qECIPVeAqa9qxwhG6LhgGkogFO4664vx7NjcLqOFSOLyR6DkRW40+nfpxPbWAmExp0RJneHc7rLMmTDhLuCzV6l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2472
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

