Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2316C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA022072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="TqstZOor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgEVK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:26:33 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:57199 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgEVK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:26:31 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id c4sjjoMu1dPgTc4skjRQYV; Fri, 22 May 2020 12:26:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1590143187; bh=n7cxLWIV8YP6hdd6CBOlnNXBi8B83SkepkJHJZPpYnc=;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=TqstZOorqUeEKMznRO37sKHCbCF6Ep7nEBOLagaTvQS6QykvYF3ofPBrz484OoKJ7
         9yxZe8tIrkwq+mmHUORzlQyJIM+X6+X2Hc3WZ4/PxFN3HlmZcP+ufCFMfKg8//REEE
         b1aOFWtPnuoZab2ra9VVQ6aPwcwXDe9qifME2wL37tKCuQXIGHNRXBYMTLYK2eCUIS
         aB9uvpaEsll2Jxt8t2LQ4vnY67lSL8bZLKbULbLjtyD9kRNwRoLc677RYns0ETSpBH
         rDLnaAGuZENqggl4wJ1iFVkJho3041sTz6UK2rUQ33IUN9RIV/dRZn4h1OaGxq80Z5
         AgXyxmQngy+EQ==
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.6.13: bug? INFO: task Link Monitor:84552 blocked for more than 120
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <058639be-6caf-7658-1b92-75b3620c085d@xs4all.nl>
Date:   Fri, 22 May 2020 12:26:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNEM1UNxjmhtd274qsHE474opzbSv9S9blDlQKSCzWV7qr8QlbCXJ/PgUi7wXlewLeL/odA/qxLjuoRv77M9fQTl6bYCun66YKPQBRrARxO7fLwD8nYq
 KiMp3M8JTK7c7vdcyq5mTtp6dvXx9bciCznKXfE28lCmlSTZ5pcHJGxup3aCdrhywyFEr46uA+t/48wPs3xSwoU7NzX2efmcJk9M+S+afYd0i9JB5DssTxi1
 60y7zJtYI3bSuueqCkj1iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was AFK when this occurred.
What happened and what can I to help get this fixed?


