Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7420748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="fRrKUGss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGJPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:49:49 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com ([40.107.20.108]:30784
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbgGJPts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhedyrS583iVXfEQVx1uHO5xcwMmIEPiLTA3iLknpbGV6rk/K0/Az9l91SdRIpLXNgnbRwLlMMbH/pBLVdA/1WsLvGTzSKTkvykqUTFM0WGHltd7fzP+ARveNC7y9CyFhlBOMj9QsuWNGMyCmIe1qQ6YI3tH80awYxfjKRUYlaLLG68gSTybJA8W/cJCeWceIVRfJ5sT7IqLCgNw9C8QJ2MbSqRPbUz/kt4rcBuZvv43MYxA50dvvPadsmcJ0DIT640J4LYOxuOd3dAHf9XTluyjTAwlpOl/fo2lZFgztkIgwGvcmvEYj/vtF6LB7m9Hexu7O//mhQM6ol1TKttZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntUudqTpdIV2P2ptD1MDuZY6tRQ5gZwq4AhJhQrFWKc=;
 b=IzlVzVeOT8DQ+9/qsVipkW4aIHRRYJiEZzJ2XQz5XBMtSRyW3NNrgkEi6DCGlsuCXz6EciJ3hdoIb/GRJRyHL7KciM1ow5e3Z4/fQKL2Xg58oJ3HRbJnVd6LbpFo9BWGMS+aJHGO1ahaGy/aFR/YGsU/KeaHrE5JXlZA1A2qjN585AKq2K0dwotudsQ1U2/KtYQf9dGtvT2D6WIctHVcN7ClX2t2vmDqzJygNxNXrfF8W8hZ/tUUbGw6OOEFjNYZW73a2xEZsCa2WfOyhZuQ3hwR/kdi1nJ+2feYkUkB1E07d04yV0lPKv9RDSZOeWZ9wQo3oSBXBePZ0w7TxoMgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntUudqTpdIV2P2ptD1MDuZY6tRQ5gZwq4AhJhQrFWKc=;
 b=fRrKUGssO/MiDZp8B9BtVRCktpcn+OTI1YU3zOVwm9LwTaW4OA765Syek+hSumyKXUCSe9WQLDxL7XJaJRb8xsutmPeXI4A8P7GpsB10grzlLO+xeRNv1lNYXw/szXH6CV5iVacGPQEaLwAvfcfPmvV7XmNhg239GZd1Cct3pL0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5879.eurprd05.prod.outlook.com (2603:10a6:20b:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 15:49:44 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 15:49:44 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: usb: ci-hdrc-usb2: add property disable-runtime-pm
Date:   Fri, 10 Jul 2020 17:49:32 +0200
Message-Id: <20200710154935.697190-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::16) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23 via Frontend Transport; Fri, 10 Jul 2020 15:49:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e6226b2-6a98-44be-72cb-08d824e8dd5f
X-MS-TrafficTypeDiagnostic: AM6PR05MB5879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5879E61A1A8B8E52D441BA79F4650@AM6PR05MB5879.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9YhtxW1tGjJzniJZ6MK0RhuwuM6BJHNPrg2ceka6rlt+ytxFt741KMZuDCOXmHlWI0tGkwVUI8H9O4jargY9bWX21NDuY1ZMmP5Rwdrm5ofSZFrj5OwQUXHROrBdfkIrIGvIoH1S1x2bDDUakx+b223bq0Iid/4d3y66emnq6BrWhlCVaUNX6dV+vOoWuvMJKtBL2O40ctK++SfFoRjjZtEU8FJXoeNjXEp2j1IS98vNjn0giT0cmKtE9GpKb1iTS1D4oKKJskRyBbJIdQRhF2R59bg3X30W2J6rPshrQhuC5q7JZryHPh4boG4/0Kh8i9EtDeg4WB78WznkUWm2uiaAlwLtJ96sa6Ue+VBj8iJUEqkfvgAzijJm0iq0vl7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(54906003)(66946007)(86362001)(52116002)(478600001)(110136005)(1076003)(6666004)(4326008)(6486002)(316002)(6506007)(83380400001)(26005)(2906002)(8936002)(44832011)(36756003)(5660300002)(16526019)(6512007)(8676002)(66476007)(66556008)(956004)(2616005)(186003)(4744005)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: z019xzeYg+ojJdyLOsfQwo4hHg77LaMET3F9pTJJ8Xham0St72jTDWeXfUSv7Iyxk5sVzXnMQFOt2Jt21cIpw8y4HFeBSLBXqKa+ClFJxgAc+G9TqCBDOC8+oYnsEW0FF/7dKGcfU3eN1E/8xI/lnDg2ulC79ZPrbJ+OkrkGSxXuNPiIbHc0dCr5JEQx7x+1ga3CIoA4bnrR0aR0V7SkD2Z2jaRHlhvTBk5CBUrhN+xKoT/neBgYFKRJzF/D0lgge4V8k0Mu74t75LOOt9CYwmk2J4HUNeqlohamHzZUo+w5SZJy/Y374/N2jeI26VCpprXVvDSW6DDWZwZpl4/MjLPdnju+E0e9m2vvWeSz+AV+FZyOGWaJkBfzgR0QDtWUmADLde2iINW4xgB2QXgNAO+WyENkXa7HHR/qjJ2UCiAuWp5Gt6Mr+eBots8d8Q1W4WRiOXdcrR0kaGzhJwwrBfiQaf9kzvRrC+drS8O8wG0=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6226b2-6a98-44be-72cb-08d824e8dd5f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 15:49:43.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E889PdGyF94hWhK4ogblsBTF3OcafpDouKZnv+DLwCmKZWmdJAUHSSakKc9bqQ0JXIUS/9SiSiWazDH26jSYPJ2bX8/mx94YnNIB8exMTQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chipidea depends on some hardware signals to be there in order
for runtime-pm to work well. Add the possibility to disable runtime
power management that is necessary for certain boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

