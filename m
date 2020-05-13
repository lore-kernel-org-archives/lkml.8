Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D82C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912B520769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dkmRKevZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbgEMAg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgEMAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:36:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F01C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:36:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o19so1265930qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=c98jWXoC4TaeEUhblVBPacdhfV8eQsofcSVE80ZpUdw=;
        b=dkmRKevZcQoDJjz2gFluP12uHNsvvKLIWSe6ZVdHIS/FZokublkegdCzSkcfTZ2ENT
         qSNX8XfhwHj9F+jTaukWRW3crOfRjfSDUEqmHeJekaTD6sbXDZaiB88fykCaYpAr44BM
         nSwbOlG6mia4t/SD5o1P1L6EbKK+JCTy564On3BX9zbeiIPwX1uMsEYRYSio1axJ5wFg
         LNuyHNWw1oQNVHofYvbf52EZF/5p2bajJj10urfJbweyxDsVzivBe8vyGR1MGEn98HkU
         CwMiArEl4k6cL5u8vFBVv3HqRiXfPYWmhZgjic0xlEDi9ZfclStbV97p/gLbjnrnQ/Jd
         zP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=c98jWXoC4TaeEUhblVBPacdhfV8eQsofcSVE80ZpUdw=;
        b=kcSx4uY0jP5fVoI2FDKFRKTfwMrcj2C3OnuCWcZNziKQM7sl/FjxK+erUecnrVpf5j
         De9+chxqrtJFovibld7zUGP3p14vrBq4Edvrjx89434ERVtwB1HBrut1hRjWF8ZQAaPb
         wls2/1xpw69PVgE3k7uvjsox5DxfcwfKrpMPJ9oo2R1JsV6d73mWfyg1884VPFE+nR/r
         j97C+O2iynv3h8wTL2jZ1Le01T+pv3VLR+Th2RJVV04B92Ic5b9L8D1xnk1GdyhgS29f
         0QThj4K7hdR0EqocRq90cWgISXkCJakIx5ir5n7ily1EIMZ6cw8jXSD9/UfoRgQLptzC
         5W+A==
X-Gm-Message-State: AGi0PuYRMrxAYXgrE7TpdlJ1XtdYOEZ26SCJ1hinpCrWNo8+TSKDJCAy
        EQwJsGUNslemo9DbyndsO1h0eA==
X-Google-Smtp-Source: APiQypI2DQ7SCpm8y7SSNxdWINMUxhlY1Qwjj34UXHctTP+qUpbQx5ASoe3cnJyvYB0Y03JxvMvQfA==
X-Received: by 2002:ac8:7586:: with SMTP id s6mr17018490qtq.96.1589330213359;
        Tue, 12 May 2020 17:36:53 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x22sm13300250qtr.57.2020.05.12.17.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 17:36:52 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: zswap z3fold + memory offline = infinite loop
Message-Id: <D90B73BA-22EC-407E-838F-2BA646C60DE0@lca.pw>
Date:   Tue, 12 May 2020 20:36:51 -0400
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put zswap z3fold pages into the memory and then offline those memory =
would trigger an infinite loop here in

__offline_pages() --> do_migrate_range() because there is no error =
handling,

			if (pfn) {
				/*
				 * TODO: fatal migration failures should =
bail
				 * out
				 */
				do_migrate_range(pfn, end_pfn);

There, isolate_movable_page() will always return -EBUSY  because,

	if (!mapping->a_ops->isolate_page(page, mode))
		goto out_no_isolated;

i.e., z3fold_page_isolate() will always return false because,

zhdr->mapped_count =3D=3D 2

It should be easy to reproduce. Otherwise, use this one,

https://github.com/cailca/linux-mm/blob/master/random.c

and then watch the console burning with those,

[12661.793667][T566417] failed to isolate pfn 1045b2
[12661.793745][T566417] page:c00c000004116c80 refcount:2 mapcount:0 =
mapping:00000000999f9672 index:0x0
[12661.793865][T566417] mapping->a_ops:z3fold_aops
[12661.793919][T566417] flags: 0x3fffc000000000()
[12661.793969][T566417] raw: 003fffc000000000 c00c000003cef388 =
c00c000006b0da08 c000001275b87f6a
[12661.794071][T566417] raw: 0000000000000000 0000000000000000 =
00000002ffffffff 0000000000000000
[12661.794158][T566417] page dumped because: isolation failed
[12661.794226][T566417] page_owner tracks the page as allocated
[12661.794292][T566417] page last allocated via order 0, migratetype =
Unmovable, gfp_mask 0x12800(GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY)
[12661.794463][T566417]  prep_new_page+0x3d0/0x450
[12661.794508][T566417]  get_page_from_freelist+0x1bb8/0x27c0
[12661.794575][T566417]  =
__alloc_pages_slowpath.constprop.60+0x240/0x15a0
[12661.794654][T566417]  __alloc_pages_nodemask+0x520/0x650
[12661.794715][T566417]  alloc_pages_current+0xbc/0x140
[12661.794772][T566417]  z3fold_zpool_malloc+0x6cc/0xe20
[12661.794826][T566417]  zpool_malloc+0x34/0x50
[12661.794888][T566417]  zswap_frontswap_store+0x60c/0xe20
[12661.794942][T566417]  __frontswap_store+0x128/0x330
[12661.794995][T566417]  swap_writepage+0x58/0x110
[12661.795048][T566417]  pageout+0x16c/0xa40
[12661.795092][T566417]  shrink_page_list+0x1ab4/0x2490
[12661.795155][T566417]  shrink_inactive_list+0x25c/0x710
[12661.795206][T566417]  shrink_lruvec+0x444/0x1260
[12661.795274][T566417]  shrink_node+0x288/0x9a0
[12661.795330][T566417]  do_try_to_free_pages+0x158/0x640
[12661.795383][T566417] page last free stack trace:
[12661.795437][T566417]  free_pcp_prepare+0x52c/0x590
[12661.795493][T566417]  free_unref_page+0x38/0xf0
[12662.156109][T566417]  free_z3fold_page+0x58/0x120
[12662.156131][T566417]  free_pages_work+0x148/0x1c0
[12662.156195][T566417]  process_one_work+0x310/0x900
[12662.156257][T566417]  worker_thread+0x78/0x530
[12662.156306][T566417]  kthread+0x1c4/0x1d0
[12662.156354][T566417]  ret_from_kernel_thread+0x5c/0x74

