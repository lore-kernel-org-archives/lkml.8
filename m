Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED22C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 23:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2F820768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 23:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yr1gxaM+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MyXKn9Ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgHNXUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:20:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 19:20:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597447250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LX7oqtOI6mdc7zsr/58CbF56Ijm4R7j+15Yb+EoC2s=;
        b=Yr1gxaM+cUiqwc8M3Lwa5stilhaPXijnRIEOE6RFJjZP14Obi0x0dSOhosUmM8PtcbNjij
        8/uKq9iH/n0y9Se/qHf1U5eRiRT7wQYzfIiv9SwezoQKTf9fr89VHl4mtypuRQzGI6G/4v
        3xBOOkeoxcmftBNiM2FcOxJhw2/Ks3imCBMdSwINykZDmpKhH7Yrg51rhQBCAvIpweuiDK
        CJVXKRIZToq0Y68DetLoludyD5RSoD9GygmiuaeL3SZqT5X0T4V898hyeuO0k54yzTKkQA
        HgEKp7m/SKeIc1vvx1H6aQdo0QYpO/sBaNkGgXYsXhVc/liq9lv2OXm+vVEybQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597447250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LX7oqtOI6mdc7zsr/58CbF56Ijm4R7j+15Yb+EoC2s=;
        b=MyXKn9VeXVyBnDpyGcQ0p7G5un8hj01qIURm0jqLpQ0vLeQ7wMa5X+pU+n03aNeYU2J+mk
        Qf1KlHDHxJvrEFBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] irq/urgent for v5.9-rc1
In-Reply-To: <CAHk-=wjUx-DOx8kL91PmPwCbA6K7-9LXZ_+bkoa4SuQ6_zbaPA@mail.gmail.com>
References: <159742071192.30851.2328227964586183297.tglx@nanos> <CAHk-=wjUx-DOx8kL91PmPwCbA6K7-9LXZ_+bkoa4SuQ6_zbaPA@mail.gmail.com>
Date:   Sat, 15 Aug 2020 01:20:49 +0200
Message-ID: <87r1s8ke5q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14 2020 at 14:14, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 9:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Two fixes in the core interrupt code which ensure that all error exits
>> unlock the descriptor lock.
>
> No diffstat?
>
> I've pulled it, but please check what went wrong..

Duh, incomplete restore of environment after replacing the worn out
SSD. Fixed.

Thanks,

        tglx

