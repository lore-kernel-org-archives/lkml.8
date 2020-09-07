Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D77C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 05:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBAC20732
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599457724;
	bh=kydM5vc3pHKLMrAc5q87T/B4UAcHcYV48KRlM3SnTaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gg7e164YDfYjyAFzmamY2R3yUnMwb58eTbr7lbQSEsnuXQNiczqCYg03xr8S/mAD
	 i27MgWOifVHBaJcgPVuKvDiffa32+NiMTcq4q0DPo7DI9L0K29vmZZGMFJxME+rGr5
	 V9gnZR/fbiJJ5USyFUQs597xAtHpY7O1/y3ID5jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgIGFsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 01:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgIGFsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 01:48:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C64B20732;
        Mon,  7 Sep 2020 05:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599457713;
        bh=kydM5vc3pHKLMrAc5q87T/B4UAcHcYV48KRlM3SnTaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1ehEq9CdIVbqmWoEHkUdqqgpOZdOsGk6sVQrIriOlwsHsWUJjXVyryp/ZUtQRFd9
         NhnMKZK8bCPo07ZJ4OWGs/bAPS0/rDx+F+hdFQEF/edLZwQHLT11hlOx19g5WunOqR
         OYrY9/w+NhajnG4XRv/89VnuMpCly0RC2oSEPyVU=
Date:   Mon, 7 Sep 2020 07:48:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
Message-ID: <20200907054829.GB280798@kroah.com>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
 <743a648dc817cddd2e7046283c868f1c08742f29.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743a648dc817cddd2e7046283c868f1c08742f29.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 10:24:20AM -0700, Joe Perches wrote:
> On Sat, 2020-08-29 at 16:48 -0700, Joe Perches wrote:
> > Output defects can exist in sysfs content using sprintf and snprintf.
> > 
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content and it's possible to overrun the
> > PAGE_SIZE buffer length.
> > 
> > Add a generic sysfs_emit function that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> > 
> > Add a generic sysfs_emit_at function that can be used in multiple
> > call situations that also ensures that no overrun is done.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > V2: Simplify sysfs_emit and add sysfs_emit_at
> >     Include Documentation change
> 
> Greg?  Rafael? Thoughts on this?

I like the idea, give me a chance to catch up on patches, it's still in
my to-review queue...

thanks,

greg k-h
