Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA60207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590445959;
	bh=U75/cbCcAyXfzuiFK7KXv+sfRvsN3iSpASew1Ubcwn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DGQ0H7GJW19r4VmhAVMBGMBFPzWdFg1FOdu7p4mnpXOeyQ96AebQKcApH+OEdI1Qo
	 kFqBf00CRGITrvA7lzQwQg2aJkWIqkY9w8j5spZ4lLw62x9tHtAJo9NEv7buOh0F2a
	 cB+inBJOGidX3TWorTt68yvoucVc41okRWv1Hm0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgEYWbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 18:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgEYWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 18:31:47 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2356F207CB;
        Mon, 25 May 2020 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590445907;
        bh=U75/cbCcAyXfzuiFK7KXv+sfRvsN3iSpASew1Ubcwn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zFIAMLsxnzq3sufRj+2AkgYKks9Kc0bnKKuFfqIbeDy/c8dqMka8T76n+a1MftXQn
         cdRmILx7yjnTnG/RQs3wOW5XKNUELtHk9Poa/ytnQcFLHen0aTN9BSbbs9exYo2Bj+
         L94COAxZM2PJ73n1dXxxacGsf0vU0WAaPS5ZgRSw=
Date:   Mon, 25 May 2020 15:31:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-Id: <20200525153146.c1337b1ca7af386ac30e5702@linux-foundation.org>
In-Reply-To: <20200525215741.zd3gry4yyqqplix6@master>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
        <20200525091458.GK1634618@smile.fi.intel.com>
        <20200525144312.mbw2z3ydncyasvss@master>
        <20200525153216.GD1634618@smile.fi.intel.com>
        <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
        <20200525215741.zd3gry4yyqqplix6@master>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 21:57:41 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> I see the patch just merged, so I suppose to add the above test code into that
> one?

Well, that's not really test code.

But yes, something which tests both the 32-bit and 64-bit functions would be
nice, sometime.

