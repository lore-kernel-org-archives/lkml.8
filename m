Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D2F208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGTDfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:35:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:7005 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGTDfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:35:05 -0400
IronPort-SDR: ECx2mUo+TDb3ZJ+d18d1qvuAexhQnlCaLwJzwUvDvRqbpvwilHNO8b5lCCJ9vQO7LYfjkU5myb
 JA0DkstKt2cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="147805065"
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208,223";a="147805065"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2020 20:33:03 -0700
IronPort-SDR: eLmgzKUBROfh1FJ8vVCW3YZtqy3YBd+9RCnm5B6BC2dDAzFJppKCTPv0q9X+NDcCmHbFkVejzY
 4524rlkXD7Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208,223";a="309689057"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2020 20:33:03 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 19 Jul 2020 20:33:02 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 19 Jul 2020 20:33:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.135]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.32]) with mapi id 14.03.0439.000;
 Mon, 20 Jul 2020 11:33:00 +0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <cai@lca.pw>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: RE: linux-next: not-present page at swap_vma_readahead()
Thread-Topic: linux-next: not-present page at swap_vma_readahead()
Thread-Index: AQHWEmmYtAO3HUjxOE6ed8VDneXiZah4msgAgGI3K9eANWRSjP//lToAgACcUKw=
Date:   Mon, 20 Jul 2020 03:32:59 +0000
Message-ID: <CA2E3DE2DD06CA4FA11644750E4E292F454E3B6D@SHSMSX104.ccr.corp.intel.com>
References: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
 <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw>
 <874ktl1p7y.fsf@yhuang-dev.intel.com> <20200616011334.GA815@lca.pw>
 <CA2E3DE2DD06CA4FA11644750E4E292F454E35A9@SHSMSX104.ccr.corp.intel.com>,<20200720021227.GA7354@lca.pw>
In-Reply-To: <20200720021227.GA7354@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.109.78.81]
Content-Type: multipart/mixed;
        boundary="_002_CA2E3DE2DD06CA4FA11644750E4E292F454E3B6DSHSMSX104ccrcor_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_CA2E3DE2DD06CA4FA11644750E4E292F454E3B6DSHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks!  Can you try the dbg patch attached?  That will print more debuggin=
g information when abnormal PTE pointer is detected.=0A=
=0A=
Best Regards,=0A=
Huang, Ying=0A=
________________________________________=0A=
From: Qian Cai [cai@lca.pw]=0A=
Sent: Monday, July 20, 2020 10:12 AM=0A=
To: Huang, Ying=0A=
Cc: Linux-MM; LKML; Minchan Kim; Hugh Dickins; Andrew Morton=0A=
Subject: Re: linux-next: not-present page at swap_vma_readahead()=0A=
=0A=
On Mon, Jul 20, 2020 at 12:37:30AM +0000, Huang, Ying wrote:=0A=
> Hi,=0A=
>=0A=
> Sorry for late reply.  I found a problem in the swap readahead code.  Can=
 you help to check whether it can fix this?=0A=
