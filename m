Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F1C38A29
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA0C2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqdSbedC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgDPWeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:34:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729216AbgDPWeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587076448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1bma2gluq3HGOu3CaCHez8AlHNyzwOb99nKMYoTBrs=;
        b=LqdSbedCp/0YynWKHxlhczr5h21f31WfT2INVXXoRCa/oYZK8XMZiT/PMwdN4vWbcQ3l/1
        6FwlLl3oV+fwTFlgFobjtPCzy+QYKYvwdzdgTyw3PVuChTIcAbH5c/eXRKMAhN55MUQ9Dc
        XeA7J3qwt50DQOBJdXTCbLwPH8VJvm8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-MYUlhjBbPaiZuf79XfUEUA-1; Thu, 16 Apr 2020 18:34:04 -0400
X-MC-Unique: MYUlhjBbPaiZuf79XfUEUA-1
Received: by mail-wr1-f70.google.com with SMTP id a3so7797wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 15:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A1bma2gluq3HGOu3CaCHez8AlHNyzwOb99nKMYoTBrs=;
        b=hzZNADA0ZCX7YqJVGILDeOMuICQ3/P4qrBARxpdTIEFe8oWcypoA16RWVuJ4ua+ECe
         UZOQF5iyjIHXHHc/QIM4QGQ/yuvxhoFXHZjmOdntAVchda4r0SZplCOEMjpuYc/NdjHc
         eQ3uaP3p5eLjLJnNUd8sV3X471/+W+WbUoh/qjzpWa2+UTODo00XXyjmNkb6+v/cNiyS
         +lClVyAUCjw3PEyMyFK6YqljJ5oUvykGmj/rO/czqlvCiX5WHG5ZxQP5qjr/NHIGEry6
         zOlM14uJhipIogbG/trX8L5rz9ANRAA+PV0Rn0UHll/QXRS55B9h44CWGOHqblwL3078
         YAHw==
X-Gm-Message-State: AGi0PuZPpZIxVwfqh6I5PN7YsyKbx1RBkDwXAuarIIGLlhDKzhOCkrtz
        HXMDJDXgJPqu2b7RsjC9DGqB6rvc++gCW8yeo3SFitJ9AijIGsBGw+J5lUnEoeO4mqQA3x+XGwz
        LwbR11l6kvmF/rwLEngmQMkhM
X-Received: by 2002:a1c:4346:: with SMTP id q67mr98422wma.162.1587076442803;
        Thu, 16 Apr 2020 15:34:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKXN83gnjbKOoJt6yPtsWQIwZwD4bOGlfUuqfOI5ajKzWnkQM8hnZuZwWeeXGxrvKUUk0sKdg==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr98410wma.162.1587076442597;
        Thu, 16 Apr 2020 15:34:02 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id m15sm5010453wmc.35.2020.04.16.15.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:34:02 -0700 (PDT)
Date:   Thu, 16 Apr 2020 18:33:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] tools/virtio: Reset index in virtio_test --reset.
Message-ID: <20200416183324-mutt-send-email-mst@kernel.org>
References: <20200416075643.27330-1-eperezma@redhat.com>
 <20200416075643.27330-8-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416075643.27330-8-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:56:42AM +0200, Eugenio Pérez wrote:
> This way behavior for vhost is more like a VM.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

I dropped --reset from 5.7 since Linus felt it's unappropriate.
I guess I should squash this in with --reset?

> ---
>  tools/virtio/virtio_test.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 18d5347003eb..dca64d36a882 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -20,7 +20,6 @@
>  #include "../../drivers/vhost/test.h"
>  
>  #define RANDOM_BATCH -1
> -#define RANDOM_RESET -1
>  
>  /* Unused */
>  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> @@ -49,6 +48,7 @@ struct vdev_info {
>  
>  static const struct vhost_vring_file no_backend = { .fd = -1 },
>  				     backend = { .fd = 1 };
> +static const struct vhost_vring_state null_state = {};
>  
>  bool vq_notify(struct virtqueue *vq)
>  {
> @@ -174,14 +174,19 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	unsigned len;
>  	long long spurious = 0;
>  	const bool random_batch = batch == RANDOM_BATCH;
> +
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
> +	if (!reset_n) {
> +		next_reset = INT_MAX;
> +	}
> +
>  	for (;;) {
>  		virtqueue_disable_cb(vq->vq);
>  		completed_before = completed;
>  		started_before = started;
>  		do {
> -			const bool reset = reset_n && completed > next_reset;
> +			const bool reset = completed > next_reset;
>  			if (random_batch)
>  				batch = (random() % vq->vring.num) + 1;
>  
> @@ -224,10 +229,24 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  			}
>  
>  			if (reset) {
> +				struct vhost_vring_state s = { .index = 0 };
> +
> +				vq_reset(vq, vq->vring.num, &dev->vdev);
> +
> +				r = ioctl(dev->control, VHOST_GET_VRING_BASE,
> +					  &s);
> +				assert(!r);
> +
> +				s.num = 0;
> +				r = ioctl(dev->control, VHOST_SET_VRING_BASE,
> +					  &null_state);
> +				assert(!r);
> +
>  				r = ioctl(dev->control, VHOST_TEST_SET_BACKEND,
>  					  &backend);
>  				assert(!r);
>  
> +				started = completed;
>  				while (completed > next_reset)
>  					next_reset += completed;
>  			}
> @@ -249,7 +268,9 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	test = 0;
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
> -	fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
> +	fprintf(stderr,
> +		"spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
> +		spurious, started, completed);
>  }
>  
>  const char optstring[] = "h";
> @@ -312,7 +333,7 @@ static void help(void)
>  		" [--no-virtio-1]"
>  		" [--delayed-interrupt]"
>  		" [--batch=random/N]"
> -		" [--reset=random/N]"
> +		" [--reset=N]"
>  		"\n");
>  }
>  
> @@ -360,11 +381,9 @@ int main(int argc, char **argv)
>  		case 'r':
>  			if (!optarg) {
>  				reset = 1;
> -			} else if (0 == strcmp(optarg, "random")) {
> -				reset = RANDOM_RESET;
>  			} else {
>  				reset = strtol(optarg, NULL, 10);
> -				assert(reset >= 0);
> +				assert(reset > 0);
>  				assert(reset < (long)INT_MAX + 1);
>  			}
>  			break;
> -- 
> 2.18.1

