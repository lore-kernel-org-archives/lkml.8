Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED3E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejIuwuJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGJKgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:36:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4DC08C5CE;
        Fri, 10 Jul 2020 03:36:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so2347636pfn.12;
        Fri, 10 Jul 2020 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k6E7LH2Rsa+GnrRcP6ifXPuNeY+Ay8cfhxue4cHFp+Y=;
        b=ejIuwuJ5q/l4SAyTZ676rI/EUXdB+Ulto0KXt0SF9qVV5BbhRNTZ640UK+ZjcFqiCw
         lvYtAKQogEsJYqeqDlU8XbNzKFlWwYeABtU0sxsM4qy/NfbGEK70m1G0ZSSRVj85yGxi
         oH8feGoAPTI0+mFzkr5hPGC5xpaBsXRavV5VPyydGheAbsiMM8ZMCNpYgNljruG0kM6K
         2YuW5d5frWq1weZHjQKdVMLffSmb0cbSZxt0Baxzh/avmqvSFUZm7MuIbiTZEcU3b2D+
         PRGMzMANKjY+TBPAjFxn8/KgSauqUvuzYyjoKyoR8LqLu42QjTKpB6692RVJzjkqx1DM
         GwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k6E7LH2Rsa+GnrRcP6ifXPuNeY+Ay8cfhxue4cHFp+Y=;
        b=G/quU/jUkBQYvsEVzE2niuXbi2FRq2bJLC3QggHFPNLtmqnniaklAhme6jzftmob9d
         3V4t0vJa8Rm/9Mo6V2n4jRe57cszH5q9wBu0rL0adOrTlF1l/wrR8umshC7qZxdvjqeT
         cJayJzbUIzPF65brxqrGJJBGiCDiguuMvrh+YGYPfS+NbPXr89KRH4TR6lFtQitk48ji
         snOJ/2ER4OZxTdjAF9/7NcS6lNieXLRkViyTPnHMDRPLFfUdIMa+RCTZL2DUvZ9vbXnG
         SSo7QVbOZdwwkUDwmG8koQ3cmKi8iMjTte7BUzdmcF2pazdjGP4GuRTz70gjNAEbJ+lx
         Y2Cg==
X-Gm-Message-State: AOAM53185RmfN+4mVTlMnXBtHIcbxwpwV6P0kLhYg0lT6E3VAhlLqUYN
        H1HZGfNKHoRRS3FHd2MOoVzfTNkR
X-Google-Smtp-Source: ABdhPJz6YyFV5tdcLS7lWZkNeBtZMvUFzkAfW8iEzo9m0Dw6sn8TUbjyhWIYFgcbO0LZha78s2iOgw==
X-Received: by 2002:a63:6ec2:: with SMTP id j185mr26610040pgc.176.1594377384965;
        Fri, 10 Jul 2020 03:36:24 -0700 (PDT)
Received: from localhost (g175.219-103-161.ppp.wakwak.ne.jp. [219.103.161.175])
        by smtp.gmail.com with ESMTPSA id 66sm5486863pfg.63.2020.07.10.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 03:36:24 -0700 (PDT)
Date:   Fri, 10 Jul 2020 19:36:21 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: USB MASS STORAGE
 DRIVER
Message-ID: <20200710103621.GA437393@lianli.shorne-pla.net>
References: <20200708095500.13694-1-grandmaster@al2klimov.de>
 <20200708103928.GC585606@kroah.com>
 <6b78a3fd-04b9-fc8e-b5c6-f03372a4cd31@al2klimov.de>
 <20200709061409.GA130260@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709061409.GA130260@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:14:09AM +0200, Greg KH wrote:
> On Wed, Jul 08, 2020 at 08:41:54PM +0200, Alexander A. Klimov wrote:
> > 
> > 
> > Am 08.07.20 um 12:39 schrieb Greg KH:
> > > On Wed, Jul 08, 2020 at 11:55:00AM +0200, Alexander A. Klimov wrote:
> > > > Rationale:
> > > > Reduces attack surface on kernel devs opening the links for MITM
> > > > as HTTPS traffic is much harder to manipulate.
> > > > 
> > > > Deterministic algorithm:
> > > > For each file:
> > > >    If not .svg:
> > > >      For each line:
> > > >        If doesn't contain `\bxmlns\b`:
> > > >          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > > > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> > > >              If both the HTTP and HTTPS versions
> > > >              return 200 OK and serve the same content:
> > > >                Replace HTTP with HTTPS.
> > > >
> > > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > > 
> > > Your subject lines are very odd compared to all patches for this
> > > subsystem, as well as all other kernel subsystems.  Any reason you are
> > > doing it this way and not the normal and standard method of:
> > > 	USB: storage: replace http links with https
> > > 
> > > That would look more uniform as well as not shout at anyone.

I would agree.  The OpenRISC patch for this series says:
  "OPENRISC ARCHITECTURE:..."

Here it would just be "openrisc:..." I think fixing the whole series is needed.
Greg is not the only on complaining.

Ideally, I think, it would be good to have this sent out as a series i.e [PATCH 3/55]
rather than individual patches so this could be discussed as a whole.

-Stafford

> > > thanks,
> > > 
> > > greg k-h
> > > 
> > Hi,
> > 
> > I'm very sorry.
> > 
> > As Torvalds has merged 93431e0607e5 and many of you devs (including big
> > maintainers like David Miller) just applied this stuff, I assumed that's OK.
> > 
> > And now I've rolled out tens of patches via shell loop... *sigh*
> > 
> > As this is the third (I think) change request like this, I assume this rule
> > applies to all subsystems – right?
> 
> Yes, you should try to emulate what the subsystem does, look at other
> patches for the same files, but the format I suggested is almost always
> the correct one.  If not, I'm sure maintainers will be glad to tell you
> otherwise :)


