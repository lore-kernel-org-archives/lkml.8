Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC8C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A23C214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSmfzfKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgIJSMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgIJSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:12:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1EEC061573;
        Thu, 10 Sep 2020 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJFNj3LJXM5inEjcMlpYk5NsvVZoANjG6yDaNXtOQ30=; b=lSmfzfKQqqcZo41ZNtr3bnrgR4
        +oCiqbseC0eG8Qb0mENU6p9HScVlmOiyyM1D/WsCKITLnLrqtYU2uSs83TNc2H7nb3CWqc5NptNNk
        eoQXGoLaw95Xu62UgQpdgGC+Iqi8qH0NWOmNiYc9/1RolRzHEPpk/vyGATU1ebBHGk6vDDNM2CcX9
        TaX6KjY56oFftWnxzn5DcUii5inCbDzwfhiWPgz4RIVc13hX2FwuCKj8MsdBhnVNxTNUpZg3UJWpM
        xgUnFjHIv4drBCNsM3tQkHR7MwJYt1gWzxiJBLlf1Z5B6uY382Y8QqZ00ZOLGmOJldB+qjNM5EBsa
        ZZXGcqWw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGR3I-0003sC-H5; Thu, 10 Sep 2020 18:12:08 +0000
Date:   Thu, 10 Sep 2020 19:12:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/14] get rid of the remaining kernel-doc warnings when
 building the docs
Message-ID: <20200910181208.GW6583@casper.infradead.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:23:53PM +0200, Mauro Carvalho Chehab wrote:
> As described on its subject, this series finally get rid of all kernel-doc warnings.
> 
> With this series applied (plus my last series fixing other warnings), building
> the docs is now clean[1] against next-20200909:

Thanks, this has been a truly heroic effort.

I'd suggest that we change the kernel build to always run the CHKDOC
instead of at W=1 (or rather, as the patch I just sent out demonstrates,
not at all (oops)).  Otherwise you're just going to have to continue
doing this.

At some point, perhaps we can add some other warnings at W=1, like
an EXPORT_SYMBOL of a function which doesn't have kernel-doc.
