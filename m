Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FAC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21307215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgBQQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:45:36 -0500
Received: from scorn.kernelslacker.org ([45.56.101.199]:52550 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgBQQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:45:36 -0500
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1j3jWX-00008K-7h; Mon, 17 Feb 2020 11:45:33 -0500
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id EBA8E56027C; Mon, 17 Feb 2020 11:45:32 -0500 (EST)
Date:   Mon, 17 Feb 2020 11:45:32 -0500
From:   Dave Jones <davej@codemonkey.org.uk>
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.6-rc2
Message-ID: <20200217164532.GA3765@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <20200217020840.GA24821@codemonkey.org.uk>
 <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
 <8025e1bf-4834-83c6-d12c-4e817f875776@toxicpanda.com>
 <CAHk-=wiG+wjLjuDDNiqfL3iLW25yqsMK_gNEWomyMH=8kxOLwQ@mail.gmail.com>
 <20200217123054.GH2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217123054.GH2902@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:30:54PM +0100, David Sterba wrote:
 > On Sun, Feb 16, 2020 at 09:08:18PM -0800, Linus Torvalds wrote:
 > > On Sun, Feb 16, 2020 at 7:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
 > > >
 > > > I assume Filipe wrote this based on my patch here
 > > >
 > > > https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?id=c821555d2b9733d8f483c9e79481c7209e1c1fb0
 > > >
 > > > which makes it so we can allocate safely in this context, but that patch hasn't
 > > > made it's way to you yet.  Do you want it now?  It was prep for a much less safe
 > > > patchset, but is fine by itself.  Thanks,
 > > 
 > > I assume it's either that, or revert 28553fa992cb and do it differently..
 > > 
 > > I'll leave that whole decision to the btrfs people who actually know
 > > the code and the situations and what the alternative would look
 > > like...
 > 
 > I'll send a pull request with fix today. The fixes get cherry-picked
 > from development branch to current rc branch and sometimes affect each
 > other. I do test the rc branch independently before sending but I
 > haven't seen the bug Dave reported.

After rebooting, it didn't reproduce, so it did seem to be dependent on
exactly which files rsync was moving around.  Given it doesn't happen
all the time, little surprise it slipped through I guess.

	Dave

