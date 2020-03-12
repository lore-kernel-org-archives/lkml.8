Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF75C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918E1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mAd2WlsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbgCLH4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:56:39 -0400
Received: from mail-am6eur05on2073.outbound.protection.outlook.com ([40.107.22.73]:25217
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387869AbgCLH4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMGwHhZ3ktePwuGbgRRh0TH4OovZOR9qirtg7HGG3VlU9FlosMurlJJnS4MIi/Fq6QaB93OLACFJeFxSGFPOGnDuVLOeUFLqfJTMW3ROc3RarvgbbNxwmxntpJtZ4LyHD5b6YgGkvRgI/tyw9V/LQXynTwqfJQ8KmFMNcZPZUSBW8kXtehA2uAk+Q3NWZ88KV62/ugWq+4WsWqlAvI2tQmTrusT51fMb1xFNp+Mj+O4qUoQCnMJNnv31W4YY+SEQ1GqBP8HMw9IACTfvtTo0qbMxxdW5DOedAln9nJpmRYS+/UfhUzpnTnzGsZYy68jQwH4MABrEti1+ZvKpQ2+w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWaFaPA568nRE6L1/jGBRG3nOf2JlpUxFEPe/eR/aak=;
 b=TsEO//vLqN7l1h1q73PBKxc03jhc/ey+06zP2EnuqnXPc1wQ1t+wPClCzEJU04Lfni+963TaCB20hBUMszmCIp5wo1fUin7Xt74qdiH+WYdEqrZW2fgTwcuIw5EJ+ELkTc2Z0j0sXTLGH65sDBxHkYLRHkPGqxrILW5KvhpT4NQErPFhpsPiMsr49jFaHM0no1zaJrs4N6BSncjOjv/dCAWUdKEccMZ6Ibo5RgL1THLFtKWH2X5Eb4sxuOBjoCHo2A0B6Frw91FzhIunz7E+6xobvcHle0V04Idu70dwYZ795+SbAUs98AnXTxv5CRVe9+hAsLZGjdFRupDov3Orpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWaFaPA568nRE6L1/jGBRG3nOf2JlpUxFEPe/eR/aak=;
 b=mAd2WlsGW7fsb5a+1nNgSIPLr6OZpcz0pq9GfI9YuZQsQ6rVyJS9/gyeAa7B2CHB1tNL1mGimwtW+xnQyyo0UhYOjaY1BPbVE0ftKaRwr4f9v+WgNny8HuSyTOFRUyqsAR7xzAsbR0HRjPoUlgHQlfKOaUUGtMdxxq8oZJ//xmE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3696.eurprd04.prod.outlook.com (52.134.15.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 07:56:35 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::751e:7e8d:ed4:ef5f]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::751e:7e8d:ed4:ef5f%7]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 07:56:35 +0000
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Add snvs clock to powerkey
To:     Anson Huang <Anson.Huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1583998450-19292-1-git-send-email-Anson.Huang@nxp.com>
 <1583998450-19292-2-git-send-email-Anson.Huang@nxp.com>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <6d28f6b5-8736-1c99-b3fb-ba253c9873d4@nxp.com>
Date:   Thu, 12 Mar 2020 09:56:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583998450-19292-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34)
 To VI1PR0402MB3485.eurprd04.prod.outlook.com (2603:10a6:803:7::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.129] (84.117.251.185) by AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 07:56:34 +0000
X-Originating-IP: [84.117.251.185]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 307f4581-8746-4cf7-91a4-08d7c65ae2e9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3696:|VI1PR0402MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB36961C95BD53B5E158991FDF98FD0@VI1PR0402MB3696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(66476007)(66946007)(4326008)(66556008)(36756003)(2616005)(956004)(558084003)(16526019)(186003)(8936002)(26005)(316002)(5660300002)(8676002)(81156014)(31686004)(16576012)(110136005)(53546011)(2906002)(81166006)(478600001)(52116002)(6486002)(86362001)(31696002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3696;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3HNDDT24cugO0dAXo0epA59TsmiPWIZjrfUTQ300SuGbj7U3xPqDLzUo6Roqn5V9Xl/+P53HwhepqD5TMXcYt0lWOm1A2D/ogYrjMlgsJZ6ikvyZOMfvU9DdJCpw2xFhDTuOJ4PiP7OC3RHauo0ybDzwphoEjaBEfPJ11dW1nmA543/H/QSkKkVl8ET+TRvzwR5fPlarxqz4nARybII6a41GLWgQElHPp5uctImOZdZeHO4jKA5scQHbyqxEZJw30Idu8gOdMPg4PhPzfBihq8ROtYW7/SFEGsUSNUOlLndoyQ6zvTA9DivWfgpDn3lVBd8S2Zwg3zBsF+k1e7n+rsbKFhH7jWcKYWztcxQJh12Tb7RLdIqHfr+wkJs21KIsposyrXX14/LNoyDJxukQ609+SOS6Hf+o0PJKOviZbsP+sXYcQXPf2ogJbRTF6gaCYvT6GrwPMdxFkI5Fei++p/qeRDKW2nv3bNEpqLc+230p9dSzSf3MgZ/UYI1r/tzI9YURLQG0cP39WyFgwxKjA==
X-MS-Exchange-AntiSpam-MessageData: FBhdA4USMzIkRgAhguEWHUk2ASjoR5JI2XGdWvOXF2wd0ZDZQfmYCHtv4R7ftIVFtxQI24hRP3MerB67wpsPh1AUT/3sHwr+wPwJI3Xao3zi2+euN/m47+slpcpOYWVs4zQP3FPdeDyN7DuJWdv0kQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307f4581-8746-4cf7-91a4-08d7c65ae2e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 07:56:35.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wCrJE3NebuylffAwLKehMKTLc8uNdA8qwIM5PKnpbN2nST0jT626wve2/a6fsnLhIX/zRynR1+2uwJeL2dOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/2020 9:40 AM, Anson Huang wrote:
> SNVS powerkey driver needs snvs clock for proper clock management,
> add support for it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>

Thanks,
Horia
