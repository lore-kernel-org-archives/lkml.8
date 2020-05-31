Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14FCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7333A2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="q/GSoRD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgEaJEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:04:52 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:34657
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgEaJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhLCIAhxJBEE6vlKec9KlNg2sYU0CoAsL7Vsi1xqFT5UTt6oyblYU/dpvrN+qV3U7j369AO/TjsDsVoE/tidVCXbfchVDcItfViaeO5HZYdhjnNP80R5Ao+c+qDUTudepKS/XFR3C2dJFdNgjri2JZG7TuFgFphSMQdWgxx5CVCXNUCI1za/jCDkwacvpDZ8K4fcRkP0y0sdv5ymjaxyIKgIqj7y4pnCJHcIQzPG8t8leMfYEcnUUfW7ycABMfByAy3YCVfTnAlWmWPXteoGJG6A6SNZPdcOXtd4bCeemUfkR0iGhhpYX0yFqKxy8+XPPktsUFDViwe+S8J5Ey8XTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYfljcGXqaco32+70Lj98gHmuZ0rF9dLeifLuc/KU0=;
 b=hObdg6o845jYmOh09UGSwC4nHd/swkBifco9VR5Mz+0sZt7uTwac+g57Wu+9OKBtWTj3YvTIXcX9DId/irIDhDrEzryiP+SbOcO187tJjW+e4lB2R6m9FOe1j4cemVAB14QXfSdIjTusrA1rw72+nwi1HB2el+zLJOTJvaIyDBAExhmai98Kv/80rcdalj+n7tOjVku9JOAnWBwutgY0bMIhs3QHSr3j85AdcA7UePAx9AFTw+mk2gn1zzqkO6twVZDm3Mn7wO48XoVksndjnnwOTlw+daEBX8ypubd2iJlYji0OdifF4q0I8Va0GTGO/LQO5lX1CTDVYFSmBqDW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYfljcGXqaco32+70Lj98gHmuZ0rF9dLeifLuc/KU0=;
 b=q/GSoRD4XGqak7zno7TYJMywRkUvIZFHpf8XJ9E2M+ti+mxPCWqrzt0WW55Pupb2iR/ESRHnkxrUSwGs4ubQSWFfVJ+bdknuSUzgOjXm32bqXguW9Y8kwMdO42ml1Dd1+6JTLurmSGavNi4TTSi09DWUah7ybomDcgWmBYzFiqU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5714.eurprd05.prod.outlook.com (2603:10a6:208:114::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sun, 31 May
 2020 09:04:48 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3045.022; Sun, 31 May 2020
 09:04:48 +0000
Subject: Re: [PATCH] nvme-tcp: constify static struct blk_mq_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0a5e1752-95b2-f5c9-b6db-7c7830561ea9@mellanox.com>
Date:   Sun, 31 May 2020 12:04:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:200:42::12) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM4PR0701CA0002.eurprd07.prod.outlook.com (2603:10a6:200:42::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend Transport; Sun, 31 May 2020 09:04:47 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0607691-ba06-4f64-675e-08d80541abae
X-MS-TrafficTypeDiagnostic: AM0PR05MB5714:
X-Microsoft-Antispam-PRVS: <AM0PR05MB571447C6F9B61A382F8EE467B68D0@AM0PR05MB5714.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvgmH7jPhXJErlXw6Abdk0oH9KYMFhXE1qPsxKuC1VeSvEI8G0iG5M88gvkEavbk6dw6qkwCKecyqDDTvdSD/nf9zqdWl9ubp5Yhs8gmAnrEH3tXAvFZhj/ezMftVSrywGHQJpAwLtxxDZsrVW7bNQY0detXXERSz2LeYz0+VyakXbgZxAcUUIQZX3cWSmKin4i3j0+NxBPrOwkMyAJNZCvJpaEptW8OzxaSXhMCu144SPP/eYaxhBTYrDnvkFrSE95gJiAYfSuvCkhaP/AG+6hYSMCIJ+/yxaU38qyeJ6r7lbdJc4iV1Wc4BEpVi/uodVvlBjI6x5cHjHQ8L2ykRl5ORl/mSvoaw9CfdQm0iGurTL76flYmJ4RobTswgAHf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(956004)(16526019)(186003)(4270600006)(19618925003)(478600001)(6486002)(52116002)(2616005)(316002)(16576012)(86362001)(31686004)(8936002)(4326008)(5660300002)(31696002)(8676002)(558084003)(2906002)(66556008)(66476007)(36756003)(26005)(66946007)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xhhLkWzZy9VQZM8K9phvfLnw9GclgmYokAJkWmxpM/tFi7PE0IQzwmxZi05o67E9oq6rhDHZgMhhMhJTTMRcOU/eLXm7OZmTgIFUffw4V6kQoFJRKfIOH2ybppz18aYzVGKymd6WBPCTWNLuk4OuryPUaN3bNvpBVjnN5wSCEJKdIdN1xTCl5H6Q6nutyKKesyVg35a45lgOCjKp1PlhFOiY2CpcFYso1QcWGq49cNUCVOSP32qC2lZjYYqIwKkqTFk5bm9g6CWwikwrHyjMNcrWcYED+OF8TeMo//iXFbxRuficINCA382qBZgvVMkBBc0DJTEBUDdDjYNlDoSQG2obcxig8SJf7gv76JKLgq8lsxikEbam//C6WFZ+dnw0+JckgLdz8CVTrBsAJ9ZfQnCpJaTAPr8iRJcU8ffvf/k+DmLYL0ddxylPSqjVLudb2WWRRTSGoGNYkpH8y1QxopvHqzv2BSzz66LlcQdv6Pg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0607691-ba06-4f64-675e-08d80541abae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 09:04:48.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7DYWkJL97aFzdVfFITbab2vsgBgP0YL+cijes1sUH/EexDwXJJUpZGeInRAlDDn73WsyFX6GHa8bCayHzaHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

