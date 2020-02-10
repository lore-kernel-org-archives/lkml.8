Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690DD20873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="i5LcFyhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBJLZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:25:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37388 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgBJLZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:25:22 -0500
Received: from zn.tnic (p200300EC2F05D4008812BAA0C57D79D0.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d400:8812:baa0:c57d:79d0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 156FB1EC071C;
        Mon, 10 Feb 2020 12:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581333921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NaiqXX+sMELuoMaZk+22aQzQw0VCUrjI3pgdh2M4tM4=;
        b=i5LcFyhjdWnvrYl86SQPuJE6746hdWxgOLTu/v97aq18gb2hB2XnJapv0MjHW9o5mi4FHc
        KSjZ+zrtU0eUBcv6M5u4pPzqcG99loFdQekeQJOZHLT2zywkxoZCKqoQjM5E/9y8LR32jd
        okIO0cTG7dwOjsMWlYSstEvlZ3qPl3E=
Date:   Mon, 10 Feb 2020 12:25:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200210112512.GA29627@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic>
 <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic>
 <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
 <20200207114122.GB24074@zn.tnic>
 <20200208000648.3383f991fee68af5ee229d65@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200208000648.3383f991fee68af5ee229d65@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 12:06:48AM +0900, Masami Hiramatsu wrote:
> OK, could you tell me your idea to make it better? I'm waiting for such
> discussion a half of last year :)

Yah, situation sounds familiar. :)

> For your information, here is the background of this bootconfig.
> To build my boot-time tracing, I need a way to pass a flexible and
> structured configuration at boot time.

Can I see an actual example of what you're doing?

> I had tried to reuse devicetree at first, but it was rejected because
> the devicetree is only for describing hardware. So I introduced this
> bootconfig.

Makes sense.

> When I designed the bootconfig, I tried to sort out the requirements.
> That config should be able to pass all setting we can do on tracefs.
> Since ftrace already has a parser for tracefs, we don't need any types
> for each settings. Thus it should be something like sysctl.conf. But the
> sysctl.conf was too simple, it couldn't handle several related keys
> well. So I decided to introduce braces which put together some related
> parameters. And the bootconfig syntax was born.

Ok, here's my boot command line:

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.5.0-rc7+ root=/dev/nvme0n1p2 ro root=/dev/disk/by-id/nvme-eui.0025385481b2fe2a-part2 resume=/dev/disk/by-id/nvme-eui.0025385481b2fe2a-part1 debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 mem_encrypt=off systemd.log_target=null

How do I use the bootconfig thing with it? Or is it not supposed to be
used that way? IOW, how is it supposed to be used so that it needs to be
enabled on every box?

> Okay, I hope it and try to prove it. Anyway, to use boot-time tracing which
> can fully utilize ftrace at boot-time, we have to enable bootconfig.

Ok, this is getting closer. But not everyone is using boottime tracing?

Or is the logic: every user/tool might need to be able to do boottime
tracing at some future point in time and bootconfig is a mandatory part
of that use case?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
