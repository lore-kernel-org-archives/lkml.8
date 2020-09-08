Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D309C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550C22078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSTZxvFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgIHKEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:04:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39683 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728726AbgIHKEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599559447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=huJspaVKs2soWVBG7ypNpD3pCie9PJMElLgmWSCDlpg=;
        b=fSTZxvFGlALxnKrauUCM/MNlb1zAjkFHpBnopMQgw0UsJ98IzB+Qpz7NnGUhM9NPeh4TDr
        wj0MGGGYZRT3RDuLdBCXkbJrzBwtVN2WQ4OXGDXTg92ajsDHyuhlF165YBnXGLpbIC/Qr+
        3NTpbp8wHJx3bTxL3eIWXmSqnJ1ZJl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-1GwrGC8JO-KOM_F9MMjh6g-1; Tue, 08 Sep 2020 06:04:03 -0400
X-MC-Unique: 1GwrGC8JO-KOM_F9MMjh6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B5A8801AE0;
        Tue,  8 Sep 2020 10:04:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E505C1BB;
        Tue,  8 Sep 2020 10:04:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 41EEF1FCF5; Tue,  8 Sep 2020 12:04:01 +0200 (CEST)
Date:   Tue, 8 Sep 2020 12:04:01 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: drop quirks handling
Message-ID: <20200908100401.q7quz5m7m42wvobj@sirius.home.kraxel.org>
References: <20200908064741.1010-1-kraxel@redhat.com>
 <20200908085721.GJ2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908085721.GJ2352366@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:57:21AM +0200, Daniel Vetter wrote:
> On Tue, Sep 08, 2020 at 08:47:41AM +0200, Gerd Hoffmann wrote:
> > These days dma ops can be overridden per device, and the virtio core
> 
> "can be overridden" or "are"?

Didn't happen yet, so scratch this one for now ...

take care,
  Gerd

