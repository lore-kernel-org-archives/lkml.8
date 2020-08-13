Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F9A20768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szT6RXv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7CsOnfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMK0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:26:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:26:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597314364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iZlveHJkPbKg+Rpvt5/+mfNHSpXh3lUq1NpO0sJBdU=;
        b=szT6RXv5mw607uKSLMoD7dtNmyeMT0uxak2defEzNebAW0ybvCTnZNV82Y+FXeBeNfvG4T
        Om+ppJi1JMDd9jtuqZXS+TZ47zbyvwteJJVdQoLHA/dim2ZYJgA1Udccdr9ZOHmF9xFtMG
        +XXzNNFYabz/UUYpzXqb7G/2ByECEFR1SsftUMk0YHivIgiXhBGV7ij60xKCH4jFR1kkSd
        bBzNwwyaAIGbrzzJrqXkCev9+H8JmWnzbW//9CrQHuO9viKaFKRwH1T9P7+mZm9UQrkIyj
        75CjhvhekFXjFqrmRcPhHiSxGtGckdAPlf9PlHmHa5VhQgh3cVg71jpbjxVkaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597314364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iZlveHJkPbKg+Rpvt5/+mfNHSpXh3lUq1NpO0sJBdU=;
        b=E7CsOnfjSwHXCrPECvNAOcIQ9Fp5UYgTvPgtFZP7xtC5QhitAymlBdWU+bKqnMtu7laUzj
        JvkSmXb1W2j/CQAw==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and real
In-Reply-To: <20200813015500.GC2020879@jagdpanzerIV.localdomain>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com> <20200811094413.GA12903@alley> <87zh7175hj.fsf@nanos.tec.linutronix.de> <20200811130218.GI6215@alley> <20200813015500.GC2020879@jagdpanzerIV.localdomain>
Date:   Thu, 13 Aug 2020 12:26:03 +0200
Message-ID: <87k0y2lu4k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <sergey.senozhatsky@gmail.com> writes:
> On (20/08/11 15:02), Petr Mladek wrote:
>> There is still the alternative to print all three timestamps regularly
>> for those interested. It is less user convenient but much easier
>> to maintain.
>
> Yes, that's a nice alternative.

It's trivial on the kernel side, annoying for all people who do not care
about them because they show up in syslog and it's a fricking nightmare
to reconstruct over a large cluster of machines.

Thanks,

        tglx
