Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6DC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0C42051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="apSZaguN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgCQBff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:35:35 -0400
Received: from outbound-ip8a.ess.barracuda.com ([209.222.82.175]:44842 "EHLO
        outbound-ip8a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgCQBfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:35:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175]) by mx8.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 17 Mar 2020 01:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXLe3NVvDS7ZVNIXprkIKRPwM6rzrAL3xvFwzBlSafp885F7oP89tPmDIy3HQVpiU0HwmKpZuy8C8I/I+zC/WBK1Cg0P1NtxvtngEwgfzy0G9Evwp68RTu7n5VNx3BZCdr8HWOTQ4QjUDEeit7KDCEfJMUwS9G+KZM2IsNMZcZ9XGL+DDBHXzoUrTBUrey1QGki5OmTu5FxxHioESRZKEEsCqqobFDjPA9PGM8Ms+h6FXAd6CJ+CUp/HBTyh9wn15n7rxUFKuILFrZswqGLuowAj5Ys/Fa+dl1kLstx9PUoTDYTDFxC8lrwhPB5fmntt4U+l/vLRysSa6Id4O3nR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aM6vSsglwBDmz+JBPcobVbVbcE2U0hhc9FbCbr3VvA=;
 b=DAjXyopjOumWcjDrC573DKvlhr66nCUeNcM3cMGMZdies+oxpVT3n/n0eW0cnCauwwn4YHK8dOA6bhj2+UpxIhvVpDyP/JyPLCaEInJCq0VuDDt/RkxbLLkozEzHXoampOW2Q6vaT0AzYrRZgkoxu0hgAecGB2iQKclubPq6dsXrIed1KUnUDrKbo0ML7OSUSMPFLOyHwDEiYjTcjR8Xcjpu3WJm/QJYfGMpMma7jk8bushiTa2YNruonhPA9o9ipIt9dB3yioDcsznBO2vAr18KwdSB3HxUobliUVecr1RLiNBuzt2YICQI9UsCkPE7CY/pR+tOms06gybBNS2HIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aM6vSsglwBDmz+JBPcobVbVbcE2U0hhc9FbCbr3VvA=;
 b=apSZaguNzUQ2y6pBP16BmPVQgVkL1SrcjKJ2bT0xNbV4qcABGjZOeE5wbItNjkY2lNABtrATrgN0mguQ+rQFFdErNeuSy8RDENlTJiCsG9ZsHz8gTkElvrYu2JXkggq3JnOTHSMnQ8RsE4Gg8HMHTSNruzkkyJ7NvtHfJGppp/8=
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (2603:10b6:208:136::33)
 by MN2PR17MB2863.namprd17.prod.outlook.com (2603:10b6:208:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Tue, 17 Mar
 2020 01:34:44 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 01:34:43 +0000
From:   Shreyas Joshi <Shreyas.Joshi@biamp.com>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] printk: handle blank console arguments passed in.
Thread-Topic: [PATCH] printk: handle blank console arguments passed in.
Thread-Index: AQHV9dPJ7vgXqRbTUEq4Sjf2AplQlqhMDLFw
Date:   Tue, 17 Mar 2020 01:34:43 +0000
Message-ID: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
In-Reply-To: <20200309052915.858-1-shreyas.joshi@biamp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
x-originating-ip: [203.54.172.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d05add94-cf41-4e55-17d5-08d7ca135ec1
x-ms-traffictypediagnostic: MN2PR17MB2863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR17MB286329DAD72CEE64E06E98F2FCF60@MN2PR17MB2863.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(199004)(81156014)(66556008)(66476007)(64756008)(81166006)(7696005)(8936002)(76116006)(66946007)(66446008)(71200400001)(86362001)(52536014)(316002)(55016002)(4744005)(26005)(6506007)(5660300002)(478600001)(186003)(8676002)(4326008)(9686003)(2906002)(33656002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB2863;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJ7LqCgcCsxF1+s8sKDYqtpNXe/0JwMRjl+s0PoZTxYZVXqZz8k9pbqphE2Qp1qfXwrM4gDPy139MonJzC2koiKM855iBaNmVfb4REwbnPH87SPwydCDtD/L4tFyG9igl7eT1+iCSn9CJN0SD+1mCKnteocahOFqo/32SEr6WK2o8W+7FGJ3F21OzoiDcV+JecloZash1NjwH2tmA9Rky6lwyHmh4jtYohz8RwUU/kUjBrHuXw6ZKj6T3Sldi1kVupoJ+tNOcDFZXYihIFiTC8aNW8BIIrJV3Akjmh/bgJbju4JjBdB8ROpVN03MTSAKxfFdyJXJY3CHa9ja486BTKEvHdyhl4SRNY7UjRzU8rIyK2pazT5e2S5XrV1qZtMZUNs2t/J8ht7AgY6TKLYi01xMTv9iZVcF6VlG2W1Mj45ug1c6mbSbka2joWL8YSB1
x-ms-exchange-antispam-messagedata: qIUZnU1Y5iaoqtFcWXO8F9R2LRkpurTP6iVZ+/n6i1lqOvLV4cbOs6Tir8FaD9S0FYSOdDDvN0TbBVM/RAzcMU8mLvg4VtRgnLce45exMt3gl7+4vUfrPDcV346sGqj0y9hVcgX8xQnafUBx3a20SA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05add94-cf41-4e55-17d5-08d7ca135ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 01:34:43.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGWV7SP6XwWGdhnlch5VZ/MXaatsKGn7uRBR+RyIG5ryCtg30UhoYNr57m9kejSzGj2OKFNR9kLkoMzr6kTAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB2863
X-BESS-ID: 1584408885-893014-22206-7049-1
X-BESS-VER: 2019.1_20200316.2111
X-BESS-Apparent-Source-IP: 104.47.56.175
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222889 [from 
        cloudscan14-19.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.50 BSF_SC0_SA_TO_FROM_ADDR_MATCH META: Sender Address Matches Recipient Address  
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_ADDR_MATCH
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If uboot passes a blank string to console_setup then it results in a trashe=
d memory.
Ultimately, the kernel crashes during freeing up the memory. This fix check=
s if there is a blank parameter being passed to console_setup from uboot.
In case it detects that the console parameter is blank then it doesn't setu=
p the serial device and it gracefully exits.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 kernel/printk/printk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c index ad460623=
4545..e9ad730991e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
 	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
 	char *s, *options, *brl_options =3D NULL;
 	int idx;
-
+	if (str[0] =3D=3D 0) {
+		console_loglevel =3D 0;
+		return 1;
+	}
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
=20
--
2.20.1

