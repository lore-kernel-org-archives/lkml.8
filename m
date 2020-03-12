Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E327A206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584012226;
	bh=mgqQ81KDhLWZBeim9rLO/VmD10zhmA8xiGYyKFo9DcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bSNfCLMKcVbb87owDWpBmKA8BcMdtvJUV9aQ04GLUEI1OLB16LwKYKsZ8dZhW9MXg
	 qru1aUGEl31By/438epP/MTnASikYQcjG4xitZ2+21V3nEHMiLf7Ng9/eXtFr5xXtE
	 brX5OCfeVVMstXPu+I2fFVvGkDqEMGbIUJL39ShM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCLLXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:23:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40124 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:23:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id 19so5947015ljj.7;
        Thu, 12 Mar 2020 04:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8aZKo7Q2cqRqibh5c2BV/6haAmX7g2ZMzNvIuDIe6Xs=;
        b=TyMc0wF8StKmepPEPnsdFhTTXLzwZHUosGKyBRq4WkbEyZNvu6A27F4C9l7tYJ57QY
         3EtrN+VRXBxJXiLz0h99zF5S3whRk02KjU/x9kO1/lqG0DpVsbkRzBhX0RpWZ5gDygkL
         PXuTmhdh2EHPd1WQbfzeibKKQm0xWOVFltiRp5akJkPGdigf6xvNTG3KOPrnpPU9Ph++
         h1vKSW7eQeDTgf9CpJHSm6Lyzgkc+DruhpGQVN8dId9mJf91ws3zm5H9XaGrXcYjkJXN
         2rAZmJF+TmQMRF5H63Rc/3XUHZ/U4BCp6sTNL2KP+agwK0tZVqn/7lgXmC2LkzfQJXiV
         5JZw==
X-Gm-Message-State: ANhLgQ1nDyAKUHsqWQaDTujfzDBbfNHRjUf9T4UKNin4WqRRLvzq8oQi
        Q/DbwLh6ywP0MXZXl5XtfvE=
X-Google-Smtp-Source: ADFU+vsCAl+/iukSnAL7ZY+TR9w4fgriCQ+WchBtcxuaJ3FfNHYfeYP25Ngr4meXpQzPXNd1vtbE8w==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr5034584ljo.80.1584012222136;
        Thu, 12 Mar 2020 04:23:42 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id f26sm26589790ljn.104.2020.03.12.04.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 04:23:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jCLw2-0005pa-1h; Thu, 12 Mar 2020 12:23:30 +0100
Date:   Thu, 12 Mar 2020 12:23:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sean Young <sean@mess.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/6] media: fix USB descriptor issues
Message-ID: <20200312112330.GO14211@localhost>
References: <20200103163513.1229-1-johan@kernel.org>
 <20200214080254.GK4150@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214080254.GK4150@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 09:02:54AM +0100, Johan Hovold wrote:
> On Fri, Jan 03, 2020 at 05:35:07PM +0100, Johan Hovold wrote:
> > This series fixes a number of issues due to missing or incomplete sanity
> > checks that could lead to NULL-pointer dereferences, memory corruption
> > or driver misbehaviour when a device has unexpected descriptors.
> 
> > Johan Hovold (6):
> >   media: flexcop-usb: fix endpoint sanity check
> >   media: ov519: add missing endpoint sanity checks
> >   media: stv06xx: add missing descriptor sanity checks
> >   media: xirlink_cit: add missing descriptor sanity checks
> >   media: dib0700: fix rc endpoint lookup
> >   media: iguanair: fix endpoint sanity check
> 
> Just sending a reminder about these as it seems only the last one has
> made into mainline (and stable) yet.

Another month, another reminder. Three of the above patches still hasn't
been applied.

Johan
