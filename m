Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4727C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FF320776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590439273;
	bh=aeOe7fH/jd/H55PWevqur5gg9YXpxI/MI38Ji58NKFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n9h286KU8vhQUeIkJvrBWt4qkBuVzO09DsJFYKAx1Ew5nHuRAV5TYc37PaOpNUZCI
	 WLc6AHRuPVxroSVkBcqcje1vkGU5uGVEIuOoZWvO/DyL6uaPP+ta3PPw5sFcFMWumu
	 0puca7hp7tPyC4NmQr/vA+rvthsHDMiQ3iQ8ivW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390523AbgEYUlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 16:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390493AbgEYUlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 16:41:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA8920776;
        Mon, 25 May 2020 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590439270;
        bh=aeOe7fH/jd/H55PWevqur5gg9YXpxI/MI38Ji58NKFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dWrweGaVmnKRDpQMrhm4JSVd88fwgaUoGxIOXfzM2izV+3xlisPmfpAFmt4tO1mnY
         ERok3+ImeXmMDUezzXnfUi8uajnZDmb3EOz2Q2EAjDatbZjF2CbAsZss948dg3XbBm
         kmwojQe0fCnOlHRUvcwfMis2E+415Ab70pNJZ1j4=
Date:   Mon, 25 May 2020 13:41:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-Id: <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
In-Reply-To: <20200525153216.GD1634618@smile.fi.intel.com>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
        <20200525091458.GK1634618@smile.fi.intel.com>
        <20200525144312.mbw2z3ydncyasvss@master>
        <20200525153216.GD1634618@smile.fi.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 18:32:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, May 25, 2020 at 02:43:12PM +0000, Wei Yang wrote:
> > On Mon, May 25, 2020 at 12:14:58PM +0300, Andy Shevchenko wrote:
> > >On Sun, May 24, 2020 at 12:35:51PM +0000, Wei Yang wrote:
> > >> These two cases could be unified into one.
> > >
> > >Care to provide a test case which supports your change?

I hurt my brain convincing myself, so I got practical:


int fls(unsigned int x)
{
	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
}

static int get_count_order(unsigned l)
{
	if (l == 0)
		return -1;
	else if (l & (l - 1UL))
		return fls(l);
	else
		return fls(l) - 1;
}										

static int get_count_order2(unsigned long l)
{
	if (l == 0)
		return -1;
	return fls(--l);
}

main()
{
	unsigned i;

	for (i = 1; i < 64; i++) {
		printf("%d %d\n", get_count_order(i),
			get_count_order2(i));
	}
}


> > 
> > Hmm.. where should I put the test? tools/testing/selftests/ ?
> 
> I guess into test_bitops.c [1]? I though it eventually should make kernel, but I don't see it.
> 
> Andrew, can you apply that or do you need Jesse to resend?
> 

Got it.
