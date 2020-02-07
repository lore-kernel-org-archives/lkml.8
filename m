Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A88DC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2FF21927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGPUC9C6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBGDii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:38:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31539 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727162AbgBGDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581046714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3Qcvm/Sy3qQWlT2RBAuTJM+EqKL92nFComMce7p/ho=;
        b=gGPUC9C60VNRNN2rqcuQ8gV05rFQ9fgp+0FMwGtzVuMkoZ87NLaMZUlp0hjVchQIMbiLO8
        Y6daOjItrkpuowekQlBxzKsG1uQ8c1FT+7G4R7ZkuxYJeH5orelP0u66fHSfr31nrWMjqO
        amcmveNJ6KIoI7OdM7mwtXEyArXFxE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-6YLNfqkvMBWf41eIHZ9zzQ-1; Thu, 06 Feb 2020 22:38:32 -0500
X-MC-Unique: 6YLNfqkvMBWf41eIHZ9zzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AEBB10054E3;
        Fri,  7 Feb 2020 03:38:31 +0000 (UTC)
Received: from [10.72.13.183] (ovpn-13-183.pek2.redhat.com [10.72.13.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5148C100194E;
        Fri,  7 Feb 2020 03:38:26 +0000 (UTC)
Subject: Re: [PATCH] tools/virtio: option to build an out of tree module
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200206080125.1178242-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d4581772-8314-e746-dbea-2603e0447cdd@redhat.com>
Date:   Fri, 7 Feb 2020 11:38:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200206080125.1178242-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/6 =E4=B8=8B=E5=8D=884:01, Michael S. Tsirkin wrote:
> Handy for testing with distro kernels.
> Warn that the resulting module is completely unsupported,
> and isn't intended for production use.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   tools/virtio/Makefile | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 8e2a908115c2..94106cde49e3 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -8,7 +8,18 @@ CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../include/ -I =
../../usr/include/ -Wno-poin
>   vpath %.c ../../drivers/virtio ../../drivers/vhost
>   mod:
>   	${MAKE} -C `pwd`/../.. M=3D`pwd`/vhost_test V=3D${V}
> -.PHONY: all test mod clean
> +
> +#oot: build vhost as an out of tree module for a distro kernel
> +#no effort is taken to make it actually build or work, but tends to mo=
stly work
> +#if the distro kernel is very close to upstream
> +#unsupported! this is a development tool only, don't use the
> +#resulting modules in production!
> +oot:
> +	echo "UNSUPPORTED! Don't use the resulting modules in production!"
> +	KCFLAGS=3D"-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/=
$$(uname -r) M=3D`pwd`/vhost_test V=3D${V}
> +	KCFLAGS=3D"-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/=
$$(uname -r) M=3D`pwd`/../../drivers/vhost V=3D${V} CONFIG_VHOST_VSOCK=3D=
n


Any reason for disabling vsock here?

Thanks


> +
> +.PHONY: all test mod clean vhost oot
>   clean:
>   	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
>                 vhost_test/Module.symvers vhost_test/modules.order *.d

