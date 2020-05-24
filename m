Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083D0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27EC2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590349568;
	bh=xo5ejZDaCCRf9jcb4FqgdnHvCQyGh3GULiim19u1a7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DhBXNQoPIN+EE84yTQoLM4BmkVhzEwQL+mo39rgs1u/GtJYFyElrTIb7TU1r9SixS
	 vbmSwXppxngZzybuTqp7+mzxW1XafnUGSzHQI4/gTaggqaSpnImEpw6Zx8aTWAp945
	 JN3+GWPE5GGKrq8Qf07Nj6PwvTk8Arq+Z4F4RuJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgEXTpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387792AbgEXTpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:45:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B712C2076C;
        Sun, 24 May 2020 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590349552;
        bh=xo5ejZDaCCRf9jcb4FqgdnHvCQyGh3GULiim19u1a7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e09oI2hxxfIAqYqp2myeTZtHRkakYHFyz36PWa7J2Voh783kudPYMQ7jx27hJU0f9
         VdPDpzuTeqyuHyvkL0Aj3M6+8yz1EQpu3WyrlLQyM7NuSbNq9olHKaL3KRHCxVwPM4
         9/3+JWdA5cuUqpvdcZ4VSKE6p/uy6GepPbDjppak=
Date:   Sun, 24 May 2020 15:45:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200524194550.GV33628@sasha-vm>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com>
 <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 10:05:28AM -0700, Linus Torvalds wrote:
>Sasha mentioned "--follow", which also happens to show that commit,
>but that's more of an incidental happenstance than anything else. "git
>log --follow" is kind of a special case, where git stops doing some of
>the pathname-based simplifying, because if the file shows up from
>nothing, git will try to then figure out where it came from. The fact
>that "--follow" this ends up not pruning irrelevant history as
>aggressively is more of an implementation artifact than anything else.
>
>So generally, don't use "--follow". It's kind of a hack to emulate
>"track changes to a file", but it is a hack, and it fundamentally is a
>bogus operation (for all the same reasons that the CVS/SCCS/SVN/etc
>notion of a "file identity" is complete garbage and leads to
>fundamental problems).

Interesting. My thinking around --follow was that it's like
--full-history in the sense that it won't prune history, but it would
also keep listing history beyond file renames.

The --follow functionality is quite useful when looking at older
branches and trying to understand where changes should go into on those
older branches.

We also do have some notion of "file identity" in the kernel; it's
prevalent with "quirk files". Look at these for example:

  - drivers/mmc/core/quirks.h
  - sound/pci/hda/patch_*.c
  - drivers/hid/hid-quirks.c

We know that patches to those files are likely to contain quirks (which
we usually want to take into the Stable branches) so I might have a
script that monitors a list of these "special" files in which case I
need to see a complete list of commits that went into those files.

-- 
Thanks,
Sasha
