Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF51C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07CA206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588084085;
	bh=D7QNgWTGi3LFiveU1UlSuH8oqtvhgNGqKALwImoVYkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hk3quCCJYOjgfRVY736f+vJjyd3wCbmmtAt8pHWvQQDXVHRtfDR/ZHS8GUHU/4hGi
	 S2Du4LMUGKFyNZQ1HzmRj67St1m3KtVdLWsRaN5U0EnlkU6hrvlG+/ez2oaP51CMYC
	 YLUL7QjuqOHgLTukuhQ19yVhxi8Mo0Xjmq8WJz7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgD1O2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgD1O2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:28:04 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 029E2206E2;
        Tue, 28 Apr 2020 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588084084;
        bh=D7QNgWTGi3LFiveU1UlSuH8oqtvhgNGqKALwImoVYkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o29hVvvQad0SDi9yf0TpO1MvWtpwYZqpd618/5yEjDqWmjCyASAVgED8qreXsCwJ6
         pcjomR4yyq7assm3J+isPP0SgXijqTklM/ILcQhMOnvia80RWdj+wTzAbPqTGXzcOp
         hB1VoplClc9b9cPdQ4oqVX4wYoPzFaBl3t+jSxJY=
Received: by mail-ot1-f50.google.com with SMTP id m18so32846836otq.9;
        Tue, 28 Apr 2020 07:28:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubPO6F5cX1OybNPgbTqCkWWTW6O/JBomtOk+VDr6xhtAgYPRetE
        cTx1gf3BDUQz5R9cx2xj2i758KHHVVCwf60xoQ==
X-Google-Smtp-Source: APiQypK3X4aUyiYhPAHhaTh4SayCKXYiLxNTHCd8y/oQZhydp53nEzkfEni/GtmVYYFLz/z1zRBGLXTAo3ngLC2yGQU=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr23106980oth.192.1588084083280;
 Tue, 28 Apr 2020 07:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200420215728.1927434-1-bjorn.andersson@linaro.org> <20200425175842.GA3773@ravnborg.org>
In-Reply-To: <20200425175842.GA3773@ravnborg.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Apr 2020 09:27:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL6bMwrXZqvGz_H_aJi+EeoikBwKznLP2VomJ=Wn822Rg@mail.gmail.com>
Message-ID: <CAL_JsqL6bMwrXZqvGz_H_aJi+EeoikBwKznLP2VomJ=Wn822Rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add IVO M133NWF4 R0
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:58 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Bj=C3=B6rn.
>
> On Mon, Apr 20, 2020 at 02:57:27PM -0700, Bjorn Andersson wrote:
> > Define the vendor prefix for InfoVision Optoelectronics and add their
> > M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel to the compatible list
> > of panel-simple.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> I got OK for the vendor prefix on irc so patch is now added to
> drm-misc-next.
> Another time please use a dedicated patch for vendor-prefix
> so it is not hidden with other stuff. This way the chance
> to get the attention of the right people is better.

I should have mentioned there's basically one thing to check:
alphabetical order.

The good news is both files got it wrong, so at least we're consistent. :)

Rob
