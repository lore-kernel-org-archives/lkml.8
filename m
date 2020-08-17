Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5493D2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geegxBTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHQLIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:08:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31912 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgHQLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597662511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sRXpA3KVhG5i/ooij8DK6osX068yWEAfosvf8o3Zs6Y=;
        b=geegxBTIg0QOKdQY/NHKC5v12WrWx9UNO63wcLBHBhZfIW2LS9/t37cWeGMO8iWFmdsh8i
        R5EpMKrY6lGN1CT3pUoxMkPhn2QWwIMTaVA6UolZF/4BDKkpBV7GWB5mdWypzgj27qzeJr
        hycX0a6RiKaxtDlIFiUDJp4oFQI9LWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-OQTjsRyGO2CmwRxlHku8Ow-1; Mon, 17 Aug 2020 07:08:28 -0400
X-MC-Unique: OQTjsRyGO2CmwRxlHku8Ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C4B2185E53C;
        Mon, 17 Aug 2020 11:08:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3997310013C2;
        Mon, 17 Aug 2020 11:08:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 201FA9D8F; Mon, 17 Aug 2020 13:08:24 +0200 (CEST)
Date:   Mon, 17 Aug 2020 13:08:24 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/qxl: Replace deprecated function in qxl_display
Message-ID: <20200817110824.ascomag3nh7ufabs@sirius.home.kraxel.org>
References: <20200524022624.10363-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524022624.10363-1-realwakka@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:26:23AM +0900, Sidong Yang wrote:
> Hi, Dave.
> 
> This is resended e-mail for your advice.
> 
> I'm a newbie interested in linux kernel and qxl module.
> Please check this patch and give me advice for me.
> Also I'll be glad if there is any task that you bothered.
> Thanks.
> 
> Sidong.
> 
> Replace deprecated function drm_modeset_lock/unlock_all with
> helper function DRM_MODESET_LOCK_ALL_BEGIN/END.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Queued for drm-misc-next.

thanks,
  Gerd

