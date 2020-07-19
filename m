Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385FDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157E620B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT0KcneR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgGSSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:23:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58969 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgGSSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595182994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ScFFpz4vFBlMNgYQO4+t85nM3baIIzWmlaiuw6ztJE=;
        b=jT0KcneRVEfLSoWykETak46+ZL+YL8ArzrR64jSSI0no13u7KY3ctUhASrgVJFzLBbCm6E
        kQ9cSpZtLQftJHTSEWWiXqSeVm0D0JThRsiYSlAxCwMGZo0xYj+cYiYKVWGbNusmEkD5/L
        keuTaJIrP+r6MxiUE1Cl383wzMhduEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ZMmX2uy3O8aWve82ysVtNQ-1; Sun, 19 Jul 2020 14:23:10 -0400
X-MC-Unique: ZMmX2uy3O8aWve82ysVtNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F928015F3;
        Sun, 19 Jul 2020 18:23:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0218A2B6DB;
        Sun, 19 Jul 2020 18:23:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 19 Jul 2020 20:23:08 +0200 (CEST)
Date:   Sun, 19 Jul 2020 20:23:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Slaby <jirislaby@kernel.org>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200719182304.GB28397@redhat.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200719072726.5892-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719072726.5892-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 07/19, Hillf Danton wrote:
>
> Dunno if the wheel prior to JOBCTL_TASK_WORK helps debug the warnings.
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2541,7 +2541,7 @@ bool get_signal(struct ksignal *ksig)
>
>  relock:
>  	spin_lock_irq(&sighand->siglock);
> -	current->jobctl &= ~JOBCTL_TASK_WORK;
> +	task_clear_jobctl_pending(current, JOBCTL_TASK_WORK);
>  	if (unlikely(current->task_works)) {
>  		spin_unlock_irq(&sighand->siglock);
>  		task_work_run();
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -43,8 +43,8 @@ task_work_add(struct task_struct *task,
>  		break;
>  	case TWA_SIGNAL:
>  		if (lock_task_sighand(task, &flags)) {
> -			task->jobctl |= JOBCTL_TASK_WORK;
> -			signal_wake_up(task, 0);
> +			if (task_set_jobctl_pending(task, JOBCTL_TASK_WORK))
> +				recalc_sigpending_and_wake(task);
>  			unlock_task_sighand(task, &flags);

To be be honest I don't understand why do you think this makes any sense...

But this doesn't matter, please note that the Jiri tested the kernel with
e91b48162332480f5 (which added JOBCTL_TASK_WORK) reverted.

Oleg.

