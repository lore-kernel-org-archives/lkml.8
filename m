Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB18C10DAA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834E82067C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="Q4M+3B0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgIDCCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:02:11 -0400
Received: from mail-eopbgr1400050.outbound.protection.outlook.com ([40.107.140.50]:14272
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbgIDCCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3odEil3Q0q4qcwYKPlESMQFZdweWr3sAXsiQ3wQzmwyzSTcJGEokeADM2bX+ulcDB9BC7u+30/9e1hw79xtDQrjPxrN/s0DPrAHDYE9XXBZ0V9AIgUbgOIEOm3bFiSo0+JJAGWw1bKVuvCaGVPZs5K8K8rxwScAAtpqTYfAH4DJN1Oa/rXod8T4wAHhsos+aVrHnDNkoxSzXBuHH5NxXGWG60/ApLPsTGteUNk276/3flQU/DzgmtLlM0O5PDrSW3Dmp4jUAFHZRpmGUvDERZ7iq95fe4ZkkoC0OKWldTZhHve/qkDq/fWqLF8DNY3nyNFQW8X+M33puRWcaCf7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OO7VXf7W24oQcf/K0vBR8ZDAQ+3ISZEu9TPJnnzZG4=;
 b=D9+IQYhG6BrjGuFnCw18M4P12dBt9kQR+WDeySLtr0keMkZOpYoVNm7eO9fGM5bjLhHB2zyaTT20WlvntUn+wExJ0iramEAFn3sIRyzEWDiXaJG7MvsNr4QGnLlXGNw4zuOljlxOvsNrfLQhIiTM+NSbR4v3Ql4HFltz0P+ugP6HQzrs65iBrxLq8rcjmvtqkRa3hmcIfSyG2cv1GLQijfoKZRuGsmc+h/4eITObsfSs9D+UECs0qklxFRnVyz9EeC8ERxwV+adJ8pgOGkedUgF8kvrB9oDRH0kvkVEKV2dlEgOBi5k4nLpvRQtjDvhDgOU7e27lW8jnBfViezHlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OO7VXf7W24oQcf/K0vBR8ZDAQ+3ISZEu9TPJnnzZG4=;
 b=Q4M+3B0iBI5dKlWGxllIcV0KExxShAbd3bBoBCT0dht22cvnHSN7PzSOPzR3UfDGLv+ng3Pvxpa0Lyf4+NO/2thna+jKNg6vLPTpLAWqoOSoAemk8Nx64KbRyxRAFeD9NP48R/6WeJene5FAyKGAZX9byFUscSZQawubKf5dKSM=
Received: from TYAPR01MB3213.jpnprd01.prod.outlook.com (2603:1096:404:8b::18)
 by TYAPR01MB4416.jpnprd01.prod.outlook.com (2603:1096:404:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 02:02:05 +0000
Received: from TYAPR01MB3213.jpnprd01.prod.outlook.com
 ([fe80::c1fb:d14a:1d72:a39]) by TYAPR01MB3213.jpnprd01.prod.outlook.com
 ([fe80::c1fb:d14a:1d72:a39%6]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 02:02:05 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] mm,hwpoison: Take free pages off the buddy freelists
Thread-Topic: [PATCH 1/4] mm,hwpoison: Take free pages off the buddy freelists
Thread-Index: AQHWgQ3LrQfep9tTU0aEmz9PX/b1n6lXvKqA
Date:   Fri, 4 Sep 2020 02:02:05 +0000
Message-ID: <20200904020205.GA32236@hori.linux.bs1.fc.nec.co.jp>
References: <20200902094510.10727-1-osalvador@suse.de>
 <20200902094510.10727-2-osalvador@suse.de>
In-Reply-To: <20200902094510.10727-2-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744105e8-f5b9-4267-327e-08d85076861b
x-ms-traffictypediagnostic: TYAPR01MB4416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB441687740D5D595D4EB569ECE72D0@TYAPR01MB4416.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVcaBitDLy8gnHPkM30n4pV13XrK9Vmvdsq3qVZkZ8uPTm+GFNcGUmKPkuq1rfj+UD5ygS0IvZGFv6ccjoykoxcBqzI0YPU4VIS9HqgDU3EXw2AY1AJdTtuKKcpAy21fWkAXJkxGy+Mcj5eH1S9PYGamOci8xwyE2MWhqdrMRUcd5wwKwQx2mUeCiv8rMn8f93qx592fsNPu1ibjzuO94pJPxMeW65RetfBlTPbfLppBIdVvJMvu30/UGwi8Zpnn5uIIqKO41TmAqX0yyu52zpo8ikhOJamKJWs2/97jrD4doY9/y2CIY7ftX9ElT/ICIAJSR1EJQTXOeNnGYZSp2eMgT2Zajv+vzgGWzf8/4ufJTmzywKSrh/mVgivsp6N17R3H5kAXMd4Aize+DvUSC6lVw/rmdvSuxIHq0FM6KpNR6hsEqa7AbCKrGnXHXvmlIjZBU8PHziu3OAODde4nTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB3213.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(1076003)(2906002)(33656002)(66946007)(85182001)(54906003)(76116006)(66446008)(64756008)(71200400001)(66556008)(5660300002)(966005)(66476007)(478600001)(6506007)(6916009)(4326008)(316002)(26005)(6512007)(8936002)(8676002)(83380400001)(86362001)(6486002)(186003)(55236004)(9686003)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Hm/IZ0kQQmkmVy0HYQgmlOvCEc5symg+KAWqm11HIexDgZPUPrs4eZxYtrV+zmRV5NxRSha1eHB4v9BOJQ/deIDBMj22DhHgUpSR43jaQOJy/MwEMELaVTa1B5lPqZ7fgtFnR27TgXL+sl/ywKpjeVdGO/PNCqJBfdFKRbTPpGF59o/jea80j/4AJm1wxixjUbLgzCkPTvl35GqKz9Mg3wwp+BUs1YbQV2KvUrz5uTwYRhbfG57CaGyzkPgeUTisDU0Ghx4e8egPfhyd5wKcUqgz1x241plNXNTCgUtxE6rqVmgIr3xVdMlliR1J6WB8gxB2OVb2EeAIx3Qk38Cr6ogoxdAw9Ie+OqtPOtIOjzvjTxisIijaJap49mCWWl51G2FSeo+7atrwE2c5JssA/y5WQuYEtzSmdwSuvS+fLk1KeCtFFDIMNCGPCHljpo34Q4sdw1BohKPpiQxKsgN6wVUMX5zjiCadqpVai3jJ3g0dNNrtFIRGavanr7oHECu2CsR3ilqaWT1epoBgqQELAyzXNoo2syv5U3aZ8dhG3N4NdiZhNXZW6zrv8qNhuQ1NqdxciIxxisdYRJ298CM3sFHrvOqcgkTYVDXJfWw6Bn086a9Fn7Keb/o26kKmntBl1Wbwoykk/fn5NpwLC4VlQw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <9997736D5911A840859137F5A7F4F461@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB3213.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744105e8-f5b9-4267-327e-08d85076861b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 02:02:05.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CwIRLx5kfBfBfQvzhPvWpE9Irqzl1xxQqWTtXQPa4L9VBME7FvfM+GLR8wUjRh6mfVzbaqSHuyWLjBXt8w8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:45:07AM +0200, Oscar Salvador wrote:
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

Thanks for spotting this.

> After that, if e.g: someone faults in the page, that someone will get kil=
led
> unexpectedly.
>=20
> [1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
> [2] https://patchwork.kernel.org/patch/11694847/
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory-failure.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 696505f56910..d349dcb45056 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1325,6 +1325,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	struct dev_pagemap *pgmap;
>  	int res;
>  	unsigned long page_flags;
> +	bool retry =3D true;
> =20
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
> @@ -1364,10 +1365,20 @@ int memory_failure(unsigned long pfn, int flags)
>  	 * In fact it's dangerous to directly bump up page count from 0,
>  	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
>  	 */
> +try_again:
>  	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
>  		if (is_free_buddy_page(p)) {
> -			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
> -			return 0;
> +			if (take_page_off_buddy(p)) {
> +				action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
> +				return 0;
> +			} else {
> +				/* We lost the race, try again */
> +				if (retry) {
> +					retry =3D false;
> +					goto try_again;
> +				}

You might need add calling action_result() here.

> +				return -EBUSY;
> +			}
>  		} else {
>  			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
>  			return -EBUSY;

And the following block also handles buddy pages, so you could also call
take_page_off_buddy() here?

        /*
         * We ignore non-LRU pages for good reasons.
         * - PG_locked is only well defined for LRU pages and a few others
         * - to avoid races with __SetPageLocked()
         * - to avoid races with __SetPageSlab*() (and more non-atomic ops)
         * The check (unnecessarily) ignores LRU pages being isolated and
         * walked by the page reclaim code, however that's not a big loss.
         */
        shake_page(p, 0);
        /* shake_page could have turned it free. */
        if (!PageLRU(p) && is_free_buddy_page(p)) {
                if (flags & MF_COUNT_INCREASED)
                        action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
                else
                        action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
                return 0;
        }

Or if get_hwpoison_page() handles retry inside it as will be done in patch =
3/4,
we don't need this block any more?

Thanks,
Naoya Horiguchi=
