Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380CBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F238420691
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j0fSxe7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgFJCOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:14:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60011C05BD1E;
        Tue,  9 Jun 2020 19:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6clucF3QXfEzAnbmB5jl3BAojfrGSwWtR1xoyvsNv9g=; b=j0fSxe7zT86tbf+E/1M9XeN6jQ
        I8G+jEqVSzMjCHH1YaJGN5FCpHL5zo/TojHrHjU6cRfeKXgHeVPFxZb7OS+WJtxiDgDKlq77a85vl
        oCVHQygdqVaYOpf+Z7hwGv7SUNMX/y6ovf7XOJ4PcgzV2RIb6w/pT5v04LAzLa+v7yz8x89dyfJAf
        50kRxec9sDmggv9iB9JdlFDRZ46vG3gU0IKQ7kqUaUQDc8DV1s/bpeyNeU4pQx4we0t5ay2PHzKVw
        fK7UV+fiTyjTsPw4KeJTEdM4pF7USyJUD0oUqvGyazphIuJtb0m1Glb4SNijeQpcw5QALkvYjWFba
        K2zj5F3w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiqFl-0002oV-Lz; Wed, 10 Jun 2020 02:14:09 +0000
Date:   Tue, 9 Jun 2020 19:14:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, manfred@colorfullife.com,
        mm-commits@vger.kernel.org
Subject: Re: + ipc-convert-ipcs_idr-to-xarray-update.patch added to -mm tree
Message-ID: <20200610021409.GH19604@bombadil.infradead.org>
References: <20200420181310.c18b3c0aa4dc5b3e5ec1be10@linux-foundation.org>
 <20200424014753.DfBuzjmzo%akpm@linux-foundation.org>
 <20200605195848.GB5393@lca.pw>
 <20200605201134.GJ19604@bombadil.infradead.org>
 <20200605142039.b8a81c08bf5ba34fa0181545@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605142039.b8a81c08bf5ba34fa0181545@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 02:20:39PM -0700, Andrew Morton wrote:
> On Fri, 5 Jun 2020 13:11:34 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Jun 05, 2020 at 03:58:48PM -0400, Qian Cai wrote:
> > > This will trigger,
> > > 
> > > [ 8853.759549] LTP: starting semget05
> > > [ 8867.257088] BUG: sleeping function called from invalid context at mm/slab.h:567
> > > [ 8867.270259] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 22556, name: semget05
> > > [ 8867.270309] 2 locks held by semget05/22556:
> > > [ 8867.270345]  #0: 00000000512de7e0 (&ids->rwsem){++++}-{3:3}, at: ipcget+0x4e/0x230
> > > [ 8867.270426]  #1: 00000000552b9018 (&new->lock){+.+.}-{2:2}, at: ipc_addid+0xf4/0xf50
> > 
> > Did the fix for this not make it into -next?
> 
> I don't think I've seen this fix before.  And I'm unclear on how it
> pertains to the current patch(es) in -mm.  And it has no changelog!
> 
> Perhaps it would be best to do a formal send of the latest version?

In testing, I discovered a lockdep warning.  I don't think it's readily
fixable, so please drop this patch for the moment.  I'll be back with
a patch set that rejiggers the locking in ipc to be more normal.
