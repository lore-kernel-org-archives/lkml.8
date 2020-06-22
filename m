Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1929120716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eb7tmofl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgFVGZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:25:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731248AbgFVGZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592807138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWL52GgKhbpQ7k8TUhHZOgGLDFtwgrzAarEVSsatCzw=;
        b=Eb7tmoflb6VBCF4WnplXCDFWv8sfUkiKuN37MbYhS+Wamm0lo7mAa1eUEeGV2LVBwL7hiZ
        5TWavyoCqDUV1P2+3vJ8yXlBtVwu8gH1uDE8QxaP6FLGCyOWQeG5l4I6TnFPbFNKuLdhQE
        cyQ2+VOObj7JAK53IxxowPL5DFsULGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-EkiwYrYNOTaGGSmPNZE8MQ-1; Mon, 22 Jun 2020 02:25:34 -0400
X-MC-Unique: EkiwYrYNOTaGGSmPNZE8MQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EEE4800053;
        Mon, 22 Jun 2020 06:25:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 583EC7C1FF;
        Mon, 22 Jun 2020 06:25:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Jun 2020 08:25:32 +0200 (CEST)
Date:   Mon, 22 Jun 2020 08:25:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        liuzhiqiang26@huawei.com, joel@joelfernandes.org,
        paulmck@linux.vnet.ibm.com, asmadeus@codewreck.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622062527.GA6516@redhat.com>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21, Alexander Kapshuk wrote:
>
> Export symbol __lock_task_sighand, so it is accessible from code compiled
> as modules.
> This fixes the following modpost error:
> ERROR: modpost: "__lock_task_sighand" [net/9p/9pnet.ko] undefined!
>
> Where __lock_task_sighand is called via lock_task_sighand in net/9p/client.c
> See https://lore.kernel.org/lkml/20200620201456.14304-1-alexander.kapshuk@gmail.com/.

Why?

current->sighand is stable and can't go away. Unless "current" is exiting and
has already passed exit_notify(). So I don't think net/9p needs this helper.

However, the games with TIF_SIGPENDING doesn't look right in any case.

Oleg.

