Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C5C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA2920757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgD1RGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:06:04 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39774 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1RGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:06:04 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7B1AD20022;
        Tue, 28 Apr 2020 19:06:00 +0200 (CEST)
Date:   Tue, 28 Apr 2020 19:05:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add IVO M133NWF4 R0
Message-ID: <20200428170559.GC27234@ravnborg.org>
References: <20200420215728.1927434-1-bjorn.andersson@linaro.org>
 <20200425175842.GA3773@ravnborg.org>
 <CAL_JsqL6bMwrXZqvGz_H_aJi+EeoikBwKznLP2VomJ=Wn822Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL6bMwrXZqvGz_H_aJi+EeoikBwKznLP2VomJ=Wn822Rg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8
        a=3hrhdDLJ5tPtOPOkrE4A:9 a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

On Tue, Apr 28, 2020 at 09:27:51AM -0500, Rob Herring wrote:
> On Sat, Apr 25, 2020 at 12:58 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Björn.
> >
> > On Mon, Apr 20, 2020 at 02:57:27PM -0700, Bjorn Andersson wrote:
> > > Define the vendor prefix for InfoVision Optoelectronics and add their
> > > M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel to the compatible list
> > > of panel-simple.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > I got OK for the vendor prefix on irc so patch is now added to
> > drm-misc-next.
> > Another time please use a dedicated patch for vendor-prefix
> > so it is not hidden with other stuff. This way the chance
> > to get the attention of the right people is better.
> 
> I should have mentioned there's basically one thing to check:
> alphabetical order.
I thought I checked that, but obviously not - hrmpf..
I will post a follow-up patch for drm-misc-next to fix it.

	Sam
