Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910EA207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SG3jcoZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgFKRsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:48:55 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C862C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:48:55 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g129so3890102vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acirWtrOI5aXX0aAE7Go5x1+MEKzhG9T4nruOYiS7c4=;
        b=SG3jcoZBkXk2ifRHzGvBnYoSfCtkFZBRFAIginsgbJIZBS+pWSLmpfD4AOBgoaCdLK
         B8/EthGFAPz3qCoSQr9Iifvtby3G5VE+cTnfiZfGmnJRe8XOZQdNLgA5+olKutx4uVGN
         iKOO7wzCdCHyPVjPCyiLN/wjVXP6numj+2aXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acirWtrOI5aXX0aAE7Go5x1+MEKzhG9T4nruOYiS7c4=;
        b=IA3YScEUMOQr0uQ6R/CBXRcY9r+ErIuWv+wEKOwcdh5cINeWxHCMTjlC7VRf44LrY7
         L0R/qMHuBcvNtWNtNMT+s0DA0jTohjqOeIqHIDJjmqNjt9LQdYJTmfZQNP8B2g323DNO
         LRPRfTJNmwfQ1LSUpvUZe340mLabTqzaWNim477uX+buXg5nB1+3tS+n7m8FHVMgIb5f
         xolVd92c1QHqGSydrBcfputDtlQScye4+aWY1j1NNWPaBpquuk4IdhSSHQYXdZrAJois
         lONpldMMg/+6R6An+2SwT3OVWpunczcYWAkiQBy9SN+Z0mRrB62/J4V8SvOGc/uNcVBf
         F6Ag==
X-Gm-Message-State: AOAM533Wz/RyUP55vvCyIPgQmged2Z7r0lsSD1iTPsGbghkbr1JKYGED
        myvcGahNCsMW16oaMde4J1jsj/1mFm4=
X-Google-Smtp-Source: ABdhPJxx3HiypNFb1bCW0tbd1nIsQlQQUKmYeC5U4Dg78KXSd02L8We38K5ytFE8ww43uJXLaBTDgg==
X-Received: by 2002:a67:e19d:: with SMTP id e29mr7621146vsl.9.1591897733454;
        Thu, 11 Jun 2020 10:48:53 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 44sm455435uas.3.2020.06.11.10.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 10:48:53 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id i1so1660364vkp.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:48:52 -0700 (PDT)
X-Received: by 2002:a1f:280c:: with SMTP id o12mr7040118vko.92.1591897731903;
 Thu, 11 Jun 2020 10:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com>
In-Reply-To: <20200611110301.GA132747@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Jun 2020 10:48:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
Message-ID: <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Quentin Perret <qperret@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 11, 2020 at 4:03 AM Quentin Perret <qperret@google.com> wrote:
>
> Hi Doug,
>
> On Wednesday 10 Jun 2020 at 15:18:43 (-0700), Douglas Anderson wrote:
> > The cros_ec_spi driver is realtime priority so that it doesn't get
> > preempted by other taks while it's talking to the EC but overall it
> > really doesn't need lots of compute power.  Unfortunately, by default,
> > the kernel assumes that all realtime tasks should cause the cpufreq to
> > jump to max and burn through power to get things done as quickly as
> > possible.  That's just not the correct behavior for cros_ec_spi.
>
> Is this specific to this driver, or something you would want applied
> more globally to all RT tasks in ChromeOS (which is what we'd like to
> have in Android for instance)?

Hrm.  I guess my first instinct is to say that we still want this
patch even if we have something that is applied more globally.
Specifically it sounds as if the patch you point at is suggesting that
we'd tweak the boost value to something other than max but we'd still
have a boost value.  In the case of cros_ec_spi I don't believe we
need any boost value at all, so my patch would still be useful.  The
computational needs of cros_ec_spi are very modest and it can do its
work at lower CPU frequencies just fine.  It just can't be interrupted
for large swaths of time.


> IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?

I'm not totally a fan, but I'm definitely not an expert in this area
(I've also only read the patch description and not the patch or the
whole thread).  I really don't want yet another value that I need to
tune from board to board.  Even worse, this tuning value isn't
board-specific but a combination of board and software specific.  By
this, I'd imagine a scenario where you're using a real-time task to
get audio decoding done within a certain latency.  I guess you'd tune
this value to make sure that you can get all your audio decoding done
in time but also not burn extra power.  Now, imagine that the OS
upgrades and the audio task suddenly has to decode more complex
streams.  You've got to go across all of your boards and re-tune every
one?  ...or, nobody thinks about it and older boards start getting
stuttery audio?  Perhaps the opposite happens and someone comes up
with a newer lower-cpu-intensive codec and you could save power.
Sounds like a bit of a nightmare.

I'd rather have a boolean value: boost all RT threads to max vs. don't
boost all RT threads to max.  Someone that just wanted RT stuff to run
as fast as possible without any hassle on their system and didn't care
about power efficiency could turn this on.  Anyone who really cared
about power could turn this off and then could find a more targeted
way to boost things, hopefully in a way that doesn't require tuning.
One option would be to still boost the CPU to max but only for certain
tasks known to be really latency sensitive.  Another might be to
somehow measure whether or not the task is making its deadlines and
boost the CPU frequency up if deadlines are not being met.  I'm sure
there are fancier ways.

...of course, I believe your patch allows me to do what I want: I can
just set the default boost to 0.  It just leaves in the temptation for
others to require a default boost of something else and then I'm stuck
in my tuning nightmare.

-Doug

-Doug
