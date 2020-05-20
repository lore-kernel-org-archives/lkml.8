Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A34020708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589936883;
	bh=b1m2H/qspG4/kk7t+fgNctP8zL54Vuj9IU/1FvM90+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hZWCK2HYb6wXdSsoGlJcje1qn/SMZ5EmF1Cn4XG66AHscSPDmUi/M66d71oxqNmiv
	 CcbMM/UbzZ17PFP+AIKVIU/chFiVJ05Ky66u+nUFH1G/h4oxSUfWryYSLx7s5epLBP
	 1Dc2g8t9jD8AsmTiLeuZgyjo9YJtRJaVd92RgWXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgETBIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgETBIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:08:01 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AA920829;
        Wed, 20 May 2020 01:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936881;
        bh=b1m2H/qspG4/kk7t+fgNctP8zL54Vuj9IU/1FvM90+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVU2J3ujhHu3+vxfjxo+AzVJ7w7oEHdUsXWm/3bbT3pBhdwOoeDHd6rRogrzIwDAJ
         pqXiWnS22c6QtGq72UW5y47uiSFV6xt74+xeyZW0PykGkB+/FGVUTzsJdgJxPB8P36
         l6oU328dkaq3KHBa755CNNA+UKvTmAyP3fP/X+IU=
Date:   Wed, 20 May 2020 09:07:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/zte: remove unneeded semicolon
Message-ID: <20200520010756.GG11739@dragon>
References: <20200504113230.40588-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504113230.40588-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 07:32:30PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/gpu/drm/zte/zx_vga.c:158:2-3: Unneeded semicolon
> drivers/gpu/drm/zte/zx_vga.c:171:2-3: Unneeded semicolon
> drivers/gpu/drm/zte/zx_vga.c:179:2-3: Unneeded semicolon
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
