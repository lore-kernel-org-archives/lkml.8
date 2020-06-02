Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1349C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6112206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFBV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:58:35 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B9C08C5C0;
        Tue,  2 Jun 2020 14:58:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgEvT-0029KV-3r; Tue, 02 Jun 2020 21:58:27 +0000
Date:   Tue, 2 Jun 2020 22:58:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Michael S. Tsirkin'" <mst@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200602215827.GP23230@ZenIV.linux.org.uk>
References: <20200602084257.134555-1-mst@redhat.com>
 <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
 <20200602163306.GM23230@ZenIV.linux.org.uk>
 <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
 <20200602162931-mutt-send-email-mst@kernel.org>
 <950896ceff2d44e8aaf6f9f5fab210e4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950896ceff2d44e8aaf6f9f5fab210e4@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 08:41:38PM +0000, David Laight wrote:

> In which case you need a 'user_access_begin' that takes the mm
> as an additional parameter.

	What does any of that have to do with mm?  Details, please.
