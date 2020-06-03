Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A870F206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFCBsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgFCBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:48:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB1C08C5C0;
        Tue,  2 Jun 2020 18:48:17 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgIVr-002FlG-NT; Wed, 03 Jun 2020 01:48:15 +0000
Date:   Wed, 3 Jun 2020 02:48:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200603014815.GR23230@ZenIV.linux.org.uk>
References: <20200602084257.134555-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602084257.134555-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:45:05AM -0400, Michael S. Tsirkin wrote:
> So vhost needs to poke at userspace *a lot* in a quick succession.  It
> is thus benefitial to enable userspace access, do our thing, then
> disable. Except access_ok has already been pre-validated with all the
> relevant nospec checks, so we don't need that.  Add an API to allow
> userspace access after access_ok and barrier_nospec are done.

BTW, what are you going to do about vq->iotlb != NULL case?  Because
you sure as hell do *NOT* want e.g. translate_desc() under STAC.
Disable it around the calls of translate_desc()?

How widely do you hope to stretch the user_access areas, anyway?

BTW, speaking of possible annotations: looks like there's a large
subset of call graph that can be reached only from vhost_worker()
or from several ioctls, with all uaccess limited to that subgraph
(thankfully).  Having that explicitly marked might be a good idea...

Unrelated question, while we are at it: is there any point having
vhost_get_user() a polymorphic macro?  In all callers the third
argument is __virtio16 __user * and the second one is an explicit
*<something> where <something> is __virtio16 *.  Similar for
vhost_put_user(): in all callers the third arugment is
__virtio16 __user * and the second - cpu_to_vhost16(vq, something).

Incidentally, who had come up with the name __vhost_get_user?
Makes for lovey WTF moment for readers - esp. in vhost_put_user()...
