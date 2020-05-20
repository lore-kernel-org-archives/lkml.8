Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D393C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41650207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgETTij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:52292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:38:39 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 15:38:38 EDT
Received: (qmail 8527 invoked by uid 109); 20 May 2020 19:31:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 May 2020 19:31:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17064 invoked by uid 111); 20 May 2020 19:31:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2020 15:31:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 May 2020 15:31:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.27.0-rc1
Message-ID: <20200520193156.GA4700@coredump.intra.peff.net>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:17:11PM -0700, Junio C Hamano wrote:

> Git 2.27 Release Notes (draft)
> ==============================
> 
> Updates since v2.26
> -------------------
> 
> Backward compatibility notes

Is it worth mentioning here the reversion of v2 as the default protocol?

It does end up (along with the actual code fix) in the "fixes from
v2.26" section:

>  * Those fetching over protocol v2 from linux-next and other kernel
>    repositories are reporting that v2 often fetches way too much than
>    needed.
>    (merge 11c7f2a30b jn/demote-proto2-from-default later to maint).
> 
>  * The upload-pack protocol v2 gave up too early before finding a
>    common ancestor, resulting in a wasteful fetch from a fork of a
>    project.  This has been corrected to match the behaviour of v0
>    protocol.
>    (merge 2f0a093dd6 jt/v2-fetch-nego-fix later to maint).

but that's somewhat buried. I dunno. It is not likely to introduce _new_
compatibility issues, but perhaps folks looking into compatibility stuff
may want to know about the revert.

-Peff
