Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6AEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CE82177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRe0vrbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHDOdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:33:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbgHDObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffhxZqFM8PBvF+vauUvvf1tRDTyBqCijDDoMA3KNyuc=;
        b=NRe0vrbpiA9J7G0sYkHgcvzysxCiKriO7HUn9imFgDL3GXHgRCV/gS0MngiZ0y/SoOCO/n
        p6N41vgEU0/vsVojR781FKHY9siI/EKPUyUQiPWeIa0OMMPzcYn8HujCWLX0kJnbz+IdWy
        wpMjA1lSnV/T4mjwiGpez7ca4YvEjDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-BeqSIuArNeeazcZXXI2UYw-1; Tue, 04 Aug 2020 10:31:15 -0400
X-MC-Unique: BeqSIuArNeeazcZXXI2UYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2753F100A8EB;
        Tue,  4 Aug 2020 14:31:14 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D53070106;
        Tue,  4 Aug 2020 14:31:10 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:31:08 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 07/24] virtio_console: correct tags for config space
 fields
Message-ID: <20200804163108.706dc379.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-8-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-8-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:59:04 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Tag config space fields as having virtio endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_console.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

