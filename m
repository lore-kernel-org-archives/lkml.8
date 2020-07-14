Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6510223FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="pZ31k9Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGNPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:18:47 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:11653
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgGNPSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFQAwM0FXiwF0tPqDEQGgRQrADQerglzDePNAdlouSFQmzwq2K6fIzUgNqy4Y55HHe3Pbgcu+L8S5t5x2QQRPgjcWjU8LKnZR1Oeh7R5FdWfNjta0/PhykIa3u3tKzBcELHBrcMPB39uYltCVm2gIVqrPSbqKErD08++0O0GcaUjBwRPCCWKd5wjhWblqq4vT5u4rX76S8/FbNdaxYfQNbmDOuERkMUnDjdnIzTqx3xRzhiGfw4cAvzr7OQWx/w7MZeFRSgridV/1dW0JLsnGeRjbESFXqxDkoCg+xnd1kGUAmPPRai70996jv6kJVgN27AxpnBIRjdlk0EuvIOA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BChI7i2E2ULDFrKu7M5Fj8dVzUlBDS4yziyfaBaHB/g=;
 b=GiFNdAkJzyHnRtY0nxoHoJLrjGBx7jNpINY74fz84ebrxf0dL6AgTyLjBONLMnxFypbbQNp0c54DNkbHwKouulRtlHnIH8f6nDPRJL/JdmXDL04gK4ccfg6hKK1rYliFmexSlm4i0sl7DBGDGc5FMqo+62tdgda8zKbRY+l65t/5fQ+B69chpu+NuseKCZ3phyhw0alJVtP7wNygDgRUrBYqatxI46cJER+amDCmtg2GdUFH+WHjzF2ncFgO1EBGfkOBNfmtTgr/xmT1ZDE8sKTlgvCqBSHFRVpcwW26QHks/5RCwXn11B62DXP0RJSMXH81kjAnhu8YakLsN5o2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BChI7i2E2ULDFrKu7M5Fj8dVzUlBDS4yziyfaBaHB/g=;
 b=pZ31k9KiwNwyB1BEZMdWHzlVYXtwUanIUdWUMxkC8qQ8BNF7+b11IQq9arPiYWP4r/1Sirr7RpCZzQ1WKGOPCkFbHEI5cZNrYYDGEqpOtthcUtyXY+TKnh5JuS5cV11ERzi9cYMRGcrxKSHBiNL9hNnN4susImPzEFa82nKgnZU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5174.eurprd05.prod.outlook.com (2603:10a6:20b:66::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Tue, 14 Jul
 2020 15:18:37 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 15:18:37 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: usb: ci-hdrc-usb2: add property disable-runtime-pm
Date:   Tue, 14 Jul 2020 17:18:20 +0200
Message-Id: <20200714151822.250783-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::6) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 15:18:36 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bceea4ca-1589-4e6b-0f34-08d828092e74
X-MS-TrafficTypeDiagnostic: AM6PR05MB5174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB51740AE7EE7600D18F02CCE8F4610@AM6PR05MB5174.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoicR8jOnqhZcvvOgLdUqd/CaonSz+UiRg/seCojW2lTiScRNZISlVEcdSC0nGPfceS0j0jE+duuTagZD7j/Pm2TBu8YCVtaHpLeWhriUt64IXE9CZLH1cSQ9PFmCip0m7DyA7qMTQZtUNEjyFXE2qNs85C2pKSGwslxHbmSp1r0WxQUbwfxGSaY7bTuXhyuYQvkHZNAEufzZ9whbT/B80bOJIKavlDO+yOc0DbY3cBpBDGr8bCdm63i2mVnhab9FNXX7s8z5FhsttbFmeUM4drjnJEPXjTFElvCeA7lX/4H77w38IWm2xyvy+8M+ff+lhP6oW99kdvWd+rqxXaBUb3KlVOmMQ8QM9FLoPoUhzhOtvSjtJJE8YPQpzo+sEEk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(110136005)(86362001)(4326008)(5660300002)(83380400001)(8676002)(6666004)(1076003)(6506007)(186003)(2906002)(6512007)(26005)(66556008)(6486002)(2616005)(956004)(36756003)(16526019)(66946007)(66476007)(52116002)(498600001)(8936002)(44832011)(54906003)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lNTcjaDZlp3OBwb/25eWin0Rf7JZmdp4bWgSOgB5mX94A7l0II0+21VFUgTlQ9FUrrbfusxZICQ3bY10zVaYzFnhNdzCvme1NknpkUNMlWE5qXp1Mz8ARCZxIlxPFNEkQyYkEAyvI05LOxDCLqq6KTuybT13wjpyVFuvOUYjTLyM2cR7xoNdQvMZQar8QR2gbamZi/b9wRK9WaFnYOk4BAYafmo3+O4YiV5QWVpxDz1Wdt+UbSh3kbBDqA3PmvdjcWkAftI1QvDaTx8ZICrQLTEPT9vcWs1/SYftX1Wr6ivb14eQOXAcIoniqtzEeLHyH+O5yVit0vwgKJnAobscscGbmlG9OyIDSQ+GIgGhmQgI+Agr0kf/PU4gJLb3nWxMGN5ycfguGBjTPkvOBVGwOBpNkDiujr76g0MW7O7wLisSPtxLsC+p+tMUGSVAHwtfLoz64nW6g8YWrZxhdpgjxgWE+HQO1s6rFrrQRu+pV+A=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bceea4ca-1589-4e6b-0f34-08d828092e74
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 15:18:37.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1VjModaoCXBkvaAlXumyDTfi4IPaX7ok7Q1PGNMlE0JLimX2Ock/O2SFrNgm0DEl03uNRzMp+32HQMRv0bIhRexGVxIAMZ261tsowPxJVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chipidea depends on some hardware signals to be there in order
for runtime-pm to work well. Add the possibility to disable runtime
power management that is necessary for certain boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 51376cbe5f3d..67a31df13e69 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -90,6 +90,7 @@ Optional properties:
   case, the "idle" state needs to pull down the data and strobe pin
   and the "active" state needs to pull up the strobe pin.
 - pinctrl-n: alternate pin modes
+- disable-runtime-pm: This disables the runtime power management.
 
 i.mx specific properties
 - fsl,usbmisc: phandler of non-core register device, with one
-- 
2.27.0

