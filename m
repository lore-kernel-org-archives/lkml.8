Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838EC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBFD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="rPQubjxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgEMN5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:57:32 -0400
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:6040
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbgEMN5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:57:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciTt8VmYRwdVT/khl6JI/clKWRez2Edqupdp7cXL57fR1TW4xEEvEySn/MwbI/Ni9tqUWRjwXSVpidXqVMGlLJEGvyQc/hYlB6TmPe9n2C839c2qrIhz2C3YnN5eop521EmapUhkuCwjzqnqaMKIoCC4ms3C8hustuem42D6dGjaDe/ubEnTmjln3GoUPKc/HsuEmcJCMOBjXIqqxphsXW+7AzFzoEFz+8TvKrsbyfHR9MnRyIMam8R1oQn9pnB8lG1zlVQjFhKkBl8V2EN4ZdV0hW9nMg52cOgaS/PGoZTjd92Vr9ZF7dIU6nxp3demOiRlTZg0aEE6oQohk2tELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60vPmv8RA5MlmBbtLlKW4Y/a5Zxl3G7WVKbBwMntZTk=;
 b=IOHz7ty52YQpZnPd8ap6yCr70TAlf3wuSMySTxnvyUBuLHLrK6E9BKD051RnH/kdM1FJxM69On+vRkvAte3U2xNV3Ahb920RptuInyOAyeK1sPXAelBIQXIKp/cqFfpqjfEnUW7IJuORmBdVPoqJMA2b3PG8okky4rcR7GWTLgqdY1sBU3cNNVXDehnFseZIjjyfh9U2g0bEynN2PE4rWzPG7abr2SWZsHzZ7txRk8SlWpl/ZcUmeV7xbAsKjMTIZmnKVOJxWIujVIbtRgSRNvAZdLq2ggzFZUonPsbXgpJI2C7A0FUoZnNBAVGW7QXJ5SlmuyGFHE1HyLjb69r0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60vPmv8RA5MlmBbtLlKW4Y/a5Zxl3G7WVKbBwMntZTk=;
 b=rPQubjxMATSoI5mhfqIP375B8xcjjWalTMPaySPYMAy3gI4VqJhuQZNscr6VKQwScNFWFrr1Uj8OCDczHEb6LqTs/SQUMTqUTgFKk1TyxrFi7XeJPh98nEvJ0WziTwcCiKrM6w63+TLTmzFwtUhdZSLIB240UVbOzBYmSWloupA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2792.namprd13.prod.outlook.com (2603:10b6:a03:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.13; Wed, 13 May
 2020 13:57:28 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Wed, 13 May 2020
 13:57:27 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, atish.patra@wdc.com,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 3/3] riscv: defconfig: enable gpio support for HiFive Unleashed
Date:   Wed, 13 May 2020 06:57:01 -0700
Message-Id: <1589378222-15238-4-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589378222-15238-1-git-send-email-sagar.kadam@sifive.com>
References: <1589378222-15238-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To BYAPR13MB2614.namprd13.prod.outlook.com
 (2603:10b6:a03:b4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BY5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:a03:1a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 13:57:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e60311-45f2-4c2d-0508-08d7f7459254
X-MS-TrafficTypeDiagnostic: BYAPR13MB2792:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB2792691A4C544F6AC01121FD99BF0@BYAPR13MB2792.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54BjP+A1LjjzkJnvvSWghphgNC8Ad2Qq4SXF0E5jq/h+PabFglb7sD6QCpshteWMSOUJYOJmBHp5ao29QlXT0VbUugDqO/gQvs29319Ybipujw4HxQ5RB7fJiUg1ccgck6o6dVZjsv+hzi5jARIUHpXn+UXXLEesZnV1VTHkOcKCZ/etlXacveePUg43raWd3yQL45TsFmSwUBdiPZJ4Z9n/Y9qIw8mirjK0jH/tGPp/F1XWfu77bFBzSxV9Ftc1iU5jT26UsN3fazZ+XYAPPQLh19eIT7PduzkkVXv3hCO0N3Y1I56WZQXzh32smy61uhBCKha9mqagGKRQaf2eEmo0uDMQd5SfZ7O4I5B7gYOZDWtWGCU6BWua4guorZ8T33Antgg367rXY1sbYjZtJhXyvmo41oWO8zs5SnZ8x7Ec8/0wtIqtjrryd3gHc8HY6h67tH70GrTmheyDKJDFO0nKf1zgfrP8cV1u+tbdnCiLLQ7/s+7eOokEuzHuLcT+YZ27oHOUo8gGH2a1VUc1sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(366004)(396003)(136003)(376002)(39830400003)(346002)(33430700001)(8936002)(8676002)(6486002)(66556008)(2616005)(4744005)(52116002)(956004)(66476007)(478600001)(7696005)(66946007)(2906002)(316002)(6666004)(36756003)(107886003)(186003)(86362001)(4326008)(5660300002)(26005)(16526019)(33440700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ChUBH7j6jhdUBi31J72zbi0hGDFii6Av1ywTtY427RcQEMGpWptm4V5VWnUYNplKrrKRT8H0On+40kk5Vr7dtaidHfxoqCB4KanLg7yNz5nEckldWlq08aAaFIKPMKkPQUujeVYzPQ3E+W3LK1eLPjrfJMuaNPakfTbYmCaxFX7/moQjfVjYuTIIEiuGSmmq3YtcgN+tGnhCFXyr9ciC2ZaRBF9fm8tD++k3VAhp5uNlHyNRDZvbDIgJLWxqsaAg6Bs7JFddolE8tnLtWuYhpY/80G73aqwJ4ibzis8ka2Hg07MJoO8xN082j8zcCoB0iM0uzowmQCcAycmS3g2/VB4VHWXQhnMXTJKeBcEfjHEHCC5+0qBWcjLMH5/sRqw8zNgqUP7MufbjbiJ8RN4n986Ghw7t7DvSOPm+07akBmmRVW/A0mxC5FfwWwEsWj8bxB0eD+3pRTFuNnudbxFWbujyOei2Bl6Viko2ixtwK38=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e60311-45f2-4c2d-0508-08d7f7459254
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 13:57:27.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL7Lrf3V96M5+SZmPaAUAB1/HRXjS6ATF7DveZ5N2fPk2RQLl28DvYEytA9MTCMl9SiV5hbVxvOvnzJXkAJsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet phy VSC8541-01 on HiFive Unleashed has its reset line
connected to a gpio, so enable GPIO driver's required to reset
the phy.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4da4886..20c38b59 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -63,6 +63,8 @@ CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=y
-- 
2.7.4

