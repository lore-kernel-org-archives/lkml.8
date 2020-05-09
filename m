Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEADC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB34218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgEILkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:40:16 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:36636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgEILkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:40:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BF79A837F24F;
        Sat,  9 May 2020 11:40:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cast62_3be03e240845c
X-Filterd-Recvd-Size: 1179
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 May 2020 11:40:11 +0000 (UTC)
Message-ID: <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
From:   Joe Perches <joe@perches.com>
To:     Chen Zhou <chenzhou10@huawei.com>, davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 May 2020 04:40:10 -0700
In-Reply-To: <20200509091849.116954-1-chenzhou10@huawei.com>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
[]
> Chen Zhou (2):
>   sparc: use snprintf() in show_pciobppath_attr() in pci.c
>   sparc: use snprintf() in show_pciobppath_attr() in vio.c

Your subjects are a bit off: snprintf vs scnprintf


