Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562FD2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4nP7v7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFLJZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgFLJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:25:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B0C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:25:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so9014377wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIO9UrjV3PHuFBsYgnQeDXYIPOYXUBbjknG+ILWYaCA=;
        b=O4nP7v7bSFuN+S78LBZPLJYv7jhujTRoFyuIPCXwniTgyrKpxgciGezh5flwTJE1Pk
         0EFgGn5B4w4DIzCtSqZdcnWGxOaqUM2EIS1ud6h2q4xzsCB+xi935Sg6TiqlewCKmWx3
         i7tnaLevovWOe3BeTtk8q8YnNS6axl7pEo+S7KWhGJUpJV3g/OTYFYhXJBubvlz8UbYt
         JsyMiMMKZlOtrySSweL7DNX8DsrxGpYGIu2Sw86kIWniFy9BXFGrnPCLWDISxtcvT/Go
         PKX5p6UB5SNSK8snYAgk2YmPt3LppOygwZWXWHTR2Qw/9EREwgqjoAQuOxuKHR3uFnEy
         L53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIO9UrjV3PHuFBsYgnQeDXYIPOYXUBbjknG+ILWYaCA=;
        b=ldSKLHCEJUskLU3Vn/HQM/lifmvj69LMLK6Xvu20JWqJcdVjd0NmmPMUPVXfhMKVqd
         OaynJSRgbqmX10D+xPx8lXqMP52/Mp5Z1LKKjd1p3hicYhEpQuvXZe+FAxTMyzY30/PV
         IOAh8wCatWfiE87gB7g8n7DpVPbIdkchSg/CyunIaAerXTwWutqVLTNK+sBnZmT8s0bz
         9M0VeDGTikY86vCzdk34e0EzZuXg04qRHG0P4b8EsyOiFRYdRTuaiqwWEpxjhh13bymU
         j0Eoq/GRuirivam3cJ8n9g8uuk+FXBtbN2z4lFPCf9vkf2H3IrEHayc8LWQ2kYVDnPRW
         VvVg==
X-Gm-Message-State: AOAM5319nPEgLyDRzXer4pawqlLE3okR0oqPrQdOA00o7JgXvxTASpct
        aAOV3VJHZGtPFmaEII4CHhxh0Q==
X-Google-Smtp-Source: ABdhPJzAi/S5HGNOc/mJunBVYDzl7gc5LyR5cCN/qlYilhdL2fxXhO0I8AWjCKtZsGZ1eEUnolzkiQ==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr14121614wrt.359.1591953898389;
        Fri, 12 Jun 2020 02:24:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id k64sm8190943wmf.34.2020.06.12.02.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:24:57 -0700 (PDT)
Date:   Fri, 12 Jun 2020 10:24:54 +0100
From:   Quentin Perret <qperret@google.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, qais.yousef@arm.com
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200612092454.GA94228@google.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com>
 <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Qais [FYI]

On Thursday 11 Jun 2020 at 10:48:40 (-0700), Doug Anderson wrote:
> Hrm.  I guess my first instinct is to say that we still want this
> patch even if we have something that is applied more globally.

Fair enough.

> Specifically it sounds as if the patch you point at is suggesting that
> we'd tweak the boost value to something other than max but we'd still
> have a boost value.  In the case of cros_ec_spi I don't believe we
> need any boost value at all, so my patch would still be useful.  The
> computational needs of cros_ec_spi are very modest and it can do its
> work at lower CPU frequencies just fine.  It just can't be interrupted
> for large swaths of time.
> 
> 
> > IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?
> 
> I'm not totally a fan, but I'm definitely not an expert in this area
> (I've also only read the patch description and not the patch or the
> whole thread).  I really don't want yet another value that I need to
> tune from board to board.  Even worse, this tuning value isn't
> board-specific but a combination of board and software specific.  By
> this, I'd imagine a scenario where you're using a real-time task to
> get audio decoding done within a certain latency.  I guess you'd tune
> this value to make sure that you can get all your audio decoding done
> in time but also not burn extra power.  Now, imagine that the OS
> upgrades and the audio task suddenly has to decode more complex
> streams.  You've got to go across all of your boards and re-tune every
> one?  ...or, nobody thinks about it and older boards start getting
> stuttery audio?  Perhaps the opposite happens and someone comes up
> with a newer lower-cpu-intensive codec and you could save power.
> Sounds like a bit of a nightmare.
> 
> I'd rather have a boolean value: boost all RT threads to max vs. don't
> boost all RT threads to max.  Someone that just wanted RT stuff to run
> as fast as possible without any hassle on their system and didn't care
> about power efficiency could turn this on.  Anyone who really cared
> about power could turn this off and then could find a more targeted
> way to boost things, hopefully in a way that doesn't require tuning.
> One option would be to still boost the CPU to max but only for certain
> tasks known to be really latency sensitive.  Another might be to
> somehow measure whether or not the task is making its deadlines and
> boost the CPU frequency up if deadlines are not being met.  I'm sure
> there are fancier ways.
> 
> ...of course, I believe your patch allows me to do what I want: I can
> just set the default boost to 0.  It just leaves in the temptation for
> others to require a default boost of something else and then I'm stuck
> in my tuning nightmare.

Right, so I am not disagreeing at all with the above. FWIW, I expect
Android to set this default value to 0 as you mentioned, so that uclamp
basically becomes 'opt-in' for _all_ tasks, including RT.

Now, given that Qais' patch is commiting something to userspace, I think
it makes sense to expose the full range rather than a boolean value, as
it's probably more future-proof. That is, if we expose a boolean knob
now, and somebody wants to be able to set a default value in the middle
in a few years, we'll have to add another knob, and maintain both (which
sucks). But it's just my personal opinion. Feel free to jump in the
other thread if you feel differently :)

Cheers,
Quentin
