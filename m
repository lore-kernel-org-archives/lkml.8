Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F2AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEFF20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ubwbdunR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGPM6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:58:46 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com ([40.107.4.119]:47723
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbgGPM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:58:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXl4T7qZxFtTYJ9ahtGdBx5MK0ZWC1GyZiUJ5XgFp1KjB11pcyOoyj876deQFGu4dH1qH3plV/g/dK3Pda8hZgQn55mS6ANZ3ZScJbpDbmzFt9vs9CtLFdrHstMWP5UnXVgIGrifbFtTbJNlKec2UmMXCp6TjuKkv2O2Wr2zq1PQo59UO/RvI8bDkSo0Ro2vNkipi2SMaByGxHrKIJkOaBtuFHckuHvCKnN9JYH0jt8H6UQ71Lc7STtdHAlGqsRNF7vJsh8yX6t2pF5FwUNQRkZoXl8A7KufkOyF7kQ+uMBCWijw+iiDrmjr+UMIhynZh2nq5v0xH6FnnNFgQjMO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZzKNWrewbXz5iTEtxmCpnc/Q+KF72vJLAaDOd5kXzI=;
 b=Lm0nYGSR8Crid7oeqCRdDJNbY/KPD4r1NzeyR6PrTTDsW8nAXNjJ5J6mI6zfuV6rLBXYAQhTKkJH/b6xM/IlhuITCdf89NykeWvSTDor+IdGPWTfHT0ttHHpdL6ijgrmrQ3iC1SOBU0HKdNnfLOW5O/NYCquPZ/W8uLkgMaFTMAfQF+Ez8zfD9WhcmI1QMs55AsqZN1bw6O3Q/6n1vwrW0S8+Bzs0gPQMDhOa10mvl5eaW9QdrVbJiaCMpQ6WUW0kbURqw92H2MB/hdS7aKpTBcrLc9sBbwRELMLMs0081s0P/aMM7veQe8nnTZG7r+N1uvaiZP8K+pOctvwhi/DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZzKNWrewbXz5iTEtxmCpnc/Q+KF72vJLAaDOd5kXzI=;
 b=ubwbdunRO+lmDu02Fdj1EOemiAdi7r6rA45kOHY896F4pM4nzcRFmjGjFK+irJY+iAwHaZzBkq9RjfZu0BeBrw3ssR61MzFoWDvWQUJy5jebwbjioXDlyaMZ1Jy0en0FoqHB5aPQe5r1+ARlXQ/x4T8EbSfQ69CfTCr8Ij/Pol8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4885.eurprd05.prod.outlook.com (2603:10a6:20b:b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 12:58:42 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.019; Thu, 16 Jul 2020
 12:58:42 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/2] Adding USB dual-role switching support for colibri-imx6/7 with extcon
Date:   Thu, 16 Jul 2020 14:58:28 +0200
Message-Id: <20200716125831.796904-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 12:58:41 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5123a95d-bd00-46b3-2012-08d82987f729
X-MS-TrafficTypeDiagnostic: AM6PR05MB4885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4885160F2ADB651F2ABF01D5F47F0@AM6PR05MB4885.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6TB8/ivG2P469hYJeMmavmOyFirCDmW3+hpRTuA8Lpy9Zl+/68tCQUiHyrg5r72i8aP6114/Bzoe09n/HVEQgXFLLuQQk4L4q1CcBSOv9e3DsqqTiBFLQ/dkvmlg7gchajSKzJ8zpBigaLISBvlFoKY9fmcLoFFYMSBbnrmrskoZG7O4GY7i3JE1/FlpaidLuw+jg1CPRvXBtlWQZqoh2H2tUYArm6d/yNsFf97r2nbpjTNWzah4iT9jISTLWdpBZFKRGK1ytipY0v8TW1jKJtRALISxb6/Ex1uqYuiUL+w90thTbfwEldjYNNdLCfpC7YpoVo1cKLK2+NUJT1Ys2UBN82nqq/jcADWWRulxLHSIbSLRLEVc4d9pFMSBFIB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(8936002)(4744005)(36756003)(44832011)(6506007)(5660300002)(86362001)(52116002)(83380400001)(186003)(66946007)(6512007)(4326008)(6666004)(66556008)(66476007)(16526019)(2906002)(6486002)(8676002)(1076003)(26005)(7416002)(316002)(110136005)(956004)(54906003)(2616005)(478600001)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QthIgYyxVQqwgTWvIsHPBGPNlrAxsgUKtIh1AwH7uRZ80OZvMMDSgkWGcYPBTD9zP2W4OWU94101gjN3iKGIj3wpM+uVE17AVtwD9waztT9cglBn32UwCIjYsVQTgvBFtJKrI87zM5hxM2GCvzYvcwprZY/NlU6ixAh/kVLjCPNu95Hba56+WlXJAkAiGlQuaJtR/92C0ILw5Ul6he+l8w3wkFzM/DcJtD2EgtxidGCgsCxlvZC6segK3cZpTblkCMfbqdsoHalQ6Sr4CE0puBt7QGCH8LH5XorPLgUcHBzLZPaw1JVhFY++4R6sl8CFk3Z1PgTjCbqUVpJtNNlt+D35NdHyyfTHhE8PFpcwLy9Oaz1L81IM+cNh39lDvIS/mwwRnIIQKalpTBwJx+7WQmQm/ZMk86CtUNlf4DHD7PNHD52A99KVshCZZFagFJkfImSE4AAunAa2STCBJngd1kkIJ3XCgREzUoqyfZ17AwU=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5123a95d-bd00-46b3-2012-08d82987f729
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 12:58:41.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chNmFJctpL8ySW81F7nYwMqMpxuyPOczABDIpRjlsbRnlXbxit9GoQwdYw5rTWACbMgjkpql1nDUnFzt0BNlZylVYc5qO3d2FYAOHEdY71A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

This is a friendly reminder as I think the two patches in this patchset
got forgotten to pull back in.

Ahmad pointed out that extcon is legacy and I should better use the new
gpio-usb-b-connector compatible for that purpose. You removed those two
patches upon this recommendation.

In the meantime it turned out that I cannot use the new usb-connector
way of switching usb dual-role. This is due to Chipidea driver not
supporting it and Ahmad is fine using extcon for it.

I would be glad if you could pull those two patches back in.

Thanks,
Philippe


Philippe Schenker (2):
  ARM: dts: colibri-imx6: add usb dual-role switch capability
  ARM: dts: colibri-imx7: add usb dual-role switch capability

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 2 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi  | 9 +++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi          | 4 ++--
 4 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.27.0

