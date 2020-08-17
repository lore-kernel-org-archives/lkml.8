Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FFCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048972063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HxifqZOp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hZBCjbUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391374AbgHQSgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:36:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16018 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730949AbgHQP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:12 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HFvxsG006356;
        Mon, 17 Aug 2020 08:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ru/QzUmDBQPL9zF8MA8riJCwLubgyXTRHACfWo3hvDA=;
 b=HxifqZOpY2zxi2CLA1vaoOhH6MKiCSWM88hEWG6tJggTnAKIaWXFdXq/EQGn3yL5QaHe
 yFp6+mvMIDN0Mnx1Mx2jAl3cZL0H1abNfnXeemuf0lU0VMllVtKC3Q7GZikIqeEhBM/h
 0CRGsNXGxmf/ncVz0yiwidplL5ssUEYfWL4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32xdepgkhg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 08:58:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 08:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJowb2efmvTveTiQWFXqgCTuhvVDumnlh+0c3wDohhAZ9va7iuNjVX0kUiuCLElHOCqVz6MP4/8Fv/r6rjSldcIRItaiiXVA38njb4tL1omzwTDSDuNHKXgo5cXPAYCLNZKuinH5l1QxB3wtoKePK9oj00TevtSjFatzc/VGi5O6V1HA/CmbdTnKiog0EHWb+dwc2+l7djkqv1OhdxlROo4BkDMd5h+ZV7Erc9EgY/iNaUFIvWd3tt0Ogekd4022mRCkvSEVeBT4Z+uirqEt0AiUL3OVmtIIx6MMFLrFwLaygRD4HARchRV9PTy+Nuyw5k/Hp5UsEGd5EJWgWMw+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru/QzUmDBQPL9zF8MA8riJCwLubgyXTRHACfWo3hvDA=;
 b=T3NFbYK1q21KXfi2iHA/jkr+JlpDjwCfqqG3LPlSUmHMGwvUywsE9EJAwatdoJM84W4Suy1Fsm5znS5f5zOJcpRZuH0JNP/EDIVk43BCUGBZ/jr5FAuOLdfCQlUpEqQPEz0TYeWkmVuC1qh5oUY5KQ44TVPM4yKbvPN+Mb1n+6ArylUlQY5eGl3w2LVGLwAJosR6dD2ffZLVY+PLL9JrHhAJZFyK2+hKJ+IKshkXAHbn3wlCghOOrMUcykB4i3UCSoVtrWMuE3vhbioWT7xL0BEWFmlbR2P/fR62CQTSC6e7aYt+G61CoLzBN0MHzBkPu4UBoIHmyTSJEN19aEYAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru/QzUmDBQPL9zF8MA8riJCwLubgyXTRHACfWo3hvDA=;
 b=hZBCjbUb0jqZoWXCRYtwoTtbBVvaNw9Qnl4jH3PrIrQBfRnqYTuBevG0PdAX7mw0pkR74O8t5FisRrKWvaAb9Am/FxP0Kpq7L51MsrO3EgyJI795nFDwfZgOZctpyWVnDGeHB8QP9T2soevz+gRd1QDjbfzOPLw31urQlkMb/QA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB4087.namprd15.prod.outlook.com (2603:10b6:a02:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Mon, 17 Aug
 2020 15:58:49 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::80ff:5c88:e972:a2b3]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::80ff:5c88:e972:a2b3%3]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 15:58:49 +0000
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To:     Keith Busch <kbusch@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
CC:     <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        <linux-kernel@vger.kernel.org>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
Date:   Mon, 17 Aug 2020 08:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2605:e000:100e:8c61:ff2c:a74f:a461:daa2] (2605:e000:100e:8c61:ff2c:a74f:a461:daa2) by BY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:1d0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18 via Frontend Transport; Mon, 17 Aug 2020 15:58:49 +0000
X-Originating-IP: [2605:e000:100e:8c61:ff2c:a74f:a461:daa2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 409f6e2f-24d4-4a97-9d8d-08d842c66e56
X-MS-TrafficTypeDiagnostic: BYAPR15MB4087:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4087EABDE295858D98B07077C05F0@BYAPR15MB4087.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vqWHpq1UsHK4OxvGzr3wVlPMq/DUqsWncXubkz1ED5FmVRrBTHH3iBqAutVpmch6KHwPqaziqOV9uxm4e5JkgRwBfTO9hUc1iMyy7ytSuw8FYx7+wMWaNwlUzoJakzthHithfI92751Do2jpisYBodb0b/idN2irQkfV0pIsKiFni99xN4JxcseUoMEJc4VmqPUUK2U9SWP/y9FxNi9DQTLvP002qXqMADPLjrH6Iyy7ZX6FU1zVkk5gULatAEmnllSRLoLhjUBXjGw6V7lTQK4ITNE8PsUB0dZjPA65smZ1ZsjfqsK+kFS0Sk//P+C5G+BvAeLk2sV5yB7P8sTZKrYN3MvDMoGYZxWouRJP4F9uupqJutHn6lBfTU6PcXkaYbFCona+8QNM5OmBAcyCUtseul3OFvAyoYWzTB4WEX3lgZ4N7xoK7Cv1P5P8ppQc6f3MNWTWfDHeLwf9Ad+0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(53546011)(966005)(52116002)(478600001)(2906002)(4326008)(186003)(16526019)(31686004)(8936002)(6486002)(36756003)(8676002)(54906003)(110136005)(66556008)(66946007)(66476007)(5660300002)(4744005)(31696002)(83380400001)(86362001)(2616005)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aW3PnnmiEGjhmExFYN4jx92QTxlXqpj37s9O0U24QDzOxjsob40YELeLtr44gB6G5hipt5SMSqGQ9nYYNQuNEqhpCtSEB85GQvME4OUn4VttJzreVuoNLns7FFiVIQxDB/MA8BxD3gQvxL+j4LyUz2Xmp7M5XJPKbotI/d8cnOopU4wQL5xo6NZxUsQn7PzSpEVD4qUc559FEBLBYmco6kBL9cA4DXzuW2V8dfDSrVwm62HkyrQCz9D82JSg803JGlqNBc/h1ur2UEcbje4z95YW3T6owIVy0vFDU9c29HEKDgQE4JlY3Dq6KFHKkwGnO7jJzbb3QT6Wd+IRoieQk7Wm8sLsEQV26+5PmTHOBUjnbL07F4GOF1FaP7PI+Q/E0Er3eBijb3243u8zo1/a8cwb8WgqO289X4JNcXLKiHiPixDdhdxxGzOb4EPW9/EWRS+/RDNq6+0rj3N/eRU9slWJf2yXbu/EwiTCfq8TkjAteCpZtDW/eIsKzTVuzW8MMXToolFjlwYMVYzDRI2Fi8MfrJFrFhsFzprMyLmTMSQndEQRamfZqevm6Z2F32AvwERvsQ7A93yT/p9c/vAVrGoyNUFKnUuIi0ab1N8rznkNnasc9LbVU8kXAFGJ9jbw8VRoObKEgSgAMkKAUm7ngNAmwl3O97fYePN/ompR2Q1dOr3Q6VUnglWFuTeq1MMU1n8D/dkfBeVVnQWEGm/uow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 409f6e2f-24d4-4a97-9d8d-08d842c66e56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 15:58:49.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOhM46YH7wXPQBubYrR5Uz4DshKRdZVOP+8JYkuIPY4ZZ0QsAhGFFc2IUmkvaYl4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_13:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 8:56 AM, Keith Busch wrote:
> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
>> Hello,
>>
>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
>> laptop. PCI nvme detection fails, and the kernel becomes not able
>> anymore to find the rootfs / parse "root=".
>>
>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
>> fixes the problem and makes me able to boot v5.9-rc1.
> 
> The fix is staged in the nvme tree here:
> 
>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e

That would have been nice to have in -rc1...

-- 
Jens Axboe

