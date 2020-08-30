Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE57C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D504420757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598831222;
	bh=qTirFCJzJuEKEBgG8M2GloQCbe4Ug1Sqp/RbcbG0n8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nui26FVauR/W5UOIKcgt4zF9RWPX4EL2br6I4H6yth8tUKT9EACen2nCYrp+7qJsF
	 ByEFnUb0kQ6/+lbZIEnZ+JRFhMObQH7Ry1gcw6xgf080oS39Gr2dO8NkR4RwjBBLwy
	 mPDhS6PHAYHfSxAa0yuXybhldchZUXGbTJK8J3xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgH3XrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgH3XrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:47:01 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A20E20757;
        Sun, 30 Aug 2020 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598831220;
        bh=qTirFCJzJuEKEBgG8M2GloQCbe4Ug1Sqp/RbcbG0n8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVa/0nul/6OHnqWyyj7aFeI130ySq697UJsgYr9L/vGA7S+MpZvykH3iKlu1trm/K
         um577mwK1VAyXVtJWmikGlevyDC46RLIoakGBEn4pIJX4HO9r3OOgqAeX6tXWm+ZqW
         MnBOeaR0EoFgUpnB/B8CIP0T1fgpKYVrVCOpIh2w=
Date:   Sun, 30 Aug 2020 19:46:59 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.9-rc3
Message-ID: <20200830234659.GB8670@sasha-vm>
References: <CAHk-=wiD1yujm_WvWLYL7gZsWMvZyWMg1rfU7dWmnYYc3a7Gsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wiD1yujm_WvWLYL7gZsWMvZyWMg1rfU7dWmnYYc3a7Gsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 04:20:17PM -0700, Linus Torvalds wrote:
>You all know the drill by now - another week, another rc.
>
>A fair number of small fixes all over here, with a lot of noise spread
>out fairly evenly due to the "fallhtough" comment conversion.
>
>But while the fallthrough annotations are some fairly widespread
>background noise, we've got the usual driver fixes all over (gpu, usb,
>others). And architecture updates (arm64 stands out with both kvm
>fixes and DT updates, but there's some x86 and powerpc changes too)
>
>And misc changes elsewhere.
>
>On the whole it's been pretty calm for being rc3. This is actually one
>of the smaller rc3's we've had in recent releases, although that's
>likely at least partially the usual timing issue (ie no networking
>pull this past week).
>
>So go out and test.

Is it possible you've forgotten to push? I don't see the tag/5.9-rc3
commit in your repo.

-- 
Thanks,
Sasha
