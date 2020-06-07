Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9181C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29E520748
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="naq53QIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgFGNNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:13:47 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:23777
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbgFGNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIJnDsfHf0Ek8AmY+QNZ1UbKLRCY40n+DcG3fjiawCsND/bou+BnEr2WBfg381vW75Yo3irfmdXs1yD+fjDlz8sPTF4ihsXpDWwjWLrKwI7VS9MtqvM6Ni4Wg9WoG3EjIwRAIUI1Nd0ooSKW2uQLiPSm/+1N56E0JQ00Kc6wcYy6Ii5zFVtHuNpRF7hIoLUggbgmnAyqCgv6WYHWIpg+1Q2Sb7QwIS0WROEMW4Wq/OBvalSKIYUJuyX+/O/o68yLf9mdsfiTNT/Q/j0ztpE1PfjVEXgJ3N5/XkbG/Dw70RoXjS3+PAAhLIQ/nVChjMw44vb9eBSeVLsvZy/MwhODig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiTvlEHB8omd/syWfL4oev857MsEuXHx+VT5AGdU3qA=;
 b=ZVNa6SDFuVi0WCnxMj6CQv/KNY7cEtuSTiPhjC1z5BnZnGJyw/2A3lBKWPcOXSs1mZpP0eIfGG4LBQqHxzGSjJybQodoLbr1ezxcwxe/n8cwMhfXlBsajqz3BnSXsPe74btgOHBXhmvL2D83Zbjv3WKvNee3WhLsH0erF+xT98wbG55f4B3pOMTHLRr9b7aEYL0QaYeaWa7MjTM+b0SslRG3XndZCOsMcRyDxjfGhBXfiHsbVL9PAupOL4Yx8Dvm/i5AMVbw0lJA9ta/bovHi/T4O59sSyzuOCguZnyXLuWMMl8nC27QajE+iphjQde/+pOWJtm/i9iiSQhlDQULgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiTvlEHB8omd/syWfL4oev857MsEuXHx+VT5AGdU3qA=;
 b=naq53QIiu+w3nx5nuv24uk41+UPJecSTr5r5/FIdENkJS2rJHoHSekwgaGn23cveiRYL2lM8KJhY9ClP9DBrscwGjzc6/DiPi6gGt775aocVuKlIMuHT8x1ok68Bm0ts9QZNCY9Zyt2/VmL803+vdps3iWfxYRkLfRoDLakKNzA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6369.eurprd05.prod.outlook.com (2603:10a6:208:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sun, 7 Jun
 2020 13:13:44 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 13:13:44 +0000
Subject: Re: [PATCH] nvme: do not call del_gendisk() on a disk that was never
 added
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Israel Rukshin <israelr@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200607114520.130756-1-niklas.cassel@wdc.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e7a92bb5-6400-34cf-393c-489ae6c6f072@mellanox.com>
Date:   Sun, 7 Jun 2020 16:13:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200607114520.130756-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::40) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM0PR06CA0135.eurprd06.prod.outlook.com (2603:10a6:208:ab::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sun, 7 Jun 2020 13:13:42 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61a0c261-98a2-4a4c-7e96-08d80ae49ab4
X-MS-TrafficTypeDiagnostic: AM0PR05MB6369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6369E3A29024B7C8C0D31FD8B6840@AM0PR05MB6369.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04270EF89C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cv8cb+2GwAbkul6VbRzNsMa6V9ypduKLPByXO0IUCMIzuav6RVwJXzYQllaeP/QU91i3nLfREXLwp5rx2+lBEGXAm5saoQQPKfN5v3pD2iNYC4r5+zphmxZ/BSZE/huRhGJzV+MZOhfb2Xtu5AXEp+herHAM595z/8aP7nYburpOz4RXZ3CcAsqwVs6pyWshWWspqS5J/IwQEfpqUC6sab0NOWzgYOGikM2oDJBaTi+sp5ud/KOe8/rUsqTr6iy3NdJGlFZODUSI6tekau47uTuQkIPs77HLm/cq6sucMjdeqBVrTuD5JmCscyRutkN9PyA28wsIp5I/ghJCUOBZz6Xs2U3Re2NWoQrnfxQF+m/Br2lePdl1uekAV3OiTKXL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(16576012)(6636002)(110136005)(316002)(5660300002)(36756003)(66556008)(6486002)(6666004)(66946007)(2616005)(956004)(31696002)(2906002)(53546011)(52116002)(66476007)(478600001)(86362001)(83380400001)(4326008)(186003)(26005)(16526019)(8936002)(8676002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KQZcjapqDHs1T3EdL2sawfkM8L5I/AnVmF4mEYZ9wlXgQEzS2vqU13CKImfeRBbCgF8x2DgOsnm4I2UdOKgK2GGm24FEvs2qZDAE/EMTDK0kfyjIfCb+0TB76ILyUhpsleEqllsr9lgGWDylp+EyG6xUq0zY1dJ4T775yGMF/cPGFT7qXo0d3OK7AcBixrFRu0t0MFpQwXKziuXh8yW981r+LJFa4a1h3nkFGYGQljKDT5/0w/hWouSAPzDfxoTRRi1VzUi9LU8usCJHBiGXzOf7QW4FXQiJcZUxsKxYDdfheu1E085yKI4UBvpagOs1N2p3cL+EZQR0AE9MojA0UWX4rf385nYvZmip9d4ApC/LQLCDaY8f9T33yNTvqLW3zPYHD/VunZPCA06Y+AU9VBu+5r8S27zn8E00MH6RWAstd6YQEP6H/A0CA9lPqpaJzO5Vn9qrxXX5Fe+IIrnMNiZ860Pj0Bb6CGoCodebeddyk4iQ5pkm7EWHs7AGOCJA
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a0c261-98a2-4a4c-7e96-08d80ae49ab4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2020 13:13:43.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fpa0gpleWxj3ch+3IHu541focH5oWHGV+mo3uiQ34pgdEJ14PrsmAXXF1txXr4thR4JRW+Y9OOrQbRAMUh3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/7/2020 2:45 PM, Niklas Cassel wrote:
> device_add_disk() is negated by del_gendisk().
> alloc_disk_node() is negated by put_disk().
>
> In nvme_alloc_ns(), device_add_disk() is one of the last things being
> called in the success case, and only void functions are being called
> after this. Therefore this call should not be negated in the error path.
>
> The superfluous call to del_gendisk() leads to the following prints:
> [    7.839975] kobject: '(null)' (000000001ff73734): is not initialized, yet kobject_put() is being called.
> [    7.840865] WARNING: CPU: 2 PID: 361 at lib/kobject.c:736 kobject_put+0x70/0x120
>
> Fixes: 33cfdc2aa696 ("nvme: enforce extended LBA format for fabrics metadata")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> An alternative would be to do like nvme_ns_remove(), i.e. in the error
> path; check if ns->disk->flags & GENHD_FL_UP is set, and only then call
> del_gendisk(). However, that seems unnecessary, since as nvme_alloc_ns()
> is currently written, we know that device_add_disk() does not need to be
> negated.
>
>   drivers/nvme/host/core.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


