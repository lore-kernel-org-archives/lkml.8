Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D58BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140792467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAoClRy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgA1O6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:58:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40214 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgA1O6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:58:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so6741252pfh.7;
        Tue, 28 Jan 2020 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xVg7yvmtWgmr43KxLTmI3D7lMD6VbKHeVc6c1ksu9WU=;
        b=cAoClRy3JAZUhXmD5tD9S6sAgFkmXeMAWWyZj4AyoV+mQvhmXqkmysZ/PpYCpQMh4q
         8URdcdKQjwDsls1KxHWOxtxJs9XXcM5qF6IluaXDwPXEre3psp1G3a+T5Szjt/gPDOKg
         Lba5C4uWOILvq46slE+w3i+qqsxfGe3CwCTqQiHcKGjPEjd8qBGPadaQPhkAeRmusLf4
         YMCDIEgpzRKl9cBTa1EYKwF+HoBNNiOxh9VdbuT8aai/yBMXWC5DtJnnWKy5kVEqwA2U
         wF4V2/UN70Gq8OEmZd7yA+tb5TMmL6/imGvzthSSzdfv7+0L916YpT4Axr0cgaJrPDjA
         HI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xVg7yvmtWgmr43KxLTmI3D7lMD6VbKHeVc6c1ksu9WU=;
        b=mzUx85DuAa1DI4wWFvUvecT9d9lUxqcEk6TELwEnjsaVyqafocH21WcTZt4AXClyYs
         6uuP7rgxDOoPbhsUwyCFR2nGgFVuQI4Jao1hOyQUvJGHmHx3FzU91Lqqg47EtVfIF0lM
         IHtm8jQ7OjQ5KKeRUwUVjgqBmXNOifGvxi2DPpMk79OkFvLSAB5+P0b/7HWkdoF+9PdD
         sVBIr3XKuQVFSf150eXcNyVMlfKkD6FvaLWsNF1rG+IxrdLFmXSPnruO3Ovg10z0himG
         oEjdeI5Z+VAO4CTQHYHLDK/G+djpDpwcGfbv/JUdKRXw7R7RAHul0/b/Fd4tvcAWrZZ8
         x1Iw==
X-Gm-Message-State: APjAAAXd4NMJlB+izLHv9X5L48It0QdXs0D4HHAe4Df7d9sHa0gcFDOK
        5jSoesoEINDl2z/SacvPnaA=
X-Google-Smtp-Source: APXvYqxNf1EXoNBaASlV1mmB+s43Ce4o89OK8f/drmebdoVYbgswj1SeuD+turU5RtHfze5RRLx7Qw==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr11059341pgq.102.1580223490422;
        Tue, 28 Jan 2020 06:58:10 -0800 (PST)
Received: from localhost (c-73-241-114-122.hsd1.ca.comcast.net. [73.241.114.122])
        by smtp.gmail.com with ESMTPSA id x7sm20743774pfp.93.2020.01.28.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 06:58:09 -0800 (PST)
Date:   Tue, 28 Jan 2020 06:58:07 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v1 4/5] ptp: 1588_clock_ines: add unspecified HAS_IOMEM
 dependency
Message-ID: <20200128145807.GA2492@localhost>
References: <20200127235356.122031-1-brendanhiggins@google.com>
 <20200127235356.122031-5-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127235356.122031-5-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:53:55PM -0800, Brendan Higgins wrote:
> Currently CONFIG_PTP_1588_CLOCK_INES=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> /usr/bin/ld: drivers/ptp/ptp_ines.o: in function `ines_ptp_ctrl_probe':
> drivers/ptp/ptp_ines.c:795: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>
