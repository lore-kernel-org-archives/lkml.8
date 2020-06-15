Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550AB206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIT3Mpa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgFOODz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729962AbgFOODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592229829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxvGAQAw035ra8R4hqvENivZC/Q6I9cGWmRWkVLwaLw=;
        b=BIT3Mpa4h56/lPhqANt2hbjKFBzxcD62yjZPomEDi3v/7nrCUwPJY0X8BLK+58Nk3rMaUD
        K2ebq364+PN3TpkOkwu6i9NOrgyWaNVoT6EJD/OeHU2a7MU/j4BmroTjKneYFT3fafBaXp
        AvNdaXLNplShCGIUNoozhkrJXXKqhgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-2T5I5DRNMmKTnabEBFEX3w-1; Mon, 15 Jun 2020 10:03:44 -0400
X-MC-Unique: 2T5I5DRNMmKTnabEBFEX3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF273109326A;
        Mon, 15 Jun 2020 14:03:02 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 592F67B603;
        Mon, 15 Jun 2020 14:03:02 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9B928833BD;
        Mon, 15 Jun 2020 14:03:01 +0000 (UTC)
Date:   Mon, 15 Jun 2020 10:03:01 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        ltp@lists.linux.it, Serge Hallyn <serge@hallyn.com>
Message-ID: <1101600340.15989438.1592229781375.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200615091850.GA3373@yuki.lan>
References: <20200615085836.GR12456@shao2-debian> <20200615091850.GA3373@yuki.lan>
Subject: Re: [LTP] 303cc571d1: ltp.setns01.fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.25, 10.4.195.29]
Thread-Topic: 303cc571d1: ltp.setns01.fail
Thread-Index: cwh21FyAYYmtDPp3+d47RhirG3sYUg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> Hi!
> > setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(12, 0x20000)
> > setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(12, 0x40000000)
> > setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(12, 0x20000000)
> > setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> > setns01     0  TINFO  :  setns(12, 0x4000000)
> > setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > errno=EBADF(9): Bad file descriptor
> 
> The messages here are a bit cryptic, I will fix that later on, but what
> it means here is that the errno has changed from EINVAL to EBADF in a
> case we pass file descriptor to a regular file to setns().

I posted a series that accepts both errnos about week ago:
  https://lists.linux.it/pipermail/ltp/2020-June/017467.html

