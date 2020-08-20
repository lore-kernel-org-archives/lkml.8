Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B1BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61422075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="RRi7q6jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHTJS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:18:27 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:58367
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHTJRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN1WChQBdiNk36XRchabJxQsJ21ZzDa0PAwGvOcueEluXsRc6vNOw0549EdQZnCuBOK8EjVSPiTxHFgzOSpVPT8G/59Z7LEAS4E7DzfIanC6dPGIKMO28ZNaEHP+t/QxxCgln7SsI3RTSKJssBzzzC5TPWl9cER48e/+jhC0bkSOUDqQWW/7g5yiJJDUSxNNDzK8LHlDnMFqH7mXil7mRdxcEPbGlqNZRXQ3v883vlsIdrwzH9PzYKqlATC0uqstx3xdUBVWszLUdbQba3Rq9zl6D1KwKNonRc/CVKe/hbwgvKLbn3X0kijKbqzQ/Gi/8+Gx1WoCrWPvUdhP6xaupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOlz0rOvq0B4LnjXQCjHWP2Xt33H2Nbm2JknmN1I6fk=;
 b=Oi2anP0zNxh9ykvnHTPRw8NFoT/Zy+CtHlq/wGS3FvEmHZ/sUaXBFLtjRYl39yli1EzlHBEFwCZuqvGSHryQhz06+qdHRQf+Sby6BbZmfal7Jgy9I3GQKngwzazz2WpI1CKu1KulpZNwrv91/0AMrRAZDI7deGD/+rs3LYVqhOTowdbtL0pWJ+7qnqCvJIJSw3oyLjoDOYAY5p+DPQP6hGuipAIBVBMzT5qxG894q/SO+FWQbdolt7WciA5fNuOOzEzKWl4a1f9kD0CBOz1i0mTl+L6IJaiCodj9WQwKcTN4hV1K6e+b6eAIhwcHxx6nzlSSy4u4HTKWNOQ/LYnsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOlz0rOvq0B4LnjXQCjHWP2Xt33H2Nbm2JknmN1I6fk=;
 b=RRi7q6jE4rYWsaqRTXFUVGeKzlVO4qnKv0Q1Hb7sEITX4yf6i1ZxYgsfPP45t5ZipJm3+grdaaY2KZ3kxT4WajXnX4FJuF7N+CTeiFiP0HeP3fZe2Sh6/XpCgEjy877BWP4OpXWXlJNRk7tSYl+cjD+7fEWdAc9RFIQYjrm+fcI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4738.namprd03.prod.outlook.com (2603:10b6:408:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:17:09 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 09:17:09 +0000
Date:   Thu, 20 Aug 2020 17:10:20 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] regulator: mp886x: two features and dt json convert
Message-ID: <20200820171020.5df4683b@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:404:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 09:17:06 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d3dbf7d-08ee-4446-aafd-08d844e9d04a
X-MS-TrafficTypeDiagnostic: BN8PR03MB4738:
X-Microsoft-Antispam-PRVS: <BN8PR03MB47381397970FD3295CA8BBD1ED5A0@BN8PR03MB4738.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkZkKL48Vh6V8QGXGjZaLnlH0ILgelH88sPDMRnjl5s4ib88A2h/PR12aPMw++dob7gsuib33tmkus8z2a6O90A8G1N47b8Y/bYI4Eu1nIyC3at+STuHgY0zq4eKmut0lKAsfV8nOXqjBGesLbrHbmvJQURSD38lZExwwnY5Dk+tDJ+nGTy1HhEx1kACyg9Ia5m4OSaMV+G/weE6LZcluMRX2PnvzZ4civI1T//xUcFAcRkYxDFYu88JwgJafkP5YEJstvYJawmq7fW8DiuZm1/oGjGxY68Gq5TajBtXQ3nw4d8vIiV0HY4To+V7AOD9Z7tWJjXTIOqP3kCH5LlJ7MED6VKFSdI5YAyNkUhV5YtZPnkZsAJj9Eq6E2LaOF3s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(316002)(2906002)(110136005)(66476007)(6486002)(66556008)(66946007)(110011004)(16576012)(4326008)(8676002)(478600001)(5660300002)(26005)(86362001)(9686003)(6666004)(52116002)(956004)(186003)(1076003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JXIfcYCLubFMrIDzCj+x6vgBNHJ37An6SEHC3lDbsJzErd9QmJCVhmPnhl52xtxnYMWz3MsAxVSRGn+wUfZjzMl/MH8QZKCeg7Thzyr5YdhHnJdcHuEkP2yv/LjhuWNnkCNRcshv93eeT3JhYlp49dlZrmth+M94OPoI6sgyDz9X0s1hafsu7BZj2A6MaoFiP65JtVTTuxnLBoh9qC5yBjxYu2ZKMpuo+n2QJYfkR6KVKA0shpy7qKMjsCZnKfxGnkdT9kp+oUvIJ7gJ5FTek9qoi4RCYLM0H1vGVpfbuWRZ/b8LvVCy1s7xHA2xXaIA3Rgz+UEn5SNolsTjX022qD4dqzKOx1APRKj3F5evclPaJHuEPF729ElOLHg+ZVONVkcCfzZQUChWvpibAQuuvbg4E2VSovcIyX0b4KHwmavsWrCBs1nJPC3TpOJ9ExOvBOMSb2esVwu/0XLVYXJlK1gPSBXvBFZKEU48GzWvHHe9jF0RQuPzCv406jEf70ZVZX7LYFhxgg5kU/OZfnB6in1F9/SfRjFNXyaJ03/DH6UQUpJMf7rq8CqxPCDGf7mvRFfGH35V8AXtNqa8uOC+ojnF67nEqP7NVgxSm5XZXZnBdnx/cGxiVHKvwx/wC76pCmYiWu4e3gTrhcVZ4qa/jQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3dbf7d-08ee-4446-aafd-08d844e9d04a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:17:08.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEfpo9c6oiCrEj+xNP8X0rTEpBJ16sDtrMRRmiPMVGSKdMXhlOCXe9u9YcXShg1H8XQ9KfiATJp3Z7+uXzmtrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to improve the mp886x regulator driver support.
patch1 implments .set_ramp_delay
patch2 and patch3 support the switch freq setting
patch4 converts dt binding to json-schema

Since v2:
 - Use mps,switch-frequency-hz instead of mps,switch-frequency
 - Add "maxItems: 2" to "mps,fb-voltage-divider" in dt-binding
 - Add a $ref to regulator.yaml in dt-binding

Since v1:
 - put any schema conversions at the end of the series as Mark
   suggested.

Jisheng Zhang (4):
  regulator: mp886x: implement set_ramp_delay
  dt-bindings: regulator: mp886x: support mps,switch-frequency-hz
  regulator: mp886x: support setting switch freq
  dt-bindings: regulator: Convert mp886x to json-schema

 .../devicetree/bindings/regulator/mp886x.txt  |  27 -----
 .../bindings/regulator/mps,mp886x.yaml        |  61 ++++++++++
 drivers/regulator/mp886x.c                    | 109 +++++++++++++++++-
 3 files changed, 167 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml

-- 
2.28.0

