Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B43C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200A72082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgEKBcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:32:11 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:43492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbgEKBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:32:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A5CE218224D6B;
        Mon, 11 May 2020 01:32:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste63_6a0e2d4071849
X-Filterd-Recvd-Size: 1626
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 01:32:08 +0000 (UTC)
Message-ID: <8bf0f4bc3ff924143fe1a90d112c73047de0288d.camel@perches.com>
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
From:   Joe Perches <joe@perches.com>
To:     chenzhou <chenzhou10@huawei.com>, davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 May 2020 18:32:07 -0700
In-Reply-To: <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
         <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
         <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 09:24 +0800, chenzhou wrote:
> Sorry, i made a mistake, should be scnprintf().

No worries.

But why do you think this is useful?
Is it likely that either snprint length will exceed PAGE_SIZE?

> 
> On 2020/5/9 19:40, Joe Perches wrote:
> > On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
> > > snprintf() returns the number of bytes that would be written,
> > > which may be greater than the the actual length to be written.
> > []
> > > Chen Zhou (2):
> > >   sparc: use snprintf() in show_pciobppath_attr() in pci.c
> > >   sparc: use snprintf() in show_pciobppath_attr() in vio.c
> > Your subjects are a bit off: snprintf vs scnprintf
> > 
> > 
> > 
> > 
> 
> 

