Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE23C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353C020716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CmSjGkAs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="QPsazEEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgC1QUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:20:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57927 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgC1QUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:20:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84856C3778;
        Sat, 28 Mar 2020 12:20:07 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ogo8rb0hMjtxC4ELJWZtM1LYWnQ=; b=CmSjGk
        AsBucxzh/wG7AwoenkMlyCw4u/+KnJQboSkkDI/wnfciTGeOejRG9YzFVyJJprv1
        dJX1oDJpGdvx1rnMdoOPrsJZEZqGJi7c3rDkRJOyOPTnuuMpzR3VTmcWSiegb+PU
        3VDZ0ZUQNvw7QwYCe8fijP8lWTc9SMyfTi27g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C75FC3777;
        Sat, 28 Mar 2020 12:20:07 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=sT0yvJaG2S1Yvkeio7Xw+/HiKCgi5bPRp3U/rvRIHWE=; b=QPsazEEItO1TiH2NT1cRiG5iaQlH2BudY3c3w/eb0EDpV7RYgV9SsiipBBr6cVokYmLNkn3mbmqjcImBwPjIg5aob5X19Qg0mkKDYj4E0lmwlazT9vUEzY2NFWEUUstNVPXLX6kmCEAAIltxlcnkj9WhLtvD6PHpdlXAVxxk/sU=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57EE9C376F;
        Sat, 28 Mar 2020 12:20:03 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 616642DA0185;
        Sat, 28 Mar 2020 12:20:01 -0400 (EDT)
Date:   Sat, 28 Mar 2020 12:20:01 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Chen Wandun <chenwandun@huawei.com>, jslaby@suse.com,
        gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        sam@ravnborg.org, b.zolnierkie@samsung.com, lukas@wunner.de,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] vt: fix a warning when kmalloc alloc large memory
In-Reply-To: <20200328031257.GA30454@angband.pl>
Message-ID: <nycvar.YSQ.7.76.2003281218470.2671@knanqh.ubzr>
References: <20200328021340.27315-1-chenwandun@huawei.com> <nycvar.YSQ.7.76.2003272232340.2671@knanqh.ubzr> <20200328031257.GA30454@angband.pl>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: FAC3642A-710F-11EA-8B7B-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020, Adam Borowski wrote:

> On Fri, Mar 27, 2020 at 10:55:14PM -0400, Nicolas Pitre wrote:
> > On Sat, 28 Mar 2020, Chen Wandun wrote:
> > 
> > > If the memory size that use kmalloc() to allocate exceed MAX_ORDER pages,
> > > it will hit the WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN)), so add memory
> > > allocation flag __GFP_NOWARN to silence a warning, othervise, it will
> > > cause panic if panic_on_warn is enable.
> > 
> > Wow! How do you manage that? You need something like a 1024x1024 text 
> > screen to get such a big memory allocation.
> 
> ioctl(VT_RESIZE) allows up to 32767x32767, unprivileged for a local user.
> That's 4GB per console.

Right. And that's ridiculous. This ought to be limited to something much 
saner.


Nicolas
