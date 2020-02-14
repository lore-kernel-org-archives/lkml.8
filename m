Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDAC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1022314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581715033;
	bh=k3wcLHnF2NAZgyf4ukrYXy7nuVMyQX9ocwrjSNrjTIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CpoYU2xHbReeK5T1I07hESTsfbQ23iJ7PtYgRG8M7PNpQ3Fyy0WOF7Eq8SlriRV1+
	 JbkfUTO7T7Ivw/4r09cKI9x3DPSCFZHE6CzOp8h6uacB0i9y/mnAnlxLxumfnpvu1a
	 UYnmWtNrPp6Xh+U7wH8y2U0gl6H8VPsMdFn3vCLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbgBNVRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbgBNVRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:17:12 -0500
Received: from localhost (unknown [65.119.211.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F853222C4;
        Fri, 14 Feb 2020 21:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581715031;
        bh=k3wcLHnF2NAZgyf4ukrYXy7nuVMyQX9ocwrjSNrjTIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzK4bwHPpZTJtOS3QVUbevbiv5lAdoCkwg9tqT1o/f7BfrMLdVbKDXvGfUsWqdYLV
         2JgM+kJwXmLAW+kd1q6HqNSOD3N/qGJtu7osh4IqGx4awVrhiOJcdZtbB0z8cYurV4
         BZ1qIFovLI1lQFaZ5Ocq6dybFL9I9Lc1b8n8I2aU=
Date:   Fri, 14 Feb 2020 16:11:26 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wayne Lin <Wayne.Lin@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 087/116] drm/dp_mst: Remove VCPI while disabling
 topology mgr
Message-ID: <20200214211126.GC4087988@kroah.com>
References: <20200213151842.259660170@linuxfoundation.org>
 <20200213151916.429278047@linuxfoundation.org>
 <6fa270d0d395d87c41b7d0a9ec87eadea5398eb6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa270d0d395d87c41b7d0a9ec87eadea5398eb6.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:38:44PM -0500, Lyude Paul wrote:
> We should drop this and the versions for all of the other kernel versions.
> This patch later got reverted in a86675968e2300fb567994459da3dbc4cd1b322a in
> drm-misc/drm-misc-next, and then replaced with a proper fix in
> 8732fe46b20c951493bfc4dba0ad08efdf41de81

That commit is not in Linus's tree so I can't do much with it yet :)

And the revert isn't there either, ugh, and that commit ended up in the
last round of 5.5.y and 5.4.y and 4.19.y releases.

I'll drop this one for now though, thanks for letting me know.

greg k-h
