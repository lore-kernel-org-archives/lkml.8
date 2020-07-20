Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5413EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D3121744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgGTAhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 20:37:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:53255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTAhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:37:35 -0400
IronPort-SDR: 1zFh+DVdjkeB++37mEbz+MHuwSSoy6obb7jIicwlEmIwJB/8DZl8lcQ4Cny3lZfJWJPaDuVNZZ
 XqvnKT5Mgz3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="129402705"
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208,223";a="129402705"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2020 17:37:32 -0700
IronPort-SDR: QASjX8aZ9SiI/UYzwGq5mBeNGkyS3mm5TcGBk4zDKjeIrq9Y8Fkygysskzr6cl4FWNkAKCA480
 IQHPNzffkpfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208,223";a="317868424"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2020 17:37:33 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 19 Jul 2020 17:37:33 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 19 Jul 2020 17:37:32 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.135]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.43]) with mapi id 14.03.0439.000;
 Mon, 20 Jul 2020 08:37:30 +0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <cai@lca.pw>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: RE: linux-next: not-present page at swap_vma_readahead()
Thread-Topic: linux-next: not-present page at swap_vma_readahead()
Thread-Index: AQHWEmmYtAO3HUjxOE6ed8VDneXiZah4msgAgGI3K9eANWRSjA==
Date:   Mon, 20 Jul 2020 00:37:30 +0000
Message-ID: <CA2E3DE2DD06CA4FA11644750E4E292F454E35A9@SHSMSX104.ccr.corp.intel.com>
References: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
 <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw>
 <874ktl1p7y.fsf@yhuang-dev.intel.com>,<20200616011334.GA815@lca.pw>
In-Reply-To: <20200616011334.GA815@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.109.78.81]
Content-Type: multipart/mixed;
        boundary="_002_CA2E3DE2DD06CA4FA11644750E4E292F454E35A9SHSMSX104ccrcor_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_CA2E3DE2DD06CA4FA11644750E4E292F454E35A9SHSMSX104ccrcor_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=
