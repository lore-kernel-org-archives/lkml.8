Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4C92073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNdSrPUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCEKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:47:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgCEKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583405260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFHDTdsHNQ+WpC3J48LkcUo13CW/xHV+YRnYq60G8e8=;
        b=bNdSrPUdbVucwqy09Kn7tUvb8HM7UuCO9VkQtP17NRsnUbfcZ1gEtCy8sz1+z2IsjrUTlz
        akWQOfFh+ozS1c67RZpRPqg3VPDpHYEiXVHaNyKPOY0NPDjC1tXKm1KrvhiuGey79iJZMf
        63FuZYxKDZ/+EEhyAZTnCPA//Nwxgq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-HuL3wU8oMkWBRhRkMioOIg-1; Thu, 05 Mar 2020 05:47:36 -0500
X-MC-Unique: HuL3wU8oMkWBRhRkMioOIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E687D107ACC7;
        Thu,  5 Mar 2020 10:47:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C937E91D79;
        Thu,  5 Mar 2020 10:47:34 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7BD4538A1;
        Thu,  5 Mar 2020 10:47:34 +0000 (UTC)
Date:   Thu, 5 Mar 2020 05:47:34 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1136615517.13281010.1583405254370.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200305073653.GC267906@xps-13>
References: <20200304175350.GB267906@xps-13> <1830360600.13123996.1583352704368.JavaMail.zimbra@redhat.com> <20200305073653.GC267906@xps-13>
Subject: Re: [PATCH] ptp: free ptp clock properly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.231, 10.4.195.18]
Thread-Topic: free ptp clock properly
Thread-Index: QwGKf1Q/LQ0b+CJqbVMkJPSAlrl8TQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrea, all,

> > I would guess that a kernel in question (5.3.0-40-generic) has the commit
> > a33121e5487b but does not have the commit 75718584cb3c, which should be
> > exactly fixing a docking station disconnect crash. Could you please,
> > check this?
> 
> Unfortunately the kernel in question already has 75718584cb3c:
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?h=hwe&id=c71b774732f997ef38ed7bd62e73891a01f2bbfe
> 
> It looks like there's something else that can free up too early the
> resources required by posix_clock_unregister() to destroy the related
> sysfs files.
> 
> Maybe what we really need to call from ptp_clock_release() is
> pps_unregister_source()? Something like this:

Err... I believe, "Maybe" is not a good enough reason to accept a kernel patch.
Probably, there should be something supporting this statement.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

