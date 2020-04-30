Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC89C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D132083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t5ZUcUUL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="YQPb/gU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgD3B1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:27:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62518 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3B1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:27:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD832CBCCA;
        Wed, 29 Apr 2020 21:27:52 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=/7UUNjs0jgjJL33kO744X1Zmsy8=; b=t5ZUcU
        ULXz5TupELg+YI8bqonlpbi0vz/LeyzsjvgtaMd2YwOiqeHDtfJreis57QLu/KfQ
        R0XPOT4qFmVPwcEpNeJX0e1W+L2NeObuh0h4x+hvZA7WsV1BuxtZXT5Aqs1PN2/K
        FQ2KxlNR30C9bzZNezSrAlR7cBo8U4UUuU+Ns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A459FCBCC9;
        Wed, 29 Apr 2020 21:27:52 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=CI/jtc3Zlelxj2BQukubtHMMJfB/+tA0KmygluxhJbA=; b=YQPb/gU/LhzfRx6zMbu+Zs1tlnMbPkPQGX+ngmjhwPGtUwYM7btvMITtaQqrB98Z4ol/vCX1ILq1cCfEPen/73hE+/Q5vml/duNEdm+ERBtA/8OI7IRyCtowoXWqN2OSzf/o//OSZh3+yrpf+HoBGWDKoxtfstaneOjI26SXqwk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 992BECBCC8;
        Wed, 29 Apr 2020 21:27:49 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B79A62DA0403;
        Wed, 29 Apr 2020 21:27:47 -0400 (EDT)
Date:   Wed, 29 Apr 2020 21:27:47 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
In-Reply-To: <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.2004292115050.2671@knanqh.ubzr>
References: <20200429214954.44866-1-jannh@google.com> <20200429215620.GM1551@shell.armlinux.org.uk> <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CDCE5890-8A81-11EA-B000-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020, Linus Torvalds wrote:

> While we're at it, is there anybody who knows binfmt_flat?

I'd say Greg Ungerer.

> It might be Nicolas too.

I only contributed the necessary changes to make it work on targets with 
a MMU. Once fdpic started to worked I used that instead.

FWIW I couldn't find a toolchain that would produce FLAT binaries with 
dynamic libs on ARM so I only used static binaries.


Nicolas
