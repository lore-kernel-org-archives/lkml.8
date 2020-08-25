Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EB5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263A32068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE5YCzAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgHYKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:13:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54557 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729778AbgHYKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598350433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfBjE/lnsE6zqa6amkpr22aF2GJzSWSxCKj8gx+aUU8=;
        b=eE5YCzAa3gSQ/bw7+QxfyiPsqIrY5JgNq3TiI+A3UBkbCJBEUt7ES/GtVi5QfIW2LrGkDA
        rw5MB3MDeoM9PqS/IHGst5Mah4lZUAREjfs8YrEWarJy4waRh+vi6ptIQHSwgwBvSl0hwH
        HBNnL8c9xuYvrOY7UECK7b0nYTQMOcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-Arl8Ua1PPfOCKcnBE9UipA-1; Tue, 25 Aug 2020 06:13:49 -0400
X-MC-Unique: Arl8Ua1PPfOCKcnBE9UipA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D2E18BA282;
        Tue, 25 Aug 2020 10:13:46 +0000 (UTC)
Received: from gondolin (ovpn-112-248.ams2.redhat.com [10.36.112.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6D2319144;
        Tue, 25 Aug 2020 10:13:36 +0000 (UTC)
Date:   Tue, 25 Aug 2020 12:13:34 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 02/16] s390/vfio-ap: use new AP bus interface to
 search for queue devices
Message-ID: <20200825121334.0ff35d7a.cohuck@redhat.com>
In-Reply-To: <20200821195616.13554-3-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-3-akrowiak@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 15:56:02 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> This patch refactor's the vfio_ap device driver to use the AP bus's

s/refactor's/refactors/

> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
> information about a queue that is bound to the vfio_ap device driver.
> The bus's ap_get_qdev() function retrieves the queue device from a
> hashtable keyed by APQN. This is much more efficient than looping over
> the list of devices attached to the AP bus by several orders of
> magnitude.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 27 ++-------
>  drivers/s390/crypto/vfio_ap_ops.c     | 86 +++++++++++++++------------
>  drivers/s390/crypto/vfio_ap_private.h |  8 ++-
>  3 files changed, 59 insertions(+), 62 deletions(-)
> 

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e0bde8518745..ad3925f04f61 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -26,43 +26,26 @@
>  
>  static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
>  
> -static int match_apqn(struct device *dev, const void *data)
> -{
> -	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> -
> -	return (q->apqn == *(int *)(data)) ? 1 : 0;
> -}
> -
>  /**
> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
> - * @matrix_mdev: the associated mediated matrix
> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
>   * @apqn: The queue APQN
>   *
> - * Retrieve a queue with a specific APQN from the list of the
> - * devices of the vfio_ap_drv.
> - * Verify that the APID and the APQI are set in the matrix.
> + * Retrieve a queue with a specific APQN from the AP queue devices attached to
> + * the AP bus.
>   *
> - * Returns the pointer to the associated vfio_ap_queue
> + * Returns the pointer to the vfio_ap_queue with the specified APQN, or NULL.
>   */
> -static struct vfio_ap_queue *vfio_ap_get_queue(
> -					struct ap_matrix_mdev *matrix_mdev,
> -					int apqn)
> +static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
>  {
> +	struct ap_queue *queue;
>  	struct vfio_ap_queue *q;
> -	struct device *dev;
>  
> -	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
> -		return NULL;
> -	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))

I think you should add some explanation to the patch description why
testing the matrix bitmasks is not needed anymore.

> +	queue = ap_get_qdev(apqn);
> +	if (!queue)
>  		return NULL;
>  
> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				 &apqn, match_apqn);
> -	if (!dev)
> -		return NULL;
> -	q = dev_get_drvdata(dev);
> -	q->matrix_mdev = matrix_mdev;
> -	put_device(dev);
> +	q = dev_get_drvdata(&queue->ap_dev.device);
> +	put_device(&queue->ap_dev.device);
>  
>  	return q;
>  }

(...)

