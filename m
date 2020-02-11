Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82185C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoYe1MpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBKDTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:19:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22099 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbgBKDTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581391185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVGmAaQelGG2wmtr8ypBYNb9UdLgn2L2ZnfBdIYaqns=;
        b=KoYe1MpG73Vb0IQLe4U7riB0GwTXYCeTc33Nq2AZeK1wK2MuzYHaVK3MmkCZXfOotOuiCu
        wthkRh1Qd+N213ZOhU+xWk968tfczBy7AYQTi+5zNvMIZYHgNj/KBr7kwpuQ43gIpMggfl
        4OzXhZuco9NhD+k1lJFxMSCLeEy5J0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-IMnbuXGMNLOCkryZsl8Ayg-1; Mon, 10 Feb 2020 22:19:43 -0500
X-MC-Unique: IMnbuXGMNLOCkryZsl8Ayg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7F498017CC;
        Tue, 11 Feb 2020 03:19:42 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F335C1D4;
        Tue, 11 Feb 2020 03:19:39 +0000 (UTC)
Subject: Re: [PATCH v2] tools/virtio: option to build an out of tree module
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200207073327.1205669-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e361e68d-e7c8-1fe0-45c1-21e6be8333d1@redhat.com>
Date:   Tue, 11 Feb 2020 11:19:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200207073327.1205669-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/7 =E4=B8=8B=E5=8D=883:35, Michael S. Tsirkin wrote:
> Handy for testing with distro kernels.
> Warn that the resulting module is completely unsupported,
> and isn't intended for production use.
>
> Usage:
>          make oot # builds vhost_test.ko, vhost.ko
>          make oot-clean # cleans out files created
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> changes from v1:
> 	lots of refactoring
> 	disable all modules except vhost by default (more of a chance
> 						     it'll build)
> 	oot-clean target
>
>   tools/virtio/Makefile | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 8e2a908115c2..f33f32f1d208 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -8,7 +8,32 @@ CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../include/ -I =
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
> +OOT_KSRC=3D/lib/modules/$$(uname -r)/build
> +OOT_VHOST=3D`pwd`/../../drivers/vhost
> +#Everyone depends on vhost
> +#Tweak the below to enable more modules
> +OOT_CONFIGS=3D\
> +	CONFIG_VHOST=3Dm \
> +	CONFIG_VHOST_NET=3Dn \
> +	CONFIG_VHOST_SCSI=3Dn \
> +	CONFIG_VHOST_VSOCK=3Dn
> +OOT_BUILD=3DKCFLAGS=3D"-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=3D${V=
}
> +oot-build:
> +	echo "UNSUPPORTED! Don't use the resulting modules in production!"
> +	${OOT_BUILD} M=3D`pwd`/vhost_test
> +	${OOT_BUILD} M=3D${OOT_VHOST} ${OOT_CONFIGS}
> +
> +oot-clean: oot-build
> +oot: oot-build
> +oot-clean: OOT_BUILD+=3Dclean
> +
> +.PHONY: all test mod clean vhost oot oot-clean oot-build
>   clean:
>   	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
>                 vhost_test/Module.symvers vhost_test/modules.order *.d


Acked-by: Jason Wang <jasowang@redhat.com>


