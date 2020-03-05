Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2EEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A1220870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583431117;
	bh=hfXqSVx/myuEP6+ICWJ8cnf/KqlVsVU4J6nyP0XIjk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=Ohnt7s2X99sjR/SAmOd9jTwFWyyxTVNqwXyYoKcvXsQloExOtELIJnfSHsuxpjYNs
	 mitg/h/NUy1rfMGkVPmAOku88w/iEyX+3HqrN1bwTN9Z3L7LQOOGCmNqAzfEnlZDNh
	 gKMDbMHkqp5MWAUALOVHJMsaFY+4IcSsVkMk+y6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCER6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCER6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:58:36 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00B52072D;
        Thu,  5 Mar 2020 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583431115;
        bh=hfXqSVx/myuEP6+ICWJ8cnf/KqlVsVU4J6nyP0XIjk4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qKSJyEad6J2TWe3CtG7UZzYFFd4titNuDlpvxKTy3PyKXHxM+6GOX5bg084YvbTUC
         OXZhhVtwBhHm7Gur8ValiHFpWjvNfhl3MzEKJcJDOF+3zk9UkTyKHkNy35wi51wBDM
         fJuZ/lGKJC1/cYF6DQrlJNeVgb8Zr94YLOK6UAl0=
Message-ID: <1583431113.12738.63.camel@kernel.org>
Subject: Re: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
From:   Tom Zanussi <zanussi@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>
Cc:     Scott Wood <swood@redhat.com>
Date:   Thu, 05 Mar 2020 11:58:33 -0600
In-Reply-To: <9003e4a9e5774ecfa377d218c71c2ad2@AcuMS.aculab.com>
References: <cover.1582814004.git.zanussi@kernel.org>
         <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
         <9003e4a9e5774ecfa377d218c71c2ad2@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 2020-03-05 at 13:38 +0000, David Laight wrote:
> From: zanussi@kernel.org
> > Sent: 27 February 2020 14:34
> > [ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]
> > 
> > If user task changes the CPU affinity mask of a running task it
> > will
> > dispatch migration request if the current CPU is no longer allowed.
> > This
> > might happen shortly before a task enters a migrate_disable()
> > section.
> > Upon leaving the migrate_disable() section, the task will notice
> > that
> > the current CPU is no longer allowed and will will dispatch its own
> > migration request to move it off the current CPU.
> > While invoking __schedule() the first migration request will be
> > processed and the task returns on the "new" CPU with "arg.done =
> > 0". Its
> > own migration request will be processed shortly after and will
> > result in
> > memory corruption if the stack memory, designed for request, was
> > used
> > otherwise in the meantime.
> > 
> > Spin until the migration request has been processed if it was
> > accepted.
> 
> What happens if the process changing the affinity mask is running
> at a higher RT priority than that of the task being changed and
> the new mask requires it run on the same cpu?
> 
> 	David
> 

This patch, 'sched: migrate_enable: Use per-cpu cpu_stop_work', removes
the busy wait and is queued for the next update:

https://lore.kernel.org/linux-rt-users/20200203173732.ldbgbpwao7xm23mm@linutronix.de/T/#mf19a8af38ac4ea0cc01775835e9d715f175f0b7b

Thanks,

Tom


> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
