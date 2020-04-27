Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFEFC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077C4206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgD0OpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:45:23 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:60030 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgD0OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:45:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 925CE181D303C;
        Mon, 27 Apr 2020 14:45:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: laugh55_689d99d258c14
X-Filterd-Recvd-Size: 2256
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 14:45:18 +0000 (UTC)
Message-ID: <afe39d6c755dbc0d79e913b531ed12ed94ec1b13.camel@perches.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add IPK MIPI DSI Host driver entry
From:   Joe Perches <joe@perches.com>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Date:   Mon, 27 Apr 2020 07:45:17 -0700
In-Reply-To: <abe4ca0b0662c17212fc5107080e949f1d3377c1.1587992776.git.angelo.ribeiro@synopsys.com>
References: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
         <abe4ca0b0662c17212fc5107080e949f1d3377c1.1587992776.git.angelo.ribeiro@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 16:00 +0200, Angelo Ribeiro wrote:
> Creates entry for Synopsys DesignWare IPK DRM driver and
> adds myself as maintainer.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -5507,6 +5507,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/ste,mcde.txt
>  F:	drivers/gpu/drm/mcde/
>  
> +DRM DRIVER FOR SYNOPSYS DESIGNWARE IPK
> +M:	Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +F:	drivers/gpu/drm/ipk/
> +F:	Documentation/devicetree/bindings/display/ipk/
> +T:	git git://anongit.freedesktop.org/drm/drm-misc

There is now a preferred order for the entries in a section.

Please use:

DRM DRIVER FOR SYNOPSYS DESIGNWARE IPK
M:	Angelo Ribeiro <angelo.ribeiro@synopsys.com>
L:	dri-devel@lists.freedesktop.org>
S:	Maintained
T:	git git://anongit.freedesktop.org/drm/drm-misc
F:	Document
ation/devicetree/bindings/display/ipk/>
F:	drivers/gpu/drm/ipk/


