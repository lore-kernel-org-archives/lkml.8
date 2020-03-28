Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76769C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F28C20714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 20:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qEkTFPur";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ypSwc9Ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgC1Uuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 16:50:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62694 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgC1Uuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 16:50:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1100243590;
        Sat, 28 Mar 2020 16:50:33 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=MVnJ4eCCBFn2tIDbc7IaRiJ4y4k=; b=qEkTFP
        urURuXj05IisyZUwOJbdNlYDNyKpD18kZK+S5iGfGsC9XophQUtpGtiwE24lK8FG
        SG69eeCM8LWv/klhBJTtiYa3adCIAP6GLWPg+nEtGFd0G/IY8KAa7OfuTM+hIGqw
        rGLvWbYaBqsvDjTFVium1K5Ameb0Tls4uj4jc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 081854358F;
        Sat, 28 Mar 2020 16:50:33 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=JASv01FUd5xtHan2jcoYVzXPo3Lp3q4mtypqVd9D1xs=; b=ypSwc9Riz3ofKU5sEtPdwWgP7uwl4R6V8NQJGeTqDgiOKLAV8zXV45VDpvBxBIlGtiiXcz+FxkvPA7daO0H29nlbOFJjvlqUH3dMwWXhRHxLgld0N+kzxGZtzol9BZHHnY/1h4g3/2+hrO1EgFrl/8U5o7AV7XRhi1C32STW8Hc=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 631834358E;
        Sat, 28 Mar 2020 16:50:32 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 721EC2DA0174;
        Sat, 28 Mar 2020 16:50:31 -0400 (EDT)
Date:   Sat, 28 Mar 2020 16:50:31 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Chen Wandun <chenwandun@huawei.com>, jslaby@suse.com,
        gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        sam@ravnborg.org, b.zolnierkie@samsung.com, lukas@wunner.de,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] vt: fix a warning when kmalloc alloc large memory
In-Reply-To: <20200328031257.GA30454@angband.pl>
Message-ID: <nycvar.YSQ.7.76.2003281641230.2671@knanqh.ubzr>
References: <20200328021340.27315-1-chenwandun@huawei.com> <nycvar.YSQ.7.76.2003272232340.2671@knanqh.ubzr> <20200328031257.GA30454@angband.pl>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C4076B7C-7135-11EA-AB05-C28CBED8090B-78420484!pb-smtp1.pobox.com
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

In fact that's not exactly true. The code has this protection:

        if (new_screen_size > (4 << 20))
                return -EINVAL;

The problem is with the unicode screen content whose buffer is larger 
than the legacy glyph buffer. Still, the above test is a bit iffy as it 
depends on the default MAX_ORDER value which is configurable.


Nicolas
