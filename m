Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF1C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F192465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582223783;
	bh=vrlr8Yaqzkj9ziXbvSzTa5UcFiN65AQ7Ci7jczR5isA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OGQQ6wqn1eLx7gvfRMY5MWGubv0uVoS1iiBuTrwGnSJbjnGVNVR/1GS2CIUrXvBIp
	 0CgqRVCUna3Fo8kd7Dz1WXzClbKXpTSZkUoY7GNkqTo7kXX/5zb34pJ0nPwg747XJv
	 x9iJ4IATjE/6SW/KGrDjC2Z+Ze76dOEPTs+uAv5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgBTSgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgBTSgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:36:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C332465D;
        Thu, 20 Feb 2020 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582223781;
        bh=vrlr8Yaqzkj9ziXbvSzTa5UcFiN65AQ7Ci7jczR5isA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aZOo1UB7NpW8BSawzs7dZGEoVH4N1bUITwekfRWZjJY7ZPihXzJCYpbpEAAffrQ4n
         y6kiFKN9rO73DEQ+s12+otJ8e/X7pIK7Lk0RfWa9Ws8rmC7I75n5N+PlJQY+lojkC7
         xMjRiSrcprMWCzDMv87T9zb4dcqn7L2QAwix5ow8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 314ED352034E; Thu, 20 Feb 2020 10:36:21 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:36:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Subject: Re: drm_dp_mst_topology.c and old compilers
Message-ID: <20200220183621.GW2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200220004232.GA28048@paulmck-ThinkPad-P72>
 <CADnq5_OJSHV5XotA6hORgQSrC4A-ZFzfXN_NRMGYFka+MTyjGg@mail.gmail.com>
 <158218553821.8112.10047864129562395990@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158218553821.8112.10047864129562395990@skylake-alporthouse-com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:58:58AM +0000, Chris Wilson wrote:
> Quoting Alex Deucher (2020-02-20 02:52:32)
> > On Wed, Feb 19, 2020 at 7:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > A box with GCC 4.8.3 compiler didn't like drm_dp_mst_topology.c.  The
> > > following (lightly tested) patch makes it happy and seems OK for newer
> > > compilers as well.
> > >
> > > Is this of interest?
> > 
> > How about a memset instead?  That should be consistent across compilers.
> 
> The kernel has adopted the gccism: struct drm_dp_desc desc = {};
> git grep '= {}' | wc -l: 2046
> git grep '= { }' | wc -l: 694
> -Chris

And this works well, a big "thank you!" to all three of you!

Please see below for the updated patch.

							Thanx, Paul

------------------------------------------------------------------------

commit 78c0e53a98a9772a99e46806f8fcbe1140d667a4
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Feb 19 16:42:47 2020 -0800

    EXP drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compilers
    
    Older compilers either want two extra pairs of curly braces around the
    initializer for local variable desc, or they want a single pair of curly
    braces with nothing inside.  Current Linux-kernel practice favors the
    latter, so this commit makes it so.
    
    Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
    Suggested-by: Joe Perches <joe@perches.com>
    Suggested-by: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 20cdaf3..b123f60 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5396,7 +5396,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *immediate_upstream_port;
 	struct drm_dp_mst_port *fec_port;
-	struct drm_dp_desc desc = { 0 };
+	struct drm_dp_desc desc = { };
 	u8 endpoint_fec;
 	u8 endpoint_dsc;
 
