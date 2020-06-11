Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B64AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFCC20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgFKTtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:49:01 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55302 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgFKTst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:48:49 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AE5942002B;
        Thu, 11 Jun 2020 21:48:44 +0200 (CEST)
Date:   Thu, 11 Jun 2020 21:48:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: simple: add CDTech
 S070PWS19HP-FC21 and S070SWV29HG-DC44
Message-ID: <20200611194842.GA160434@ravnborg.org>
References: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
 <20200611124209.25028-1-matthias.schiffer@ew.tq-group.com>
 <686342440e7e1be0b010820154d3ae3dbc9f7990.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686342440e7e1be0b010820154d3ae3dbc9f7990.camel@ew.tq-group.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=edQTgYMH c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8f9FM25-AAAA:8 a=uEie4X3uJoHb6EmIMRgA:9
        a=CjuIK1q_8ugA:10 a=uSNRK0Bqq4PXrUp6LDpb:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias.
On Thu, Jun 11, 2020 at 02:46:22PM +0200, Matthias Schiffer wrote:
> On Thu, 2020-06-11 at 14:42 +0200, Matthias Schiffer wrote:
> > Add the CDTech Electronics displays S070PWS19HP-FC21 (7.0" WSVGA) and
> > S070SWV29HG-DC44 (7.0" WVGA) to the panel-simple compatible list.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> > 
> > v2: no changes
> 
> Oops, it seems I held my git send-email wrong, which caused patches v2
> 2-4 to bounce from some servers, should I resend?
Please do, I do not see them here.

	Sam
> 
> 
> > 
> >  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4
> > ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-
> > simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-
> > simple.yaml
> > index 31e3efc73e00..2ddb520edc6d 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-
> > simple.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-
> > simple.yaml
> > @@ -81,6 +81,10 @@ properties:
> >        - boe,nv140fhmn49
> >          # CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-
> > LCD panel
> >        - cdtech,s043wq26h-ct7
> > +        # CDTech(H.K.) Electronics Limited 7" WSVGA (1024x600) TFT
> > LCD Panel
> > +      - cdtech,s070pws19hp-fc21
> > +        # CDTech(H.K.) Electronics Limited 7" WVGA (800x480) TFT LCD
> > Panel
> > +      - cdtech,s070swv29hg-dc44
> >          # CDTech(H.K.) Electronics Limited 7" 800x480 color TFT-LCD
> > panel
> >        - cdtech,s070wv95-ct16
> >          # Chunghwa Picture Tubes Ltd. 7" WXGA TFT LCD panel