[207927.171466] cp210x 5-4.1:1.0: device disconnected
[264738.655873] INFO: task Link Monitor:84552 blocked for more than 120
seconds.
[264738.655875]       Not tainted 5.6.13 #29
[264738.655876] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.655878] Link Monitor    D    0 84552   3841 0x00000000
[264738.655880] Call Trace:
[264738.655884]  ? __schedule+0x1f0/0x600
[264738.655885]  ? bit_wait_timeout+0x90/0x90
[264738.655886]  ? schedule+0x41/0xe0
[264738.655887]  ? io_schedule+0xd/0x30
[264738.655888]  ? bit_wait_io+0x8/0x50
[264738.655889]  ? __wait_on_bit_lock+0x58/0xa0
[264738.655891]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.655893]  ? var_wake_function+0x20/0x20
[264738.655895]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.655897]  ? __read_extent_tree_block+0x51/0x120
[264738.655898]  ? ext4_find_extent+0x14e/0x310
[264738.655899]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.655901]  ? _raw_spin_unlock_irqrestore+0xf/0x30
[264738.655903]  ? percpu_counter_add_batch+0x81/0xb0
[264738.655904]  ? _raw_read_unlock+0x13/0x30
[264738.655905]  ? ext4_map_blocks+0x32d/0x570
[264738.655907]  ? workingset_refault+0x47/0xe0
[264738.655909]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.655911]  ? preempt_schedule_irq+0x3f/0x50
[264738.655912]  ? read_pages+0x6d/0x160
[264738.655913]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.655915]  ? filemap_fault+0x59c/0x820
[264738.655916]  ? _raw_spin_lock+0xe/0x30
[264738.655917]  ? _raw_spin_unlock+0xd/0x20
[264738.655919]  ? page_swapcount+0x63/0x80
[264738.655920]  ? filemap_map_pages+0x260/0x350
[264738.655921]  ? ext4_filemap_fault+0x28/0x3a
[264738.655922]  ? __do_fault+0x33/0x90
[264738.655923]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.655924]  ? __switch_to_asm+0x40/0x70
[264738.655926]  ? handle_mm_fault+0x4b/0xc0
[264738.655927]  ? do_page_fault+0x1a3/0x41a
[264738.655929]  ? page_fault+0x2f/0x40
[264738.655931] INFO: task Timer:84595 blocked for more than 120 seconds.
[264738.655932]       Not tainted 5.6.13 #29
[264738.655932] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.655933] Timer           D    0 84595   3841 0x00004000
[264738.655934] Call Trace:
[264738.655936]  ? __schedule+0x1f0/0x600
[264738.655937]  ? blk_flush_plug_list+0xcb/0xf0
[264738.655938]  ? bit_wait_timeout+0x90/0x90
[264738.655939]  ? schedule+0x41/0xe0
[264738.655940]  ? io_schedule+0xd/0x30
[264738.655941]  ? bit_wait_io+0x8/0x50
[264738.655942]  ? __wait_on_bit+0x25/0x80
[264738.655943]  ? out_of_line_wait_on_bit+0x8d/0xb0
[264738.655944]  ? var_wake_function+0x20/0x20
[264738.655945]  ? bh_submit_read+0x6e/0x80
[264738.655946]  ? __read_extent_tree_block+0xd7/0x120
[264738.655947]  ? ext4_find_extent+0x14e/0x310
[264738.655949]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.655950]  ? percpu_counter_add_batch+0x81/0xb0
[264738.655951]  ? _raw_read_unlock+0x13/0x30
[264738.655952]  ? ext4_map_blocks+0x32d/0x570
[264738.655954]  ? workingset_refault+0x47/0xe0
[264738.655955]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.655956]  ? read_pages+0x6d/0x160
[264738.655957]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.655959]  ? filemap_fault+0x59c/0x820
[264738.655960]  ? alloc_set_pte+0xfc/0x5d0
[264738.655961]  ? filemap_map_pages+0x260/0x350
[264738.655962]  ? ext4_filemap_fault+0x28/0x3a
[264738.655963]  ? __do_fault+0x33/0x90
[264738.655964]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.655965]  ? handle_mm_fault+0x4b/0xc0
[264738.655966]  ? do_page_fault+0x1a3/0x41a
[264738.655968]  ? prepare_exit_to_usermode+0x101/0x130
[264738.655969]  ? page_fault+0x2f/0x40
[264738.655977] INFO: task Socket Thread:684933 blocked for more than
120 seconds.
[264738.655978]       Not tainted 5.6.13 #29
[264738.655978] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.655979] Socket Thread   D    0 684933  84512 0x00004000
[264738.655980] Call Trace:
[264738.655981]  ? __schedule+0x1f0/0x600
[264738.655982]  ? move_pages_to_lru+0x12c/0x3d0
[264738.655983]  ? bit_wait_timeout+0x90/0x90
[264738.655984]  ? schedule+0x41/0xe0
[264738.655985]  ? io_schedule+0xd/0x30
[264738.655986]  ? bit_wait_io+0x8/0x50
[264738.655987]  ? __wait_on_bit_lock+0x58/0xa0
[264738.655988]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.655989]  ? var_wake_function+0x20/0x20
[264738.655990]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.655991]  ? __read_extent_tree_block+0x51/0x120
[264738.655993]  ? ext4_find_extent+0x14e/0x310
[264738.655994]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.655995]  ? percpu_counter_add_batch+0x81/0xb0
[264738.655996]  ? _raw_read_unlock+0x13/0x30
[264738.655997]  ? ext4_map_blocks+0x32d/0x570
[264738.655998]  ? workingset_refault+0x47/0xe0
[264738.655999]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656001]  ? read_pages+0x6d/0x160
[264738.656002]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656004]  ? filemap_fault+0x59c/0x820
[264738.656005]  ? alloc_set_pte+0xfc/0x5d0
[264738.656006]  ? filemap_map_pages+0x260/0x350
[264738.656007]  ? ext4_filemap_fault+0x28/0x3a
[264738.656008]  ? __do_fault+0x33/0x90
[264738.656009]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656010]  ? handle_mm_fault+0x4b/0xc0
[264738.656011]  ? do_page_fault+0x1a3/0x41a
[264738.656012]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656013]  ? page_fault+0x2f/0x40
[264738.656028] INFO: task Timer:685050 blocked for more than 120 seconds.
[264738.656029]       Not tainted 5.6.13 #29
[264738.656029] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656030] Timer           D    0 685050 685004 0x00000000
[264738.656031] Call Trace:
[264738.656032]  ? __schedule+0x1f0/0x600
[264738.656033]  ? bit_wait_timeout+0x90/0x90
[264738.656034]  ? schedule+0x41/0xe0
[264738.656035]  ? io_schedule+0xd/0x30
[264738.656036]  ? bit_wait_io+0x8/0x50
[264738.656037]  ? __wait_on_bit_lock+0x58/0xa0
[264738.656038]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.656039]  ? var_wake_function+0x20/0x20
[264738.656040]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.656041]  ? __read_extent_tree_block+0x51/0x120
[264738.656042]  ? ext4_find_extent+0x14e/0x310
[264738.656043]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656044]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656046]  ? _raw_read_unlock+0x13/0x30
[264738.656047]  ? ext4_map_blocks+0x32d/0x570
[264738.656048]  ? workingset_refault+0x47/0xe0
[264738.656049]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656050]  ? _raw_spin_lock+0xe/0x30
[264738.656051]  ? _raw_spin_unlock+0xd/0x20
[264738.656053]  ? __switch_to_xtra+0x2b2/0x470
[264738.656054]  ? __switch_to_asm+0x40/0x70
[264738.656055]  ? _raw_spin_unlock_irq+0xe/0x20
[264738.656056]  ? read_pages+0x6d/0x160
[264738.656057]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656059]  ? filemap_fault+0x59c/0x820
[264738.656060]  ? _raw_spin_lock+0xe/0x30
[264738.656061]  ? alloc_set_pte+0xfc/0x5d0
[264738.656062]  ? filemap_map_pages+0x260/0x350
[264738.656063]  ? ext4_filemap_fault+0x28/0x3a
[264738.656064]  ? __do_fault+0x33/0x90
[264738.656065]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656066]  ? handle_mm_fault+0x4b/0xc0
[264738.656067]  ? do_page_fault+0x1a3/0x41a
[264738.656068]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656069]  ? page_fault+0x2f/0x40
[264738.656080] INFO: task Timer:685117 blocked for more than 120 seconds.
[264738.656081]       Not tainted 5.6.13 #29
[264738.656081] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656082] Timer           D    0 685117 685004 0x00004120
[264738.656083] Call Trace:
[264738.656084]  ? __schedule+0x1f0/0x600
[264738.656085]  ? bit_wait_timeout+0x90/0x90
[264738.656086]  ? schedule+0x41/0xe0
[264738.656086]  ? io_schedule+0xd/0x30
[264738.656087]  ? bit_wait_io+0x8/0x50
[264738.656088]  ? __wait_on_bit_lock+0x58/0xa0
[264738.656089]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.656090]  ? var_wake_function+0x20/0x20
[264738.656091]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.656092]  ? __read_extent_tree_block+0x51/0x120
[264738.656094]  ? ext4_find_extent+0x14e/0x310
[264738.656095]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656096]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656097]  ? _raw_read_unlock+0x13/0x30
[264738.656099]  ? ext4_map_blocks+0x32d/0x570
[264738.656100]  ? workingset_refault+0x47/0xe0
[264738.656101]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656102]  ? _raw_spin_unlock_irq+0xe/0x20
[264738.656103]  ? read_pages+0x6d/0x160
[264738.656104]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656106]  ? filemap_fault+0x59c/0x820
[264738.656107]  ? _raw_spin_lock+0xe/0x30
[264738.656108]  ? alloc_set_pte+0xfc/0x5d0
[264738.656109]  ? filemap_map_pages+0x260/0x350
[264738.656110]  ? ext4_filemap_fault+0x28/0x3a
[264738.656111]  ? __do_fault+0x33/0x90
[264738.656112]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656113]  ? handle_mm_fault+0x4b/0xc0
[264738.656114]  ? do_page_fault+0x1a3/0x41a
[264738.656115]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656116]  ? page_fault+0x2f/0x40
[264738.656121] INFO: task Timer:685199 blocked for more than 120 seconds.
[264738.656122]       Not tainted 5.6.13 #29
[264738.656122] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656123] Timer           D    0 685199 685004 0x00004120
[264738.656124] Call Trace:
[264738.656125]  ? __schedule+0x1f0/0x600
[264738.656126]  ? move_pages_to_lru+0x12c/0x3d0
[264738.656127]  ? bit_wait_timeout+0x90/0x90
[264738.656128]  ? schedule+0x41/0xe0
[264738.656129]  ? io_schedule+0xd/0x30
[264738.656130]  ? bit_wait_io+0x8/0x50
[264738.656131]  ? __wait_on_bit_lock+0x58/0xa0
[264738.656132]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.656133]  ? var_wake_function+0x20/0x20
[264738.656134]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.656135]  ? __read_extent_tree_block+0x51/0x120
[264738.656136]  ? ext4_find_extent+0x14e/0x310
[264738.656137]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656139]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656140]  ? _raw_read_unlock+0x13/0x30
[264738.656141]  ? ext4_map_blocks+0x32d/0x570
[264738.656142]  ? workingset_refault+0x47/0xe0
[264738.656143]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656144]  ? read_pages+0x6d/0x160
[264738.656146]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656147]  ? filemap_fault+0x59c/0x820
[264738.656148]  ? _raw_spin_lock+0xe/0x30
[264738.656149]  ? _raw_spin_unlock+0xd/0x20
[264738.656150]  ? page_swapcount+0x63/0x80
[264738.656151]  ? filemap_map_pages+0x260/0x350
[264738.656152]  ? ext4_filemap_fault+0x28/0x3a
[264738.656153]  ? __do_fault+0x33/0x90
[264738.656154]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656156]  ? handle_mm_fault+0x4b/0xc0
[264738.656157]  ? do_page_fault+0x1a3/0x41a
[264738.656158]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656159]  ? page_fault+0x2f/0x40
[264738.656164] INFO: task Timer:685309 blocked for more than 120 seconds.
[264738.656165]       Not tainted 5.6.13 #29
[264738.656165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656166] Timer           D    0 685309 685004 0x00000120
[264738.656167] Call Trace:
[264738.656168]  ? __schedule+0x1f0/0x600
[264738.656169]  ? blk_flush_plug_list+0xcb/0xf0
[264738.656170]  ? bit_wait_timeout+0x90/0x90
[264738.656171]  ? schedule+0x41/0xe0
[264738.656172]  ? io_schedule+0xd/0x30
[264738.656172]  ? bit_wait_io+0x8/0x50
[264738.656173]  ? __wait_on_bit+0x25/0x80
[264738.656174]  ? out_of_line_wait_on_bit+0x8d/0xb0
[264738.656175]  ? var_wake_function+0x20/0x20
[264738.656177]  ? bh_submit_read+0x6e/0x80
[264738.656178]  ? __read_extent_tree_block+0xd7/0x120
[264738.656179]  ? ext4_find_extent+0x14e/0x310
[264738.656180]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656181]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656182]  ? _raw_read_unlock+0x13/0x30
[264738.656183]  ? ext4_map_blocks+0x32d/0x570
[264738.656185]  ? workingset_refault+0x47/0xe0
[264738.656186]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656188]  ? reweight_entity+0x255/0x2b0
[264738.656189]  ? read_pages+0x6d/0x160
[264738.656190]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656191]  ? filemap_fault+0x59c/0x820
[264738.656193]  ? filemap_map_pages+0x260/0x350
[264738.656194]  ? ext4_filemap_fault+0x28/0x3a
[264738.656195]  ? __do_fault+0x33/0x90
[264738.656196]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656197]  ? handle_mm_fault+0x4b/0xc0
[264738.656198]  ? do_page_fault+0x1a3/0x41a
[264738.656199]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656200]  ? page_fault+0x2f/0x40
[264738.656205] INFO: task Timer:685329 blocked for more than 120 seconds.
[264738.656206]       Not tainted 5.6.13 #29
[264738.656206] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656207] Timer           D    0 685329 685004 0x00000120
[264738.656208] Call Trace:
[264738.656209]  ? __schedule+0x1f0/0x600
[264738.656210]  ? bit_wait_timeout+0x90/0x90
[264738.656211]  ? schedule+0x41/0xe0
[264738.656212]  ? io_schedule+0xd/0x30
[264738.656213]  ? bit_wait_io+0x8/0x50
[264738.656213]  ? __wait_on_bit_lock+0x58/0xa0
[264738.656215]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.656216]  ? var_wake_function+0x20/0x20
[264738.656217]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.656218]  ? __read_extent_tree_block+0x51/0x120
[264738.656219]  ? ext4_find_extent+0x14e/0x310
[264738.656220]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656222]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656223]  ? _raw_read_unlock+0x13/0x30
[264738.656224]  ? ext4_map_blocks+0x32d/0x570
[264738.656225]  ? workingset_refault+0x47/0xe0
[264738.656226]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656228]  ? enqueue_entity+0xd1/0x2f0
[264738.656229]  ? read_pages+0x6d/0x160
[264738.656230]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656231]  ? filemap_fault+0x59c/0x820
[264738.656233]  ? filemap_map_pages+0x260/0x350
[264738.656234]  ? ext4_filemap_fault+0x28/0x3a
[264738.656235]  ? __do_fault+0x33/0x90
[264738.656236]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656237]  ? handle_mm_fault+0x4b/0xc0
[264738.656238]  ? do_page_fault+0x1a3/0x41a
[264738.656239]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656240]  ? page_fault+0x2f/0x40
[264738.656245] INFO: task Timer:685355 blocked for more than 120 seconds.
[264738.656246]       Not tainted 5.6.13 #29
[264738.656246] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656247] Timer           D    0 685355 685004 0x00000120
[264738.656248] Call Trace:
[264738.656249]  ? __schedule+0x1f0/0x600
[264738.656250]  ? bit_wait_timeout+0x90/0x90
[264738.656250]  ? schedule+0x41/0xe0
[264738.656251]  ? io_schedule+0xd/0x30
[264738.656252]  ? bit_wait_io+0x8/0x50
[264738.656253]  ? __wait_on_bit_lock+0x58/0xa0
[264738.656254]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.656255]  ? var_wake_function+0x20/0x20
[264738.656256]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.656258]  ? __read_extent_tree_block+0x51/0x120
[264738.656259]  ? ext4_find_extent+0x14e/0x310
[264738.656260]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656261]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656262]  ? _raw_read_unlock+0x13/0x30
[264738.656263]  ? ext4_map_blocks+0x32d/0x570
[264738.656265]  ? workingset_refault+0x47/0xe0
[264738.656266]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656267]  ? _raw_spin_lock+0xe/0x30
[264738.656268]  ? _raw_spin_unlock+0xd/0x20
[264738.656269]  ? __switch_to_xtra+0x1e8/0x470
[264738.656270]  ? _raw_spin_unlock_irq+0xe/0x20
[264738.656271]  ? read_pages+0x6d/0x160
[264738.656272]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656274]  ? filemap_fault+0x59c/0x820
[264738.656275]  ? _raw_spin_lock+0xe/0x30
[264738.656275]  ? alloc_set_pte+0xfc/0x5d0
[264738.656276]  ? filemap_map_pages+0x260/0x350
[264738.656278]  ? ext4_filemap_fault+0x28/0x3a
[264738.656278]  ? __do_fault+0x33/0x90
[264738.656279]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656281]  ? handle_mm_fault+0x4b/0xc0
[264738.656282]  ? do_page_fault+0x1a3/0x41a
[264738.656283]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656284]  ? page_fault+0x2f/0x40
[264738.656289] INFO: task Timer:685383 blocked for more than 120 seconds.
[264738.656290]       Not tainted 5.6.13 #29
[264738.656290] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[264738.656291] Timer           D    0 685383 685004 0x00000120
[264738.656292] Call Trace:
[264738.656293]  ? __schedule+0x1f0/0x600
[264738.656294]  ? bit_wait_timeout+0x90/0x90
[264738.656295]  ? schedule+0x41/0xe0
[264738.656296]  ? io_schedule+0xd/0x30
[264738.656297]  ? bit_wait_io+0x8/0x50
[264738.656298]  ? __wait_on_bit_lock+0x58/0xa0
[264738.656299]  ? out_of_line_wait_on_bit_lock+0x8d/0xb0
[264738.656300]  ? var_wake_function+0x20/0x20
[264738.656301]  ? bh_uptodate_or_lock+0x5a/0x60
[264738.656302]  ? __read_extent_tree_block+0x51/0x120
[264738.656303]  ? ext4_find_extent+0x14e/0x310
[264738.656305]  ? ext4_ext_map_blocks+0x5c/0xfe0
[264738.656306]  ? percpu_counter_add_batch+0x81/0xb0
[264738.656307]  ? _raw_read_unlock+0x13/0x30
[264738.656308]  ? ext4_map_blocks+0x32d/0x570
[264738.656309]  ? workingset_refault+0x47/0xe0
[264738.656310]  ? ext4_mpage_readpages+0x364/0x8c0
[264738.656312]  ? reweight_entity+0x255/0x2b0
[264738.656313]  ? read_pages+0x6d/0x160
[264738.656314]  ? __do_page_cache_readahead+0x192/0x1b0
[264738.656316]  ? filemap_fault+0x59c/0x820
[264738.656317]  ? filemap_map_pages+0x260/0x350
[264738.656318]  ? ext4_filemap_fault+0x28/0x3a
[264738.656319]  ? __do_fault+0x33/0x90
[264738.656320]  ? __handle_mm_fault+0xcd4/0xfe0
[264738.656321]  ? handle_mm_fault+0x4b/0xc0
[264738.656322]  ? do_page_fault+0x1a3/0x41a
[264738.656323]  ? prepare_exit_to_usermode+0x101/0x130
[264738.656324]  ? page_fault+0x2f/0x40
[265201.827733] systemd[1]: systemd-journald.service: Main process
exited, code=dumped, status=6/ABRT
[265201.827875] systemd[1]: systemd-journald.service: Failed with result
'watchdog'.
[265201.829468] systemd[1]: systemd-journald.service: Consumed 7.277s
CPU time.
[265201.963978] systemd[1]: systemd-journal-flush.service: Control
process exited, code=exited, status=1/FAILURE
[265201.964082] systemd[1]: systemd-journal-flush.service: Failed with
result 'exit-code'.
[265201.964815] systemd[1]: systemd-journald.service: Consumed 7.277s
CPU time.
[265202.463718] systemd-journald[707659]: File
/var/log/journal/6bc32011e81922c063bab4ec493561d1/system.journal
corrupted or uncleanly shut down, renaming and replacing.
[265204.032635] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
timeout, signaled seq=12476642, emitted seq=12476645
[265204.032691] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process GPU Process pid 685005 thread firefox:cs0 pid 685053
[265204.032696] amdgpu 0000:0a:00.0: GPU reset begin!
[265204.083611] amdgpu 0000:0a:00.0: GPU reset succeeded, trying to resume
[265204.083893] [drm] PCIE GART of 1024M enabled (table at
0x000000F400900000).
[265204.084220] [drm] PSP is resuming...
[265204.104089] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
[265204.114574] [drm] psp command (0x5) failed and response status is
(0xFFFF0007)
[265204.330586] amdgpu 0000:0a:00.0: RAS: ras ta ucode is not available
[265204.613017] [drm] kiq ring mec 2 pipe 1 q 0
[265204.644600] [drm] VCN decode and encode initialized
successfully(under DPG Mode).
[265204.644609] amdgpu 0000:0a:00.0: ring gfx uses VM inv eng 0 on hub 0
[265204.644611] amdgpu 0000:0a:00.0: ring comp_1.0.0 uses VM inv eng 1
on hub 0
[265204.644615] amdgpu 0000:0a:00.0: ring comp_1.1.0 uses VM inv eng 4
on hub 0
[265204.644618] amdgpu 0000:0a:00.0: ring comp_1.2.0 uses VM inv eng 5
on hub 0
[265204.644620] amdgpu 0000:0a:00.0: ring comp_1.3.0 uses VM inv eng 6
on hub 0
[265204.644623] amdgpu 0000:0a:00.0: ring comp_1.0.1 uses VM inv eng 7
on hub 0
[265204.644625] amdgpu 0000:0a:00.0: ring comp_1.1.1 uses VM inv eng 8
on hub 0
[265204.644628] amdgpu 0000:0a:00.0: ring comp_1.2.1 uses VM inv eng 9
on hub 0
[265204.644630] amdgpu 0000:0a:00.0: ring comp_1.3.1 uses VM inv eng 10
on hub 0
[265204.644633] amdgpu 0000:0a:00.0: ring kiq_2.1.0 uses VM inv eng 11
on hub 0
[265204.644635] amdgpu 0000:0a:00.0: ring sdma0 uses VM inv eng 0 on hub 1
[265204.644637] amdgpu 0000:0a:00.0: ring vcn_dec uses VM inv eng 1 on hub 1
[265204.644640] amdgpu 0000:0a:00.0: ring vcn_enc0 uses VM inv eng 4 on
hub 1
[265204.644642] amdgpu 0000:0a:00.0: ring vcn_enc1 uses VM inv eng 5 on
hub 1
[265204.644644] amdgpu 0000:0a:00.0: ring jpeg_dec uses VM inv eng 6 on
hub 1
[265204.654990] [drm] recover vram bo from shadow start
[265204.654992] [drm] recover vram bo from shadow done
[265204.654995] [drm] Skip scheduling IBs!
[265204.655060] amdgpu 0000:0a:00.0: GPU reset(2) succeeded!
[265205.696615] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
timeout, signaled seq=12476651, emitted seq=12476654
[265205.696660] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process gnome-shell pid 3841 thread gnome-shel:cs0 pid 3851
[265205.696665] amdgpu 0000:0a:00.0: GPU reset begin!
[265205.747606] amdgpu 0000:0a:00.0: GPU reset succeeded, trying to resume
[265205.747877] [drm] PCIE GART of 1024M enabled (table at
0x000000F400900000).
[265205.748214] [drm] PSP is resuming...
[265205.768089] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
[265205.782592] [drm] psp command (0x5) failed and response status is
(0xFFFF0007)
[265205.986551] amdgpu 0000:0a:00.0: RAS: ras ta ucode is not available
[265206.265804] [drm] kiq ring mec 2 pipe 1 q 0
[265206.297755] [drm] VCN decode and encode initialized
successfully(under DPG Mode).
[265206.297771] amdgpu 0000:0a:00.0: ring gfx uses VM inv eng 0 on hub 0
[265206.297773] amdgpu 0000:0a:00.0: ring comp_1.0.0 uses VM inv eng 1
on hub 0
[265206.297776] amdgpu 0000:0a:00.0: ring comp_1.1.0 uses VM inv eng 4
on hub 0
[265206.297780] amdgpu 0000:0a:00.0: ring comp_1.2.0 uses VM inv eng 5
on hub 0
[265206.297782] amdgpu 0000:0a:00.0: ring comp_1.3.0 uses VM inv eng 6
on hub 0
[265206.297785] amdgpu 0000:0a:00.0: ring comp_1.0.1 uses VM inv eng 7
on hub 0
[265206.297788] amdgpu 0000:0a:00.0: ring comp_1.1.1 uses VM inv eng 8
on hub 0
[265206.297790] amdgpu 0000:0a:00.0: ring comp_1.2.1 uses VM inv eng 9
on hub 0
[265206.297791] amdgpu 0000:0a:00.0: ring comp_1.3.1 uses VM inv eng 10
on hub 0
[265206.297795] amdgpu 0000:0a:00.0: ring kiq_2.1.0 uses VM inv eng 11
on hub 0
[265206.297797] amdgpu 0000:0a:00.0: ring sdma0 uses VM inv eng 0 on hub 1
[265206.297798] amdgpu 0000:0a:00.0: ring vcn_dec uses VM inv eng 1 on hub 1
[265206.297800] amdgpu 0000:0a:00.0: ring vcn_enc0 uses VM inv eng 4 on
hub 1
[265206.297802] amdgpu 0000:0a:00.0: ring vcn_enc1 uses VM inv eng 5 on
hub 1
[265206.297804] amdgpu 0000:0a:00.0: ring jpeg_dec uses VM inv eng 6 on
hub 1
[265206.308069] [drm] recover vram bo from shadow start
[265206.308072] [drm] recover vram bo from shadow done
[265206.308074] [drm] Skip scheduling IBs!
[265206.308138] amdgpu 0000:0a:00.0: GPU reset(4) succeeded!
[265206.310555] [drm] Skip scheduling IBs!


Kind regards,
Udo
