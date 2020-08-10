Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D83C20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597103155;
	bh=0rxBVqCiXgW++BolD15LIj72xU68nplEsQ5hkeWVWVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r2Uhh0y0nB/3XgrLQZ92wDqc8l3lvV+slE7WHVlfbaiYe5gv7W5XakEJ8+XKpJfg3
	 zgrvpCH/VKHUqVWbxA7gTYGZA6LeX+yW7GlVuxxmbgxJeQre6I01MmtglHM4maPMz+
	 bWVnjATflk4UN115tZUI6Yuhg9VZRIaGIehn3lj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgHJXpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgHJXpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:45:53 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C52206E9;
        Mon, 10 Aug 2020 23:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597103153;
        bh=0rxBVqCiXgW++BolD15LIj72xU68nplEsQ5hkeWVWVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTz1ud+HOuPoIC7aMP4WSRgEG5Zfd6eMQZF2bQX0t4JdLzfoYrlzTA7YSMpFkIjVx
         aa7UhJId7cyPnxqhc82q8BuppGaIKbH/D/IX2/iR7XRBjeJsn3T+J49U0gMlktSTeU
         tAJiI0iEe9zkaGuNogJUtdcvFga3DWOITLsFZB6I=
Date:   Mon, 10 Aug 2020 16:45:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: api: add kzfree script
Message-ID: <20200810234551.GA851736@gmail.com>
References: <20200604140805.111613-1-efremov@linux.com>
 <20200717115709.543882-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2007172239130.2837@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2007172239130.2837@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:39:20PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 17 Jul 2020, Denis Efremov wrote:
> 
> > Check for memset()/memzero_explicit() followed by kfree()/vfree()/kvfree().
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Applied.

FYI, this new script is already outdated, since kzfree() has been renamed to
kfree_sensitive().

- Eric
