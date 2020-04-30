Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6ABC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8BA206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255958;
	bh=bnbnGBpcSkW6SMoI1IFutrz+f0CFOtixejW6RxJUWtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1QDeA9mM1rPooEOM+wCOz6ns04nbYSzWdSuuxR5BrUQxxQod3b6o9S6/5h4f6bMe6
	 VvQwVc/iBvKmdPTWBm5KT/G2k1in5kSu2v9y4G5QQnbxI+3BzVqB+Wb2Gezxr8tL4l
	 sChkEFgfCkhTb3Z/A7eM3SHKZLU28EVBh2K2BWWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgD3OMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:12:37 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:46222 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgD3OMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:12:33 -0400
Received: by mail-oo1-f65.google.com with SMTP id x16so1301184oop.13;
        Thu, 30 Apr 2020 07:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4VjQG4GaeZwUvuLCg1gpRlRogX8RvlAHCiaM0iOEnI=;
        b=J6lpTDRZaNPYoLUnGMDVGSzHSGs6W1QTFBT41GlWseKs3Ib6MaEo75QOwdTAPjSTwR
         S/rTS4S/ElSSrncdFwmwWXf2t13PuNToC738fEjdt+YiqowYph6wid0fwsfxhdgaBTQw
         P9uWpgoF6nM15WyIH1343rdarRDF4BBwG/Gv0RJzM6zgEcBtR6Ydio1XEQPGUYdwwL4h
         wR6He6R0J1G8JFNnuog1JJCD2qEMY4z17XXyerefT2smJk3OfJ55fuysnSaK0HCXVGvy
         zcGQ7ZtNkP1+e3SGRTbNtsQcPosHJGis9PJPuesY8dHVwfIyQXAWaSoQgYh9owu3W7yp
         UbIw==
X-Gm-Message-State: AGi0PuYn/u1IIzEbjy9Aza7XjzwiVg1H8hkLZPLr8+swjbpehl8LPtYM
        2uLSJxQZHd9vWJjU5IHC194YuQ0=
X-Google-Smtp-Source: APiQypJZZKu6q0o/sEjNsrIJ8Ue6NRQME63JkomfCMYnMIiIszUXKpZSJ2lwInTV04v8Fv8dAtRTzg==
X-Received: by 2002:a4a:3b4a:: with SMTP id s71mr2953497oos.81.1588255952586;
        Thu, 30 Apr 2020 07:12:32 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u9sm6726otq.54.2020.04.30.07.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:12:31 -0700 (PDT)
Received: (nullmailer pid 9061 invoked by uid 1000);
        Thu, 30 Apr 2020 14:12:31 -0000
Date:   Thu, 30 Apr 2020 09:12:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 04/10] dt-bindings: marvell,mmp2: Add clock id for the
 Audio clock
Message-ID: <20200430141231.GA9028@bogus>
References: <20200419172742.674717-1-lkundrak@v3.sk>
 <20200419172742.674717-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419172742.674717-5-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 19:27:36 +0200, Lubomir Rintel wrote:
> This clocks the Audio block.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  include/dt-bindings/clock/marvell,mmp2.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