=0A=
Sorry for late reply.  I found a problem in the swap readahead code.  Can y=
ou help to check whether it can fix this?=0A=
=0A=
Best Regards,=0A=
Huang, Ying=0A=
________________________________________=0A=
From: Qian Cai [cai@lca.pw]=0A=
Sent: Tuesday, June 16, 2020 9:13 AM=0A=
To: Huang, Ying=0A=
Cc: Linux-MM; LKML; Minchan Kim; Hugh Dickins; Andrew Morton=0A=
Subject: Re: linux-next: not-present page at swap_vma_readahead()=0A=
=0A=
On Wed, Apr 15, 2020 at 10:01:53AM +0800, Huang, Ying wrote:=0A=
> Qian Cai <cai@lca.pw> writes:=0A=
>=0A=
> >> On Apr 14, 2020, at 10:32 AM, Qian Cai <cai@lca.pw> wrote:=0A=
> >>=0A=
> >> Fuzzers are unhappy. Thoughts?=0A=
> >=0A=
> > This is rather to reproduce. All the traces so far are from copy_from_u=
ser() to trigger a page fault,=0A=
> > and then it dereferences a bad pte in swap_vma_readahead(),=0A=
> >=0A=
> >     for (i =3D 0, pte =3D ra_info.ptes; i < ra_info.nr_pte;=0A=
> >          i++, pte++) {=0A=
> >             pentry =3D *pte;   <=97 crashed here.=0A=
> >             if (pte_none(pentry))=0A=
>=0A=
> Is it possible to bisect this?=0A=
>=0A=
> Because the crash point is identified, it may be helpful to collect and=
=0A=
> analyze the status of the faulting page table and readahead ptes.  But I=
=0A=
> am not familiar with the ARM64 architecture.  So I cannot help much=0A=
> here.=0A=
=0A=
Ying, looks like the bug is still there today which manifests itself=0A=
into a different form. Looking at the logs, I believe it was involved=0A=
with swapoff(). Any other thought? I still have not found time to bisect=0A=
this yet.=0A=
=0A=
[  785.477183][ T8727] BUG: KASAN: slab-out-of-bounds in swapin_readahead+0=
x7b8/0xbc0=0A=
swap_vma_readahead at mm/swap_state.c:759=0A=
(inlined by) swapin_readahead at mm/swap_state.c:803=0A=
[  785.484752][ T8727] Read of size 8 at addr ffff00886ecaffe8 by task trin=
ity-c35/8727=0A=
[  785.492488][ T8727]=0A=
[  785.494675][ T8727] CPU: 35 PID: 8727 Comm: trinity-c35 Not tainted 5.7.=
0-next-20200610 #3=0A=
[  785.502942][ T8727] Hardware name: HPE Apollo 70             /C01_APACHE=
_MB         , BIOS L50_5.13_1.11 06/18/2019=0A=
[  785.513387][ T8727] Call trace:=0A=
[  785.516538][ T8727]  dump_backtrace+0x0/0x398=0A=
[  785.520891][ T8727]  show_stack+0x14/0x20=0A=
[  785.524900][ T8727]  dump_stack+0x140/0x1b8=0A=
[  785.529087][ T8727]  print_address_description.isra.12+0x54/0x4a8=0A=
[  785.535185][ T8727]  kasan_report+0x134/0x1b8=0A=
[  785.539545][ T8727]  __asan_report_load8_noabort+0x2c/0x50=0A=
[  785.545036][ T8727]  swapin_readahead+0x7b8/0xbc0=0A=
[  785.549745][ T8727]  do_swap_page+0xb1c/0x19a0=0A=
[  785.554195][ T8727]  handle_mm_fault+0xf10/0x2b30=0A=
[  785.558905][ T8727]  do_page_fault+0x230/0x908=0A=
[  785.563354][ T8727]  do_translation_fault+0xe0/0x108=0A=
[  785.568323][ T8727]  do_mem_abort+0x64/0x180=0A=
[  785.572597][ T8727]  el1_sync_handler+0x188/0x1b8=0A=
[  785.577305][ T8727]  el1_sync+0x7c/0x100=0A=
[  785.581232][ T8727]  __arch_copy_to_user+0xc4/0x158=0A=
[  785.586115][ T8727]  __arm64_sys_sysinfo+0x2c/0xd0=0A=
[  785.590912][ T8727]  do_el0_svc+0x124/0x220=0A=
[  785.595100][ T8727]  el0_sync_handler+0x260/0x408=0A=
[  785.599807][ T8727]  el0_sync+0x140/0x180=0A=
[  785.603818][ T8727]=0A=
[  785.606007][ T8727] Allocated by task 8673:=0A=
[  785.610193][ T8727]  save_stack+0x24/0x50=0A=
[  785.614208][ T8727]  __kasan_kmalloc.isra.13+0xc4/0xe0=0A=
[  785.619350][ T8727]  kasan_slab_alloc+0x14/0x20=0A=
[  785.623885][ T8727]  slab_post_alloc_hook+0x50/0xa8=0A=
[  785.628769][ T8727]  kmem_cache_alloc+0x18c/0x438=0A=
[  785.633479][ T8727]  create_object+0x58/0x960=0A=
[  785.637844][ T8727]  kmemleak_alloc+0x2c/0x38=0A=
[  785.642205][ T8727]  slab_post_alloc_hook+0x70/0xa8=0A=
[  785.647089][ T8727]  kmem_cache_alloc_trace+0x178/0x308=0A=
[  785.652322][ T8727]  refill_pi_state_cache.part.10+0x3c/0x1a8=0A=
[  785.658073][ T8727]  futex_lock_pi+0x404/0x5e0=0A=
[  785.662519][ T8727]  do_futex+0x790/0x1448=0A=
[  785.666618][ T8727]  __arm64_sys_futex+0x204/0x588=0A=
[  785.671411][ T8727]  do_el0_svc+0x124/0x220=0A=
[  785.675603][ T8727]  el0_sync_handler+0x260/0x408=0A=
[  785.680312][ T8727]  el0_sync+0x140/0x180=0A=
[  785.684322][ T8727]=0A=
[  785.686510][ T8727] Freed by task 0:=0A=
[  785.690088][ T8727]  save_stack+0x24/0x50=0A=
[  785.694104][ T8727]  __kasan_slab_free+0x124/0x198=0A=
[  785.698899][ T8727]  kasan_slab_free+0x10/0x18=0A=
[  785.703340][ T8727]  slab_free_freelist_hook+0x110/0x298=0A=
[  785.708648][ T8727]  kmem_cache_free+0xc8/0x3e0=0A=
[  785.713175][ T8727]  free_object_rcu+0x1e0/0x3b8=0A=
[  785.717796][ T8727]  rcu_core+0x8bc/0xf40=0A=
[  785.721810][ T8727]  rcu_core_si+0xc/0x18=0A=
[  785.725825][ T8727]  efi_header_end+0x2d8/0x1204=0A=
[  785.730442][ T8727]=0A=
[  785.732625][ T8727] The buggy address belongs to the object at ffff00886=
ecafd28=0A=
[  785.732625][ T8727]  which belongs to the cache kmemleak_object of size =
368=0A=
[  785.746875][ T8727] The buggy address is located 336 bytes to the right =
of=0A=
[  785.746875][ T8727]  368-byte region [ffff00886ecafd28, ffff00886ecafe98=
)=0A=
[  785.760519][ T8727] The buggy address belongs to the page:=0A=
[  785.766009][ T8727] page:ffffffe021fbb280 refcount:1 mapcount:0 mapping:=
0000000000000000 index:0xffff00886ecaa8c8=0A=
[  785.776268][ T8727] flags: 0x7ffff800000200(slab)=0A=
[  785.780971][ T8727] raw: 007ffff800000200 ffffffe0222c12c8 ffffffe0223a1=
488 ffff000000323080=0A=
[  785.789410][ T8727] raw: ffff00886ecaa8c8 00000000005b001d 00000001fffff=
fff 0000000000000000=0A=
[  785.797849][ T8727] page dumped because: kasan: bad access85.811794][ T8=
7270886ecaff00: fc  fc fc fc fc fc     ^=0A=
[  785.842727]  ffff00886ecb0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00=0A=
[  785.858703][ T8727] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[  785.866621][ T8727] Disabling lock debugging due to kernel taint=0A=
[  785.872714][ T8727] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  785.879523][ T8727] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  785.886322][ T8727] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=

