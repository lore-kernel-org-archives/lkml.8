Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA2620835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cnyOvU6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFLOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:40:39 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F8C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:40:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49k3L73YpDz9sSS;
        Sat, 13 Jun 2020 00:40:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591972832;
        bh=iILg0eBdrp/DHNiIYM7CVkaPPOszIUXBZc2ZNSyElHA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cnyOvU6by97JA6beC+oqWuYD2hsqBJv08yzwYgq6rTabYWon+Rv9Md07rQhh686DB
         +P7kPNo+jr+PU8UgaZ9dw1J/DSSi5MA3Tt9YlEzryBs5G4VUK0FVEvAdAEY99oaQB3
         JcbScu8M7QFuHSEvbDmDkLsRKQNdX5mEPWeYOsVcwh02Q41Pes/qb199X2oLL1H3kM
         eHsknW2e0Ji10Xco6G3FtlBoM3pNLjlAOq5/2JU0DTKgukWK34ccvPKOAnASNqHEx8
         otydrOz5Rq2F+LGhOjAI7pRjYZnbryHAf7xlDnsi6fRmbxyHLt4sWjiuCXgxH/VkDI
         1sJnuGRMd4fGg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiri Slaby <jslaby@suse.cz>, SeongJae Park <sjpark@amazon.com>,
        Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, apw@canonical.com,
        SeongJae Park <sjpark@amazon.de>, colin.king@canonical.com,
        sj38.park@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of blacklist/whitelist
In-Reply-To: <38ac91ab-ced3-8a4f-b825-4503fdcddeb8@suse.cz>
References: <20200611073804.10225-1-sjpark@amazon.com> <38ac91ab-ced3-8a4f-b825-4503fdcddeb8@suse.cz>
Date:   Sat, 13 Jun 2020 00:40:59 +1000
Message-ID: <877dwcfitg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jslaby@suse.cz> writes:
> On 11. 06. 20, 9:38, SeongJae Park wrote:
>> On Wed, 10 Jun 2020 23:35:24 -0700 Joe Perches <joe@perches.com> wrote:
>>> On Thu, 2020-06-11 at 08:25 +0200, SeongJae Park wrote:
>>>> From: SeongJae Park <sjpark@amazon.de>
>>>>
>>>> This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
>>>> and 2) set the 'blacklist' and 'whitelist' as deprecated with
>>>> replacement suggestion of 'denylist' and 'allowlist', because the
>>>> suggestions are incontrovertible, doesn't make people hurt, and more
>>>> self-explanatory.
>>>
>>> While the checkpatch implementation is better,
>>> I'm still very "meh" about the whole concept.
>> 
>> I can understand your concerns about politic things in the second patch.
>> However, the concept of the 'deprecated terms' in the first patch is not
>> political but applicable to the general cases.  We already had the commits[1]
>> for a similar case.  So, could you ack for at least the first patch?
>> 
>> [1] https://www.phoronix.com/scan.php?page=news_item&px=Linux-Kernel-Hugs
>
> Fuck you! replaced by hug you! is a completely different story. The
> former is indeed offending to majority (despite it's quite common to
> tell someone "fuck you" in my subregion; OTOH hugging, no way -- I'm a
> straight non-communist). If it turns out that any word (e.g. blacklist)
> offends _majority_ (or at least a significant part of it) of some
> minority or culture, then sure, we should send it to /dev/null.
> should by no means listen to extreme individuals.

I agree you have to draw the line somewhere, there will always be
someone somewhere that's offended by something. But this seems like a
pretty easy case.

It's not like blacklist / whitelist are even good to begin with, it's
not obvious which is which, you have to learn that black is bad and
white is good.

Blocklist (or denylist?) and allowlist are actually more descriptive and
less likely to cause confusion.

cheers
