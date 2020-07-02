Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB5320702
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="QaIN66L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGBJPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:15:35 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:17633
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgGBJPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKvBjRmBwNTIqUcvreUld9KOcwc+OUxY8vWhj0/rZZx6iBY4RWRKlR5agerDeLzLMYLbeG11eS0HLyzdF9YBnELzy0PBSG1Z/z0v94GXEJLbwFAmOr2T33bpAD1Pg9Dp0lP+5UIQTx/UT5679WIzvOYFGsyQa6yUfXliJuFw02W8WDAKAQNmAWqFg7al+ZBfkDsy92GpU8Y7OO/fe4Q3uPV536skpqMAwWWx4YBPL9MwrSarN1AXqdYuksQLy0fpbKqUWfqycn6XjQ62GY9Q5FilkpzYeBGENaezv9DFYDKDa6vd75abuWd2GRzlRwO0AMu3vrh4WE5kBAd4EFd8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVZkx6FRJN5JWnK2dO3iV06+2O2ob1Lknq2M9fcjV0g=;
 b=Qo1LS3zVrgirMydN7i0oKaNec4I/9Jb16+YKg+AB7mI9YjtFa8HQyQGsaql5d8LB2yXGugj+2UA8EGSJ7zaRe40wbxZ5JjkJJ8HEvC5yetvAYT9dCqnJ/GK7Qyr/1U85PQrfcKTY9FLzuYUJWDPDFWbOrj+i6aECNOgoP74ymncD07eN5Z8IR71hGxfp3J417Ek6ke6liZOixCGSxPtDNmZ+i335lgDmTbHJnEf2buxMeegRPj/ZJ0wB2K2vZ3rgPHM9FHSXCm9/wAhtI4rN+wl/laguX4tZbED9NAP3rG7OAvJcSB3TtLjBKFinv+H60QLoaTi68Uz5eMnL3fCvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVZkx6FRJN5JWnK2dO3iV06+2O2ob1Lknq2M9fcjV0g=;
 b=QaIN66L0MaVj8y4qHTksKndzxOKrlXE4JXBmXjHHvLkO8jhQFP658AIt36tqngp+p9t/TJL51x99aqoQw9ORAnlpk/WKoKS2MgtlECNjmKyMs7VH5u/862Np3cXHi93kULjsOl1qz9RSuY2HiCJIMk9uMocjCgvLLr69SxleOPA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3574.namprd03.prod.outlook.com (2603:10b6:a02:aa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 09:15:31 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:15:30 +0000
Date:   Thu, 2 Jul 2020 17:13:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] regulator: add support for SY8827N regulator
Message-ID: <20200702171304.68928e88@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0144.apcprd02.prod.outlook.com
 (2603:1096:202:16::28) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HK2PR02CA0144.apcprd02.prod.outlook.com (2603:1096:202:16::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 09:15:29 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41002daf-ba28-4ebe-d4c8-08d81e68778c
X-MS-TrafficTypeDiagnostic: BYAPR03MB3574:
X-Microsoft-Antispam-PRVS: <BYAPR03MB35749F11DD82AF939E02F2F7ED6D0@BYAPR03MB3574.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZiGV1gpNSFQoGinMcXDsKasZGI+13DGTvlS8OeXFeGW+b33XxyxsCxFlR5d4bTWvQ84kBC2E80wIzgXCEutWJBQYqNwr74+aDTorc4ti/oswd50fp1mUqPwYg4x4ESLW3L+9Cu31lTRhFrxla8DOpXIVlfXb8GQZvwBC82RknUVQIXngn11gSMHqh4N82GB+OtTuu4ryqjkbqO+AL0MGU4hKS9EkCgoczaLLPQuttL07TcsuFUgY2IShaiaqaBnwbMom3udmjlFva9iPv9SnS8opjFflvP+X9A7Ua5+p75MvnVVFOT4+TfNMFoYMkBXa0QjYWyouCsgYEQn6vvbZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(39850400004)(346002)(136003)(956004)(478600001)(2906002)(66476007)(66556008)(66946007)(8676002)(8936002)(9686003)(4326008)(55016002)(16526019)(26005)(186003)(316002)(110136005)(86362001)(7696005)(1076003)(52116002)(6666004)(6506007)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MY/alwbgSDH9UluAfmJFLUvjaqflBlIit3KP9LVD379+73tMEr7N8mF9ddWVQL1gww8VdY0Nygui0tYpHMw6FkmdktE67n+LcNWlz/VZQVydIesgGRJeqF3sqZVeZe2IH3YL/pRJHFJsFvPpg+YK8VnMg5GFU+p0sk8NaMIGWJCHVxgOfrRGOrSw5Pq4MMqNM+LYb5EDNReBV5O3siKsLq4839CoIFTJoRGijl9mQ6SHQ7nYaE0yU+TIUjgfFdp3p7G59H2MMVbFzSEJ73vpLPI3G/ZlNRxqsL80+VV1Tkm5DOR2Z1p8TSIqOaEAiq8Lhzbhao7yr/dugNr41wlU1qh4ZEw/AksqoF9LEOOCtFFUSRlUyt2Y3foArM4LVg7VjdPl21lZ57DRgnurJWWXSAgwhYa2yatsVpYHKYsXJNgQg1c0X4BdS7HoQq6DNiPee9vnATtQbJhkqlk1WpKbEdTN5ivejK9m6IO66tB6xBKBPlFb2Y4EOdyDK+kQiYgJ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41002daf-ba28-4ebe-d4c8-08d81e68778c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:15:30.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+cM9s/LzVheP5l0qPbq23jQphjoOO++qdOXVDhdJmg0tvMY146YdVQ5B9qn66T+qygNKtnQPU6UzY7R5NGHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SY8827N from Silergy Corp is a single output DC/DC converter. The
voltage can be controlled via I2C.

Jisheng Zhang (2):
  dt-bindings: regulator: add document bindings for sy8827n
  regulator: add support for SY8827N regulator

 .../bindings/regulator/silergy,sy8827n.yaml   |  45 +++++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sy8827n.c                   | 185 ++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
 create mode 100644 drivers/regulator/sy8827n.c

-- 
2.27.0

