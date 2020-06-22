Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF98A20708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYezhqu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFVLbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:31:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21320 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726998AbgFVLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592825509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmsQUkrMhCL5SGBQbKt+n8nVk/2RnNQHsX/u5U1pL3A=;
        b=BYezhqu/9TZbdH3F2gN8e44fSwMecjtU2dtAlHld5VT7wJ5t1L2K2K25srDEQ/Vb0sqSL+
        /Mm9Le6uYQTKGGv+4XlyztqGXKqx1Gqzql7HcwXW072kuUPXftlDPsarIcIZV5RuUU/IU0
        zDihYI797DBzcg54akS1twPkQ9TDKwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Gvw9u-L-MLSNYGSHhyeS9A-1; Mon, 22 Jun 2020 07:31:47 -0400
X-MC-Unique: Gvw9u-L-MLSNYGSHhyeS9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA166107ACF4;
        Mon, 22 Jun 2020 11:31:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id 723CE1A8F5;
        Mon, 22 Jun 2020 11:31:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Jun 2020 13:31:45 +0200 (CEST)
Date:   Mon, 22 Jun 2020 13:31:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622113141.GC6516@redhat.com>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
 <20200622102401.GA12377@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622102401.GA12377@nautica>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22, Dominique Martinet wrote:
>
> What about the possibility of sighand being null that the function does
> check, is that impossible for current as well?

It is only possible if "current" has already exited and passed exit_notify(),
iow if it is already a zombie and can be (auto)reaped.

Oleg.

