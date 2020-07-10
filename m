Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6377EC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDCF20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KcAca0KL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGJMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgGJMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:43:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D1C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5B4cspuVVjW1c32qyp3lTOvelP3lNpucgNRz7GOy+c=; b=KcAca0KLudjx37wfFcUtfa6T3n
        zeBg3It/XatvnU5AZWsWxucozUvZVDOY8+/9UuSrXL9Ut7AqquB+e033XMWMpHoGj08umrqpbT9rd
        IANHNMZNeO6s3rwpDxLRQ1PmgyzYtu09f+NRZpcBaeh4kiZtnk9LJkOmRjBhu/bLcJxNfekZNFpad
        2u5N6+sD/OK5S7z8nc4+YAeIhQGqFzEpeUu2IF8J4eg83jXlvBqLvDkkz6dd3GByhGBpCPAv6jAI6
        ZvXQxoZKQBIdyLB6XSXB+Q/opVsKCMeJsDm8/+Xs+7/4tuu3atl26HxsaGq/aWF3DBQxRrD9R4Iqp
        jJ2XrN9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtsN9-0000uM-H0; Fri, 10 Jul 2020 12:43:24 +0000
Date:   Fri, 10 Jul 2020 13:43:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v3] vmalloc: Add the right hint when vmalloc failed
Message-ID: <20200710124323.GJ12769@casper.infradead.org>
References: <1594383472-52983-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594383472-52983-1-git-send-email-tiantao6@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:17:52PM +0800, Tian Tao wrote:
> In fact "vmalloc=<size>" cmdline option is not available on many
> platforms.When the user encounters this error, add the correct
> hint to prevent misleading.

i don't think this is an improvement.