=0A=
Unfortunately, I can still reproduce it easily after applied the patch.=0A=
=0A=
# git clone https://gitlab.com/cailca/linux-mm=0A=
# git checkout v5.8-rc1 -- *.sh=0A=
# dnf -y install tar wget golang libseccomp-devel jq=0A=
# ./runc.sh=0A=
=0A=
[  575.517290][T28667] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.522901][T28650] BUG: KASAN: slab-out-of-bounds in swapin_readahead+0=
x780/0xbd8=0A=
swap_vma_readahead at mm/swap_state.c:758=0A=
(inlined by) swapin_readahead at mm/swap_state.c:802=0A=
[  575.522928][T28650] Read of size 8 at addr ffff0089a603ffe8 by task trin=
ity-c92/28650=0A=
[  575.522947][T28650] CPU: 126 PID: 28650 Comm: trinity-c92 Not tainted 5.=
8.0-rc5-next-20200717+ #1=0A=
[  575.522958][T28650] Hardware name: HPE Apollo 70             /C01_APACHE=
_MB         , BIOS L50_5.13_1.11 06/18/2019=0A=
[  575.522966][T28650] Call trace:=0A=
[  575.529895][T28667] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.535819][T28590] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.535829][T28590] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.535836][T28590] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.537424][T28650]  dump_backtrace+0x0/0x398=0A=
[  575.537438][T28650]  show_stack+0x14/0x20=0A=
[  575.545308][T28667] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.554134][T28650]  dump_stack+0x140/0x1c8=0A=
[  575.554148][T28650]  print_address_description.constprop.10+0x54/0x550=
=0A=
[  575.554159][T28650]  kasan_report+0x134/0x1b8=0A=
[  575.554173][T28650]  __asan_report_load8_noabort+0x2c/0x50=0A=
[  575.559496][T28588] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.559506][T28588] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.559513][T28588] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.562203][T28586] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.562215][T28586] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.562223][T28586] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.665163][T28560] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.671260][T28650]  swapin_readahead+0x780/0xbd8=0A=
[  575.671280][T28650]  do_swap_page+0xb1c/0x1a78=0A=
do_swap_page at mm/memory.c:3166=0A=
[  575.678067][T28560] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.682774][T28650]  handle_mm_fault+0xfd0/0x2c50=0A=
handle_pte_fault at mm/memory.c:4234=0A=
(inlined by) __handle_mm_fault at mm/memory.c:4368=0A=
(inlined by) handle_mm_fault at mm/memory.c:4466=0A=
[  575.682789][T28650]  do_page_fault+0x230/0x818=0A=
[  575.682804][T28650]  do_translation_fault+0x90/0xb0=0A=
[  575.682819][T28650]  do_mem_abort+0x64/0x180=0A=
[  575.687259][T28560] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.694051][T28650]  el1_sync_handler+0x188/0x1b8=0A=
[  575.694064][T28650]  el1_sync+0x7c/0x100=0A=
[  575.694079][T28650]  strncpy_from_user+0x270/0x3e8=0A=
[  575.694100][T28650]  getname_flags+0x80/0x330=0A=
[  575.698001][T28827] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.698048][T28827] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.698056][T28827] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.755679][T28620] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.757304][T28650]  user_path_at_empty+0x2c/0x60=0A=
[  575.764131][T28620] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.768782][T28650]  do_linkat+0x10c/0x528=0A=
[  575.768792][T28650]  __arm64_sys_linkat+0xa0/0xf8=0A=
[  575.768802][T28650]  do_el0_svc+0x124/0x228=0A=
[  575.768812][T28650]  el0_sync_handler+0x260/0x410=0A=
[  575.768820][T28650]  el0_sytack+0x24/0x50+0x14/0x20=0A=
[  5ap file entry 58_object+0x58/0x968c/0x1880=0A=
[  575.779790][T28650]  __alloc_percpu_gfp+0x14/0x20=0A=
[  575.779799][T28650]  qdisc_alloc+0x2bc/0xb98=0A=
[  575.779809][T28650]  qdisc_create_dflt+0x60/0x748=0A=
[  575.803406][T28643] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.806107][T28650]  mq_init+0x1a0/0x3b8=0A=
[  575.806120][T28650]  qdisc_create_dflt+0xc8/0x748=0A=
[  575.811321][T28643] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.815788][T28650]  dev_activate+0x488/0x8b8=0A=
[  575.815806][T28650]  __dev_open+0x240/0x360=0A=
[  575.820848][T28643] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  575.827542][T28650]  __dev_change_flags+0x344/0x480=0A=
[  575.827553][T28650]  dev_change_flags+0x74/0x140=0A=
[  575.906574][T28650]  do_setlink+0x7c8/0x2760=0A=
[  575.910856][T28650]  __rtnl_newlink+0x80c/0x1000=0A=
[  575.915481][T28650]  rtnl_newlink+0x68/0xa0=0A=
[  575.919671][T28650]  rtnetlink_rcv_msg+0x394/0xa48=0A=
[  575.924477][T28650]  netlink_rcv_skb+0x19c/0x340=0A=
[  575.929103][T28650]  rtnetlink_rcv+0x14/0x20=0A=
[  575.933380][T28650]  netlink_unicast+0x3ec/0x5e0=0A=
[  575.938005][T28650]  netlink_sendmsg+0x63c/0xa60=0A=
[  575.942632][T28650]  ____sys_sendmsg+0x5b0/0x740=0A=
[  575.947261][T28650]  ___sys_sendmsg+0xec/0x160=0A=
[  575.949053][T28716] futex_wake_op: trinity-c158 tries to shift op by -1;=
 fix this program=0A=
