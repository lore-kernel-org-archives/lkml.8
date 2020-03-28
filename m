Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B1C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBB0206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vNC33ELS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="HyLMTyrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgC1CzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:55:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61579 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC1CzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 22:55:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3E86BBA3F;
        Fri, 27 Mar 2020 22:55:19 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=sSqb30NNQNqTsRknQ8lLupar/mE=; b=vNC33E
        LSGl3qIU7V1DJYieTA0b9SjQDataFVKlJh2Er126pDxr0rMIbVR5sb86lFLmWbOG
        RjHgrjVejLXJqrToicwK4iaWajnl3bHXFkXKXQIHv4QEmnudNxBvsSUcFB39OIdZ
        QqTunpP69TTC7gT4/LotMdwfngYY/Nq8h8+Xk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A764BBA3E;
        Fri, 27 Mar 2020 22:55:19 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=kMBm7Q4AhHCbPnyWnAC5N85IkTkWQ/zsEXlcMmQI1eo=; b=HyLMTyrUhBpkuSWwYNO0K2veNsYjRr6ddfRxK0sMpiL/jKjyd8Z/QWUmoCB/349A9Jh1ao2d035KqrUuL3xU7hzLV8CGz83Y6HCfYgpWPvrhwA5HhafAU2WnfFC+oU6GjdpBJF9Dv+gVfYuVSRsYD8KI60GJ50trk5b6AFWS4Ds=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90B5EBBA3D;
        Fri, 27 Mar 2020 22:55:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id A7ADD2DA01B0;
        Fri, 27 Mar 2020 22:55:14 -0400 (EDT)
Date:   Fri, 27 Mar 2020 22:55:14 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Chen Wandun <chenwandun@huawei.com>
cc:     jslaby@suse.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, b.zolnierkie@samsung.com,
        lukas@wunner.de, ghalat@redhat.com, kilobyte@angband.pl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] vt: fix a warning when kmalloc alloc large memory
In-Reply-To: <20200328021340.27315-1-chenwandun@huawei.com>
Message-ID: <nycvar.YSQ.7.76.2003272232340.2671@knanqh.ubzr>
References: <20200328021340.27315-1-chenwandun@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8D9B5CC4-709F-11EA-9B54-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020, Chen Wandun wrote:

> If the memory size that use kmalloc() to allocate exceed MAX_ORDER pages,
> it will hit the WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN)), so add memory
> allocation flag __GFP_NOWARN to silence a warning, othervise, it will
> cause panic if panic_on_warn is enable.

Wow! How do you manage that? You need something like a 1024x1024 text 
screen to get such a big memory allocation.

Still, GFP_NOWARN is not a proper fix. This kmalloc() should rather be 
replaced by vmalloc(), and corresponding kfree() should then be vfree(). 
There is no need for this allocation to be physically contiguous.


Nicolas
