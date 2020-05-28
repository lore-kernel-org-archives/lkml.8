Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D4E207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aod433Qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgE1HCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:02:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59224 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgE1HCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590649353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDDJ9W9XOpuhYXls0f2pXAJfIi1uNmOqH7E8hW7QAjk=;
        b=Aod433Qm8KlOsvtP3yJ4vFWhMJhkDQyspwd6QJJOykpMNoWNIKPVfragL+RMM3BfesXZiQ
        WUnr9ZQoewnKK031i4C4+MTPPSWPNlhE5DyIpb3xzMI60stBXYpKXGBUz0DbmXXcfhbLC4
        nQasb//eK5unlBYRu4Mm11RKdaWX64g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-4q13vZZgMnGlG_c-AMWSEA-1; Thu, 28 May 2020 03:02:29 -0400
X-MC-Unique: 4q13vZZgMnGlG_c-AMWSEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31651872FE0;
        Thu, 28 May 2020 07:02:28 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC0065C1B0;
        Thu, 28 May 2020 07:02:22 +0000 (UTC)
Date:   Thu, 28 May 2020 09:02:20 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Neo Jia <cjia@nvidia.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Jike Song <jike.song@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/mdev: Fix reference count leak in
 add_mdev_supported_type.
Message-ID: <20200528090220.6dc94bd7.cohuck@redhat.com>
In-Reply-To: <20200528020109.31664-1-wu000273@umn.edu>
References: <20200528020109.31664-1-wu000273@umn.edu>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 21:01:09 -0500
wu000273@umn.edu wrote:

> From: Qiushi Wu <wu000273@umn.edu>
> 
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Thus,
> replace kfree() by kobject_put() to fix this issue. Previous
> commit "b8eb718348b8" fixed a similar problem.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

