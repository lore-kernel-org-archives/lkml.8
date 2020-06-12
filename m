Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB60C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6763920838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ch+G5Ff+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="v5jS8qjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFLPTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:19:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52335 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgFLPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:19:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ED59E4CC8;
        Fri, 12 Jun 2020 11:19:30 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=22t9Ut8LGNPQZcuwBoygY9sFDBQ=; b=ch+G5F
        f+rL9Y26JkM0TLDTfVupXzFMDulMjp1sMBUdGKFMmjp1modPgIygeyoZTyVOuRw+
        fAuBoAQA+HW7pEcZbxOFf4Dghu2GwFStiVqRRRR3Q8O6UK3MSddf8ZTSVi45wdPK
        /tknsJa6jpntcZs4/0B54vnBDPDs0lG8k5Qso=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1609AE4CC7;
        Fri, 12 Jun 2020 11:19:30 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=+j2zvxY3yyACYmz62lMN5mkK3euzNoR2JXP7LPUWCaA=; b=v5jS8qjxtE91zh+Qiqg4lLx/8UpHSwhsar4xdmNNdFLRGtCwuesR9hp4v2lgfr+ll9ZTtCwf8AN6/HgHuXA2zK9L8ITkZ6F2455mW1BwgExJK+QV1xJsoYm/cGlhr4iSM6jEV/K36ENBr7MQ3cqJMoLFd3dgAtYHEZXMvAR3AN4=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCCC5E4CC3;
        Fri, 12 Jun 2020 11:19:25 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 011CC2DA0AF0;
        Fri, 12 Jun 2020 11:19:23 -0400 (EDT)
Date:   Fri, 12 Jun 2020 11:19:23 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/3] ARM: copy_{from,to}_user() for vmsplit 4g/4g
In-Reply-To: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
Message-ID: <nycvar.YSQ.7.77.849.2006121117250.3341460@knanqh.ubzr>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 1A10A78E-ACC0-11EA-AF12-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020, afzal mohammed wrote:

> Performance wise, results are not encouraging, 'dd' on tmpfs results,
> 
> ARM Cortex-A8, BeagleBone White (256MiB RAM):
> w/o series - ~29.5 MB/s
> w/ series - ~20.5 MB/s
> w/ series & highmem disabled - ~21.2 MB/s
> 
> On Cortex-A15(2GiB RAM) in QEMU:
> w/o series - ~4 MB/s
> w/ series - ~2.6 MB/s
> 
> Roughly a one-third drop in performance. Disabling highmem improves
> performance only slightly.

Could you compare with CONFIG_UACCESS_WITH_MEMCPY as well?


Nicolas
