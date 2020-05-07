Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A7C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1EE20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cq+T7769";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cq+T7769"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEGKC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:02:26 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:28130
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnIr/E4F1RHdpa9YcshjPnw0j88O+R1CaK2I4BKZCa8=;
 b=Cq+T7769tqHnXHCw91LRK9r8/UJlTVk7OQ5lotNTZtuiEWmrrvBRzWj+R26HHynYm+IzKRj3/Bl7y0oeKuv8k8hyUPjfCrOmpWrDq64UKYty6p+SFSJS7gSHq8JldHmr99qcjEFVsOxr+XbCArjIgQ1Pdrz+aQyXQCVArRpj+Ts=
Received: from AM6P191CA0105.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::46)
 by VI1PR08MB4093.eurprd08.prod.outlook.com (2603:10a6:803:de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 10:02:20 +0000
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::a9) by AM6P191CA0105.outlook.office365.com
 (2603:10a6:209:8a::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Thu, 7 May 2020 10:02:20 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT005.mail.protection.outlook.com (10.152.18.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 10:02:19 +0000
Received: ("Tessian outbound 567b75aed2b9:v54"); Thu, 07 May 2020 10:02:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 15a83750b13d57c7
X-CR-MTA-TID: 64aa7808
Received: from 3a5ff3512ac5.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9D93D6E6-56E8-4F91-92B3-BEFCAD80D5AE.1;
        Thu, 07 May 2020 10:02:12 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3a5ff3512ac5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 May 2020 10:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or9i21ipG4qWVFmptWHZ6X2hc0MEU+vzGPXP8R3A37zg8wylhDhh4US886FOnzlzfWJaEtYF+UNbY8pOev3M4hD88uyAEUhbEDOM3WyX7Q5fFKp0TrtfQ7WDEmddrczse6CNXw2cKJ1OVpSTi/707cH+rvbE3RzJMnPpAxL5M1m29v3+flHzzc6/QxHQJMQPDTZAs5FcCXm/b0YERFJlrGahPc8jrxC1Os0w+JHLnzjoZK94vu3gxLSMcD6rshcJjNrZqwmcjgFLzmkUccZjVy0gk+RBSeyGQ+xQAXTazlFJsxFW+n7ZPDiRLr8YaGIcqN5d5tBGMh3hbm40S7fYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnIr/E4F1RHdpa9YcshjPnw0j88O+R1CaK2I4BKZCa8=;
 b=BupOtrcGATyET+coqusArF79cLuGwwNsq7TibWWJEdLsnVyzAzb3Wp9a8E+CQF+4teMfluSBGzbp0L2RBg8RzIGC/nxk0pLx0pq2GNramSmpO9CfXgo2I9MsMX1YZnB1ZbBoCjQseJhIeTFp3JG6+YjzEEGXmsZ8LtB4y61GcVVGixLl5OZYx0QcDD93QdSIJX+zdQrxAmifB8A/wQEgDEN4ptwMxg5zS+2ZpuHfIZomrCfeyAFVicH9vzyg9p9pn2rZ5Rwf3kxFy0F6R6BWzvw/uOyLzbs3V0aC+600URnYuLkFLnkEr5LoLh8yrjkdG2CdVjPxp/is8K3UIeNdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnIr/E4F1RHdpa9YcshjPnw0j88O+R1CaK2I4BKZCa8=;
 b=Cq+T7769tqHnXHCw91LRK9r8/UJlTVk7OQ5lotNTZtuiEWmrrvBRzWj+R26HHynYm+IzKRj3/Bl7y0oeKuv8k8hyUPjfCrOmpWrDq64UKYty6p+SFSJS7gSHq8JldHmr99qcjEFVsOxr+XbCArjIgQ1Pdrz+aQyXQCVArRpj+Ts=
Authentication-Results-Original: linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=arm.com;
Received: from DBBPR08MB4661.eurprd08.prod.outlook.com (2603:10a6:10:d6::16)
 by DBBPR08MB4856.eurprd08.prod.outlook.com (2603:10a6:10:f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 10:02:09 +0000
Received: from DBBPR08MB4661.eurprd08.prod.outlook.com
 ([fe80::3591:2343:3c1e:e9f2]) by DBBPR08MB4661.eurprd08.prod.outlook.com
 ([fe80::3591:2343:3c1e:e9f2%5]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 10:02:09 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     akpm@linux-foundation.org
Cc:     nd@arm.com, dave.rodgman@arm.com, pushbx@ulukai.org, w@1wt.eu,
        sergey.senozhatsky.work@gmail.com, markus@oberhumer.com,
        minchan@kernel.org, ngupta@vflare.org, yuchao0@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/lzo: fix ambiguous encoding bug in lzo-rle
Date:   Thu,  7 May 2020 11:02:03 +0100
Message-Id: <20200507100203.29785-1-dave.rodgman@arm.com>
X-Mailer: git-send-email 2.23.0
X-ARM-No-Footer: FoSSMail
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To DBBPR08MB4661.eurprd08.prod.outlook.com
 (2603:10a6:10:d6::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from davepc.cambridge.arm.com (217.140.106.49) by LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 10:02:09 +0000
X-Mailer: git-send-email 2.23.0
X-ARM-No-Footer: FoSSMail
X-Originating-IP: [217.140.106.49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bf12398-9449-42d1-39be-08d7f26dbb0d
X-MS-TrafficTypeDiagnostic: DBBPR08MB4856:|DBBPR08MB4856:|VI1PR08MB4093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4093573B4444B2BAF45CF5948FA50@VI1PR08MB4093.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /v2wPM18UGnFtjiWsCJoxKQ4RA5dqQmGUVuPEJGHrCjsFgdwpH9sqrSEzIUcChVkJgVuwS24vohVuL8JevKnIraD9jyq+zX2tbY/921HCWIz8bEa7uRmVcQwhwsCFxrN/LZftP14/20MrD/iOS3eDEUxd204ydoxpGjOd3hrirwzLVo0rHhdlJkyS70UWtFFxdcuM01TM0MQgUmA8TFjgn6rcR737tM/TAS0y+M7C7MA11IfcFKX68q2eK20mTt+SEMPRk+ncA8L685FkqA2mNob662cFUl+FH5jSoYF2wwuCzQ4AdQHA7B/DQ6c58cFLUEjWu8oHhuitQWHwKKgdYcCjWQWRyvEzIV7T4QcopvCJrT0hVsRl6TM7p0Dg3qH4RRAPOGVQFTjXMiS8lhgGT/An6b2rcSMUcOK5xVUIKdnVUUh4tFFVu5XcuDl9DgEV8HyWvoVmb3E3xcNJy2UT+UcXUBCOcHi+FJtDc+H8RRIKnxGBiTRaQrlvsU9rUZzfKV10b2QaC6xuxe2ZO9elA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4661.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(33430700001)(86362001)(5660300002)(6666004)(316002)(186003)(6916009)(478600001)(16526019)(26005)(1076003)(6486002)(2906002)(66946007)(36756003)(4326008)(8676002)(7696005)(52116002)(83320400001)(83280400001)(66476007)(83310400001)(33440700001)(2616005)(83300400001)(44832011)(66556008)(956004)(83290400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: I72Aa22l0KWspMqp+HhyM8CG49175JKfdV6KourwrS+xTJza/wfdsHZhJHmnCPnl8Og6ZknyHEV/EBWwkv9Nxl42V2ky6EfHnyfTTWBUy0/4Z+9nhXeFPUyqkT3gZ0Pyhbq8wEcGs+lXdJ+UOaqaZpexf5x2nA0aq2z+Bcdstm66/o7TQtHL9Nd+Hnzc7EUdFjJDWYEQsFFmh544rUbdEOzsr+nVF+TWnkxTkuQSn0hPklxxND5zsZPXxuF2laQymFFthkINA9RAxk3GwKzTvhsFZpHHXF6UUTiPbrMhcxPP6C4YFq3yAblxOP96DSOmJP63uqJcoOkCM0QHh9HDWNz0zBMYArnI1X9CCgrd/xGkdkThy7JBmHzApp7QztpUSA4sIkoQFe187+66+bVrwyFLOLjg+12KVQCNKwcNbpxzGFxmf8dsLQQgsV1rANtexL1oepxtrPafnshPpaIrdg9iXHFliG8erqmXdAU9Z3TMqiFst1L34xRk2TEo7Qqun2yTqMXF4s6bvuez4amKyROPSkC37NQVgsxHXPZBlp3r0AUPRtldnyA3iN6Su/nDKjuZ2Ndcii833uuV8HAavc1ENciYcxZ9jpo/jgYOlvymS8GPcucq2XrhiK9ouUL26J3bMcyvUeaz/9yw/pgS/S6l55rsjAHl2u/ZAuhm43GwBK1EYWQRodcYDgkEATTPFxTrr2Q/l3v8MHkDyIwkjGm33LFZsY6lZhDZfxYOPvoPwK+j/wDBQJK6DgU1gmLFTOrt3MrNbLRtcYUi6bBFspKhlS+2ucu+TRW0c5K2FT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4856
Original-Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(33430700001)(1076003)(956004)(34206002)(336012)(316002)(5660300002)(8936002)(33440700001)(4326008)(44832011)(81166007)(82310400002)(186003)(356005)(36906005)(2616005)(16526019)(2906002)(86362001)(6666004)(82740400003)(70206006)(478600001)(70586007)(26005)(6486002)(36756003)(47076004)(8676002)(7696005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 556032e0-1775-4f6d-67ca-08d7f26db4d7
X-Forefront-PRVS: 03965EFC76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fngRyj3I2eXMoVKKYQgSfMrQo0OQxWbOfc/BwkMw6M0i1/1LTUygO25Bgvf+P8K8x2dpyA769QoNnfcL3JUyTsMYJK1uaWcRSXGlodmdACMvUyIwJI/heP8y5zhcF1V9LXBf37N9K9k18wXgL3L5OexUlHtksJtru98dElaByLXps49J7wB1pkC/KTluYWb3/c8G16x9XhZvHXfz9EWDIibb+CJ/sIHhaVJBWVoBlL+ZzOEQDcMDos+uGDsQi/WQrmPplSNQLVp3L9rZ24ooFsA5H/m4HqYHnhvYuMR2ZGw+PLP6YVXSyCjArPMUadmZGqqumWWpUT1mZDMVCkwr3gDAeoinz2eCW8b8ArwJ7RQOSiVwqZC+l3l/x/51XF8UzXtb5Tmi4QBB88Nb8vMl1gkAqh6LtpKoFwKZ0cuqLc9znwffiqPDGzPrLp+kjzINO/EXXdGSB6iey4t/sBoHWEKG5tLxTfAoB4M38uIk/H8L1/dQKko1Ps0ohuqhx+vzkAxzO9kAlGcrKcTtqXDrWj3iKZztvD1ppiz79cIMxN/af8gF7cu8N4A8ZpUAdg+MQGsErO274/yu5gwW8dvuhg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 10:02:19.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf12398-9449-42d1-39be-08d7f26dbb0d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some rare cases, for input data over 32 KB, lzo-rle could encode
two different inputs to the same compressed representation, so that
decompression is then ambiguous (i.e. data may be corrupted - although
zram is not affected because it operates over 4 KB pages).

This modifies the compressor without changing the decompressor or the
bitstream format, such that:
- there is no change to how data produced by the old compressor is
  decompressed
- an old decompressor will correctly decode data from the updated
  compressor
- performance and compression ratio are not affected
- we avoid introducing a new bitstream format

In testing over 12.8M real-world files totalling 903 GB, three files
were affected by this bug. I also constructed 37M semi-random 64 KB
files totalling 2.27 TB, and saw no affected files. Finally I tested
over files constructed to contain each of the ~1024 possible bad input
sequences; for all of these cases, updated lzo-rle worked correctly.

There is no significant impact to performance or compression ratio.

Cc: stable@vger.kernel.org
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 Documentation/lzo.txt    |  8 ++++++--
 lib/lzo/lzo1x_compress.c | 13 +++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
index ca983328976b..f65b51523014 100644
--- a/Documentation/lzo.txt
+++ b/Documentation/lzo.txt
@@ -159,11 +159,15 @@ Byte sequences
            distance = 16384 + (H << 14) + D
            state = S (copy S literals after this block)
            End of stream is reached if distance == 16384
+           In version 1 only, to prevent ambiguity with the RLE case when
+           ((distance & 0x803f) == 0x803f) && (261 <= length <= 264), the
+           compressor must not emit block copies where distance and length
+           meet these conditions.
 
         In version 1 only, this instruction is also used to encode a run of
-        zeros if distance = 0xbfff, i.e. H = 1 and the D bits are all 1.
+           zeros if distance = 0xbfff, i.e. H = 1 and the D bits are all 1.
            In this case, it is followed by a fourth byte, X.
-           run length = ((X << 3) | (0 0 0 0 0 L L L)) + 4.
+           run length = ((X << 3) | (0 0 0 0 0 L L L)) + 4
 
       0 0 1 L L L L L  (32..63)
            Copy of small block within 16kB distance (preferably less than 34B)
diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 717c940112f9..8ad5ba2b86e2 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -268,6 +268,19 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 				*op++ = (M4_MARKER | ((m_off >> 11) & 8)
 						| (m_len - 2));
 			else {
+				if (unlikely(((m_off & 0x403f) == 0x403f)
+						&& (m_len >= 261)
+						&& (m_len <= 264))
+						&& likely(bitstream_version)) {
+					// Under lzo-rle, block copies
+					// for 261 <= length <= 264 and
+					// (distance & 0x80f3) == 0x80f3
+					// can result in ambiguous
+					// output. Adjust length
+					// to 260 to prevent ambiguity.
+					ip -= m_len - 260;
+					m_len = 260;
+				}
 				m_len -= M4_MAX_LEN;
 				*op++ = (M4_MARKER | ((m_off >> 11) & 8));
 				while (unlikely(m_len > 255)) {
-- 
2.23.0

