Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D1C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E6E24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBTH7H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:59:07 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:58201 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726783AbgBTH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:59:07 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20283602-1500050 
        for multiple; Thu, 20 Feb 2020 07:59:01 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Alex Deucher <alexdeucher@gmail.com>, paulmck@kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CADnq5_OJSHV5XotA6hORgQSrC4A-ZFzfXN_NRMGYFka+MTyjGg@mail.gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
References: <20200220004232.GA28048@paulmck-ThinkPad-P72>
 <CADnq5_OJSHV5XotA6hORgQSrC4A-ZFzfXN_NRMGYFka+MTyjGg@mail.gmail.com>
Message-ID: <158218553821.8112.10047864129562395990@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: drm_dp_mst_topology.c and old compilers
Date:   Thu, 20 Feb 2020 07:58:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Deucher (2020-02-20 02:52:32)
> On Wed, Feb 19, 2020 at 7:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > A box with GCC 4.8.3 compiler didn't like drm_dp_mst_topology.c.  The
> > following (lightly tested) patch makes it happy and seems OK for newer
> > compilers as well.
> >
> > Is this of interest?
> 
> How about a memset instead?  That should be consistent across compilers.

The kernel has adopted the gccism: struct drm_dp_desc desc = {};
git grep '= {}' | wc -l: 2046
git grep '= { }' | wc -l: 694
-Chris
