Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC9FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8280E206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589439893;
	bh=ovxNtapxmI0nCn8QNtZeDRLQLgwKTYUqiXwGSyP3pfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lbSAlv4IUNp7BKG4vd617zjHnb2A6cnnI3VoW1JMnIEug1wRarOmFCPvFI7MBtpaL
	 N4p9a6MQzqi2aArfqJ6OBObBhsl9FaQm9CXQAmw9DwoU6bHgYLGr4d7WqdoN7LutxA
	 wnt/cHET/m5hTPyyceUxwHloyBBlH0wm0QAfTQOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENHEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:04:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44989 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgENHEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:04:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id d22so1647866lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9WnzFdmVQbheZ8Ai9Qer5xXiDc1MgImnC5EGlPBIDA=;
        b=qoqgLgMkbrsTqv/ML9/jQxZ3Nj/LrMXhkEWfwJEMHEFOB6H1YwF93j+g3Xi+cUQJdj
         +ktzZcIUs3e45Zzjl4LyNFO6QQOURnxU/J7OlEjYZBoyXOjlA/70riyAs8lIR8Fl23Pt
         7oOIDT1/ENJvp5p9rDQjhZyFpjbtk0w+yCqTS+qwaVEt+Y0wuekQFUurzpTq0imZAW1p
         umDp23Mqi6SHAvZsA1MoLLwaQPpK4CAYISlFVH5+KahrJ+jPaN5tqn52Tw4h0yVNfxA5
         QOIlvMwIvqMluaLHyMSXJSU4cggxBy9JKW6F/WFS0uEkjnSmX7ZsYUBdXN51TUPnX37D
         Uncw==
X-Gm-Message-State: AOAM532kqBzpj02rKqzorzrwnbd172QHs4oh80Jo1RfElnjehMxZFoMY
        4fiTCwr7188Sy4f+J76PW9o=
X-Google-Smtp-Source: ABdhPJzbhRRGhNeIlXT1SpAvrdP+VLu4RYUXW0vcX5PRMC55VImUYwDNmGzuxiMOD5YnC/GXLi5E5A==
X-Received: by 2002:ac2:5542:: with SMTP id l2mr2220386lfk.113.1589439889686;
        Thu, 14 May 2020 00:04:49 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id c20sm937831ljk.59.2020.05.14.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 00:04:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jZ7vA-00018d-2b; Thu, 14 May 2020 09:04:44 +0200
Date:   Thu, 14 May 2020 09:04:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Lin <dtwlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Haslam <ahaslam@baylibre.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@google.com>,
        Johan Hovold <johan@hovoldconsulting.com>
Subject: Re: [greybus-dev] [PATCH] greybus: uart: fix uninitialized flow
 control variable
Message-ID: <20200514070444.GB25962@localhost>
References: <20200429190022.12671-1-arnd@arndb.de>
 <7146e1ca-1fc7-61ab-e798-7b017c7c974b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7146e1ca-1fc7-61ab-e798-7b017c7c974b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:00:44PM -0500, Alex Elder wrote:
> On 4/29/20 2:00 PM, Arnd Bergmann wrote:
> > gcc-10 points out an uninitialized variable use:
> 
> Wow, nice, checking individual uninitialized fields within
> the structure.
> 
> The structure should really be zero-initialized anyway; it's
> passed as a structure in a message elsewhere.  With your
> change, all fields in the structure are written, but in
> theory the structure could change and stack garbage could
> be sent over the wire.
> 
> What do you think of doing this instead?  Or in addition?
> 
>         struct gb_tty_line_coding newline = { };
> 
> (Presumably that would also silence the warning.)
> 
> I endorse of your change, either way.

Looks like Greg ended up applying an identical version of this patch
that was submitted this week instead.

Taking a closer look at this code I noticed we have two versions of this
line-coding struct which are supposed by be identical, but which could
get out of sync (and have once already it turns out).

Johan
