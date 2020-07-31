Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9292C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F822245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZDali6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgGaMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:39:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733093AbgGaMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596199160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNeA04+1XYPzyOhWw2oc2hqG+CGv2cApApUzSqaPtB8=;
        b=VZDali6vwAbbQJ1/Np6mAcq9KLbxC4TuJIBqJfGWprQyWZiI5Z2a/xNaR8FtsO5ITsYBwr
        331qIwtC4GGX6k4F3hT30HPAFfUrcJP/GUuQNamFZi/rdonz7jPxT4IRj6PNci9m4CNJdZ
        muUE8xfNprEWk6558FS5N1HtaMg3ILU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-6PsxlUCyO-qEuopFkCWz6w-1; Fri, 31 Jul 2020 08:39:18 -0400
X-MC-Unique: 6PsxlUCyO-qEuopFkCWz6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49CE0801A03;
        Fri, 31 Jul 2020 12:39:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7059719C58;
        Fri, 31 Jul 2020 12:39:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 31 Jul 2020 14:39:16 +0200 (CEST)
Date:   Fri, 31 Jul 2020 14:39:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V3 0/3] posix-cpu-timers: Move expiry into task work
 context
Message-ID: <20200731123912.GA13775@redhat.com>
References: <20200730101404.956367860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730101404.956367860@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30, Thomas Gleixner wrote:
>
>  arch/x86/Kconfig               |    1 
>  include/linux/posix-timers.h   |   17 +++
>  include/linux/sched.h          |    4 
>  include/linux/seccomp.h        |    3 
>  kernel/entry/common.c          |    4 
>  kernel/time/Kconfig            |    9 +
>  kernel/time/posix-cpu-timers.c |  216 ++++++++++++++++++++++++++++++++++++-----
>  kernel/time/timer.c            |    1 
>  8 files changed, 227 insertions(+), 28 deletions(-)

FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

