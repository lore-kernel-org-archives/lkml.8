Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F3FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C71920665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAJ0KU/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgH1IKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:10:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728593AbgH1IKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598602221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvafGB3h1uSuShOcxklJX4Q2Ef6CI/lwjYNIZ0zdVjc=;
        b=IAJ0KU/y5M3VFQYb7/2GeCjUEQEkMijjGGhKGvBRTD7dtRO/0Eb30o7/ebdIk5/tWm3JYc
        u9T8IJasvDzws8iDwRYVss7soKgmWRKyXwNDR+WwJ6UHM5YCkOj4Fx1MzgmrXKwLXEHSXi
        zb2I7PpQp4HK/CfHlsUrrI6abjvzUSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-RHOgIQ7tOa6GJlcVJUT-kg-1; Fri, 28 Aug 2020 04:10:17 -0400
X-MC-Unique: RHOgIQ7tOa6GJlcVJUT-kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 204F5425E8;
        Fri, 28 Aug 2020 08:10:15 +0000 (UTC)
Received: from gondolin (ovpn-113-255.ams2.redhat.com [10.36.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2C85D9F3;
        Fri, 28 Aug 2020 08:10:05 +0000 (UTC)
Date:   Fri, 28 Aug 2020 10:10:02 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v10 01/16] s390/vfio-ap: add version vfio_ap module
Message-ID: <20200828101002.57c0d81f.cohuck@redhat.com>
In-Reply-To: <8b3eb14e-c388-3025-1bfb-2dc7fb820de3@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-2-akrowiak@linux.ibm.com>
        <20200825120432.13a1b444.cohuck@redhat.com>
        <ca016eca-1ee7-2d0f-c2ec-3ef147b6216a@linux.ibm.com>
        <20200827123240.42e0c787.cohuck@redhat.com>
        <8b3eb14e-c388-3025-1bfb-2dc7fb820de3@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 10:39:07 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Currently there are two tools that probably need to be aware of
> the changes to these assignment interfaces:
> * The hades test framework has tests that will fail if run against
>  =C2=A0=C2=A0 these patches that should be skipped if over-provisioning is
>  =C2=A0=C2=A0 allowed. There are also tests under development to test the
>  =C2=A0=C2=A0 function introduced by these patches that will fail if run =
against
>  =C2=A0=C2=A0 an older version of the driver. These tests should be skipp=
ed in
>  =C2=A0=C2=A0 that case.
> * There is a tool under development for configuring AP matrix
>  =C2=A0=C2=A0 mediated devices that probably need to be aware of the chan=
ge
>  =C2=A0=C2=A0 introduced by this series.
>=20
> Since a tool would have to first determine whether a new sysfs
> interface documenting facilities is available and it would only
> expose one facility at this point, it seems reasonable for these tools
> to check for the sysfs guest_matrix attribute to discern whether
> over-provisioning is available or not. I'll go ahead and remove this
> patch from the series.

Thanks for the explanation, that seems reasonable to me.

