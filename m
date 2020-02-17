Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF7C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D692920725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5+UnAVh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="pj+Qrzbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgBQQAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:00:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55575 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgBQQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:00:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDC795CE84;
        Mon, 17 Feb 2020 11:00:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=2CMqNie/jgw27GZLCTfFeu7CdIg=; b=B5+UnA
        VhqAWU3+g3omzzdBVexEpAa+wKzJF+DQ73CPdMwDpjCMxleLkCkFcZEK5Nnqjz6E
        Ukw8Yu901D2gPGF5dKgwbz/bCLmrV+ZoHK8Ot3D8u5qCR927mSctKW2jBLc+SM1D
        7C5MtwPWqYdGG5WIXUfIt48/F6vjBeG0IKzKU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2F155CE83;
        Mon, 17 Feb 2020 11:00:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=9oU7m/+N59y4UIzicilnkFO8xw/KIfHOdwGXAKP2J3U=; b=pj+Qrzbzi+EXyQElrTgV2eg6jl+bTwoWKCmw4Qqt+X92of6rUpK3Go8QdGr+0tAcp0NADL6GBQWzZZ236lKRjYbZaDeYhN1Stle+tMbCsXLuvMtNCd4lvuOuLqddest4ErCDDverKmfghtzA1WQr/Z6wqnN7TVJSrgcAQles/v8=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 594B05CE82;
        Mon, 17 Feb 2020 11:00:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 83CC62DA01B8;
        Mon, 17 Feb 2020 11:00:39 -0500 (EST)
Date:   Mon, 17 Feb 2020 11:00:39 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Quentin Perret <qperret@google.com>
cc:     Matthias Maennich <maennich@google.com>, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, jeyu@kernel.org, hch@infradead.org
Subject: Re: [PATCH v4 1/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
In-Reply-To: <20200217153023.GA71210@google.com>
Message-ID: <nycvar.YSQ.7.76.2002171059230.1559@knanqh.ubzr>
References: <20200212202140.138092-1-qperret@google.com> <20200212202140.138092-2-qperret@google.com> <20200217152201.GA48466@google.com> <20200217153023.GA71210@google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A50A65BE-519E-11EA-992F-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Quentin Perret wrote:

> On Monday 17 Feb 2020 at 15:22:01 (+0000), Matthias Maennich wrote:
> > In case the whitelist file can't be found, the error message is
> > 
> >  cat: path/to/file: file not found
> > 
> > I wonder whether we can make this error message a bit more specific by
> > telling the user that the KSYMS_WHITELIST is missing.
> 
> +1, that'd be really useful. I'll check the file existence in v5 (in a
> POSIX-compliant way, I promise).

In fact, if you explicitly provide a file that is not there, then this 
is arguably a good reason to even fail the build.


Nicolas
