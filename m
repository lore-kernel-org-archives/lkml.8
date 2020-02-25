Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EE3C35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F46B24650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waifu.club header.i=@waifu.club header.b="Kv7jHqmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgBYD4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:56:49 -0500
Received: from mx1.cock.li ([185.10.68.5]:44443 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbgBYD4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:56:49 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=waifu.club; s=mail;
        t=1582603005; bh=btnYEUoxM2lY7tAOZNUCienv1ZMrRKlySzePRr4n7oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kv7jHqmJYvHDHIRb1elIE+/xmowJ8x2vdz41WWMiRJWThK/CfVf7qyOJOMuS4348T
         cBEMOiou23qlWp9pEmyJjnUEEeS0HEzpSgHJVzipQrTrdoOWcUnN4w2vQqIl5SR5J4
         qBHG9GW4RbtvH0gzR44Wm8nukaymhfNDBktmHGV1AdCL8KjXwIFhb7i38TcJysirsT
         7/HIyoEhaa3W9GuObrPVNVfNDPIDUWy3KSkYzAUnEOQODfS+2B7kmepB53CJ4Nmlwf
         ge/ds1rQZVM39rclhkZdO87N1dJYrG7C5vNJBXORRmTH30yGP3IOyngo4x1M4VXd48
         BHVOBb9pDjXRA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Feb 2020 03:56:44 +0000
From:   whywontyousue@waifu.club
To:     Stephan von Krawczynski <skraw.ml@ithnet.com>
Cc:     linux-kernel@vger.kernel.org, bruce@perens.com, rms@gnu.org,
        moglen@columbia.edu, blukashev@sempervictus.com,
        tcallawa@redhat.com, editor@lwn.net, skraw.ml@ithnet.com,
        torvalds@osdl.org
Subject: Re: General Discussion about GPLness
In-Reply-To: <20200224150124.7c88cb8a@ithnet.com>
References: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
 <20200223133301.03eab91d@ithnet.com>
 <2241a3e0c8dcba5b69b4f670e181d7cd@waifu.club>
 <20200223153909.1ba91bae@ithnet.com>
 <dadb648cd23ee79dacf5992ff5ca6094@waifu.club>
 <20200223214757.5adf49e4@ithnet.com>
 <9c062aed49c1484d435e1a394e979c83@waifu.club>
 <20200224150124.7c88cb8a@ithnet.com>
Message-ID: <e02b9131897a194aaec834c9393aab68@waifu.club>
X-Sender: whywontyousue@waifu.club
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see that you're just going to ignore
Universal City Studios Inc v Reimerdes

Instead you address your emotional issues. This is the making of a 
beast: which is what you are. Driven by your instincts.

You want to violate the linux copyright. You announced your intent 
(which increases the damages you are liable for under US jurisprudence.)

The facts are simple: You may not execute the scheme you are suggesting. 
If you do execute the scheme you or suggesting, or if you assist others 
in doing so then you are liable for copyright infringement (direct or 
contributory). If you make over 1000 dollars off of this infringement 
you are liable for criminal penalties as-well.

The courts see unlicensed modification of another copyright-holders 
work, in memory, while running, as the creation of an unlicensed 
derivative work.

It does not matter how you try to sugar coat it or change your 
description, nor do your complaints of me CC'ing relevant parties (a 
diversion technique by you) who could explain this all to you in ways 
you could understand, change anything. The courts in the USA see this 
type of action you suggest as the creation of a derivative work.

Thus you must follow the permissions and must not overstep them. That is 
all. Having non-gpl modules work as you describe violates the linux 
kernel copyright just as the plugin in the Reimerdes case violated the 
RealPlayer copyright: in both cases the situation involves "modules" 
extending the running program in real-time, in both cases the "modules" 
are not permitted by the copyright owners to do as they wish: and the 
Court agreed.

On 2020-02-24 14:01, Stephan von Krawczynski wrote:
> On Mon, 24 Feb 2020 07:46:33 +0000
> whywontyousue@waifu.club wrote:
> 
>> > Hm, really it is quite hard to stay calm reading your constant insults
>> > on
>> 
>> If such is so, it is shown to all that you are a stupid white man, 
>> what
>> can I say. You can't separate facts from fiction (opinion)
>> [...]
> 
> Please stop spamming people completely unrelated to this thread.
> And please stop spamming this thread with insults and blatant 
> ignorance.
> Thank you.
> No more answers from me to you.
> --
> Regards,
> Stephan
