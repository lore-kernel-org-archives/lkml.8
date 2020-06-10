Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C069C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8612070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg2M/C6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgFJTUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFJTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:20:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF613C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:20:52 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c14so3184064qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gkvfxUP+ZGpQ9yo7tiW4XvIcLynrm+gZRuYO90l403o=;
        b=Hg2M/C6n9F8VBzvBH4OGC4g0h9kbarxfj4j3mDUbSB7q/AbmH0tO6oPwMhGiwKBRkb
         Lym8twgrOWioQl3oUZ59aQIbNhpLtBpPhXepP5jBzdy/YlxBKj7EZAA1rrNu8tco1DJL
         S3ww9Uq7TBLFUTEBHJQy5sA8muGn9gc0kNQUVY//DZ5UaDPdU3JkxAqWkv/WpqKuWBuK
         At7FiLIqYEiUtRKs4G1nrFpB+WnoOSI0bhtkVgSkweS5n5URs0KWG0Z3d0oE4z8ATdfE
         h/xsIwCFxjrGSF6V4G68g5OADpUg+O86pFv1skZvL5JBCnmClho74vygZSf3/rbGeEQF
         jUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkvfxUP+ZGpQ9yo7tiW4XvIcLynrm+gZRuYO90l403o=;
        b=Owz6ZZs9qrorQy+Fibe69Hz+Y8FfGIUVWfjSZ6uWndSUK06tacEUEHIsy7eou/UwvB
         In+mrnS6KtOkXtVPRzX8UPXG9dATueHFATkhiq+RSONUi4EbIc/c8fX6o9umLvsiWY7W
         zyTN/6OFogGv13sn4Lf8vyzlvzTjn2CcOMv/lZFD+pde0Q5ssWe29PASHnNW4SWPboxN
         b05o9F6PLFcqj1DX9dO1qz9NHY2a7OgCX5OPc6HY8Mpyr/f7cQK/HEkzdvpjAcscFVDo
         oiYXPhCWZk4yAQLmpESmFQ+G44I6w784JWIZCxHCfWZyZnV/tC4jQCV4MZpDGO+V9HQI
         h9mg==
X-Gm-Message-State: AOAM530C+ZlULJ8DvaS33USOGml3th8cfW8RFcefzgKP4UGvm7Q+pgG5
        nt5aLv3yPt2eyICCveDxnOc=
X-Google-Smtp-Source: ABdhPJwU2Jx5i3xpWvnmDT02RDeWFGBbOySoYhi11uAOl9RdEcTNXVqzFnS0k2Hft7oAeFkb/4KrdQ==
X-Received: by 2002:a37:aa87:: with SMTP id t129mr4757802qke.197.1591816851911;
        Wed, 10 Jun 2020 12:20:51 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id b21sm474161qkk.61.2020.06.10.12.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 12:20:51 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:20:49 +0000
From:   Rodolfo C Villordo <rodolfovillordo@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
Message-ID: <20200610192049.GA11463@ip-172-31-24-31.ec2.internal>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
 <20200608054614.GO23230@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.2006080758510.2430@hadrien>
 <e3d7cc965eccec881bc35ae18d63f4bc23c33dfc.camel@perches.com>
 <20200608225838.GA26559@ip-172-31-24-31.ec2.internal>
 <c25f5af83658ab9ef4ae8ef3825ea6540fe4e094.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25f5af83658ab9ef4ae8ef3825ea6540fe4e094.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 04:33:06PM -0700, Joe Perches wrote:
> On Mon, 2020-06-08 at 22:58 +0000, Rodolfo C Villordo wrote:
> > 
> > How should I move forward with this?
> > 
> > 1 - Update this patch with the changes pointed by Dan Carpenter? 
> 
> Keep your changes small until you really know how this
> style of linux kernel staging changes is done.
> 
> > 2 - Do a more elaborated and bigger change, like suggested by Al Viro
> > and Joe Perches?
> 
> A patch series is much preferred to a single large change.
> 
> If you decide to refactor various functions, please do that
> in separate, discrete patches.
> 
> Adding a #define and doing a sed like:
> 
> $ sed -i 's/(BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW/AL2230_RLEN_CTL/' drivers/staging/vt6655/*.[ch]
> 
> should be a single patch.
> 
> And if you do that, another should be done for AL7230
> 
> $ sed -i 's/(BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW/AL7230_RLEN_CTL/' drivers/staging/vt6655/*.[ch]
> 
> etc...
> 
> Maybe the #define BY_AL2230_REG_LEN should be 0x17 so that
> the << 3 is more obviously constrained to the low byte
> 
> Maybe the + uses in the macros should be bitwise |.
> 
> Go wild after you figure out the process, just keep your
> patches to obvious, small and verifiable changes.
> 
Thank you so much for your comments Joe. 

I'll take off this patch and focus on these other changes.


