Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D811EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC22222B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6MoMg8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgHDORf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:17:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgHDORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596550625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MPZ1iQ3JPjBlNMrYPSGQLxY1mun+60bwK9qZEBjRfg=;
        b=h6MoMg8BAhoKiKoDQfqXmn5gmZeyhU7hJNam6uEKTmx7411NONyZg6do4DX0fvSeMoHI8Q
        IpjiW9o21SMr9n7yrfoHJ7Ke54gYqGhkJ9f8DanIoI5WqHrZ0nFyMjgkk0W5E7uDXyYXBt
        qEI4xvYI57L8mWtR8RBGa1CwC+dLxqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-c2MZmszDOQSEpbXrxO_oYA-1; Tue, 04 Aug 2020 10:17:03 -0400
X-MC-Unique: c2MZmszDOQSEpbXrxO_oYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E6688B1086;
        Tue,  4 Aug 2020 14:17:02 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4EE5C6DD;
        Tue,  4 Aug 2020 14:16:55 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:16:53 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 01/24] virtio_balloon: fix sparse warning
Message-ID: <20200804161653.32076296.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-2-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-2-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:58:38 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> balloon uses virtio32_to_cpu instead of cpu_to_virtio32
> to convert a native endian number to virtio.
> No practical difference but makes sparse warn.
> Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

