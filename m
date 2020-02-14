Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5EAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AD222314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPZBvwha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgBNIoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:44:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:44:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id n10so7981658wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXq1qTTEJGxPRttgekd5c81xjN3eOF8wuB+0NRpZEVw=;
        b=PPZBvwhalZ1ByZiC5h4/2jZ0bic0Xxq4NIJxlOqDuxVEzVLkWTlypUMH4BF2ZY1GhA
         YLQwvs062k26eMuXSkUoQEdIVSVJ+yA++89VxJW8rgY7d/YRrOrwGpJ5JGEWLotutAF0
         cv4LS6M2UJOxvrkh/m6bOuIhPrL+dg6Wa9Pl7kV/9INMi9GrszTM0RU1ujwB5hp4cFR6
         0FmHv3z51S3uElm0MyKZQ+R1wXGCf9AARlEJyczDobDoX8oU2r+G1PMVbsa1WLCxMZpU
         gVnPfJ/OVnWYLH/ApiOs8J74UEMIyBostXo+Jot0rNsM16fieYijlHv8+zTU/6b1mdZy
         U2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXq1qTTEJGxPRttgekd5c81xjN3eOF8wuB+0NRpZEVw=;
        b=pKxS4xNu0pcrsVbo6D9OLTQa1BagNPWdJ32ud8hIywLl+lf0KLov5AGDbXIxkugEyU
         yZm8PwFvzDvFM8FxcjcWiYX3O65ZgEznpPYRy0ClvadWlekXNoVJEsISpW1QVMN1XxmN
         cKNbusPz31tIZTdsfBC0IXvE0tTiAl9Xs3mR8dN4o0HVw73LKmVlbcL80L5iKNxzb4zc
         V6AtCE2Jtw1TedpqjsPGD+ffy89Vw86S0RCUXVRFjqVsVTWTdmsyykaql56UcMl+imjd
         Mznyiy2TmpCclKNdWzNte5SI4Pob9DFXd/PZWrlyioR5qJjARPWyhGXoAOQ3omyJ2dIn
         6AEQ==
X-Gm-Message-State: APjAAAVmsRPoNOHfmMzTLaCSZWRfaOEOSWilzQXj5DZpWGY4pVraHd+e
        yI3KPfI9zxKBYIii/yMLjoXZByBAlrAnrQ==
X-Google-Smtp-Source: APXvYqxS/TScRSLlqJlyhr//zA4jaFbzxneoXDXkbl4duj/BRqbmb25+lDDvv1nUh4I6g8T3WVp2Cw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr2868980wrt.229.1581669841655;
        Fri, 14 Feb 2020 00:44:01 -0800 (PST)
Received: from kedthinkpad ([213.197.144.54])
        by smtp.gmail.com with ESMTPSA id s139sm6677722wme.35.2020.02.14.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:44:00 -0800 (PST)
Date:   Fri, 14 Feb 2020 10:43:58 +0200
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Message-ID: <20200214084358.GA25266@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
 <20200212222355.17141-2-andrey.lebedev@gmail.com>
 <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
 <20200213200823.GA28336@kedthinkpad>
 <20200214075218.huxdhmd4qfoakat2@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214075218.huxdhmd4qfoakat2@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:52:18AM +0100, Maxime Ripard wrote:
> > > This will create a spurious warning message for TCON1, since we
> > > adjusted the driver to tell it supports LVDS, but there's no LVDS
> > > reset line, so we need to make it finer grained.
> >
> > Yes, I can attribute two of the messages in my dmesg log [1] to this
> > ("Missing LVDS properties" and "LVDS output disabled". "sun4i-tcon
> > 1c0d000.lcd-controller" is indeed tcon1). And yes, I can see how they
> > can be confusing to someone.
> >
> > I'd need some pointers on how to deal with that though (if we want to do
> > it in this scope).
> 
> Like I was mentionning, you could introduce a new compatible for each
> TCON (tcon0 and tcon1) and only set the support_lvds flag for tcon0

Can you give me an idea how that compatible might look like?

		tcon0: lcd-controller@1c0c000 {
			compatible = "allwinner,sun7i-a20-tcon", "allwinner,lvds";

or

		tcon0: lcd-controller@1c0c000 {
			compatible = "allwinner,sun7i-a20-tcon", "allwinner,tcon0";

? Or something completely different?


-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
