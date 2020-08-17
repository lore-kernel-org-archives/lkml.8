Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0F320829
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgHQIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:22:18 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:60032 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgHQIWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:22:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id ED0F3FB03;
        Mon, 17 Aug 2020 10:22:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vsj6xPO_wWQO; Mon, 17 Aug 2020 10:22:05 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 683F14576F; Mon, 17 Aug 2020 10:22:05 +0200 (CEST)
Date:   Mon, 17 Aug 2020 10:22:05 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Modernize rocktech,jh057n00900 bindings a bit
Message-ID: <20200817082205.GA31233@bogon.m.sigxcpu.org>
References: <cover.1597561897.git.agx@sigxcpu.org>
 <20200816152534.GB1394979@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200816152534.GB1394979@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Aug 16, 2020 at 05:25:34PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Sun, Aug 16, 2020 at 09:13:41AM +0200, Guido Günther wrote:
> > This was prompted by Sam's review in
> > https://lore.kernel.org/dri-devel/20200815210802.GA1242831@ravnborg.org/
> > and yamllint. I also added myself as maintainer, hope that's o.k.
> > 
> > Guido Günther (2):
> >   dt-bindings: panel: rocktech,jh057n00900: Modernize
> >   dt-bindings: panel: rocktech,jh057n00900: Add myself as maintainer
> 
> Thanks for this nice clean-up, and always good with an extra person
> caring for something.
> Applied to drm-misc-next

Thanks!
 -- Guido

> 
> 	Sam
> 
> > 
> >  .../display/panel/rocktech,jh057n00900.yaml   | 40 +++++++++----------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> > 
> > -- 
> > 2.26.2
> 
