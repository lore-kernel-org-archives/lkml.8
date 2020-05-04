Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE69C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91152071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kechdpiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEDNQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:16:09 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478F5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 06:16:09 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j16so6518928oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VBH3Efn4XXIbG2xmQzJe+eWyQyJINI15wWLEaPRCf0s=;
        b=kechdpiBPlIHWnNVt1TaHpRHCeeS7fwwOCSdtrU9iiNBJsBNu6QWGSKJ+I+FIFQPXX
         lGqgirzt1rIgUFnUt37Wv58OS/r+OEA6Pvf3/BnN7iGn/t7NzfRcan9GZHTBd8aR+lGm
         Ro2kGmjjTkH+xIyLyp5v1BVr/ja60e+p+s4vontPoNN0XOSS7ZPTMjapgaBUcQu5YGYF
         bmJJYWals2klkQiGc+irGyEZyEyjgz8PRvF0CWCiPyy3gZSQptaUG8FOfWg0HtQcOdZx
         zvYJ01grR4mwC1NsWhjMqerezj52WLKgRz3Tu7LMPV4Pz01MfIUSrQFgAUbUec5h56h9
         Px8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VBH3Efn4XXIbG2xmQzJe+eWyQyJINI15wWLEaPRCf0s=;
        b=M18aleNtbBL9ShxoXZO1jcwmjCXsQvcrN7OX8onJtnymrP16i3i2HlvUHHcIXkUHKM
         OeYqA25b4W7pETIGo3Cdi89nwLn+56xacykIcrVX9vJh4RvbLvH6bFz+XNXDFhOeZqCx
         biTAIieO/B6oRpqXWtFmOuoOerQAk0qW0AhmGGkyWvYttHkzfxnxJFeNYmhKnVR9tala
         6wbzAqoZ829Slp68DBYYOKILUYj7qJiNkZ5UiTn/gpphLPpAMwhuKYsOCAu0/BaKpSO0
         RPickx8eabIXYciF5XtYbFX95Pk0fwX48TK6l53M3D6fcvoZqjKkUgJqbrDPmTHmbsdW
         1VRQ==
X-Gm-Message-State: AGi0PuaNeEzKayERkP0V2YTX9Vxh3dbeD0L19W/rpJMvcUDiTB4TpAc2
        XC5sQN9joFrJ1uwm3AF/Ay+KN6Q=
X-Google-Smtp-Source: APiQypLy5igSWLA4K0+SZkpOMKFpnRRqNviwXaBY3vSZJuoY8TgfECyJedONERxz5u3Sc7Ss/Rpk/w==
X-Received: by 2002:aca:abc6:: with SMTP id u189mr8764738oie.30.1588598168362;
        Mon, 04 May 2020 06:16:08 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id g10sm3280807oou.31.2020.05.04.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:16:07 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 6A12F18000D;
        Mon,  4 May 2020 13:16:06 +0000 (UTC)
Date:   Mon, 4 May 2020 08:16:05 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipmi:bt-bmc: Fix error handling and status check
Message-ID: <20200504131605.GJ9902@minyard.net>
Reply-To: minyard@acm.org
References: <20200418080228.19028-1-tangbin@cmss.chinamobile.com>
 <20200418134909.GF6246@minyard.net>
 <cc048630-831d-9765-7f7a-7eaacd3a8199@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc048630-831d-9765-7f7a-7eaacd3a8199@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 02:29:26PM +0800, Tang Bin wrote:
> Hi, Corey:
> 
> On 2020/4/18 21:49, Corey Minyard wrote:
> > On Sat, Apr 18, 2020 at 04:02:29PM +0800, Tang Bin wrote:
> > > If the function platform_get_irq() failed, the negative
> > > value returned will not be detected here. So fix error
> > > handling in bt_bmc_config_irq(). And if devm_request_irq()
> > > failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
> > > it may be more suitable for using the correct negative values
> > > to make the status check in the function bt_bmc_remove().
> > You need to mention changing platform_get_irq to
> > platform_get_irq_optional in the header.
> > 
> > Another comment inline below.
> > 
> > Otherwise, this looks good.
> 
> Got it. The v3 will be as follows：
> 
> If the function platform_get_irq() failed, the negative value
> 
> returned will not be detected here. So fix error handling in
> 
> bt_bmc_config_irq(). And in the function bt_bmc_probe(),
> 
> when get irq failed, it will print error message. So use
> 
> platform_get_irq_optional() to simplify code. Finally in the
> 
> function bt_bmc_remove() should make the right status
> 
> check if get irq failed.
> 
> > 
> > You need to set this to rc.  Otherwise it will remain the interrupt
> > number assigned by platform_get_irq_optional().
> 
> Yes, I think you are right. I'm not as considerate as you. Thank you for
> your instruction.
> 
> When get irq failed, the 'bt_bmc->irq' is negative; when request irq failed,
> the 'bt_bmc->irq = 0' is right.
> 
> So 'bt_bmc->irq <= 0' means irq failed.

Sorry, I missed your question here and was waiting for v3.

Well, we want bt_bmc->irq < 0 to mean the irq request failed.

> 
> Now let me rearrange the logic here:
> 
>     In bt_bmc_probe():
> 
>         bt_bmc_config_irq(bt_bmc, pdev);
> 
>         if (bt_bmc->irq > 0) {

Should be >= 0.

> 
>         }
> 
> 
>     In bt_bmc_remove():
> 
>         if (bt_bmc->irq <= 0)
>             del_timer_sync(&bt_bmc->poll_timer);

Should be < 0.  But other than that, I think it's correct.

-corey

> 
> 
> If you think this logic is correct, I'll submit v3.
> 
> Thanks,
> 
> Tang Bin
> 
> > 
> > 
> > 
> > 
> 
> 
