Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A73C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CC62076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZT3kSVyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDWOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:19:26 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:40070
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbgDWOTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXpDmR1/rfMCe0mTRLuxaXzhtWt5Ffz1CE80j46P5O8aPmScwE3vRBcRGeG5ssJbUAReE8AGbOH7bFPUkAvmpac5GaH6zzsKVT49bWtLLnGMA9dNlw8ARTxAjuw+QBzT/wsCr7b1yZVT6Ttcx5qMznhk9FpGsani8IYFTd8v4cAT0pqy1J6LCdy0ih4niVh6CbT3HLf4+rENq97yGRWMb0zu1Ljl5KprWPbRX1hjWuHmRPlT0r1y/dZkwTpgDXxlheJSyVRxdhgTth//PZc6GbKdBig860mHtfbgh73y0/+q2YC0/S25ijKRd6By4bBmPkoMRzy9R/xdezOd7WoQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbNtqdTzONO1szolTXjAYTVXOoKArFZIRQ3VKuG3pe8=;
 b=TtfkuhHsnj8kV0MOGfJ8y8tpIsrEV3sgzgG8jf0+Eh/mUYWqOezWqX11SRa9SJ8xJiMQoe/feK5CMSRZgDpUKmvZX54Y2lnV1cFpFAFDThEfxzrwe7ai4roWZgIXeNXBuY7d/ztVGvkzhvLyY0t+dbYP72Dy/hGkPS39bOSOT9ntDKelXvIsfWvgl1OnA2sA+hqCUFSoAMtjzTpgHMXDlaLtGKi763M/MmknOtPJmJBC9JqUoiKCl11o53kbUERJoWlXoGkBLJwVHDKE30qiwwxORghg1i9s17kG9fSE28qQE57QanZCErTTM6nzm0qY8Wbn9e3WDREDYpzsysdB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbNtqdTzONO1szolTXjAYTVXOoKArFZIRQ3VKuG3pe8=;
 b=ZT3kSVyXJQWlHgWp2LVegwMXqONL7Q0CZCn4YXC9KsSjHG3wL1etiWtFaAkJWGfBmuCEHHXvFRcDx/bn4gG/pbSUob9yTIPJfONoYjib5bPGFFH6J19V7/zEP8LKbZSY/d9dXKcTPkjJQNXfVHgxjz5GGXCVwBDE88T1ABFcKzc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2366.eurprd04.prod.outlook.com
 (2603:10a6:800:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 14:19:21 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9858:e485:aaa6:ecc8]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9858:e485:aaa6:ecc8%3]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 14:19:21 +0000
Subject: Re: [PATCH 3/3] thermal: imx_sc: Include rsrc.h instead of types.h
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, linux@rempel-privat.de, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org0001-dt-bindings-firmware-imx-Move-system-control-into-dt.patch
Cc:     Linux-imx@nxp.com
References: <1587650382-18586-1-git-send-email-Anson.Huang@nxp.com>
 <1587650382-18586-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <e13f4012-a022-be83-54e3-5eb010006961@nxp.com>
