Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD42E207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy3ZnT0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0N0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgH0NSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:18:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61BC061264;
        Thu, 27 Aug 2020 06:18:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t2so5160741wma.0;
        Thu, 27 Aug 2020 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGOm36EJ1gvLT2vEuLBm0bHlK+EP6bPxI7F5u3wXPR4=;
        b=Dy3ZnT0b4XvZlnNaeII0JsUKxqSjbFz+Z7OhG/wjskDJ/PnJsbHSQbx0BWivbJdHCH
         j6/XjkAmC6OhhG7LLrlrb0uVUZxo6XoMDZ9MQFzUje9t8Oa2bQwUZfJHnZiHcJvrUbsG
         i77TYccRCB91FAJgI7GLKikJ65oci6GcYLN6oOq8oZj4zFHMUKIxxXM9F/Ois0A7RM/1
         PzHNRvNPBCYxatHt0pBMaVGby2n7AK/w/7ODwumi2Jf7qznj9hSMwHP455BJTgjO5cAW
         La7nqnS0MLQY5AVl+LJDGpQGpAh/vqClkQNJamCHCKipH5+QJKZ3HC9mL9ZrSgSLCh7X
         OzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGOm36EJ1gvLT2vEuLBm0bHlK+EP6bPxI7F5u3wXPR4=;
        b=LHdx9fXhqdJxngz/XfjcezIQknPHyULrNAf5ildmbIjfl3K25SPp48m9b5+w/2QadA
         5CpnXum9kHpU/SxgMGI3vLECQobu75saZ9ZM+PN4NX28/2UEbMHwagHqkvWzpkfdchW9
         qQ5B1om2pHG1VmUSjHbhh16GjPSh3e6P+7yR9qatpUCy9Tl6H2EoEp3o+jv9oeng4Oeu
         cB5Bxfdxrm+aDJ5nRHRNYJyGi7aAiwGYjSdw+O5T6GIh2gt5wWvpsNjcH6Cnh45nw8J5
         pqOWrlU2Y1YOcE3NjFBfhBBM9qzGpAio3V5VPiw/ldLWhclTdOUSnMfchYYmhd4oQxI/
         /tEQ==
X-Gm-Message-State: AOAM531lWyzIjJuT9+++TjjnMPLIJs3dfrQD58259dTJ/MmMh83q/ed8
        ACl+GoDhxhit98qMqytGCUw=
X-Google-Smtp-Source: ABdhPJzI5QjfPnh3uAIN0AT002leMR5QibZkzxxKT/UrRwGZ8om6hYO2KClj4bQXPg1weT+7NmHm2g==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr11738054wmz.8.1598534301988;
        Thu, 27 Aug 2020 06:18:21 -0700 (PDT)
Received: from lenovo-laptop ([2a00:23c4:4b87:b300:cc3a:c411:9a4b:dba6])
        by smtp.gmail.com with ESMTPSA id f3sm5022756wmb.35.2020.08.27.06.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:18:21 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Thu, 27 Aug 2020 14:18:19 +0100
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Message-ID: <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827071537.GA168593@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:15:37AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 27, 2020 at 08:42:06AM +0200, Rasmus Villemoes wrote:
> > On 25/08/2020 00.23, Alex Dewar wrote:
> > > kernel/cpu.c: don't use snprintf() for sysfs attrs
> > > 
> > > As per the documentation (Documentation/filesystems/sysfs.rst),
> > > snprintf() should not be used for formatting values returned by sysfs.
> > >
> > 
> > Sure. But then the security guys come along and send a patch saying
> > "sprintf is evil, always pass a buffer bound". Perhaps with a side of
> > "this code could get copy-pasted, better not promote the use of sprintf
> > more than strictly necessary".
> > 
> > Can we have a sysfs_sprintf() (could just be a macro that does sprintf)
> > to make it clear to the next reader that we know we're in a sysfs show
> > method? It would make auditing uses of sprintf() much easier.
> 
> Code churn to keep code checkers quiet for pointless reasons?  What
> could go wrong with that...
> 
> It should be pretty obvious to any reader that you are in a sysfs show
> method, as almost all of them are trivially tiny and obvious.  Yes, it
> doesn't help with those that make blanket statements like "sprintf is
> evil", but I think that kind of just shows them that they shouldn't be
> making foolish blanket statements like that :)

Perhaps I should have mentioned this in the commit message, but the problem
is that snprintf() doesn't return the number of bytes written to the
destination buffer, but the number of bytes that *would have been written if
they fitted*, which may be more than the bounds specified [1]. So "return
snprintf(...)" for sysfs attributes is an antipattern. If you need bounded
string ops, scnprintf() is the way to go. Using snprintf() can give a
false sense of security, because it isn't necessarily safe.

[1] https://github.com/KSPP/linux/issues/105

> 
> Anyway, we've had this for 20 years, if sysfs calls are the only left
> remaining user of sprintf(), then I'll be glad to consider using a
> "wrapper" function or macro.
> 
> thanks,
> 
> greg k-h
