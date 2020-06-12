Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EF2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9147D20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrSl08+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFLNra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:47:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B7C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:47:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so9783978wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRGSaoaZXAME28NoyxgD/FZqB6wuHhSggY6fzT6nWF4=;
        b=qrSl08+LFjVLPVlqix58AoGdl8qP7msVljgP0k0oI8DW1wKfoNerfLHGE3b2+QdLw1
         wSMJ5VoewY6Vral8iG8AACybnjl8MKml2VoKlXX7z3uMjxVModSVy0HFmmZ01KNRz+hN
         up1RjPsufCbFlZn65HtBts1MLg8tTKOv3b+ZWjv1A2lotc6WygTiV22qX+3hZp5GW9UW
         SDW0kuG3xy8dkOdOm1Q44i4FYiR8xa9JScurdYyVuA3a4/ahxQOlKvZUACBTEy+LBsw8
         iRsTdB6vMOzb9iOT3cL5c418aWjFyvPfDWv/5/eIP3c3Xnvy2CDiwzT3iypZMENcbG8j
         LZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRGSaoaZXAME28NoyxgD/FZqB6wuHhSggY6fzT6nWF4=;
        b=Hm9Rr+rXi1IWBx7E8VXLbqd5PAwOkO27tNni3SZSElw74c6o4ugLB0ZasFcfnUbpgE
         ZARq1CLKa7il9qxqtgbLVyPhgfYLbmp1LRt7IQtO+ZfkuABexiVIqLhWajC6K/RA6f/Q
         dyXeDTxVqfB+GBL3ILmjR3JlfI9FJADgiJHKHXj5LLZRdlj57mWDyGUwVWYxX+AoT07t
         PDxrtvUTCWAryQX/rX7aW1vwgrRe46MvGMZgaUz11hEIHelsQs0naeuVZliMVx6r/LvB
         64vl396Klaqygfqy4p/RQLEbhEX/+bmHLfW4hWcRO1nLv+7qLtkNhcavnNRLtC6s+d3Y
         nQCA==
X-Gm-Message-State: AOAM530n7hyyCRnHfQetA2BDVf8eqKdqECyg4QLj8gU8+wmvHePOmTSB
        90BwoKvDs3FqBG0SUVaf6zn06g==
X-Google-Smtp-Source: ABdhPJxYZXjECba+nbE9tk2s6BTEOkK7Zvtj8zBoTmkEQculfoPOyyOWcljy/pVOGks04A4LAA3pkg==
X-Received: by 2002:a5d:5489:: with SMTP id h9mr14678096wrv.125.1591969645858;
        Fri, 12 Jun 2020 06:47:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a16sm9881227wrx.8.2020.06.12.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:47:25 -0700 (PDT)
Date:   Fri, 12 Jun 2020 14:47:21 +0100
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200612134721.GA142550@google.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com>
 <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
 <20200612092454.GA94228@google.com>
 <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Jun 2020 at 13:34:48 (+0100), Qais Yousef wrote:
> > On Thursday 11 Jun 2020 at 10:48:40 (-0700), Doug Anderson wrote:
> > > I'm not totally a fan, but I'm definitely not an expert in this area
> > > (I've also only read the patch description and not the patch or the
> > > whole thread).  I really don't want yet another value that I need to
> > > tune from board to board.  Even worse, this tuning value isn't
> > > board-specific but a combination of board and software specific.  By
> > > this, I'd imagine a scenario where you're using a real-time task to
> > > get audio decoding done within a certain latency.  I guess you'd tune
> > > this value to make sure that you can get all your audio decoding done
> > > in time but also not burn extra power.  Now, imagine that the OS
> > > upgrades and the audio task suddenly has to decode more complex
> > > streams.  You've got to go across all of your boards and re-tune every
> > > one?  ...or, nobody thinks about it and older boards start getting
> > > stuttery audio?  Perhaps the opposite happens and someone comes up
> > > with a newer lower-cpu-intensive codec and you could save power.
> > > Sounds like a bit of a nightmare.
> 
> Generally I would expect this global tunable to be part of a vendor's SoC BSP.
> 
> People tend to think of the flagship SoCs which are powerful, but if you
> consider the low and medium end devices there's a massive spectrum over there
> that this range is trying to cover.
> 
> I would expect older boards init script to be separate for newer boards init
> script. The OS by default boosts all RT tasks unless a platform specific script
> overrides that. So I can't see how an OS upgrade would affect older boards.

I think Doug meant that the device-specific values need re-tuning in
case of major OS updates, which is indeed a pain. But yeah, I'm not sure
if we have a better solution than that, though.

> This knob still allows you to disable the max boosting and use the per-task
> uclamp interface to boost only those tasks you care about. AFAIK this is
> already done in a hacky way in android devices via special vendors provisions.
> 
> > > 
> > > I'd rather have a boolean value: boost all RT threads to max vs. don't
> > > boost all RT threads to max.  Someone that just wanted RT stuff to run
> 
> If that's what your use case requires, you can certainly treat it like
> a boolean if you want.

+1

> > > as fast as possible without any hassle on their system and didn't care
> > > about power efficiency could turn this on.  Anyone who really cared
> > > about power could turn this off and then could find a more targeted
> > > way to boost things, hopefully in a way that doesn't require tuning.
> > > One option would be to still boost the CPU to max but only for certain
> > > tasks known to be really latency sensitive.  Another might be to
> 
> per-task uclamp interface allows you to do that. But SoC vendors/system
> integrators need to decide that. I'm saying this with Android in mind
> specifically. Linux based laptops that are tuned in similar way are rare. But
> hopefully this will change at some point :)
> 
> > > somehow measure whether or not the task is making its deadlines and
> > > boost the CPU frequency up if deadlines are not being met.  I'm sure
> > > there are fancier ways.
> 
> You need to use SCHED_DEADLINE then :)

Well, not quite :-)

The frequency selection for DL is purely based on the userspace-provided
parameters, from which we derive the bandwidth request. But we don't do
things like 'raise the frequency if the actual runtime gets close to the
WCET', or anything of the sort. All of that would have to be implemented
in userspace ATM.

Cheers,
Quentin
