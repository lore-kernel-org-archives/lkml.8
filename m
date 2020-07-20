Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD438C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB60208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EQ84D1XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGTCMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgGTCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:12:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70FBC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 19:12:35 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so6749515qvx.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 19:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1o8rvm1fMiXx1ByR45nI68rffQe2cwB5SlcbCgRNC7Q=;
        b=EQ84D1XQDN4koUsoU4PzAxKtoxIFkQiNFllgRYcm3Dd5nAJVdDZEZbT0r5cIHtKG3w
         xKg1ZMjcjHUw/8QKK4fZBGlJPNxKpQJ5jhm6VSV6fRp/f9jJC3d5gVK8Gu96d8GfWaYC
         D8six7eJ3ti7OLxZtC//Zm9WTpCAIUwSuKiL9pY//ZMDptZH52pK2wJoRpoxKR3VAfzZ
         VsqWiu2T359nCJn7lR22DnAVB9yAMV0uwU6P7H780ul9ddwFbG5PDAd378AwvNc3X+KH
         SAryc4zauVXLL7rZ+2OzRxv5pyN0jU9ZJMUCxkf+4+x79CdSfj40LB4+eE3nQC3sr5dd
         4fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1o8rvm1fMiXx1ByR45nI68rffQe2cwB5SlcbCgRNC7Q=;
        b=Xk9GmjF0V6uVHc/AFlIXteCAsaDab5wUSfY0xFhDmYdugHc2Zdy6djYK4ALWo1H0ei
         zG9x2QZIkCnGIpFP6PofCGJO95rAj6RoXV5srSaQ8YvF1VtsRzc7AZ0Crr1N+bBfyFPs
         9+sMP3XYfD9pMBMSVSC9vIio/dBH3b0gCtwuAYh7zIt/15IBnvj/BturcuMhT5G+TLow
         hUn1uSOqSHtw+0gVs4PZa0D/ymYkkZTtdXuZu+DYCH7mQh9qL6RjGyU21eM5xSPRuPMW
         G6uwKy4+b8EabM6Nn7WxKIhuB829iwZWKbJzeyb/+wXGC5oY06AvQzneCRvOKLzVJlBi
         XpgA==
X-Gm-Message-State: AOAM532uq4oQ24Zz+ExsssXsO73hQ3CqAmcwkmZYCHD3TRsCozjLrxjt
        t1JeY1Hpu2YoyI0e2HjQs6qfcg==
X-Google-Smtp-Source: ABdhPJxydygNoKiwoCUWdA+8lsNdtvWGSlOmjVzkxEwRyyPmhkFe6HXdRSqZHLsdQnMtmqAy4y5QZQ==
X-Received: by 2002:ad4:4645:: with SMTP id y5mr20077655qvv.163.1595211154681;
        Sun, 19 Jul 2020 19:12:34 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d14sm16442795qkl.9.2020.07.19.19.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 19:12:34 -0700 (PDT)
Date:   Sun, 19 Jul 2020 22:12:28 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: not-present page at swap_vma_readahead()
Message-ID: <20200720021227.GA7354@lca.pw>
References: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
 <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw>
 <874ktl1p7y.fsf@yhuang-dev.intel.com>
 <20200616011334.GA815@lca.pw>
 <CA2E3DE2DD06CA4FA11644750E4E292F454E35A9@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA2E3DE2DD06CA4FA11644750E4E292F454E35A9@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:37:30AM +0000, Huang, Ying wrote:
> Hi,
> 
> Sorry for late reply.  I found a problem in the swap readahead code.  Can you help to check whether it can fix this?

Unfortunately, I can still reproduce it easily after applied the patch.

# git clone https://gitlab.com/cailca/linux-mm
# git checkout v5.8-rc1 -- *.sh
# dnf -y install tar wget golang libseccomp-devel jq
# ./runc.sh

