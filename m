Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33254C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BDE20709
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BDE20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgDLUeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:34:07 -0400
Received: from asavdk3.altibox.net (asavdk3.altibox.net [109.247.116.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB7C0A3BF0;
        Sun, 12 Apr 2020 13:34:07 -0700 (PDT)
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 924C72001F;
        Sun, 12 Apr 2020 22:34:04 +0200 (CEST)
Date:   Sun, 12 Apr 2020 22:34:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] fbdev: mx3fb: const pointer to ipu_di_signal_cfg
Message-ID: <20200412203402.GA27677@ravnborg.org>
References: <20200408162551.3928330-1-arnd@arndb.de>
 <87pnchhp2s.fsf@intel.com>
 <20200408180216.GC24828@ravnborg.org>
 <20200408182926.GA21997@ravnborg.org>
 <20200408200141.GM4881@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408200141.GM4881@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8
        a=QyXUC8HyAAAA:8 a=7gkXJVJtAAAA:8 a=ZTmiYS-oAAAA:8 a=hD80L64hAAAA:8
        a=VwQbUJbxAAAA:8 a=ouh9qIkmRCoZiYK3H64A:9 a=CjuIK1q_8ugA:10
        a=D0XLA9XvdZm18NrgonBM:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Bgfdu2smNuKfk3vLOmSO:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:01:41PM +0300, Laurent Pinchart wrote:
> Hi Sam,
> 
> Thank you for the patch.
> 
> On Wed, Apr 08, 2020 at 08:29:26PM +0200, Sam Ravnborg wrote:
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> and
> > Jani Nikula <jani.nikula@intel.com> both
> > suggested to make the pointer to struct ipu_di_signal_cfg const.
> > 
> > Fix this.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Fixes: 3f6c93ec9254 ("fbdev: mx3fb: avoid warning about psABI change")
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Enrico Weigelt <info@metux.net>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-fbdev@vger.kernel.org
> 
> Assuming this is compile-tested,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks. Applied and pushed out to drm-misc-next.

	Sam
