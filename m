Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A6C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C8A2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbgAXQvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:51:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:46162 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387875AbgAXQvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:51:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C16C66D9;
        Fri, 24 Jan 2020 16:51:05 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:51:04 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: zram: various fixes in zram.rst
Message-ID: <20200124095104.595f1db5@lwn.net>
In-Reply-To: <20200123014824.GC249784@google.com>
References: <77000e12-677a-62f6-9f78-343be5bd6630@infradead.org>
        <20200123014824.GC249784@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 17:48:24 -0800
Minchan Kim <minchan@kernel.org> wrote:

> On Mon, Jan 20, 2020 at 02:51:41PM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix various items in zram.rst:
> > - typos/spellos
> > - punctuation
> > - grammar
> > - shell syntax
> > - indentation
> > - sysfs file names
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>  
> 
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> Thanks for the all corrections, Randy!
> 
Applied, thanks.

jon