--_002_CA2E3DE2DD06CA4FA11644750E4E292F454E35A9SHSMSX104ccrcor_
Content-Type: text/x-patch;
	name="0001-dbg-Fix-a-logic-hole-in-swap_ra_info.patch"
Content-Description: 0001-dbg-Fix-a-logic-hole-in-swap_ra_info.patch
Content-Disposition: attachment;
	filename="0001-dbg-Fix-a-logic-hole-in-swap_ra_info.patch"; size=796;
	creation-date="Mon, 20 Jul 2020 00:36:45 GMT";
	modification-date="Mon, 20 Jul 2020 00:36:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNmNhZDQzYWQzY2Y2M2Q3M2U1MzllM2VhYWRkNGVjOWQyNzQ0ZGM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIdWFuZyBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT4KRGF0
ZTogRnJpLCAxMCBKdWwgMjAyMCAxNzoyNzo0NSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRiZzog
Rml4IGEgbG9naWMgaG9sZSBpbiBzd2FwX3JhX2luZm8oKQoKLS0tCiBtbS9zd2FwX3N0YXRlLmMg
fCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL21tL3N3YXBfc3RhdGUuYyBiL21tL3N3YXBfc3RhdGUuYwppbmRleCAw
NTg4OWU4ZTNjOTcuLjg0ODFjMTU4MjliMiAxMDA2NDQKLS0tIGEvbW0vc3dhcF9zdGF0ZS5jCisr
KyBiL21tL3N3YXBfc3RhdGUuYwpAQCAtNjY5LDEyICs2NjksMTEgQEAgc3RhdGljIHZvaWQgc3dh
cF9yYV9pbmZvKHN0cnVjdCB2bV9mYXVsdCAqdm1mLAogCXB0ZV90ICp0cHRlOwogI2VuZGlmCiAK
KwlyYV9pbmZvLT53aW4gPSAxOwogCW1heF93aW4gPSAxIDw8IG1pbl90KHVuc2lnbmVkIGludCwg
UkVBRF9PTkNFKHBhZ2VfY2x1c3RlciksCiAJCQkgICAgIFNXQVBfUkFfT1JERVJfQ0VJTElORyk7
Ci0JaWYgKG1heF93aW4gPT0gMSkgewotCQlyYV9pbmZvLT53aW4gPSAxOworCWlmIChtYXhfd2lu
ID09IDEpCiAJCXJldHVybjsKLQl9CiAKIAlmYWRkciA9IHZtZi0+YWRkcmVzczsKIAlvcmlnX3B0
ZSA9IHB0ZSA9IHB0ZV9vZmZzZXRfbWFwKHZtZi0+cG1kLCBmYWRkcik7Ci0tIAoyLjI3LjAKCg==

--_002_CA2E3DE2DD06CA4FA11644750E4E292F454E35A9SHSMSX104ccrcor_--
