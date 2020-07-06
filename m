Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F536C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CB1206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594053717;
	bh=n8OiSfe/Z690dnapKdsW6D6FIOToqNPdixzZr+FmA/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KywddvCxs27yQvITL7WhPgIB01vRbxgMKji1byP9x04+DRWhR54Tmz3/9Zt4zHk+N
	 HkhST0AXpoQnOJdXhjeGooa/GSLHpxa+H7n+nyYet36RgvZ2ae8Ug5dohbYjHSQu2y
	 twJM/uCS5GRDG81b/c6rV7WWOe7FoTZheas3Ccu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgGFQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgGFQlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:41:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7945C206CD;
        Mon,  6 Jul 2020 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594053715;
        bh=n8OiSfe/Z690dnapKdsW6D6FIOToqNPdixzZr+FmA/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+z922QbMSs49D6/G9NiG+tj1b2RuASnBo8iW07QPfTLpjVlV4boEOPwgp3ogkFup
         H3wif53o8939bBzcREZh7t0rgsLh+N+9BDi5xbV14Bmk2VVcGU+CU7ojXgICDwOzB5
         sRxlY0Ajge7ZRDPhgUmIioLP0Mpc2G5bOwQAlNig=
Date:   Mon, 6 Jul 2020 18:41:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 5/6] devres: provide devm_krealloc()
Message-ID: <20200706164154.GA2315307@kroah.com>
References: <20200629065008.27620-1-brgl@bgdev.pl>
 <20200629065008.27620-6-brgl@bgdev.pl>
 <20200702124258.GA1882489@kroah.com>
 <CAMRc=Mc6dWCtnFT_SMGLUsggf68i3y7Njr61NyDQ7KeQ-rSErg@mail.gmail.com>
 <CAMRc=McxekKgEFe2y3R1SiA0ZhLZXsUrzMXWgwXVtHtymG75ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McxekKgEFe2y3R1SiA0ZhLZXsUrzMXWgwXVtHtymG75ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 06:38:10PM +0200, Bartosz Golaszewski wrote:
> On Thu, Jul 2, 2020 at 3:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, Jul 2, 2020 at 2:42 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 08:50:07AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Implement the managed variant of krealloc(). This function works with
> > > > all memory allocated by devm_kmalloc() (or devres functions using it
> > > > implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> > > >
> > > > Managed realloc'ed chunks can be manually released with devm_kfree().
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > [snip!]
> >
> > >
> > > That's a lot of logic that does not seem to match up with the krealloc()
> > > logic in mm/slab_common.c, are you sure we need to do all of that?
> > >
> >
> > What are you referring to exactly? The check for rodata? It's because
> > devm_kfree() handles this case, while regular kfree() (or krealloc())
> > doesn't - there's kfree_const() but no devm_kfree_const().
> >
> > > Who wants this?
> >
> > The hwmon commit I mentioned in my response to patch 6/6 explicitly
> > mentions the lack of this helper.
> >
> > Bartosz
> 
> Hi Greg,
> 
> As we've established in the discussion under the iio patch that there
> will in fact be more users of this - can this now be merged too?

Sorry, it's still in my queue, along with 500+ other patches :)

it's not lost...

thanks,

greg k-h