[  575.517290][T28667] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.522901][T28650] BUG: KASAN: slab-out-of-bounds in swapin_readahead+0x780/0xbd8
swap_vma_readahead at mm/swap_state.c:758
(inlined by) swapin_readahead at mm/swap_state.c:802
[  575.522928][T28650] Read of size 8 at addr ffff0089a603ffe8 by task trinity-c92/28650
[  575.522947][T28650] CPU: 126 PID: 28650 Comm: trinity-c92 Not tainted 5.8.0-rc5-next-20200717+ #1
[  575.522958][T28650] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  575.522966][T28650] Call trace:
[  575.529895][T28667] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.535819][T28590] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.535829][T28590] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.535836][T28590] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.537424][T28650]  dump_backtrace+0x0/0x398
[  575.537438][T28650]  show_stack+0x14/0x20
[  575.545308][T28667] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.554134][T28650]  dump_stack+0x140/0x1c8
[  575.554148][T28650]  print_address_description.constprop.10+0x54/0x550
[  575.554159][T28650]  kasan_report+0x134/0x1b8
[  575.554173][T28650]  __asan_report_load8_noabort+0x2c/0x50
[  575.559496][T28588] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.559506][T28588] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.559513][T28588] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.562203][T28586] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.562215][T28586] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.562223][T28586] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.665163][T28560] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.671260][T28650]  swapin_readahead+0x780/0xbd8
[  575.671280][T28650]  do_swap_page+0xb1c/0x1a78
do_swap_page at mm/memory.c:3166
[  575.678067][T28560] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.682774][T28650]  handle_mm_fault+0xfd0/0x2c50
handle_pte_fault at mm/memory.c:4234
(inlined by) __handle_mm_fault at mm/memory.c:4368
(inlined by) handle_mm_fault at mm/memory.c:4466
[  575.682789][T28650]  do_page_fault+0x230/0x818
[  575.682804][T28650]  do_translation_fault+0x90/0xb0
[  575.682819][T28650]  do_mem_abort+0x64/0x180
[  575.687259][T28560] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.694051][T28650]  el1_sync_handler+0x188/0x1b8
[  575.694064][T28650]  el1_sync+0x7c/0x100
[  575.694079][T28650]  strncpy_from_user+0x270/0x3e8
[  575.694100][T28650]  getname_flags+0x80/0x330
[  575.698001][T28827] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.698048][T28827] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.698056][T28827] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.755679][T28620] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.757304][T28650]  user_path_at_empty+0x2c/0x60
[  575.764131][T28620] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.768782][T28650]  do_linkat+0x10c/0x528
[  575.768792][T28650]  __arm64_sys_linkat+0xa0/0xf8
[  575.768802][T28650]  do_el0_svc+0x124/0x228
[  575.768812][T28650]  el0_sync_handler+0x260/0x410
[  575.768820][T28650]  el0_sytack+0x24/0x50+0x14/0x20
[  5ap file entry 58_object+0x58/0x968c/0x1880
[  575.779790][T28650]  __alloc_percpu_gfp+0x14/0x20
[  575.779799][T28650]  qdisc_alloc+0x2bc/0xb98
[  575.779809][T28650]  qdisc_create_dflt+0x60/0x748
[  575.803406][T28643] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.806107][T28650]  mq_init+0x1a0/0x3b8
[  575.806120][T28650]  qdisc_create_dflt+0xc8/0x748
[  575.811321][T28643] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.815788][T28650]  dev_activate+0x488/0x8b8
[  575.815806][T28650]  __dev_open+0x240/0x360
[  575.820848][T28643] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  575.827542][T28650]  __dev_change_flags+0x344/0x480
[  575.827553][T28650]  dev_change_flags+0x74/0x140
[  575.906574][T28650]  do_setlink+0x7c8/0x2760
[  575.910856][T28650]  __rtnl_newlink+0x80c/0x1000
[  575.915481][T28650]  rtnl_newlink+0x68/0xa0
[  575.919671][T28650]  rtnetlink_rcv_msg+0x394/0xa48
[  575.924477][T28650]  netlink_rcv_skb+0x19c/0x340
[  575.929103][T28650]  rtnetlink_rcv+0x14/0x20
[  575.933380][T28650]  netlink_unicast+0x3ec/0x5e0
[  575.938005][T28650]  netlink_sendmsg+0x63c/0xa60
[  575.942632][T28650]  ____sys_sendmsg+0x5b0/0x740
[  575.947261][T28650]  ___sys_sendmsg+0xec/0x160
[  575.949053][T28716] futex_wake_op: trinity-c158 tries to shift op by -1; fix this program
[  575.951712][T28650]  __sys_sendmsg+0xb8/0x130
[  575.951727][T28650]  __arm64_sys_sendmsg+0x6c/0x98
[  575.969052][T28650]  do_el0_svc+0x124/0x228
[  575.973248][T28650]  el0_sync_handler+0x260/0x410
[  575.977959][T28650]  el0_sync+0x140/0x180
[  575.981974][T28650] Last call_rcu():
[  575.985557][T28650]  kasan_save_stack+0x24/0x50
[  575.990099][T28650]  kasan_record_aux_stack+0xe0/0x110
[  575.995249][T28650]  call_rcu+0x114/0x680
[  575.999273][T28650]  put_object+0x84/0xc0
[  576.003303][T28650]  __delete_object+0xc4/0x110
[  576.007848][T28650]  delete_object_full+0x18/0x20
[  576.012565][T28650]  kmemleak_free+0x2c/0x38
[  576.016844][T28650]  slab_free_freelist_hook+0x190/0x298
[  576.022158][T28650]  kmem_cache_free+0x128/0x518
[  576.026775][T28650]  file_free_rcu+0x68/0xb0
[  576.031045][T28650]  rcu_core+0x8b8/0xf90
[  576.035059][T28650]  rcu_core_si+0xc/0x18
[  576.039079][T28650]  efi_header_end+0x358/0x14d4
[  576.043712][T28650] Second to last call_rcu():
[  576.048176][T28650]  kasan_save_stack+0x24/0x50
[  576.052723][T28650]  kasan_record_aux_stack+0xe0/0x110
[  576.057871][T28650]  call_rcu+0x114/0x680
[  576.057998][T28976] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.061888][T28650]  put_object+0x84/0xc0
[  576.061898][T28650]  __delete_object+0xc4/0x110
[  576.061906][T28650]  delete_object_full+0x18/0x20
[  576.061917][T28650]  kmemleak_free+0x2c/0x38
[  576.061925][T28650]  slab_free_freelist_hook+0x190/0x298
[  576.061933][T28650]  kmem_cache_free+0x128/0x518
[  576.061950][T28650]  putname+0xb8/0x108
[  576.065453][T28678] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.065462][T28678] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.065470][T28678] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.068777][T28976] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.072740][T28650]  do_sys_openat2+0x26c/0x4c0
[  576.072753][T28650]  do_sys_open+0xa4/0xf8
[  576.077404][T28976] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.082097][T28650]  __arm64_sys_openat+0x88/0xc8
[  576.082107][T+0x260/0x410
[ 6.082138][T28650s to the cache kted 336 bytes to 576.082157][T28ntry 58025a5a5a5a5a5a
[  576.120513][T28650] page:00000000e119790b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8a2603
[  576.127826][T28675] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.131821][T28650] flags: 0x7ffff800000200(slab)
[  576.131835][T28650] raw: 007ffff800000200 ffffffe0223a3908 ffffffe02234c948 ffff000000322480
[  576.131845][T28650] raw: 0000000000000000 00000000005b005b 00000001ffffffff 0000000000000000
[  576.131853][T28650] page dumped because: kasan: bad access detected
[  576.131865][T28650] Memory state around the buggy address:
[  576.131875][T28650]  ffff0089a603fe80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
[  576.131884][T28650]  ffff0089a603ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  576.131894][T28650] >ffff0089a603ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  576.131900][T28650]                                                           ^
[  576.131908][T28650]  ffff0089a6040000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  576.131917][T28650]  ffff0089a6040080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  576.131923][T28650] ==================================================================
[  576.131928][T28650] Disabling lock debugging due to kernel taint
[  576.132028][T28650] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.132038][T28650] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.132046][T28650] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.281114][T28912] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.286297][T28675] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.293442][T28912] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  576.293451][T28912] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a

> From b6cad43ad3cf63d73e539e3eaadd4ec9d2744dc6 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Fri, 10 Jul 2020 17:27:45 +0800
> Subject: [PATCH] dbg: Fix a logic hole in swap_ra_info()
> 
> ---
>  mm/swap_state.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 05889e8e3c97..8481c15829b2 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -669,12 +669,11 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	pte_t *tpte;
>  #endif
>  
> +	ra_info->win = 1;
>  	max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
>  			     SWAP_RA_ORDER_CEILING);
> -	if (max_win == 1) {
> -		ra_info->win = 1;
> +	if (max_win == 1)
>  		return;
> -	}
>  
>  	faddr = vmf->address;
>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
> -- 
> 2.27.0
> 

