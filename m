Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F162E20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dn1EaMow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGPIrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:47:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727096AbgGPIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594889235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7j27KYTRCqDITI6VquYdl66YYuEpgB8nWCwNHaK5Pw=;
        b=dn1EaMow1cDjr1o05S9I49tS+GpUBy8mpbW9Kp7V/WD4Bc5cg88i4c+GbNxKyij48Z3O3Q
        g7copy9+H9CNx5Qe5KiQ3JDWKy37Cvy9M0zI6ryCupNm6succaq56vm+KGak2vrgYAldtz
        lq2M+xbOT47K2shw93vTgHIdjUVEePU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-RGOdNCfxPEONt2Mm22tRCQ-1; Thu, 16 Jul 2020 04:47:14 -0400
X-MC-Unique: RGOdNCfxPEONt2Mm22tRCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B275310059BC;
        Thu, 16 Jul 2020 08:47:12 +0000 (UTC)
Received: from starship (unknown [10.35.206.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F372D5C1C3;
        Thu, 16 Jul 2020 08:47:10 +0000 (UTC)
Message-ID: <fdbc12dc79ed73c00d37d5b60c00afc3d7e3f556.camel@redhat.com>
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, sakari.ailus@linux.intel.com,
        heikki.krogerus@linux.intel.com
Date:   Thu, 16 Jul 2020 11:47:09 +0300
In-Reply-To: <20200716082807.GA1335446@kroah.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
         <20200716082807.GA1335446@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 10:28 +0200, Greg KH wrote:
> On Thu, Jul 16, 2020 at 11:17:03AM +0300, Maxim Levitsky wrote:
> > Hi!
> > 
> > Few days ago I bisected a regression on 5.8 kernel:
> > 
> > I have nvidia rtx 2070s and its USB type C port driver (which is open source)
> 
> Is that driver merged into the tree?  If not, do you have a pointer to
> it somewhere?
> 
> thanks,
> 
> greg k-h
> 
It is in the tree.

CONFIG_TYPEC_UCSI selectes the generic UCSI driver
CONFIG_UCSI_CCG selects the hardware driver,
which is an i2c driver which binds to an i2c device (I think with address 0x8)
on an i2c controller, which is exposed by function 3 of the NVIDIA card, and uses the
CONFIG_I2C_NVIDIA_GPU driver.

We also have CONFIG_TYPEC_NVIDIA_ALTMODE which I haven't researched
what it does.

Best regards,
	Maxim Levitsky

