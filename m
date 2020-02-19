Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A566C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3055221D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuoJJ18K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBSMbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:31:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46457 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:31:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so258535wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xWzztMTzhqfpMp/oxkFfq6/jzPcps3NnPgi8EJQA1qU=;
        b=iuoJJ18K2W1MdBJOFUOoIv+RAmQbMi1/+2amFZ68XZzhA2ydvwyWzwb3cnyMs6M0nq
         EjQ0bJ8Kd6VFpN7T47eKHwNEWG9koVSDNuSH0E3DOxl4wUBlPxhEDbxGHxTeQ/y2cr7u
         Qhl/A1h35CdccaG6txx1HTzPH3/RnYnMazrYlauKJn4k0Qarn4mancJIq5VhPbdhjJJg
         mstJdE39eCWKzohs0cxiiy5dFAEdzQs/SYX9AuDTKyVDnWxbiswelBeYN2mE/qi25YPK
         6uGgF8Lw/8dUSrwY/za/FTs16IbHTD9oD+z90ZE0rJZvLEwrhALHlaNd75C6eN6iMqAM
         X0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xWzztMTzhqfpMp/oxkFfq6/jzPcps3NnPgi8EJQA1qU=;
        b=Ekn6xOWtDZYv4KbUX87FSl77BNu0+DwDQItrFodLk4eTv4K03FKFkTQtTFJYHlt/Ox
         AzosO8kEAVWGvA0+2VChyJ4kvdO3+7wp3RkOeB8stH4Bs87PiMyPgcgb4KoD+dSVS3kO
         dgutXRwqWePURQKg/hi1mfKhtGWLc83khCQozrQ1/yo/lxJXvsyt1GMir+Rd0xHTXxlu
         mTjnHsDnlDj+JdUWTxBXm/APtYcxCZz2oVZFYq6TqAiEbulhclAqLjo30+/5903Zk1tt
         Pfsv/swI4GD77YHkFdizrukrQmESvdnQMYakTNEoMCBQ4R/NkKavNvD3WWIBjOv9ahrK
         niPQ==
X-Gm-Message-State: APjAAAVnrKKlPcLH98IbwHpeK25+ZzQRZOkP6oTGkoNFOGkTbyL2IvOD
        JAQ2+extD2vngi+xhKya6eIpGQ==
X-Google-Smtp-Source: APXvYqw2N0uh7U0WFn+dX6qGxFk0SOMqL1r7sW2kuNzsK6krw72sZejr4NG0O/o50wMY7lQjMEbaew==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr35221069wrp.112.1582115464128;
        Wed, 19 Feb 2020 04:31:04 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id k10sm2736543wrd.68.2020.02.19.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 04:31:03 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:31:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200219123130.GE3494@dell>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
 <20200123092639.GC4098@ediswmail.ad.cirrus.com>
 <20200123114805.GA5440@sirena.org.uk>
 <20200123120240.GD4098@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200123120240.GD4098@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020, Charles Keepax wrote:

> On Thu, Jan 23, 2020 at 11:48:05AM +0000, Mark Brown wrote:
> > On Thu, Jan 23, 2020 at 09:26:39AM +0000, Charles Keepax wrote:
> > 
> > > 3) We could look at doing something in regmap IRQ to change when
> > > it does PM runtime calls, it is regmap doing runtime gets when
> > > drivers remove IRQs that causes the issue. But my accessment was
> > > that what regmap is doing makes perfect sense, so I don't think
> > > this is a good approach.
> > 
> > Why do you even care about the errors?  It's not like this device is
> > going to get removed in a production system and the primary IRQ will be
> > disabled when the core is removed, this is just something that happens
> > during development isn't it?
> 
> I am more than happy to do the leg work if we really don't like
> this solution. Do either you or Lee have any thoughts on my
> selective MFD remove helpers? That seemed like the most promising
> alternative solution to me.

It's hard to say without seeing your implementation, but it sounds
okay in principle.  Depends how messy it all ends up getting.  Sounds
like a scenario where a reverse -EDEFER_PROBE could be useful.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
