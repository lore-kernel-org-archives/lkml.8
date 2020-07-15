Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219EFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E722064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQAk1brb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgGOJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:20:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729503AbgGOJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594804829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZJXdRz3OuvEKIr6ixIjruDiELI7j1w7zQRvg35RSOI=;
        b=UQAk1brbAqEigmFQIY3mea5At/ExG1NljFKpxXTYz6w/191YH+ZH8IB4Qk60C5DZ4dCd4A
        W9uBY72R2VcJ6OuDy5ltvTcJY+LOcLVWpJQSv633fFQasvGoW91cAnnq/VwRISTSxd4jF0
        Uvo/3xGqIw/UcpiGJlQ3YFw8NC1mz5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-U6TKGjfSPMKNdyXUeZeCDA-1; Wed, 15 Jul 2020 05:20:25 -0400
X-MC-Unique: U6TKGjfSPMKNdyXUeZeCDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE0661083;
        Wed, 15 Jul 2020 09:20:22 +0000 (UTC)
Received: from gondolin (ovpn-112-242.ams2.redhat.com [10.36.112.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C879C5D9C5;
        Wed, 15 Jul 2020 09:20:16 +0000 (UTC)
Date:   Wed, 15 Jul 2020 11:20:14 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v7 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200715112014.7a196261.cohuck@redhat.com>
In-Reply-To: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 10:31:07 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi all,
> 
> The goal of the series is to give a chance to the architecture
> to validate VIRTIO device features.
> 
> in this respin:
> 
> 1) I kept removed the ack from Jason as I reworked the patch
>    @Jason, the nature and goal of the patch did not really changed
>            please can I get back your acked-by with these changes?
> 
> 2) Rewording for warning messages
> 
> Regards,
> Pierre
> 
> Pierre Morel (2):
>   virtio: let arch validate VIRTIO features
>   s390: virtio: PV needs VIRTIO I/O device protection
> 
>  arch/s390/mm/init.c           | 28 ++++++++++++++++++++++++++++
>  drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>  include/linux/virtio_config.h |  1 +
>  3 files changed, 48 insertions(+)
> 

LGTM.

I assume that this will go either via the virtio tree or via the s390
arch tree, i.e. not through virtio-ccw, right?

