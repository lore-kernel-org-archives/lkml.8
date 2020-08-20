Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8B82076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="lUFx4Ltd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHTHwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:52:51 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:55712
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgHTHwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwIvihp/QXca7zUxiLRHTkF9SlWE0SMqpVHYEkAK8syrrjMMU7uzDSc7geSltKDabRuMhNQYy4hyWiVMdsrDQsibm9/yXOvvO97B43sJCZmDnkXGhs4fp19KI9zN79LSFHtw6fjgiw5O56DZDdlTuGevxZtcFlTchVXKwPEmjncuaMoXmHffAaLR4Z6TgJqIiRPUP6V8BIqlXCDzr9w4I/1B9tMHfm+WUjSmCY9DA+fXef7rH6Z1OJpji3fO4nkqzLGWQg/4g+bFE2dWm7JydPOxLyWHqEVtrrYtfGu9ckmM8sp/hTgkyW9VQplX09VArcJ4tadRPxigJLok5PQwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRi3V6FNJkkTIWaeuZ1/4YbTh9G8sffk/HVDfxbdOmU=;
 b=IKmhP8Hn8AzKWVaDTj/NRg90zKrXbYXvqz37PLAdABcCiaSxl7QNspcAgSPuqYktokjdD1B5cXk0j5ey1+nhuKnoPkuJ4/eX+VVrXP4PBeWt7P/OD0gm5AOd00/iH4UA2k+qw070wz+8VXOKts9HI1ScFLvrKmDsZam4ouPMZBtcUcXiAwAjMyXheySmaQkh//nIKNKsDw5X3lpd7iamBaWZ0YbMzU/kogsKr5k3EzVoHnemugo4Kbp6gfF3j0Uiyu+4IrGrmBIQetMuJ6m/b9KWb6jhOem6JKsm/aRcuQd1orIi1dNXMyPyGGliQdrDGxdTCMRQOzu2WJsudOXzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRi3V6FNJkkTIWaeuZ1/4YbTh9G8sffk/HVDfxbdOmU=;
 b=lUFx4LtdEJRh04bEicQI8zEZ3R1Cqw0X/FWQsT0GtzToy6xytMxybHqokHjfHXTSELj2QCDESyapZNq8EdKy/bzVtN0Su8kG3v/XisSHCmeZxenKgkM/XxhhHrgbzn+fxtsvxI467PkbZZVx4MT4E/8RRq6L1K/sEUg/ahp+KZM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:52:45 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:52:45 +0000
Date:   Thu, 20 Aug 2020 15:48:55 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/12] regulator: Fix W=1 build warning when CONFIG_OF=n
Message-ID: <20200820154855.46881c8a@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:52:42 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f4b5e31-caa7-454b-c5f9-08d844de062f
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4563ABDADC7B593F2F7D7097ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:55;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktaDe+ueVbDfddZNt7E988Ne7koaqgzzEmXUeTqTrludGbH+DWhQ/0uNsa/xxCsYvglFUvIf1HaYfuoFcOMPBfCSq3f8z/mFNL4PQ8zDSUmGy/fYiW/G5fwfRXyU7MlH/ocKNLUuJv7x3MkIVJzKgt12YnaPSbAInuvbT7L3czSh19Kj5I+9hE2BwSW3lQw6UyEWzvzrz2zKNWycu3ZpJBW9djitId5GCWdS8r8Fx1vzYbFRI8UgCrado5rLvH753K9dFS++zNVF8UgfuIw4sYzAj+q7W2ToeK5u18mG0OzfTuiwSK17FC7R0MKdQK1TmaN9SQ6xIb3vo2jlZLABpoyhQzYuw1wR9IRCT0mxaEo60zgmxGKihvWf67jTzYKb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZC5DCiUXK6U1isQmVa9P8s6DKrBFNcwTgx4jMItlmsLKql8MJ5Am2BA3JJnfdKzKO7A7C2/Z0sL9US/Uz4MxEWVAuNJI4Liv0fmPeZEPsfHgm6LFcefWD4eP6FwCb7zQn13+r0SvaHK7WTHV6iGFknOQgppw/9+G6kLDnieC58IKVXOOsRVDP1b6EVxVgVppcyBg9sAtgtMKyJ5mwceyzRAbnBkn5t1vsSBdP/EeD78BDEhqtQlnfHkSb5Hc+QFA2u3MlHU13k5Hbh2qesIvMTeXaDxohwDz7FQMovus2hM9okBaTL2tZH19bnSQnhoRYZ4cmk0xDbsY8xiPE+BebOacSXq3azL+U4NFtecUC9przi44+0XFV/JBhdBCCQWXEfg9pF6RjziyojQLLAstiqqqnwUNgrUVQfIOcjtqBv2SigNHCkGRcaglr/Cp9kGcdhKl/jBKB5A2zlEvxfDhbrotRhq6lqrVsskcChCdH7c2hPhEly5K0cmwnP3t5+X1De6FUVICoPmQQT9/nOBuHPpKbR5iSijZrC9bIZ3traJ0XNbu7zxYnR2VP1EfeTRD7XMZqrlMrpqvC3heTi1M1t4v1+kSdrC2c9Ryf9NZZaFvAg7701+w33NRZlwDTwe06sjGrW8UPzXKYEp3cNQS6A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b5e31-caa7-454b-c5f9-08d844de062f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:52:45.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG03/5xRyVzMENtl3uH3uLRJ0mYcm1U2LzsUoF+x6M/5ZZTWm03L/vzrWG70xkGgfyMf5EVuqBIQKkWKBCxCwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing W=1 build warning when no support for device tree is there.

Jisheng Zhang (12):
  regulator: 88pg86x: Fix W=1 build warning when CONFIG_OF=n
  regulator: da9210: Fix W=1 build warning when CONFIG_OF=n
  regulator: fan53555: Fix W=1 build warning when CONFIG_OF=n
  regulator: fixed: Fix W=1 build warnings when CONFIG_OF=n
  regulator: ltc3589: Fix W=1 build warning when CONFIG_OF=n
  regulator: ltc3676: Fix W=1 build warning when CONFIG_OF=n
  regulator: max1586: Fix W=1 build warning when CONFIG_OF=n
  regulator: max77826: Fix W=1 build warning when CONFIG_OF=n
  regulator: pwm: Fix W=1 build warning when CONFIG_OF=n
  regulator: stm32-pwr: Fix W=1 build warning when CONFIG_OF=n
  regulator: stm32-vrefbuf: Fix W=1 build warning when CONFIG_OF=n
  regulator: sy8106a: Fix W=1 build warning when CONFIG_OF=n

 drivers/regulator/88pg86x.c            |  2 ++
 drivers/regulator/da9210-regulator.c   |  2 ++
 drivers/regulator/fan53555.c           |  2 ++
 drivers/regulator/fixed.c              | 16 ++++++++--------
 drivers/regulator/ltc3589.c            |  2 ++
 drivers/regulator/ltc3676.c            |  2 ++
 drivers/regulator/max1586.c            |  2 ++
 drivers/regulator/max77826-regulator.c |  2 ++
 drivers/regulator/pwm-regulator.c      |  2 ++
 drivers/regulator/stm32-pwr.c          |  2 ++
 drivers/regulator/stm32-vrefbuf.c      |  2 ++
 drivers/regulator/sy8106a-regulator.c  |  2 ++
 12 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.28.0

