Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B5BC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1405620753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSFORe1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgDHKd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:33:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgDHKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586342036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++RuusisyWa3FOCfbkvyrwom8wa+9JZWrf8CKTDIg3Q=;
        b=OSFORe1ba6H5qwOxZZHmWhldVrQAKu7iQacSN+aNJAiJOOXV6u3yuqr4PhuyCOY1FeeL1R
        61L6X3rfJMiXOaMyFZIbF0Y3y0SoKtGshOWRnSsre9qaaiBJbC4ZuWi80c6V5jdrMZ3NWH
        zlNO7b7HwZLOaOx55osysJWEKV5z71s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-K0x25oQUMiiWwzsykewO7A-1; Wed, 08 Apr 2020 06:33:54 -0400
X-MC-Unique: K0x25oQUMiiWwzsykewO7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8169800D4E;
        Wed,  8 Apr 2020 10:33:52 +0000 (UTC)
Received: from gondolin (ovpn-113-103.ams2.redhat.com [10.36.113.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF145DA60;
        Wed,  8 Apr 2020 10:33:47 +0000 (UTC)
Date:   Wed, 8 Apr 2020 12:33:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com,
        mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        jjherne@linux.ibm.com, fiuczy@linux.ibm.com
Subject: Re: [PATCH v7 06/15] s390/vfio-ap: sysfs attribute to display the
 guest CRYCB
Message-ID: <20200408123344.1a9032e1.cohuck@redhat.com>
In-Reply-To: <20200407192015.19887-7-akrowiak@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-7-akrowiak@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Apr 2020 15:20:06 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The matrix of adapters and domains configured in a guest's CRYCB may
> differ from the matrix of adapters and domains assigned to the matrix mdev,
> so this patch introduces a sysfs attribute to display the CRYCB of a guest
> using the matrix mdev. For a matrix mdev denoted by $uuid, the crycb for a
> guest using the matrix mdev can be displayed as follows:
> 
>    cat /sys/devices/vfio_ap/matrix/$uuid/guest_matrix
> 
> If a guest is not using the matrix mdev at the time the crycb is displayed,
> an error (ENODEV) will be returned.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 58 +++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)

> +static DEVICE_ATTR_RO(guest_matrix);

Hm... should information like the guest configuration be readable by
everyone? Or should it be restricted a bit more?

> +
>  static struct attribute *vfio_ap_mdev_attrs[] = {
>  	&dev_attr_assign_adapter.attr,
>  	&dev_attr_unassign_adapter.attr,
> @@ -1050,6 +1107,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
>  	&dev_attr_unassign_control_domain.attr,
>  	&dev_attr_control_domains.attr,
>  	&dev_attr_matrix.attr,
> +	&dev_attr_guest_matrix.attr,
>  	NULL,
>  };
>  

