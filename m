Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95E2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA2207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tyz+V32H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIGLul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:50:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729145AbgIGLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599479271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJK2rYubePS6o9IGw+xv/Kicmr6oDOLLUaC6aIiTRC8=;
        b=Tyz+V32HME1J5XS3IrvFlTI00zHH+CAmMnMvhZkrlVPDy/51RgkGhvSypHxft57Zbnv5tl
        ZCPmCcuzC6/oYlz3Tnx1CZl0e/KupbLZNHFBglTeWNMTqqobOSwJuko7Cwd27fmrao7GEd
        j2TmWoW2TTvdAknBGk2zH2czQXlhqJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-PYqdx2vkOBuCVrrp-aWETg-1; Mon, 07 Sep 2020 07:47:48 -0400
X-MC-Unique: PYqdx2vkOBuCVrrp-aWETg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B77C100670D;
        Mon,  7 Sep 2020 11:47:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 448141A3D7;
        Mon,  7 Sep 2020 11:47:47 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 36C8C79FE6;
        Mon,  7 Sep 2020 11:47:47 +0000 (UTC)
Date:   Mon, 7 Sep 2020 07:47:47 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1180880820.16044889.1599479267134.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200904161240.GA3730201@kroah.com>
References: <20200811150129.53343-1-vdronov@redhat.com> <20200904114207.375220-1-vdronov@redhat.com> <20200904161240.GA3730201@kroah.com>
Subject: Re: [PATCH] debugfs: Fix module state check condition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.73, 10.4.195.19]
Thread-Topic: debugfs: Fix module state check condition
Thread-Index: Kw0NjrRlcAHw1JiDINDqN4pEdx9zzA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg,

----- Original Message -----
> From: "Greg KH" <gregkh@linuxfoundation.org>
> Subject: Re: [PATCH] debugfs: Fix module state check condition
> 
...skip...
> > A customer which has reported this issue replied with a test result:
> > 
> > > I ran the same test.
> > > Started ib_write_bw traffic and started watch command to read RoCE
> > > stats : watch -d -n 1 "cat /sys/kernel/debug/bnxt_re/bnxt_re0/info".
> > > While the command is running, unloaded roce driver and I did not
> > > observe the call trace that was seen earlier.
> 
> Having this info, that this was affecting a user, would have been good
> in the original changelog info, otherwise this just looked like a code
> cleanup patch to me.

Thank you, Greg. Makes sense indeed, I will pay attention to this next time(s).

<rant>oh so many little but important details to know and follow...</rant>

> I'll go queue this up now, thanks.
> 
> greg k-h

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

