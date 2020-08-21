Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6115C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E482075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="iqb3h5kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgHUCTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:19:25 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:52480
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbgHUCTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6f5R9aNUmLrGHuJSRq0/KI14YpFpwKJPhC9p8qIyfQIzgaUX7E4nJOi4xIRysKq8hp+m/EWZ51dBN0YIpcsLlmq6h+4BUOuCemRT9N+VXrbICafbuGkTwabYhxZymzfuO9OZwniOr7QEncK90ufbQkkBJyNQBfjbimMyA+3pvbFdlusPkPxBZQm0I2EZGwsAfXrZO088VpKyQ+HtW/tFSUQiYjxfwXFnkzUTk38cMmql9LUCH4r/BhtxxguX59yah0LES0yIc8Ba84akiR3075gA0Yb9HRDotUh9VnyNh6TTDgeKqF1O+Phw+T6WBWYDC7raq446F7+B5vfOKSllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fq5SiOaTYdX32V7iVt1nuK8Uq8FAEUJE5Q8hg0hsC0=;
 b=aEQJhhIuw2G1dmO7+axkjlSRk0wPKa2LVM7F+5gYaALJ1QR8jVg4HWnbWhWeFvhbEQnfMJs7d/wgoh1bHf9HynJ2dF+SlYYi522mpgzxiL54rOn2n2NtkxKT4jW6LWClYBjmQIjDJiyU8EFd+3W1NO5Fbi2t0CzWFPNn9j+SxiMzUz9ZlBpeZKQ3ywdk9Wb3c8bj1j6n7JhAtFixs488qqFXLsExKRxAnhHPAYBpLKyzWOKL4+vpzpOcd9Gs+uqRMMj4HwL1AyJT1KSYkWCQzKkS37Bl5iwzgjA7HFqjyi7vF962DytLOuQmVsBFFDwPWGI21xi1HVzD3jmdJ12r5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fq5SiOaTYdX32V7iVt1nuK8Uq8FAEUJE5Q8hg0hsC0=;
 b=iqb3h5kZCGIvRMQPJTPyy80RLXcq5b4of1cFOcnvsCT/kH1NmRfZwMhx58MhAd0EXI1SrhWk1ykQDhzX6NDcUEoSwH0cpPnM6AgBy/z3IpENLp36dXSPeQGMyOP1byNnnHtPffmilklwG85B8SR+VxyCiisu+2XGRj0/T9sgbBo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4233.namprd03.prod.outlook.com (2603:10b6:5:8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 02:19:17 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 02:19:17 +0000
Date:   Fri, 21 Aug 2020 10:17:29 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] regulator: mp886x: implement set_ramp_delay
Message-ID: <20200821101729.76f1951b@xhacker.debian>
In-Reply-To: <20200820210513.GA41191@sirena.org.uk>
References: <20200820171020.5df4683b@xhacker.debian>
        <20200820171051.55a238e8@xhacker.debian>
        <20200820210513.GA41191@sirena.org.uk>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::16) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR01CA0052.jpnprd01.prod.outlook.com (2603:1096:404:2b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 02:19:15 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0be932-a328-45e2-e333-08d845789aee
X-MS-TrafficTypeDiagnostic: DM6PR03MB4233:
X-Microsoft-Antispam-PRVS: <DM6PR03MB42334F217C28FA7294542A41ED5B0@DM6PR03MB4233.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOGGkrV+C7OX9r0qZAlZqAiSzMBE4zIdju9KtjQWjphJZDUPe+FWhEuBXN1M7T67Cvzd3hnGNIP4WrHWMGToumyHa17F3XR6FAP/6swZoqqUmOxQliqYh83suaxltmgwZhep6ieVhoMxsiOJCo+7Ci1vVbEyOZ6TE/4Rlfz64Kn9LTM2R/19I+DSn+8B8MIlZb3VAZ4Iaxb5VesbffecJ5Unn7RxiWx0kpoK/7HA0A1C85vAeD4hiCk786NylCgzB20DMyyHJ2eseRVl5Qyz6eM2qdvPeT5E1NF4e1omJJunIqepZwIxLZEdSijBKmHxmnNNhReO6EWqqWGeR3LCnyO4SE0/kIEm3lm4yTb287B/zhTNxu8viT6g2arpCUme
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(136003)(376002)(366004)(66556008)(316002)(4326008)(66476007)(6916009)(6666004)(2906002)(66946007)(54906003)(52116002)(1076003)(956004)(26005)(5660300002)(16576012)(86362001)(4744005)(186003)(6486002)(478600001)(8936002)(9686003)(110011004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G6iyJVTZ4ns74/AaPlIuXAn3k5QIEkdiq/dlqu6e6mEzZet0EVpMatDluEhGVikgu/fXLDjo2aul16i2wvl5eXBokQFPRQlChoetnmloulqzFaoHAg/ca7UeMsVighZBU/bq4G1/f4Kb+b53emNFzLXgnZSw1Aiv9e2kcLxFvwgYyI696/QpTaghLH0Hy9kNrgSmuHpmYxBWsG2GHQewD3d/sxdWhmPan5wwmVaypToCwRCyi9aLxoCrbhadafObiBVlYw9mDof4FgcgWIVLXz19ZUA/Ev2A85e8aIfpPhH9Ar8F/uPwiYlk8IQBPBSSnHVrXYnjSjmsA7h+1sT0F8s/ja/9tQJpX6KNaicD6IbPuwik7LZvEiDw7oTXPd/0snkIvjbXfFhhR7Bi4IzvwsqhycCjm3uUYQmTM94+goz3y/voFY78LyPTl4taugY2dOv48VsF8TBYQchz5WfF4Scs8Jiqzbq9XyNF2ofLfyNYyIOnBaWgAJbuKrTxP9f2oIURFqBuOUnbtOzxb9N+nVh64rCJAJRBBV6IQlM3cfc4esNWCezYnAjk52drw87A+38saZvp59tI1aKBemkrVAXUMT7SUmib3w32HqkKFSQlQnSk2hMyEDr4c39P1spvq+CvpXlQq4GyZM43GYrNdg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0be932-a328-45e2-e333-08d845789aee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 02:19:17.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ+7pgeGkBRr7w8iS8gCm3XRINGd8BWIHG8Yj6PDQxmWQA4FXWIIhRHAQazim3hM4TIgVqsFT5dKfyMg38dFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 22:05:13 +0100 Mark Brown wrote:

> On Thu, Aug 20, 2020 at 05:10:51PM +0800, Jisheng Zhang wrote:
> > Implement the .set_ramp_delay for MP8867 and MP8869. MP8867 and MP8869
> > could share the implementation, the only difference is the slew_rates
> > array.  
> 
> This doesn't apply against current code, please check and resend.

I found the reason, the three patches in v2 were applied to for-next tree.
Should I renew patches based on for-next? Since the "mps,switch-frequency"
binding isn't released and used, I think I can send new patches to convert
mps,switch-frequency to mps,switch-frequency-hz.

Thanks