[  575.951712][T28650]  __sys_sendmsg+0xb8/0x130=0A=
[  575.951727][T28650]  __arm64_sys_sendmsg+0x6c/0x98=0A=
[  575.969052][T28650]  do_el0_svc+0x124/0x228=0A=
[  575.973248][T28650]  el0_sync_handler+0x260/0x410=0A=
[  575.977959][T28650]  el0_sync+0x140/0x180=0A=
[  575.981974][T28650] Last call_rcu():=0A=
[  575.985557][T28650]  kasan_save_stack+0x24/0x50=0A=
[  575.990099][T28650]  kasan_record_aux_stack+0xe0/0x110=0A=
[  575.995249][T28650]  call_rcu+0x114/0x680=0A=
[  575.999273][T28650]  put_object+0x84/0xc0=0A=
[  576.003303][T28650]  __delete_object+0xc4/0x110=0A=
[  576.007848][T28650]  delete_object_full+0x18/0x20=0A=
[  576.012565][T28650]  kmemleak_free+0x2c/0x38=0A=
[  576.016844][T28650]  slab_free_freelist_hook+0x190/0x298=0A=
[  576.022158][T28650]  kmem_cache_free+0x128/0x518=0A=
[  576.026775][T28650]  file_free_rcu+0x68/0xb0=0A=
[  576.031045][T28650]  rcu_core+0x8b8/0xf90=0A=
[  576.035059][T28650]  rcu_core_si+0xc/0x18=0A=
[  576.039079][T28650]  efi_header_end+0x358/0x14d4=0A=
[  576.043712][T28650] Second to last call_rcu():=0A=
[  576.048176][T28650]  kasan_save_stack+0x24/0x50=0A=
[  576.052723][T28650]  kasan_record_aux_stack+0xe0/0x110=0A=
[  576.057871][T28650]  call_rcu+0x114/0x680=0A=
[  576.057998][T28976] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.061888][T28650]  put_object+0x84/0xc0=0A=
[  576.061898][T28650]  __delete_object+0xc4/0x110=0A=
[  576.061906][T28650]  delete_object_full+0x18/0x20=0A=
[  576.061917][T28650]  kmemleak_free+0x2c/0x38=0A=
[  576.061925][T28650]  slab_free_freelist_hook+0x190/0x298=0A=
[  576.061933][T28650]  kmem_cache_free+0x128/0x518=0A=
[  576.061950][T28650]  putname+0xb8/0x108=0A=
[  576.065453][T28678] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.065462][T28678] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.065470][T28678] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.068777][T28976] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.072740][T28650]  do_sys_openat2+0x26c/0x4c0=0A=
[  576.072753][T28650]  do_sys_open+0xa4/0xf8=0A=
[  576.077404][T28976] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.082097][T28650]  __arm64_sys_openat+0x88/0xc8=0A=
[  576.082107][T+0x260/0x410=0A=
[ 6.082138][T28650s to the cache kted 336 bytes to 576.082157][T28ntry 5802=
5a5a5a5a5a5a=0A=
[  576.120513][T28650] page:00000000e119790b refcount:1 mapcount:0 mapping:=
0000000000000000 index:0x0 pfn:0x8a2603=0A=
[  576.127826][T28675] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.131821][T28650] flags: 0x7ffff800000200(slab)=0A=
[  576.131835][T28650] raw: 007ffff800000200 ffffffe0223a3908 ffffffe02234c=
948 ffff000000322480=0A=
[  576.131845][T28650] raw: 0000000000000000 00000000005b005b 00000001fffff=
fff 0000000000000000=0A=
[  576.131853][T28650] page dumped because: kasan: bad access detected=0A=
[  576.131865][T28650] Memory state around the buggy address:=0A=
[  576.131875][T28650]  ffff0089a603fe80: 00 00 00 fc fc fc fc fc fc fc fc =
fc fc fc fc fc=0A=
[  576.131884][T28650]  ffff0089a603ff00: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc=0A=
[  576.131894][T28650] >ffff0089a603ff80: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc=0A=
[  576.131900][T28650]                                                     =
      ^=0A=
[  576.131908][T28650]  ffff0089a6040000: 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00=0A=
[  576.131917][T28650]  ffff0089a6040080: 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00=0A=
[  576.131923][T28650] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[  576.131928][T28650] Disabling lock debugging due to kernel taint=0A=
[  576.132028][T28650] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.132038][T28650] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.132046][T28650] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.281114][T28912] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.286297][T28675] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.293442][T28912] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
[  576.293451][T28912] get_swap_device: Bad swap file entry 58025a5a5a5a5a5=
a=0A=
=0A=
> From b6cad43ad3cf63d73e539e3eaadd4ec9d2744dc6 Mon Sep 17 00:00:00 2001=0A=
> From: Huang Ying <ying.huang@intel.com>=0A=
> Date: Fri, 10 Jul 2020 17:27:45 +0800=0A=
> Subject: [PATCH] dbg: Fix a logic hole in swap_ra_info()=0A=
>=0A=
> ---=0A=
>  mm/swap_state.c | 5 ++---=0A=
>  1 file changed, 2 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/mm/swap_state.c b/mm/swap_state.c=0A=
> index 05889e8e3c97..8481c15829b2 100644=0A=
> --- a/mm/swap_state.c=0A=
> +++ b/mm/swap_state.c=0A=
> @@ -669,12 +669,11 @@ static void swap_ra_info(struct vm_fault *vmf,=0A=
>       pte_t *tpte;=0A=
>  #endif=0A=
>=0A=
> +     ra_info->win =3D 1;=0A=
>       max_win =3D 1 << min_t(unsigned int, READ_ONCE(page_cluster),=0A=
>                            SWAP_RA_ORDER_CEILING);=0A=
> -     if (max_win =3D=3D 1) {=0A=
> -             ra_info->win =3D 1;=0A=
> +     if (max_win =3D=3D 1)=0A=
>               return;=0A=
> -     }=0A=
>=0A=
>       faddr =3D vmf->address;=0A=
>       orig_pte =3D pte =3D pte_offset_map(vmf->pmd, faddr);=0A=
> --=0A=
> 2.27.0=0A=
>=0A=
=0A=

--_002_CA2E3DE2DD06CA4FA11644750E4E292F454E3B6DSHSMSX104ccrcor_
Content-Type: text/x-patch;
	name="0001-dbg-dump-upon-abnormal-pte-values.patch"
Content-Description: 0001-dbg-dump-upon-abnormal-pte-values.patch
Content-Disposition: attachment;
	filename="0001-dbg-dump-upon-abnormal-pte-values.patch"; size=1029;
	creation-date="Mon, 20 Jul 2020 03:32:53 GMT";
	modification-date="Mon, 20 Jul 2020 03:32:53 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzY2E3YTliYTU4NTQxZDg2OTJkM2Y4M2NiZGVkMmFkMTdiZTIzMzU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIdWFuZyBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT4KRGF0
ZTogTW9uLCAyMCBKdWwgMjAyMCAxMToyOTozOCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRiZzog
ZHVtcCB1cG9uIGFibm9ybWFsIHB0ZSB2YWx1ZXMKCi0tLQogbW0vc3dhcF9zdGF0ZS5jIHwgMTEg
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvbW0vc3dhcF9zdGF0ZS5jIGIvbW0vc3dhcF9zdGF0ZS5jCmluZGV4IDA1ODg5ZThlM2M5Ny4u
YzE5NzMxMzZkMDM1IDEwMDY0NAotLS0gYS9tbS9zd2FwX3N0YXRlLmMKKysrIGIvbW0vc3dhcF9z
dGF0ZS5jCkBAIC03NTYsNiArNzU2LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqc3dhcF92bWFf
cmVhZGFoZWFkKHN3cF9lbnRyeV90IGZlbnRyeSwgZ2ZwX3QgZ2ZwX21hc2ssCiAJYmxrX3N0YXJ0
X3BsdWcoJnBsdWcpOwogCWZvciAoaSA9IDAsIHB0ZSA9IHJhX2luZm8ucHRlczsgaSA8IHJhX2lu
Zm8ubnJfcHRlOwogCSAgICAgaSsrLCBwdGUrKykgeworCQlwdGVfdCAqdHB0ZSA9IHB0ZV9vZmZz
ZXRfbWFwKHZtZi0+cG1kLCB2bWYtPmFkZHJlc3MpOworCisJCWlmICgoKHVuc2lnbmVkIGxvbmcp
cHRlID4+IFBBR0VfU0hJRlQpICE9CisJCSAgICAoKHVuc2lnbmVkIGxvbmcpdHB0ZSA+PiBQQUdF
X1NISUZUKSkgeworCQkJcHJfaW5mbygicmFfaW5mbzogJWQsICVkLCAlZCwgJXBcbiIsCisJCQkJ
cmFfaW5mby53aW4sIHJhX2luZm8ub2Zmc2V0LCByYV9pbmZvLm5yX3B0ZSwKKwkJCQlyYV9pbmZv
LnB0ZXMpOworCQkJcHJfaW5mbygiaTogJWQsIHB0ZTogJXAsIGZhZGRyOiAlbHhcbiIsIGksIHB0
ZSwKKwkJCQl2bWYtPmFkZHJlc3MpOworCQl9CisJCXB0ZV91bm1hcCh0cHRlKTsKIAkJcGVudHJ5
ID0gKnB0ZTsKIAkJaWYgKHB0ZV9ub25lKHBlbnRyeSkpCiAJCQljb250aW51ZTsKLS0gCjIuMjcu
MAoK

--_002_CA2E3DE2DD06CA4FA11644750E4E292F454E3B6DSHSMSX104ccrcor_--
