Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDFEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927872177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BE+qxI/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgHDO06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:26:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728909AbgHDO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWmkUuPwdSE6jVaLHRBwvmw+aysHTDsWCc3++Cs6dng=;
        b=BE+qxI/OXKOyBQwIXqF04HDfj06F5kAepoLGQRS65DRUGDDrFSaTKoWARHyFAvDpFWgai1
        KKlSedlfvLpvhTYTQhzvqCX8ddaCyELPVx1dcoiEegZVVSxn5uLFUKXLXtQdlqO1SL0eZP
        VxViUaP9fyjxKgYls19Sc2jRJA3KIWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-2xBGwrxaPXyby0OVlcnTDA-1; Tue, 04 Aug 2020 10:26:43 -0400
X-MC-Unique: 2xBGwrxaPXyby0OVlcnTDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 517578064AC;
        Tue,  4 Aug 2020 14:26:42 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBC610013D0;
        Tue,  4 Aug 2020 14:26:38 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:26:36 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 05/24] virtio_balloon: correct tags for config space
 fields
Message-ID: <20200804162636.7548ba13.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-6-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-6-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:58:55 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Tag config space fields as having little endian-ness.
> Note that balloon is special: LE even when using
> the legacy interface.

At least that is clearer now.

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_balloon.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

