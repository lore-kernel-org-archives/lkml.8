Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC80C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B75246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1kOoe0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgB0NSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:18:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39961 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgB0NSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:18:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so1171734pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tso06dQ5KURpIQbwzfLBnMB5Yciq8th0gVZxPZDPYR0=;
        b=A1kOoe0J2pr4Hm3yBkmJ/3llEgRRM7WGp0I+bw6LgoNvKSAraMZGmsJY8AOlzPo1SZ
         UxkxfNHq3Cq4NfrU7Vx9OPwr1tlRMjNhPjKqK9dYXIGHQ2aGMu90oHsbkJJtgDtlm2rk
         Do31YHlDAixtr0kHkDf4X43askJFQJGFc40Sjx9T30pOdpI1vCAcO2gR45CRenD0z56k
         rWdD8+xTgnwXZIQLzfyXkKXipXHcFvEzI9ukDptFzW1mlVzKwtOhhpxaiH1ZcXRr2OL5
         a0fpeFRSIp+aMEaVmvU8bhIMzJTHt6Te7Po7z8su2EW49fZ8+FZQwW3xRODe5RMErTKg
         /72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tso06dQ5KURpIQbwzfLBnMB5Yciq8th0gVZxPZDPYR0=;
        b=qgxOuLFGi3DDHX0X0rinizJos5l3DL3AwdAv7B6bBUXL3mZdpQLgkfgiC9sktd4iPB
         xublx2gEImyBki4eLRzBWg0MZEf8HLW1kYe1Lv9P0y3hR7AO6ZFPOupJIRQtZsSo3QXM
         M7i1GzRAqRQxU7/VsUcrgpEHX6oviptNj/yJmGNgFaLyZcg3K0zR6MCFqITP9FYNrjjO
         WXw3fJlLO8GgpchOMa41cdGO6Ih8fRl2NBEoPQoE2vkg8cUBzx5yqP53H0vKLBed/GY7
         1T8U5IHT4ATXDJYvsbR7bFkMA+N72JieaEZF4aU7vpyQa/OjPXzWY9alOWx5FSatE6wp
         h8tA==
X-Gm-Message-State: APjAAAV88sVSvMps71qSZiWVYlX7NxySGa+xofgiCWTS5t+uxdFEXPQb
        WtiJtzzd7BchExCJhfREodk=
X-Google-Smtp-Source: APXvYqzF7IoKdlTUwbggtc5n+VbV8IRrqbMxDjr5/cNKzt0gJHtjWrw1C+arbiUmtSvvC+KAHq0OoA==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr4559688plk.263.1582809533502;
        Thu, 27 Feb 2020 05:18:53 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id t189sm7203682pfd.168.2020.02.27.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:18:52 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:18:50 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 0/3] OpenRISC clone3 support
Message-ID: <20200227131850.GH7926@lianli.shorne-pla.net>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 01:26:54PM +0100, Christian Brauner wrote:
> On Thu, Feb 27, 2020 at 07:56:22AM +0900, Stafford Horne wrote:
> > This series fixes the clone3 not implemented warnings I have been seeing
> > during recent builds.  It was a simple case of implementing copy_thread_tls
> > and turning on clone3 generic support.  Testing shows no issues.
> 
> This all looks good to me. Thanks for doing this. We're getting closer
> and closer to having all architectures supporting clone3()!
> 
> You want me to pick this series up for 5.7 or are you going through
> another tree?

I am the OpenRISC maintainer so I will just send these through my tree during
the 5.7 merge window with you Ack attributions.

-Stafford
