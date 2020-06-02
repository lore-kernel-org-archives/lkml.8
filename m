Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA23C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CA820738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhgsM9iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFBI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFBI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:59:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B9C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 01:59:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m21so9409439eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3H7xUAxDIV492pf+xpLGSX23/17GnpDs0cq3NBGktLM=;
        b=rhgsM9iUAuh9JU1+ADlPV/IhOgbmy1ylfxitvFBlq987YnbyFO+CC98BD5g+fMxeTJ
         rr1zQT0K5MxkqbWNtDSydlH3xQyJWWJq9qJ75KesZxnCdP6HKvi5e3XCYR3xrV3mKI0M
         bnOP43YOoOYMEWh1AzhASUolMDLPyYjvRKLcu8oWo1UrU1j10OQEghsHI6PzVkYJcbev
         w4fV+1OpIhp+PdbBg06Qh9jE3/keJn2djpt8D6ujIIX2Ez0b53YD6yuH49sf24w+6Lk7
         yee1ADJCQlN+1ra6cvLzrVZ0imASeuY7bVn6H7jVkzS+Hq5CAsWtMgPXwh2JAoniZO+s
         2YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3H7xUAxDIV492pf+xpLGSX23/17GnpDs0cq3NBGktLM=;
        b=oWefjEFpODj1FxO6ALXwbfXUgdzddOKaKvuDEb10aiTvdet6tx8znZMh7x4JwL/5WW
         5Oj5rWenE0HBnn+3iINE/gj0+t4mlWCq5T1T0hKZzlql5zT12yK9AN2vnuaI6Y8r7vGn
         tZ+I6JXXfm1oWWsj8RSg29jo47bkKf2MWBUlFveVSB8R/I7Vkr+TKK8NHUsTDxg3xbDD
         jpKJESYW0Bv1oh15FO6TW/TO5oFNVz01xcaJGsUtJiYPCSMkgYNPOwJNbQS5brzFG9ux
         UUgVVA6TOTxyHGzohI4r2Wok15QvMjgDVPVRwyQLS1bjhwuIRIOT+m2As0ZWh9YMSdjC
         c8bg==
X-Gm-Message-State: AOAM532MjLYEAwL3d+XZ0Wy5IWknv3bN6vHcfGYUQX5Sq2aRiysD6O02
        eQFBoXyoo5LjrxOxtE8xsRQ=
X-Google-Smtp-Source: ABdhPJx2NTksfyGytSlAr7jnghHLiOJQmPA8RgLMrtA2/H0poqMIJPzAz7P+wn+rfYKXR8h+wyT0YA==
X-Received: by 2002:aa7:cb8d:: with SMTP id r13mr24946658edt.12.1591088390713;
        Tue, 02 Jun 2020 01:59:50 -0700 (PDT)
Received: from ubuntu-laptop.micron.com ([165.225.203.62])
        by smtp.googlemail.com with ESMTPSA id b16sm1222984edu.89.2020.06.02.01.59.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 01:59:50 -0700 (PDT)
Message-ID: <aabedbd547708a52b8bf8e0d10ba10e994acb54f.camel@gmail.com>
Subject: Re: [PATCH v6 0/5] Micron SLC NAND filling block
From:   Bean Huo <huobean@gmail.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com, s.hauer@pengutronix.de,
        derosier@gmail.com, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Date:   Tue, 02 Jun 2020 10:59:46 +0200
In-Reply-To: <20200602094825.26396b06@collabora.com>
References: <20200525121814.31934-1-huobean@gmail.com>
         <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
         <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
         <20200602094825.26396b06@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 09:48 +0200, Boris Brezillon wrote:
> Hi Bean,
> 
> On Mon, 01 Jun 2020 23:10:43 +0200
> Bean Huo <huobean@gmail.com> wrote:
> 
> > Hi Richard 
> > would you please help us confirm below question??
> 
> Miquel suggested an approach that would allow us to deal with both
> JFFS2
> and UBI/UBIFS without having any FS/wear-leveling specific code at
> the
> NAND level, but you decided to ignore his comments. Sorry but there's
> nothing we can do to help you if you don't listen to our
> recommendations.

Expose this issue to FS layer, it is not good idea. that will impact
more code, and involve duplicated code.
> 
> I've been quite disappointed by your behavior in the past, and it

> continues. Recently you've taken Miquel's patches and claimed
> ownership
did you seem my recent patch? you can ignore that see this.


> on them (probably not intentionally, but still) while you were
> clearly
> unable to rework your original series the way I suggested (which
> Miquel
> did after seeing you would never send new versions). 

seriously?

> And when Miquel
> suggested a change to the implementation he had done based on the
> discussion we had with Richard, you decided to ignore it and pursue
> in
> the original direction. So, quite frankly, I'm really not convinced
> you
> can conduct such a change.
> 

As Miquel mentioned, we need richard's final comfirmation,
If he agrees with this proposal, I give up my current patch.

