Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5534C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9932074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/UBLJYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgGILBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGILBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:01:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0BC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QzgcO9zT0nQ3JkZsYLfaohKLlobA0w2kWRQELU810mI=; b=j/UBLJYf6Qkcz6KaazMXp8JGO2
        cMe3Vu7DUIPLVlDiT2fYpUgaUsoF4SvFsopWQTHrOCASIOqVs04PlUr/BGyVsQCcBNAnaBKjPkdsS
        MDXT2PhqYFIyg57W2e3VwkoBO6jrm9CL3kIxTwMTUoLbTfWHVZFfGYinWEBOSY+NWi8bchuQawDDx
        00cmTzT3gXieLqbCxWfz4WgeJuiQj1VvN/0CF8t6LtLMC4zr0BZIlZjqfa/JkvkJqpJ2WXE/voXWD
        fllAVhkf5yABzpJy4LrE25A8KDy371F47cr/g+JY2evbT1yi4XSFSGCaQN4f6Z4QxrCOOE/QyXF9L
        kzxu0ojw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtUIe-0003Fl-1B; Thu, 09 Jul 2020 11:01:08 +0000
Date:   Thu, 9 Jul 2020 12:01:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     sanggil2.kim@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kernel: Add module symbols _text, _etext.
Message-ID: <20200709110107.GA12046@infradead.org>
References: <CGME20200709082408epcas2p4369fa8f06a57c7358be38282aae0f501@epcas2p4.samsung.com>
 <1594283025-4166-1-git-send-email-sanggil2.kim@samsung.com>
 <20200709094950.GA28361@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709094950.GA28361@willie-the-truck>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 10:49:51AM +0100, Will Deacon wrote:
> On Thu, Jul 09, 2020 at 05:23:45PM +0900, sanggil2.kim@samsung.com wrote:
> > From: Sanggil Kim <sanggil2.kim@samsung.com>
> > 
> > We have a solution to protect kernel code section(autually from _text to
> > _etext) by not MMU. In order to do this, we have to know the addresses
> > of _text and _etext at runtime.
> 
> Interesting! Can you post patches so that we can implement this solution
> upstream? Without an in-tree user, we won't be exporting these symbols.

And even with that I'm pretty sure the code doing the 'protection'
should be built-in and not modular..
