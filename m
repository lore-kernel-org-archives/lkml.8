Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0E9C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8BE20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mDnyGV9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEDMof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728146AbgEDMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:44:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBDEC061A0E;
        Mon,  4 May 2020 05:44:32 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr25so13729850ejb.10;
        Mon, 04 May 2020 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvTx81p1Or0dC1AYdpQVhyeYDLLZOkvh0mdzl023l7M=;
        b=mDnyGV9vyqN4qdNFSgPodWfKAeIJdsnzLWCVE8hkdcgscKtJcmm+zWzb5sIPtxxFbW
         cTqYaxtqfa9KGeCG5wazeiWXdHFyxOAL2+z0npBw40wxhWLJWQl0H/Q2z3hpJyZcw4hy
         aRDSBJ7r82H61YpnPyuDlgWBQEmRvXn2MX5EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvTx81p1Or0dC1AYdpQVhyeYDLLZOkvh0mdzl023l7M=;
        b=a4Qk0RqvPuly8sBdKeVHDUMhwPtHwxOzKQqsrqH3lewQ2ek8ugu4Kq43L5p+R6YI73
         FUiLiw5U9u6lqUfdyVpjrNutjF/steJpR9e7jzIwe4naEeXXnp0TSnwQx0EKtc5BljLo
         KIXMHlNbn8fvr5DtsQg3XJA7T+83lew8CweqXdc0gSngcbeL1XfR/FUrd0Qe/1ASKkH3
         xt0mgF/BgQoczACos895Nzdye4PFWUHyYTe0GjZqJSt2IWpY7mEHWomMtb23VJATj61X
         oAN5CcHsR3I4Ov5+yBvqFB9/1x2NlUTNwp3prjpAJK+WOD0vHpA1DwUNnWkNOczxtiow
         DrDw==
X-Gm-Message-State: AGi0PuY6/V62gg84QY1gOQL9tzdMREe2bNu6/oflPiww/06zUbR9uigU
        qF3UuCV5wA/g0zu/zJss8adOPWCIvDsYxs03BDTQQg==
X-Google-Smtp-Source: APiQypKejwm/lQkWQj4iWmwktQXWSonZw9Wd0eQ/NGcxoYqEAKwt5FFlvQ4MvtMF3OCEEc0RhtVTDF2rQMF4pnE6tDU=
X-Received: by 2002:a17:907:43c2:: with SMTP id i2mr14786264ejs.185.1588596271042;
 Mon, 04 May 2020 05:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200424135303.20952-1-a.filippov@yadro.com> <CACPK8XcP3V=8fAUfNvRFqPU9G38dGR43Kpp=Uxm=P_AjrMnzBQ@mail.gmail.com>
 <c1de0c90-d486-4855-bb26-0f3cc416b05d@www.fastmail.com>
In-Reply-To: <c1de0c90-d486-4855-bb26-0f3cc416b05d@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 4 May 2020 12:44:19 +0000
Message-ID: <CACPK8XezSFzCeQN4tkvcmjOHEAgrRGYBiBzRymaazpv8Lh-gTQ@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: DTS: Aspeed: Add YADRO Nicole BMC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 at 11:04, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Mon, 27 Apr 2020, at 20:41, Joel Stanley wrote:
> > On Fri, 24 Apr 2020 at 13:53, Alexander Filippov <a.filippov@yadro.com> wrote:
> > >
> > > Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> > > by YADRO.
> > >
> > > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> >
> > This looks good to me.
> >
> > Andrew, do you have any comments before I merge?
>
> Not other than muxing all the ADC lines to enable just one seems a bit strange,
> but Alexander mentioned previously that the rest were simply grounded so it's
> not going to cause any problems in practice.

Thanks. Can you say the magic words for patchwork to pick up?
