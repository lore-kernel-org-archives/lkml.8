Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0603C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57E6207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XiI2d2CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgG1G55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:57:57 -0400
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:6752
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbgG1G54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp/QkqoWYP90eJVpgPL7Z2ZMZBaem3XgWXD5Ca271dacs52eTyikJlIXKV01PEf8qEDOWKH2FskwP2KMyim/mGWOze4Xvo0hnqNu3gnDnTeHtEOLnflwlw6QkyKAb2Qbq46nb4ai54RXk9w2sU1BgZdsP/YfDEVTtKr9CRbx/gwiFWh1J6/mMld9DctqIuNC2sDVsCbu/Pzxc1/boWx1SJv/HOuWCfCfYiXzyeat0edaha907PYLMCzYktGjpiplDyompisGFymLkzTTkuI3ojZHRH8/zpK6sn+LAant/p28O8SlT5H31HWj0uCoBG+AUHZh+w3rQMetjNEaXJDasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AY12Ct1ru5dz2YMX5IRLKUyzB9Zkt7cjgCUQ4SR+f4=;
 b=KKA5ZbnBmkAeYC0fntZZcPObZjmQmyVBsJDNFGB/3gdOu3B+p23Jj+0t20vj1ZlGy2n55dWk7+N7Gleic8JqKLnl7jHXcSEU3NpLNM1m9c5kOqANYgwzYnMS3RGBRN6+9XFEUHa+5dSj7uflStIcisIbPsACVfB4DAFv0TwZYCK+nKqg4QivP1hGqhl7I9uFmbw2VoVhhpesf0LMelr4+oXvzvhSuSLZDZS8pTttZnnSpoWLw+VEMeGfD46DzVQHR1GkUyre7gi6o+I1ooAcmWi9pMPJJhoPtxwUV6S8TQaqTAn4mH6ZMNqAO5gHKx3P7uSLovve7TVM+/mvy7Va7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AY12Ct1ru5dz2YMX5IRLKUyzB9Zkt7cjgCUQ4SR+f4=;
 b=XiI2d2CFmsumTgBLNvoWBd+Meco6ZDBoE4DmvUJBJudQQFubjwc5Fqfn4qmwCVymWXeAIM39KX7AGLRjqOcglHye6+e39ScBj1z1LqknZBefvgvT/+c+m6wRr4FNZKNGIQAOlhsFy1AR4lhNQnrb5PPI5hmnGcd2MyCWs4MmiPE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR05MB3379.eurprd05.prod.outlook.com (2603:10a6:205:5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 06:57:53 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:57:53 +0000
Date:   Tue, 28 Jul 2020 09:57:50 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200728065750.GA233546@mtl-vdi-166.wap.labs.mlnx>
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
 <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
 <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM3PR05CA0146.eurprd05.prod.outlook.com
 (2603:10a6:207:3::24) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM3PR05CA0146.eurprd05.prod.outlook.com (2603:10a6:207:3::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 06:57:52 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0cf3efd9-0707-416a-8460-08d832c38cc5
X-MS-TrafficTypeDiagnostic: AM4PR05MB3379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR05MB3379E6229557F66B92FF4230C5730@AM4PR05MB3379.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8sHf3Xi38ho+qUv5QCTq64nASMv+SiJnoOneOawv1RXHD2VDEoCg8mnDDylGkpBKjmlVHIe8R4FjDc8nzdKgN7gGZBFfbqn5UVzvzVWNPDlK/79JC8dFVm63dPjHvfBrZWrFqB5kcMf8r2YZHF47+Tn9CeuFIHYftqncEgqexEnv1xXqdXSKsMTychA+mWWDvRntdHs0NzbiSVqkkXQ3J1OulhUSKwOp99YvGVYo7p8mw7XQKwtPU19mtSc4epy9pkbJ50By0YW4lKVkIjvk4bJxTIOHaQYeZ1eMWbyZYsDN8iJHfv9eLJ9njCa7oH4i0b4nR7SxBdcjJj5EP6BzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(1076003)(52116002)(9686003)(7696005)(55016002)(86362001)(16526019)(186003)(33656002)(8676002)(956004)(26005)(6506007)(316002)(5660300002)(2906002)(8936002)(4326008)(6916009)(66946007)(66476007)(478600001)(83380400001)(66556008)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rkb6XnRbFQzjVRdl6IBEdstOoaQnIeVlS2JyFL/znweAf2XCu4T8jJhtpneu1OLWVISRxlNYxwuVQmRY+XTAT8sUkg+kem9nugRfgGF11ruDJKkqybB62ijIqQ+pU6mDwYUV7IdgPqjCXMxrSFhaAL8/wMrGtQXloE0xFISAKIm6f1CM1K+iCjAAzPX/GSWWjjDViP7kiGniqaBN7xnUGWkJM7HNtTCrk21zNLj22cGCFOUOCaLScSNGRaFYkzNYz0zUCLVeO621UyWJ+03H5jTxPGsMXT41186I50jW4jbgmHpn7I7Q5bITPuz1eFDd4x1YON+xpz5gCjX1zwa3WYzedEoVDKA20M1VXszuJ6WqvCuH+CG+83eMT9nEWGeMClMQCV8y7GnQ4yx1L/qBH0mv4o1JguvW15FAmRUSd1db78ZXdiHN/g3uJR8xVyfXhQIj8cJsHDnddib7GOaWVeEg+ocGs+Q0YQecdpGEzQ8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf3efd9-0707-416a-8460-08d832c38cc5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 06:57:53.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKDfNFl3VO9xdb/s0zPxxWA9MyeA3jp7cBjX7aWl1ww8qsfeBMgmg3f+CP+k3vxhg6AC6TtSDxNBnsYgVdP+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 02:53:34PM +0800, Jason Wang wrote:
> 
> On 2020/7/28 下午2:40, Jason Wang wrote:
> >
> >On 2020/7/28 下午2:32, Eli Cohen wrote:
> >>On Tue, Jul 28, 2020 at 02:18:16PM +0800, Jason Wang wrote:
> >>>On 2020/7/28 下午2:05, Eli Cohen wrote:
> >>>>Hi Michael,
> >>>>please note that this series depends on mlx5 core device
> >>>>driver patches
> >>>>in mlx5-next branch in
> >>>>git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> >>>>
> >>>>git pull
> >>>>git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git
> >>>>mlx5-next
> >>>>
> >>>>They also depend Jason Wang's patches submitted a couple of weeks ago.
> >>>>
> >>>>vdpa_sim: use the batching API
> >>>>vhost-vdpa: support batch updating
> >>>
> >>>Just notice that a new version is posted[1] (you were cced). Talked
> >>>with Michael, and it's better for you to merge the new version in
> >>>this series.
> >>>
> >>OK, will send again. Just to make sure, I should put your series and my
> >>series on Michal's vhost branch, the same tree I have been using so far?
> >
> >
> >Yes. I think so.
> >
> >Thanks
> 
> 
> Just notice Michael's vhost branch can not compile due to this commit:
> 

Yes, I noticed this too.

> commit fee8fe6bd8ccacd27e963b71b4f943be3721779e
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Jul 27 10:51:55 2020 -0400
> 
>     vdpa: make sure set_features in invoked for legacy
> 
> Let's wait for Michael to clarify the correct branch to use then.
> 
> Thanks
> 
