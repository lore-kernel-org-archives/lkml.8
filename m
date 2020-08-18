Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72DC20789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597748286;
	bh=J7VxecJmS67J6UNrXJpkf+lwbw4VNoeGDUuCvboivXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tObb1Pu72+F1xK74P/jdh2CkDNngTR6+REt8ezDohFAEkgodX7XhaiTEbq4zfgjxE
	 pqOcpdMH6qdcKffRaYU+bVbX+gpWODWcpCSnSyua4+dysMo7ttdG1FmbW1CsdNkyt0
	 kTiueKdpPJTeJXKBgbjTPxN/bkUk8kUrdvPjH/2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHRK6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgHRK6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:58:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4525205CB;
        Tue, 18 Aug 2020 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597748281;
        bh=J7VxecJmS67J6UNrXJpkf+lwbw4VNoeGDUuCvboivXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIScz0mXjK2BB/sVSQNuTDkoLRJqX/tgDNBdkAiLyg626RVbpViuzUPqzL42AoBR4
         beAW8jNZiedWuWQbaGxpU4WWNHQaQQFqBNhyHnVrfYCxcS3Yxzs7jrEgv1rdzgNagL
         6s/wNJUB329gp4PGLxa/c0fdO+swSA4HNfeucw78=
Date:   Tue, 18 Aug 2020 12:58:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5] usb: typec: tcpm: Migrate workqueue to RT priority
 for processing events
Message-ID: <20200818105824.GA135059@kroah.com>
References: <20200731065830.3744049-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731065830.3744049-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:58:30PM -0700, Badhri Jagan Sridharan wrote:
> "tReceiverResponse 15 ms Section 6.6.2
> The receiver of a Message requiring a response Shall respond
> within tReceiverResponse in order to ensure that the
> sender’s SenderResponseTimer does not expire."
> 
> When the cpu complex is busy running other lower priority
> work items, TCPM's work queue sometimes does not get scheduled
> on time to meet the above requirement from the spec.
> Moving to kthread_work apis to run with real time priority.
> Just lower than the default threaded irq priority,
> MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).
> 
> Further, as observed in 1ff688209e2e, moving to hrtimers to
> overcome scheduling latency while scheduling the delayed work.
> 
> TCPM has three work streams:
> 1. tcpm_state_machine
> 2. vdm_state_machine
> 3. event_work
> 
> tcpm_state_machine and vdm_state_machine both schedule work in
> future i.e. delayed. Hence each of them have a corresponding
> hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.
> 
> When work is queued right away kthread_queue_work is used.
> Else, the relevant timer is programmed and made to queue
> the kthread_work upon timer expiry.
> 
> kthread_create_worker only creates one kthread worker thread,
> hence single threadedness of workqueue is retained.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---

With this patch applied I get the following build breakage:

ERROR: modpost: "sched_setscheduler" [drivers/usb/typec/tcpm/tcpm.ko] undefined!

Please fix up and resend against 5.9-rc1.

thanks,

greg k-h
