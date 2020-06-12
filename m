Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA133C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8564920691
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhXfN3AB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFLPhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:37:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7070C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:37:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so4463686pfx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yeQePqg3uWAwrie1fUmEupGOkhDXHe9EBr4w1yLk0WI=;
        b=OhXfN3AB8RZ9P+/tL0HI8nayoWUxdl956odNAbxbgFNQnDcB0NrFtAFhFM4Dj8pWCM
         t3QKzk7C1GXr731BMbQdOe5yt0G5m8VSAp6wYHBRXLeF6sogLntHKxC4mlVkuQuOCQgB
         fUfHsLR5S7YsIyHs7tWJUQJ7LsGYJXLqT5Ls3P5dqNr6vPBS8tR3GSeq5zzWOHCIOgR8
         bYH5khodwPW6SrRuQ5kYp8N/VkE6StVpyG6Tp2RLdyHTfK5rffkraKb46aQdFQePecyY
         OhLTzwyZpzd5WQU+a3oMkRxZcl4ZLwkWvGyeYflfcs7Crq2X8DBG5UdesonwEFd+35UK
         AlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yeQePqg3uWAwrie1fUmEupGOkhDXHe9EBr4w1yLk0WI=;
        b=kyrZCdEmAQHF7bow+vrMtyJAYGDyxeB9jkpx8ilalYYVrIrGvlJCnpC8kxZiWpwTrO
         weaLxLjpRmJ/C4loxkxPpScfqV0qP2Vg4RFhSF+hi3NhTUklnaRQRBBdgq1fZJtoG54N
         up+/ioR0IL89pNaGBtR2keFn2T2whWREfGn3G+FSlmOqLWDooX82D9xq4TdIyijomohr
         7k4lb4vL7Q9bULAi8cGoFQjC643bYUjqag/CiiG7GqiJ4JvvhvcOOYdvxx112bRgY5Sk
         V9DLyHf+ZWGaCje59k5NsFnOl9oquqCq9elHxwRMTTK6mUW8dSLkI0sC85RS+Djue6Na
         2sgA==
X-Gm-Message-State: AOAM532Vf8v0h2xTSO45NZHeFFjudSJQQI9QBGTDxdkj5yZlXz7j8pzw
        kSfJsiWxWt09yw7JdIorVcA=
X-Google-Smtp-Source: ABdhPJx3K+XSpLrzivT/rI9+MH+R35M6XFdycVvYMHz1m+33OwfD46jZYe6e76uYodfTAJXUy5H9gQ==
X-Received: by 2002:a63:9347:: with SMTP id w7mr11155653pgm.409.1591976252287;
        Fri, 12 Jun 2020 08:37:32 -0700 (PDT)
Received: from gmail.com (jfdmzpr06-ext.jf.intel.com. [134.134.137.75])
        by smtp.gmail.com with ESMTPSA id 140sm6457374pfy.95.2020.06.12.08.37.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 08:37:31 -0700 (PDT)
Date:   Fri, 12 Jun 2020 21:07:24 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200612153722.GB26807@gmail.com>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
 <20200610182322.GC21465@gmail.com>
 <20200611082616.GA4671@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611082616.GA4671@sirena.org.uk>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 09:26:16AM +0100, Mark Brown wrote:
> On Wed, Jun 10, 2020 at 11:53:24PM +0530, Vaibhav Agarwal wrote:
> 
> > With patch#6 in this series, I'm proposing some of the (dummy) helper 
> > APIs required to link DAPM DAI widgets for the GB Audio modules 
> > added/removed dynamically.
> 
> > Eventually, I would like to propose relevant changes in snd-soc APIs to 
> > enable dynamic linking of DAI widgets for the modules added and 
> > remove/free component controls for the module removed.
> 
> > I'm seeking your opinion on the proposed changes. And as per the 
> > recommendation I'm sharing the changes with ASoC mailing list as well.
> 
> These are proposed incremental changes to an out of tree driver that has
> never been submitted.  I don't know what the current code looks like,
> what it's supposed to be doing or anything like that so I've no idea
> what's going on or why.
> 
> > Kindly suggest me the preferred way to follow on this thread. 
> 
> This is effectively out of tree code, until someone submits it properly
> I'm not sure it's useful to submit incremental patches upstream.

Thanks for the suggestion Mark. I'll create a separate patchset aligned 
to the ASoC tree in next ~2 weeks and share them separately.

Hi Greg,

Do you think the current patchset can be considered for the purpose of 
resolving componentization issue raised by Alexandre?

--
Regards,
Vaibhav
