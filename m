Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FFD2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVwW8wID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgHGMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728350AbgHGMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=273fiZa3j2YUsHYvjEo3xvFBeJLIY7mZ32ur6GZf0EM=;
        b=QVwW8wIDIa1aK18bgE0wv6MXTdWGITG4t87itufgubLiU4N8nT5UlKy68dffxcZscFKngp
        6+SGR/SiO+K8nYE36PggEtI/DYrfkY8Nu3P5KDjFcJTgWIGUSiQC4N5pQ32JSJg+HX0Z7x
        nuJL5yKJF8u3O3h2hiVQpkImdRUWPwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-8ExUZS9hO7iDqC6bCcjDtg-1; Fri, 07 Aug 2020 08:43:14 -0400
X-MC-Unique: 8ExUZS9hO7iDqC6bCcjDtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 549B718A1DFB;
        Fri,  7 Aug 2020 12:43:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9E377B932;
        Fri,  7 Aug 2020 12:43:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 001E99CBC; Fri,  7 Aug 2020 14:43:10 +0200 (CEST)
Date:   Fri, 7 Aug 2020 14:43:10 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Xin He <hexin.op@bytedance.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qi Liu <liuqi.16@bytedance.com>
Subject: Re: [PATCH] drm/virtio: fix memory leak in
 virtio_gpu_cleanup_object()
Message-ID: <20200807124310.cmhbj6bj76twdtaw@sirius.home.kraxel.org>
References: <20200722051851.72662-1-hexin.op@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722051851.72662-1-hexin.op@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:18:51PM +0800, Xin He wrote:
> Before setting shmem->pages to NULL, kfree() should
> be called.

>  			sg_free_table(shmem->pages);
> +			kfree(shmem->pages);
>  			shmem->pages = NULL;

Pushed to drm-misc-fixes.

thanks,
  Gerd

