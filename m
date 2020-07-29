Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4971522B42
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596034405;
	bh=fp2UmJ60nahw5GDWRN0Aw65GthA1YO0B+AQzyViir4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=amf1XXIG5u5z/oTV4KOP5DrMdX8W6+SpjHFbR37sjcj662DXRGRBrubiWhsfbo8PO
	 d2vapyxOlqzhzAuvOQnUt6pWQPueJfi1awW7K7fvydKkPgGrh6jyRIJ/uKgsdWhxFF
	 lAIqTd9uziHazUnpVjjrPKQy82DOH0fbKPOf83nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgG2OxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgG2OxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:53:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A29121744;
        Wed, 29 Jul 2020 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596034399;
        bh=fp2UmJ60nahw5GDWRN0Aw65GthA1YO0B+AQzyViir4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBUvVV1R89Ln+j78ufGotq8p+n7KvD1YVJ6LxenHh/ilGpPs6Yb/uV+v+mTZ424aG
         KnA2dbpF0QwLxV/NYoYPAjeU0uaOI0lbYVQB7MO43C4c0yEkbBuypsETuRVcG1PMsB
         8y8MscqKKOtrXTt1lKOBxzm507dEdnSfuCz5d3hk=
Date:   Wed, 29 Jul 2020 16:53:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Migrate workqueue to RT priority
 for processing events
Message-ID: <20200729145309.GA3490882@kroah.com>
References: <20200724020551.2737376-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200724020551.2737376-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:05:51PM -0700, Badhri Jagan Sridharan wrote:
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

This doesn't apply against my usb-next branch at all.

Can you rebase and resend?

Remember to collect the reviewed-by tags as well when you do so.

thanks,

greg k-h
