Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E729C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 01:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A5820709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 01:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="A0XQasre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHJB6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 21:58:13 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:45313
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgHJB6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 21:58:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WilUiai+BapioypeDUOdyiXTt2i/sefLRZmNe5k+5oi7LxVb1tUdpHS/GAyzrF3drDdalYWLdUhIO60zrMqCCmye7dWdj5+cExLHauobArnMQ1XePG+cxql3yPXV6HuXSEEbsTZU9qCQ8CPpB9dE5ZaQ6OcnxIA6hAc8Hby9M8DTN10exq2QxsNYjkNX+NmZj/vWekw+U6XDFAAv7LLGF1HaxwDVWkPBmmq2obaEuq8ojjW78s0n2u6v1jaYw1BdIiLPG79DFgxmM6+my39KF+KGPuVl1OmkTVxpQ0XK84BY7AUlv8Zg9U7MDQ4Z5gyv+E+zxaXS0+fVPE6oYLOTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNZUovORxJEq6B5aS+fjCDRsfOPtC3Se6hdNBPl4+Ug=;
 b=MaTOYoq74RN4c12wWjFgBwruzfURZHorNUueHNxQgJUxw1VLnPnPW2GqeOhfH6Zudr4jByCIKxq+Npk6q7dZ+rZKyToB9w+lo8rvluu+kGmqqSdzdHr+wtIhBQhhg7/gNHjXAB0RyX2NHd4XaMPtFg4qADRk40Ak3QfuvWetsqKx+UQhxMGW+ttsARM+NErUsi2RBQGKU1Ohb5I/G/jckeY4PT+Ucfm2poopITeTmdSwxmDoAWp3M7557/9AJBTDt+6egBdpw2rnhmqPZRT4+euZa8IRfXr0c0l3qLqsy2crpKILz5wXgH/ynyiAIY8fH1Rj1KUZrwzyyvGN6ZDhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNZUovORxJEq6B5aS+fjCDRsfOPtC3Se6hdNBPl4+Ug=;
 b=A0XQasreK64b4Fkzq5EoLSFxrtVMx6Q3qGjExGnPhfz1aIKo6dS1H/MS8+nxS5XIqkF7PtnlLhR1xM72gBYoizlmL8ZtzlbOEELSruUe+wU5j3o/Z8emV0kmTYXlOURVin/67pjpMzxCenY5Cgho9VEMryuj6pg7+IJ3TgRGNmE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4858.namprd03.prod.outlook.com (2603:10b6:5:182::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 01:58:09 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::423:b1ba:77e2:e14d]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::423:b1ba:77e2:e14d%7]) with mapi id 15.20.3261.023; Mon, 10 Aug 2020
 01:58:09 +0000
Date:   Mon, 10 Aug 2020 09:57:53 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: sy8827n: Fix W=1 build warning when CONFIG_OF=n
Message-ID: <20200810095753.59ce9f75@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0074.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::14) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0074.jpnprd01.prod.outlook.com (2603:1096:404:2c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Mon, 10 Aug 2020 01:58:07 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da8a2606-96ee-4d20-0897-08d83cd0d49d
X-MS-TrafficTypeDiagnostic: DM6PR03MB4858:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4858FB16F0A90397907413C6ED440@DM6PR03MB4858.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZzKtbh/RogsTxe/VTCRQCGa7Jq0KO5VRdWo9xok92OjBG59UKLHo/u04CXiQxUHwqxdWuDk4NA8ErUe+TPqrlcTeMwS+PuI3vQuXWzR9VQA4RUIInb6EFA33hg7Eab0k7wkmnoCR2otXJafpSYeyLcglVTPORppjWw8NlAN2Sj9xazytOtBqWCU0AxOXfA0J9GdOmAy6W1eZUZSXFCULOh9W1L8JWpkcJrqtLCoUOtotVYlyU3tpbmiYIB3BrbmSenEEj7OjCB5BhtszgdV/PV1aYiC36FNJ8GZD+lW70gJGmTba7fHf5ohEfu3YdTRKZo3cd4qTo+tyX/pEycA9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(39850400004)(136003)(346002)(366004)(83380400001)(8936002)(86362001)(8676002)(316002)(956004)(110136005)(186003)(52116002)(7696005)(16526019)(2906002)(4744005)(26005)(6506007)(5660300002)(55016002)(1076003)(66556008)(66476007)(66946007)(6666004)(478600001)(4326008)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aPM8ULlIfm1OUUeCTq7+s6qQIDs2tDd4QBJ2jfLnoXWXkamARNhVpeYe9qD2gm52MDuiGgAI8LBRWYrHMdD0vMtF9wNaVYS38AJuzc1BlPnpkSHg8gJ3+EQ3C0We0m1VN9oKJFbL1NyMG6TIzsj1dG0uhOaLr6qjCwPJ4O7+N1tKnhdLaUiUSnsPxMFLgoJLH72frSwh7DF/VqibiPod28Lcddqox6q2GNCUz6d8TJPjRz2E5kOSFm+e6F/fPlRArHPDl4UdxUG+XqD4MLYqNPvgf6WUwF+rJpFaRos9dPOTXV248ZnKCzYreOhetGHoleMgHCTJYv4iXuikVJfJgOSWAluXkISW8J7M1cSb7bgqN6HikSDh82ug2lpVJb3kAImEvUpuuJ/oyJCDXxiWYQBI5fBFLrkadvAs3yzUTGYwXf1Pz3tZGNnXKw+MAQljJ6LJcYs181ntzUGJLA1Xb0KfHmdXrHVcT4QuyYQJIfzAVHLVopMZdmRXdwLy7X+JklcMYP4te2Z7RC8lFjOFDd1oYSBXMgVQ3unhIdCSNuZj31MNFyo/C3X81Fxhf1RpfsZiIFfGYb7GUK8KuimNx1CmejY7D/JFj/aT/blWzz5Q8Of/X6x2N9PaE/+56CN2hJr2/KgW10Q0eadXEq81UA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8a2606-96ee-4d20-0897-08d83cd0d49d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 01:58:09.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gprc91gZqdrB1FdjGmXbrcFjff+G3HuKKHQ/BV2CR8+tbd0KSOeoURmqaLWmQx/Wx+n2QhNK+KEwtdzLQA1MqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing W=1 build warning when no support for device tree is there.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8827n.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/sy8827n.c b/drivers/regulator/sy8827n.c
index b207217f74d8..52e8c17afe24 100644
--- a/drivers/regulator/sy8827n.c
+++ b/drivers/regulator/sy8827n.c
@@ -156,6 +156,7 @@ static int sy8827n_i2c_probe(struct i2c_client *client)
 	return ret;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id sy8827n_dt_ids[] = {
 	{
 		.compatible = "silergy,sy8827n",
@@ -163,6 +164,7 @@ static const struct of_device_id sy8827n_dt_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8827n_dt_ids);
+#endif
 
 static const struct i2c_device_id sy8827n_id[] = {
 	{ "sy8827n", },
-- 
2.28.0

