Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439C8C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA216208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="QTQYVFIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgIKCiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:38:03 -0400
Received: from mail-eopbgr1410042.outbound.protection.outlook.com ([40.107.141.42]:22496
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgIKCiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:38:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAVH8bkzMigjb7x50sOgo6RjxyJzLKRHBxXhJ8dxvGrqdcGwWJI7HUMF9uTd4/0VKeQRPSy66a4AsIZEikoNmBoHN8f3IqMjq4iUEjYFi9tr/AqZoGKd64TpMvMl4s+8HwKvWomvHc7rW1JTY4BWKTnSHH06sFeC0ETdik43UjvuTd/4q3Ag4qi5gGal/6tEdWzsL2GsasHNBpOPQZ6rrPjxQFSpzcXI/S2lzyCSlJW9g4Eo/C9Hc8lU4ScVLTcT694untE4dYvhlWvXyTpFAt4XC7C4yf13mPOmGcMYsq9KhTf8PX4lMTZxLLDfchKYHUtwd1OO2H7Hf6eb8K5XGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4hR0c6dxboQbYPO9/YnnK2jYjRFVLZxKziXwIEEOIs=;
 b=FpiEfJsTFbiJ/GKH/tZrPxLhMkIxdvL5XXr5KX7vlEQRln/4xJth9GY+2oLIu6HgSw2xPdizPdbbwDW4X9cRVx8v0Mb0t8aNqrJbvTQQn8nHmUxhWk7o0iTeJxMGJQsjEis4PQUrCS2z1HJRcDQI9++zKyifPKulOKXsKftRxI+g3wCcJ9BBQEAloESxZy4UfyJUGhQib03WxULh7EiLPIepjk8EXyM/Rc5Qose/tlMDwnXm0mzZk7hR6RiAYwmOG5IN7AwEnElcHklO17ZeK1bR7Z62iV3qWm4jD8D+jREIA2fQgMfA0a1j/2UqNiHewUnTko9TsQw2WXUUgvaKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4hR0c6dxboQbYPO9/YnnK2jYjRFVLZxKziXwIEEOIs=;
 b=QTQYVFIipWysqTeSmpZ6TN4w03FxJlBkdhHCiWNFitqLTe+6XSyZCVOQ5occ2s9Q4irb9mVaDGpM4eipG5qNO2Gt/Rih/Sk5a+P8DtiDRrr4RwXkqIHycBwtOJCvZk1SEfuKAWDapO3gfwZo4Lak/yciCO2ccNSukhqMkw25WG4=
Received: from OSBPR01MB3208.jpnprd01.prod.outlook.com (2603:1096:604:20::9)
 by OSBPR01MB2165.jpnprd01.prod.outlook.com (2603:1096:603:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 02:37:58 +0000
Received: from OSBPR01MB3208.jpnprd01.prod.outlook.com
 ([fe80::8ef:27a:1b4e:aff4]) by OSBPR01MB3208.jpnprd01.prod.outlook.com
 ([fe80::8ef:27a:1b4e:aff4%4]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 02:37:58 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/5] mm,hwpoison: Take free pages off the buddy
 freelists
Thread-Topic: [PATCH v2 1/5] mm,hwpoison: Take free pages off the buddy
 freelists
Thread-Index: AQHWhbWWq5TCWGYrrkelAaAxJmrEeKlivbKA
Date:   Fri, 11 Sep 2020 02:37:58 +0000
Message-ID: <20200911023757.GA27723@hori.linux.bs1.fc.nec.co.jp>
References: <20200908075626.11976-1-osalvador@suse.de>
 <20200908075626.11976-2-osalvador@suse.de>
In-Reply-To: <20200908075626.11976-2-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41e11e13-aaf5-43e3-bbf8-08d855fbb1f0
x-ms-traffictypediagnostic: OSBPR01MB2165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB216580848F17F2C001B8C1AEE7240@OSBPR01MB2165.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AO6vjtJ0k9M7gBmNvX5Uu3ech1bCwkO4DFxVgF+aUZdPlQhez7TjKR+RSULh7bffsD4ptUfwT+lkyF5i3rWDOTs0tDIuHFfbpAHOyT7dbHPH9XbLZ0bzmuXN0N7eaUrsCXs33e+0/YIGohphibIVZvBacTfsN3sgiYx9eNe97uepaKVrDCGteHbOYx76/0p7DKPpCK1J4ousCSLkkaVMqq5JXEwYx0VvYfjIF+ufF5QRWNNwf6/C9+cVtgxbP4//Nq7pr8lPJFGQ4p9/uNnLvuNp49rSuKAHgbWb7jYY7wQcxfTgKKe9rZSc9L9MtK24+tp36kG682BoOV5Ro1EFNRCYdzlTAwI6AJFWEhTH/pqqmXm/UNUBsBfQiDeyc8Yb0IkP71Jj/kI70xXqF2xF7UOSvEc3hWTufvYZZUu+RLjxydfssH4TlSMOaeaxzC/FMLA7wrzMLlNXMOn9VlvUSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3208.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(64756008)(76116006)(8936002)(26005)(5660300002)(4326008)(66556008)(66476007)(186003)(71200400001)(6512007)(6506007)(9686003)(66946007)(66446008)(55236004)(91956017)(86362001)(85182001)(316002)(6486002)(83380400001)(54906003)(1076003)(966005)(6916009)(2906002)(33656002)(478600001)(8676002)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MC2mjSG9R2fxTxS2fJfkuzo6gApvOBrcUdHFLtSd+vDjP6C/RKeYGSOEm0l50+YCR0YuuqRz4I2HbVxj/DjRkRs5hn5X1QQwS1273v7bd6nSlTdTDTc8OTK88psVwj3ADIWFkRfsu4jnzXGbBHpBR8Srj0aJkgzJCpGw3MrYLyEMs1iYKO8V+MSW4WNav2nUXhMpFxI8SrQcOlad2JhAlTo2Dw6uuWaWhQcovO8FQdizZMPTb/HF6VimOw6f3l2VSpzBBIz9SYPqP1JlMpiEPxw9Okcvf837cH50Xheo68eg/P0vn9xrdQwt+CFn0Q42If2LW5jGLqWxhtf8wY9k+A3bdOAY6ijt2sqKNqDqmkz6N7NR2yfSmzaKn9yvsojPw323CR30W5Mlk62nLgeF8yzTUf2XQqaqdeCY1anXZ0ROoOQ0s/i56dl5Y7Wi+fsCXud2Ztf17FQY0zxBG6OwfgayjLG4wDVmou3SMViiX+iJTOaBtqKRiL2zK8424GAxvyOZXKMzHNoH+oRujP4iLgwqKJY45uQe2T+XwtbvsRWveGQYP+CIbIGZmZ+E37juymcODDRVDV/K8Xk+8STMsyYmnnkt6NErNejarxqLpcYTpMt/vRrY/MOd5qoYSySLGWZaI75UAlqH4kQN+TxK1A==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1523B2B74A4A1A4B91E14D81730F715C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3208.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e11e13-aaf5-43e3-bbf8-08d855fbb1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 02:37:58.2771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXhYl0cNDIFR2FHii9ieE9E2dz3Mmu/6DHEwD/iznXlYTYo69U2JIfQD5cSLActwWPJZ8fXB+ziAKnQQwd7KiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 09:56:22AM +0200, Oscar Salvador wrote:
> The crux of the matter is that historically we left poisoned pages
> in the buddy system because we have some checks in place when
> allocating a page that a gatekeeper for poisoned pages.
> Unfortunately, we do have other users (e.g: compaction [1]) that scan
> buddy freelists and try to get a page from there without checking
> whether the page is HWPoison.
>=20
> As I stated already, I think it is fundamentally wrong to keep
> HWPoison pages within the buddy systems, checks in place or not.
>=20
> Let us fix this we same way we did for soft_offline [2], and take
> the page off the buddy freelist, so it is completely unreachable.
>=20
> Note that this is fairly simple to trigger, as we only need
> to poison free buddy pages (madvise MADV_HWPOISON) and then we need
> to run some sort of memory stress system.
>=20
> Just for a matter of reference, I put a dump_page in compaction_alloc
> to trigger for HWPoison patches:
>=20
> kernel: page:0000000012b2982b refcount:1 mapcount:0 mapping:0000000000000=
000 index:0x1 pfn:0x1d5db
> kernel: flags: 0xfffffc0800000(hwpoison)
> kernel: raw: 000fffffc0800000 ffffea00007573c8 ffffc90000857de0 000000000=
0000000
> kernel: raw: 0000000000000001 0000000000000000 00000001ffffffff 000000000=
0000000
> kernel: page dumped because: compaction_alloc
>=20
> kernel: CPU: 4 PID: 123 Comm: kcompactd0 Tainted: G            E     5.9.=
0-rc2-mm1-1-default+ #5
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1=
.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> kernel: Call Trace:
> kernel:  dump_stack+0x6d/0x8b
> kernel:  compaction_alloc+0xb2/0xc0
> kernel:  migrate_pages+0x2a6/0x12a0
> kernel:  ? isolate_freepages+0xc80/0xc80
> kernel:  ? __ClearPageMovable+0xb0/0xb0
> kernel:  compact_zone+0x5eb/0x11c0
> kernel:  ? finish_task_switch+0x74/0x300
> kernel:  ? lock_timer_base+0xa8/0x170
> kernel:  proactive_compact_node+0x89/0xf0
> kernel:  ? kcompactd+0x2d0/0x3a0
> kernel:  kcompactd+0x2d0/0x3a0
> kernel:  ? finish_wait+0x80/0x80
> kernel:  ? kcompactd_do_work+0x350/0x350
> kernel:  kthread+0x118/0x130
> kernel:  ? kthread_associate_blkcg+0xa0/0xa0
> kernel:  ret_from_fork+0x22/0x30
>=20
> After that, if e.g: someone faults in the page, that someone will get kil=
led
> unexpectedly.
>=20
> While we are at it, I also changed the action result for such cases.
> I think that MF_DELAYED is a bit misleading, because in case we could
> contain the page and take it off the buddy, such a page is not to be
> used again unless it is unpoison, so we "fixed" the situation.

Thanks for pointing out this.

Originally (before the reported issue related to compaction is recognized),
this case is categorized as MF_DELAYED because the error page is to be
removed from buddy later when page allocator finds it in subsequent
allocation time (not in memory_failure() time).

But this patch changes the situation, and the removal from buddy is done
immediately in memory_failure(), so ...

>=20
> So unless I am missing something, I strongly think that we should report
> MF_RECOVERED.

this change looks correct to me.

>=20
> [1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
> [2] https://patchwork.kernel.org/patch/11694847/
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory-failure.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 696505f56910..b0ef5db45ba6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1323,8 +1323,9 @@ int memory_failure(unsigned long pfn, int flags)
>  	struct page *hpage;
>  	struct page *orig_head;
>  	struct dev_pagemap *pgmap;
> -	int res;
>  	unsigned long page_flags;
> +	int res =3D 0;
> +	bool retry =3D true;
> =20
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
> @@ -1364,10 +1365,21 @@ int memory_failure(unsigned long pfn, int flags)
>  	 * In fact it's dangerous to directly bump up page count from 0,
>  	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
>  	 */
> +try_again:
>  	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
>  		if (is_free_buddy_page(p)) {
> -			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
> -			return 0;
> +			if (take_page_off_buddy(p)) {
> +				action_result(pfn, MF_MSG_BUDDY, MF_RECOVERED);
> +				return 0;
> +			} else {
> +				/* We lost the race, try again */
> +				if (retry) {
> +					retry =3D false;
> +					goto try_again;
> +				}
> +				action_result(pfn, MF_MSG_BUDDY, MF_IGNORED);

According to include/linux/mm.h MF_IGNORED means "Error: cannot be handled"=
,

    /*
     * Error handlers for various types of pages.
     */
    enum mf_result {
            MF_IGNORED,     /* Error: cannot be handled */
            MF_FAILED,      /* Error: handling failed */
            MF_DELAYED,     /* Will be handled later */
            MF_RECOVERED,   /* Successfully recovered */
    };

This case is an occasional failure, so maybe MF_FAILED seems better to me.

> +				return -EBUSY;
> +			}
>  		} else {
>  			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
>  			return -EBUSY;
> @@ -1393,11 +1405,15 @@ int memory_failure(unsigned long pfn, int flags)
>  	shake_page(p, 0);
>  	/* shake_page could have turned it free. */
>  	if (!PageLRU(p) && is_free_buddy_page(p)) {
> +		if (!take_page_off_buddy(p))
> +			res =3D -EBUSY;
> +
>  		if (flags & MF_COUNT_INCREASED)
> -			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
> +			action_result(pfn, MF_MSG_BUDDY, res ? MF_IGNORED : MF_RECOVERED);
>  		else
> -			action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
> -		return 0;
> +			action_result(pfn, MF_MSG_BUDDY_2ND, res ? MF_IGNORED : MF_RECOVERED)=
;
> +
> +		return res;

Althouth this code will be removed in 5/5, you can use MF_FAILED in failure=
 case too.

Thanks,
Naoya Horiguchi=