Date:   Thu, 23 Apr 2020 17:19:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1587650382-18586-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::30) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.100] (5.12.61.133) by AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 14:19:19 +0000
X-Originating-IP: [5.12.61.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9380c634-f70b-43d6-f2a5-08d7e79150d3
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2366:|VI1PR0401MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2366A1011A5A6CD2DC8E17FFF9D30@VI1PR0401MB2366.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(7416002)(44832011)(956004)(186003)(4326008)(52116002)(16576012)(16526019)(478600001)(53546011)(26005)(2616005)(86362001)(31696002)(31686004)(2906002)(8936002)(81156014)(8676002)(316002)(36756003)(66946007)(66556008)(66476007)(5660300002)(6486002)(921003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eRtozwv1Gq20qVLPuLBOL5pRjVD4xY2gPBz9xsZd9Ei9K4Jhm2rCISEFe6mPjw6PVT99j2Q8nE4TffsUVzNnjMDwjK9zY9l86U+YQNC0eUNF1WVvujTFmdIs+abIPO+6AyFJtQOqiSQEq3xiPhHgn3kxsoWUvhNLB/qn8qb5AUIB/NJZgpsML07f4RK2HoHcbIoqx1uTejjADOzDnc05YlAWWz6HCc8yR6MqjY0VHs4bqa3XCeQzQBWDkc97LYgUwfCvC1DbkEVCuKE74pjLxxI9do49ca1OXVDQivKUdLHI7U7xcudwPWLhTdjM9Ae3v9qhYCnCHchgK5atPbMnZnUfYJymqffqAxbry5tyn+5NIpwY5a8EZhL9NgsekOVszI/Yu6JVRD3r+QC9rExkIkATVKR6PtLKbu02tHppqDVwZWb4AIMrxXVF/wQZxTUxKV++9EHZmRPucKIFcv94R7Fo51H8zlUx4A3a8U8Xxs=
X-MS-Exchange-AntiSpam-MessageData: VYD7ETtHyK2v80wGlq8acs0mmwq2tfJZyg/wJbVkGU2saI4AruEw732O1FkDlYXeyuB23eSeA6c23+bnhpb4NSBOdlGLLBaW4mN6MkjgUaym+LA6PdSLG3aEcwS5/NXajkQLD+EtmHsdAh6qxC168St73lbnygtkFYUarq1hCsikCo1MRj5WiuJBKAPLUEVJe+HjC8hufPGKTMJVIEiuogB/Mmd4F7hZFUZQ+r5Gqcvbj73JwvHrThTR16S+4ik9JIIq8czlww4g9XRg/flPDZtYXpDr8kjVIm0Zw1tdcpHBVHxL9UnQrFUjSuF113S8sLs4/sZeqHUto02qp+tpvltLLv/mRzb9nPK+PbYUjTlzPARG674f02SVxB+L6bgMDkS/lmOYt1iMRUeYKgw5J/16wn6mG/TL4gGjI2U+Igs2of/N/skg0R94QiQTHBNbDTbNydFjNw4w6PIy2LlPHNT8GR6vS29Ot38VapgGt44kGBpbFjcDZnc3FiXELAMZYETTakFMmvmHZomDW6MNR44P55DgNDMa9RZ2OFO/TXC0uibOdsL8L8JeehAI/49v/Q1G50JeS5DQnCHUi+LT0cz8YwkYZ7f/flTh66H2O9hyrBiEsSd047y1rt+0MkdtoR0cyveDa1Teb4vw9TyHwXlqZuNJmlIWg0+YL1Nnx15SUSfrawU77wSNiYg2yPBGUqI27tv9qJ7dYbXsiOnqTk/2CrR1JzXYZMInQIBeTFyPfveRTulZwV86sf833rKUnBPndHaOPH45TBmzg1514EJIi01KXu6523hS1U6tVdI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9380c634-f70b-43d6-f2a5-08d7e79150d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 14:19:21.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFEqCP4yDASBfGjSl0kuGMghDtMFUOWZX9X4rBtXgsNL++AIE7DGGLoEs8+HCy8HIcKdiSdIQcxivkxzpACdAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 4:59 PM, Anson Huang wrote:
> The linux/firmware/imx/types.h has been merged into
> dt-bindings/firmware/imx/rsrc.h, change the includes
> in imx_sc_thermal.c driver accordingly.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/thermal/imx_sc_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index b2b68c9..b01d28e 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -3,9 +3,9 @@
>    * Copyright 2018-2020 NXP.
>    */
>   
> +#include <dt-bindings/firmware/imx/rsrc.h>
>   #include <linux/err.h>
>   #include <linux/firmware/imx/sci.h>
> -#include <linux/firmware/imx/types.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>


You should do the operation of removing the header file and updating the 
*.c files in one single patch.

Otherwise, we will break bisection. There will be states of the linux 
kernel tree that do not compile.


