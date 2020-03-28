Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A84C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE1D20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1Jpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:45:42 -0400
Received: from gw.cm.dream.jp ([59.157.128.2]:51635 "EHLO vsmtp01.cm.dti.ne.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgC1Jpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:45:42 -0400
X-Greylist: delayed 1121 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2020 05:45:37 EDT
Received: from localhost (KD124210025232.ppp-bb.dion.ne.jp [124.210.25.232]) by vsmtp01.cm.dti.ne.jp (3.11v) with ESMTP AUTH id 02S9Qf22018705;Sat, 28 Mar 2020 18:26:53 +0900 (JST)
Date:   Sat, 28 Mar 2020 18:26:40 +0900 (JST)
Message-Id: <20200328.182640.1933740379722138264.hermes@ceres.dti.ne.jp>
To:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_construct
From:   ARAI Shun-ichi <hermes@ceres.dti.ne.jp>
In-Reply-To: <874kuapb2s.fsf@logand.com>
References: <87immckp07.fsf@logand.com>
        <87v9p2tkut.fsf@logand.com>
        <874kuapb2s.fsf@logand.com>
        <CAKFNMomjWkNvHvHkEp=Jv_BiGPNj=oLEChyoXX1yCj5xctAkMA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Msg <874kuapb2s.fsf@logand.com>;
   Subject "Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct":

> Tomas Hlavaty <tom@logand.com> writes:
>>>> 2) Can you mount the corrupted(?) partition from a recent version of
>>>> kernel ?
> 
> I tried the following Linux kernel versions:
> 
> - v4.19
> - v5.4
> - v5.5.11
> 
> and still get the crash

Ryusuke Konishi pointed out:

In Msg <CAKFNMomjWkNvHvHkEp=Jv_BiGPNj=oLEChyoXX1yCj5xctAkMA@mail.gmail.com>;
   Subject "Re: BUG: kernel NULL pointer dereference, address: 00000000000000a8":

> As the result of bisection,  it turned out that commit
> f4bdb2697ccc9cecf1a9de86905c309ad901da4c on 5.3.y
> ("mm/filemap.c: don't initiate writeback if mapping has no dirty pages")
> triggers the crash.

This commit modifies __filemap_fdatawrite_range() as follows.

[before]
	if (!mapping_cap_writeback_dirty(mapping))
		return 0;

[after]
	if (!mapping_cap_writeback_dirty(mapping) ||
	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
		return 0;

I did simple test with this code (Kernel 5.5.13).

[test]
	if (!mapping_cap_writeback_dirty(mapping) ||
	    mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
		return 0;

It does not cause crash by the test (without long-term operation). So,
I think that it may be related to PAGECACHE_TAG_TOWRITE.


One possible(?) scenario is:

0. some write operation

1. sync (WB_SYNC_ALL)

2. tagged "PAGECACHE_TAG_TOWRITE"

3. __filemap_fdatawrite_range() is called and returns successfully
  (but no-op)

4. some data is/are free-ed
  (because of 3.)

5. crash at test/setting writeback for free-ed data
  nilfs_segctor_do_construct()
   nilfs_segctor_prepare_write()
    set_page_writeback()

How about this?
