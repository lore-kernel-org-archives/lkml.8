Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A5C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279F72073D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alkj7wx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgARUKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:10:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52737 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgARUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:10:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so4784222pjh.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pTlazCNxUY2WnhqQUJW93zmqTNOLYC2EDHPWpa9mxbA=;
        b=alkj7wx06eVo+EteRZwj3oj8Dns2P52ChrKCK9d3GEd7UDNcf5dqbktNFIXEYlxhMM
         /CyZ4Z1u3J/QHRRxNAk48xF1D8NecB2e2Ojs4bF5nh6ERDsd9lrp8CCKLQgDqOmQ73ny
         IASABNUu4TllCxQGZl00hG3PRC7fm2QUGtwysN6h6vqmRR+nydIERhs4bPcNRSox/ts+
         vmvs118o8cKMsq7aTKYjpfFilnIt+IhtZ5qPmXacGM+odgdI+yqT7HofFBJ3ZDOR8WPQ
         NbBRJAkMd9tsCe83BgSOpUo5pfpgzzt06m89Zo5Mupn+TPU3Nrrk9GYXGro008oEOz2A
         IDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTlazCNxUY2WnhqQUJW93zmqTNOLYC2EDHPWpa9mxbA=;
        b=HZ0GUHFl7eTXvL1RF96pgwR130Ddt6/7M0qugl3OsKYOjWBoLgF45kStrae297vx80
         tsbK7DuVmKNN1SQrAIu+8q8YcuNNwJwLufkRf3bSBM/49QcwZZcRtDHYB4hqVtA4yTK2
         Oqps98M3QkM/46NbOWjbmN41h1rCJ/yIf80JEL+pkpuZ6RFRkzvUN0ZMBCVGzMs2QD1L
         pW43Cb6B4MYNm9XczmIFX7NFy2t/YbqvzF9rzUTwsJeWwaiJP/pyUuAQfY0ladtKzC9M
         HbaRRT0hIrfHN2bUHbYrmEs81VKw73U2ScseBf17YRBENm03X1pOHokurH2mP/F9nmX2
         DUtw==
X-Gm-Message-State: APjAAAUbGdTXrL/lfpUQSR34jYKitzrb3CJ99ASzDUaicSBfuKUHHpGZ
        zdvVBcfkAZNdgRY04oOPqjJB+Q==
X-Google-Smtp-Source: APXvYqwlqj9Dde4TU8hw6QRRZNwWNiqOrg/Jc8GxPylIlJqtwOqTYzwv4YKAYF1KyhX6b9Drx1qZ1A==
X-Received: by 2002:a17:902:bc85:: with SMTP id bb5mr6396764plb.208.1579378244210;
        Sat, 18 Jan 2020 12:10:44 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i3sm33490574pfg.94.2020.01.18.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:10:43 -0800 (PST)
Date:   Sat, 18 Jan 2020 12:10:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jari Ruusu <jari.ruusu@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>, johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org
Subject: Re: Fix built-in early-load Intel microcode alignment
Message-ID: <20200118201040.GH1511@yoga>
References: <CACMCwJK-2DHZDA_F5Z3wsEUEKJSc3uOwwPD4HRoYGW7A+kA75w@mail.gmail.com>
 <20200113154739.GB11244@42.do-not-panic.com>
 <CAHk-=wja2GChi_JBu0xBkQ96mqXC3TMKUp=YvRhgPy0+1m5YNw@mail.gmail.com>
 <20200115022705.GE11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115022705.GE11244@42.do-not-panic.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Jan 18:27 PST 2020, Luis Chamberlain wrote:

> On Mon, Jan 13, 2020 at 11:44:25AM -0800, Linus Torvalds wrote:
> > On Mon, Jan 13, 2020 at 7:47 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > So I'd like to determine first if we really need this. Then if so,
> > > either add a new global config option, and worst comes to worst
> > > figure out a way to do it per driver. I don't think we'd need it
> > > per driver.
> > 
> > I really don't think we need to have a config option for some small
> > alignment. Increasing the alignment unconditionally to 16 bytes won't
> > hurt anybody.
> 
> Since you are confident in that, then simply bumping it to 16 bytes
> seems fine by me.
> 
> > Now, whether there might be other firmware loaders that need even more
> > alignment, that might be an interesting question, and if such an
> > alignment would be _huge_ we might want to worry about actual memory
> > waste.
> 
> I can only envision waste being considered due to alignent for remote
> proc folks, who I *doubt* use the built-in stuff given the large size of
> their blobs... but since you never know, better poke. So I've CC'd them.
> 

I've not heard of anyone using built-in firmware with remoteproc, but as
you say firmware used with remoteproc is large. So I can't see there
being a problem of potentially wasting 8 bytes...

> > But 16-byte alignment for a fw blob? That's nothing.
> 
> Fine by me if we are sure it won't break anything and we hear no
> complaints by remote proc folks.
> 

Go for it.

Regards,
Bjorn
