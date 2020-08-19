Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123C5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88D020772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+5TGRi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHSF7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgHSF7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597816783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0zCJ2NK5Z+fl5pnDgfA8+GQ4DbNrhn0PYxAHaqZv20=;
        b=R+5TGRi74sNzgF2qRelzquYpeUGZ7pbo2zsD2NcMHLrAn1xELB/IErJ+ifO0yLmL/fkDL3
        4VU2EkeTp4v+FhNkjS7sFctkhpmYvccfNY3oq7MZ0vNpedjdxK/cJtQG7FzQkWhpsUWiLL
        SGOEY/BgOLbltJNbuJZMGWz2MjgTVVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-w0vSojaiMqKKKPAZ3GVM5g-1; Wed, 19 Aug 2020 01:59:41 -0400
X-MC-Unique: w0vSojaiMqKKKPAZ3GVM5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 448CD873159;
        Wed, 19 Aug 2020 05:59:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC755C1D0;
        Wed, 19 Aug 2020 05:59:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 45C2731E21; Wed, 19 Aug 2020 07:59:36 +0200 (CEST)
Date:   Wed, 19 Aug 2020 07:59:36 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 30/38] virtio_input: convert to LE accessors
Message-ID: <20200819055936.bnb5of7yxl5i57hc@sirius.home.kraxel.org>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-31-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-31-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:44:36AM -0400, Michael S. Tsirkin wrote:
> Virtio input is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

