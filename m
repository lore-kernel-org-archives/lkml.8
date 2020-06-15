Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C08EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262CA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t8UEl+WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgFOF7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:59:53 -0400
Received: from mail-eopbgr140111.outbound.protection.outlook.com ([40.107.14.111]:3458
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbgFOF7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:59:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aahjmKUZ5r/FhQ46SNs1dcLQicwrT7gxcOOhB8v29bnzN9jGg5wjgNNI6CaCn8Uf9T0qx1hKGTGNi+o1h/L7GNKOIFUeI+KV5TOKmCXhONAjhpuSN0xneb+GA7YBq6yJUuHqRf8+unlk//rnLbDMs81BAcjJjkFl3fyJPz4zRmfIPPPizy4zcA4reF78+QE7lz7xt2RtYHBrs1x03ux6mEAbqF8Gqg4RPFlH+FmygguYSyaV3LlT5xER2coMAgpE0ppqsfrxxY0lZMMd7t8ZhbkJYITxuRP4ixvgqJeTDllHqShnY7s8GziIzSbLikOT/Lf7LRVmFqCIxU4J1dEDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmxAI0otxBUFzZzhTwz6Lj8Li5Q1uJuF3BWv48atEBk=;
 b=IRDk8fvK+hafjeuxdfPs+QM2CCNe25RAbvObTOTxvi9gpyFBKNQU5XR46pFMTZa7RUUxvjTl4a61oHVsmmMy8dYPaJUGg2K7z8Vj+tuDsyc89PcGGzHmIR/bcPZoRD8OysNmOWNcFMFtimq+NbPP3ceOkIzu3lAeAHssMMBLkCdmSi1hyykJR1LaxLoFcdEGkLQeuLLuOYuDWZ9YAO/bq1M5Zk56FXRtTS2/mPrCaTq67KgqoL5LeXLl5ICYXxSkuTU2dBAh6yOcNRFZ0L1Z2aNQ9O8xCK9VgkPlGYqjFqcqM8Shl6vtseVGExliw6os2Fah0JraCGIe0QhrKBvlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmxAI0otxBUFzZzhTwz6Lj8Li5Q1uJuF3BWv48atEBk=;
 b=t8UEl+WKlSR3GjhRqoyObuC5LxJsbUYKc/xhySq4rXSZmVsKFbs/NjnGqrPtu07ZBQy6VTuw1Oo3c/emeA37ZBhSlFMYerQvBfVzm/kWvD9lc8N0uNdNFxRu6ByTeUhrJvwCiX7XdtLe/RwZlhC1YFIicge/TpO3wDZbHje2zic=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB3843.eurprd08.prod.outlook.com (2603:10a6:208:fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 05:59:49 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 05:59:49 +0000
Subject: Re: [fuse] 6b2fb79963: WARNING:at_fs/fuse/file.c:#tree_insert[fuse]
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Maxim Patlasov <maximvp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200615005036.GU12456@shao2-debian>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
Date:   Mon, 15 Jun 2020 08:59:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200615005036.GU12456@shao2-debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0016.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::29) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0016.eurprd02.prod.outlook.com (2603:10a6:208:3e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 05:59:48 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fafb634b-1ecf-4586-2804-08d810f14fff
X-MS-TrafficTypeDiagnostic: AM0PR08MB3843:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3843755ABCC4C206C9CB2775AA9C0@AM0PR08MB3843.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tvZiykqRA5rDjoKfFREqbdiJVnYOzXEN2wDenEIVONtljCNvByAejYum/euGBE6UhH4hUK52RSqNxZUYewXsiYKsHaJUrsw1LJcMz3D+BnqsX2uYMLNKcyn6yK3GpFo7g0by682B+pWPfOsIOzGnhcgz9S+lb34EkeWTAQCoizuS/041tHhPwTrZlnSq9qG5B+O9GpmjJjm7sVyw7cYuDNp+aKsAmlPdqLEezOz5s80gDemnDIvJ6CS06owIcEWhvXgmuF/I3g5w9hH39kiKxXY/TiNKgJ719YmDPFylMg25XGnKDhfpQ5Wcw+YwSQ8wmlKXqkr8AoxTZKm45QRKGCoL8BBquKBHkBHlL625UxtBTWdvH5ubUHjs3Dd1RxnAFNEVkP7RgK0SjijeEVXDzHolhcJP0FE/DwQ7+TP7O6Ve1RpY/FpCjivLtq8Ev3uyGzZ0XoJlseIoKDsyFT/FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39830400003)(396003)(136003)(376002)(366004)(346002)(31686004)(54906003)(52116002)(16576012)(6916009)(2616005)(5660300002)(956004)(316002)(36756003)(66946007)(53546011)(8676002)(66476007)(66556008)(4326008)(966005)(8936002)(31696002)(83380400001)(26005)(2906002)(6486002)(478600001)(186003)(86362001)(16526019)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UIJSW6gzcSIjO+whWFTB1YcEcpjzrH7uTS2wD8dLOlJFhVNwlx6CHyyBa9hXhDE9oQeGHXyXxBZakPWiMh6Imy3/+rS8SWT9IzW64VhVgT02rmXt4ZaqdaAuHweCDNc/A77eIiLjGNDCBX1VLEgXihR9QxxusQDqflYHHnrxB278597lwk4TCXeuPvO4ZprLxBNq92aFxFIts16F60eTeTinZfuNsEejdzVRA4tHU91AaxJmdccoWjgpWD6apFAm/SotGhZf2Oe+D4+M7GDy7uYyaddrZVpg3sb9mtnlS35aKSBw8IuolzVQt1QR5b5a03nCPcYfRK2GgfkUG1RyQYwN5WIegNvTId1dmsIXEhQ/eaScevtoeCmsUbkH8sEVnqjZLpICS0kDop3DHa63cxOzWawnjwE0sAnU65QVrCkpzVllVHEd3W0fRLh5XK6/NXIU4xEa6B7nkQrgmW2fXD61MBx7djH+bOiZZhVNV+k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafb634b-1ecf-4586-2804-08d810f14fff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 05:59:48.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7RioFJs7hPhauk6kH7wnktGAwwSJfsr7+0aHl/i5MGp/UNh8UC1ZXEQqDUHQRVWUrAvbxlbRIXKK7/hCaeAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 3:50 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 6b2fb79963fbed7db3ef850926d913518fd5c62f ("fuse: optimize writepages search")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

> [ 1030.995703] ------------[ cut here ]------------
> [ 1030.997563] WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
> [ 1031.021943] RIP: 0010:tree_insert+0xab/0xc0 [fuse]
> [ 1031.057802] Call Trace:
> [ 1031.060015]  fuse_writepages_fill+0x5da/0x6a0 [fuse]
> [ 1031.062536]  write_cache_pages+0x171/0x470
> [ 1031.064933]  ? fuse_writepages+0x100/0x100 [fuse]
> [ 1031.067419]  ? terminate_walk+0xd3/0xf0
> [ 1031.069707]  ? _cond_resched+0x19/0x30
> [ 1031.072140]  ? __kmalloc+0x274/0x280
> [ 1031.074407]  fuse_writepages+0x8a/0x100 [fuse]
> [ 1031.076599]  do_writepages+0x43/0xe0

It is  WARN_ON(!wpa->ia.ap.num_pages);
however tree_insert() was called from fuse_writepages_fill() with ap->num_pages = 0;
In submitted PATCH RFC we have used 

+static int tree_insert(struct rb_root *root, struct fuse_req *ins_req)
...
+	pgoff_t idx_to   = idx_from + (ins_req->num_pages ?
+				ins_req->num_pages - 1 : 0);

Though committed patch version have 

+static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
...
+       pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
...
+       WARN_ON(!wpa->ia.ap.num_pages);

Miklos,
do you have any objections if I return to our initial proposal?
Am I missed something and it is not allowed now?

Thank you,
	Vasily Averin

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e573b0c..b8c3ef4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1677,11 +1677,11 @@ void fuse_flush_writepages(struct inode *inode)
 static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
 {
        pgoff_t idx_from = wpa->ia.write.in.offset >> PAGE_SHIFT;
-       pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
+       pgoff_t idx_to = idx_from + (wpa->ia.ap.num_pages ?
+                               wpa->ia.ap.num_pages - 1 : 0) ;
        struct rb_node **p = &root->rb_node;
        struct rb_node  *parent = NULL;
 
-       WARN_ON(!wpa->ia.ap.num_pages);
        while (*p) {
                struct fuse_writepage_args *curr;
                pgoff_t curr_index;
