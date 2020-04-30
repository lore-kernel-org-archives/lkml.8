Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE8C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E4220838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="qkoMOUkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgD3J7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:59:36 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:37818
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbgD3J7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uak6xEeq4ji3/4qjjdbTe0Q/oX/Ee1kvVuiX3kQIekOqTmr8AfDPbU3duF7mdyUZxdWtaJ9FOcgWoAL35I60P2JOykarOKc01HlqriDNa1HOetJPv/x9Cmj3yhuxrFUcOW2BAvSPqG+lVEuDLkE+RQLQEZ/FSWnnj5AbvBzvyMIBNO4SaZpUMLqMwpnFrxGCtL8hlkgpEi9fonzfwr2paBlVMdj/bszJmUPV80xLiD6bKLkbBmv/TM+kcZMswO0FtqT0wNYBGssPQi4spmULQKnQ/pTdBov5iIFa/6Rmuk2KoDZfFyxMiPONUPjJmfaIREw6s5mmlf8i1bw9+JxAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCjrNLC2LhnFkNcifiJpqfLa/GGgYoNgV84DoNYXhiw=;
 b=N1tFlprDu3Kd8PFMaUXPt9/CBhw1c3mgEUy3DqXs79s1wqHpA8pkOjhgV0O81kOS6YuFKjCf//oVlQbZzV18GG7uND547B3/yk0I9H1xpNh0qlVvQ/JPYPhGUfFxCnjb34RvH38ZthyfoRLeC+pvzud2EAKMJthM/m0R9zpswOzmZ8SuXdIR1nkpNQIIoj9uYTRSWcWEbN/M0Jc4c07hIlnCMv4g1CCs4DaCmJ5NLevOaYZhLn7gkboPKd/5np9xJKV1VukH1selhKjyuPHWSdKsC/n4EL552BzoFFwOuen5JcjBnQ/dxD4GxTegcvTFUyXOb4IowXgFH/VebBdz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCjrNLC2LhnFkNcifiJpqfLa/GGgYoNgV84DoNYXhiw=;
 b=qkoMOUkbFbATJoVjN72Ixn7WCyVE5dnwQOGAokQPL8ZaWx6kzbKK3WcFwHbTkAnaix4D3VApMASGZTQGGeubDSjS+fjqz5mT4I1I/K5VqCEHISB9XZtSeYcKBauIiC+UFu5+wvXD5RTqPUG/JV2iblKCw5T7tCT5kBTvAmGI2F8=
Authentication-Results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=sifive.com;
Received: from BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
 by BN8PR13MB2884.namprd13.prod.outlook.com (2603:10b6:408:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Thu, 30 Apr
 2020 09:59:18 +0000
Received: from BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929]) by BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 09:59:18 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed A00 board.
Date:   Thu, 30 Apr 2020 02:58:51 -0700
Message-Id: <1588240732-13905-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588240732-13905-1-git-send-email-sagar.kadam@sifive.com>
References: <1588240732-13905-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BN8PR13MB2611.namprd13.prod.outlook.com
 (2603:10b6:408:81::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 09:59:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f59fe8-1b43-4f15-1e76-08d7eced25c5
X-MS-TrafficTypeDiagnostic: BN8PR13MB2884:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR13MB28840A50452C06794ED0832D99AA0@BN8PR13MB2884.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxicrGQAppmCd9g9ACLPPrwQl8lVGO4Rx1ZRBagPsmuwXf3vacWBDg8QzfKSdh+Lq+EJIBKycRL2YbeGjzYdxAjxr9JvT+pnQHfpadyK4BrqFQ5XxCIl/P31shP9sTvr8l2FgKhLxMIK6+VWV2cQj791Wlbex7NKzB3S7rwK9lIBbA7kI1H8toT4gwZtoBaq5gRyw5MIkgMlxD/GiMQRkeKVbPrxsaxHd53P4h1sjDF5Tjp80sPHwrEmcwxGmCrx4Q5Q4eHTOFBwaS1Ml1SCqKeYr3P232vCccNsHZ0qKJs9uUmCu8uLvHLlic5zZuNIMk1ZxMIVXcAqxgoL3yO1DYLTpZr3TkAzh++QZ0q6xXpm1xa3kAkywBLri0n6nquswAQIqFOTxAfki1iLQezeClCSvQ5fnUNW7yZERRfj7nwHSrehaClmQLgYEcYgtJ10
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2611.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39850400004)(396003)(366004)(7696005)(52116002)(8676002)(8936002)(16526019)(186003)(26005)(5660300002)(4744005)(956004)(478600001)(2906002)(2616005)(316002)(6666004)(66476007)(66556008)(66946007)(86362001)(36756003)(107886003)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GSecvMogeO4xfYfwXzYLnRhZ/Qxf8JH09tISPVYn9sB7MIAzE42EG4jgqn9Fz1DQBw9bFmp/tEvZ4sDm52fcQ3RzRBoEtVW7qmzV4TJk6du4ixHl629Uuue55NSxdRwDDWufbaDLWvVgDH0mgO4SxTdG2b8vnxivnuNlTEgTTQjFInn6ol47jAxPANEVMOx4imQKNR5Dg2Jm4UvrOmPGPnwxTKPkxZfcwfsp8+1awMhdb+v4n/0DwN9ZWyoMxxY5b2CudnTJdW0phacpzgjtqZ1fYwO/7C1KN7W+Jk3UR9obFNhe56+lW/plYb4sKAiz6jI5Yc/fJbU4Cx2J6Bpj5nbPYB1xdiFtLCyvH14SH1yOQMxqs+ciS6amPcSxjnAlb8wsyTK7rW90eQFPJMmBs2afQX0AExpkRmN+j6ZGpU2ZIMFVI5bEb0FeNBFbn0yQ1NTbzBClY1xEacjQ7zO+w9B011rd1UGpqpZQR1cC/xhKkNN+o7UWxVFNEdUPSm11hTilQ9iplqFt148NcC89vJwZjCuqQo6bRfUcY0R7TbrdrSo7BAkLq0o9gxUknUKASVI3ZwpdSb3SjJUXtyLvrjxaDs0r+dpBQHvnNIQHHwvuhqu/mchUih48GairkjLtBwW76J3qndBkUOKIb/7lDa5KKIW4aGQgCYmi4gUkTIVI0aQSYaS8iir46ck9X2ZWRdfCLJXEBclouwy0aB8GMvMj+qjXNKmR0U/h4mSvSQ8KL+Bbp1ndJ9fXTSkXkvfetMxisZN2Qu2lMn3hD1PpDoMXxYqlD/2YREwOXV4cfKY=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f59fe8-1b43-4f15-1e76-08d7eced25c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:59:18.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4NdIfRh0nZAlpEVZgg7Ukq7HkkJlVWcJQEeviumtvyAuTFvC0xnW45bleOFgXomILZiHau2qroVrm4ifufRmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MTD based SPI-NOR framework in order to use spi flash
available on HiFive Unleashed A00 board.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4da4886..970580b 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -80,6 +80,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_RTC_CLASS=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
-- 
2.7.4

