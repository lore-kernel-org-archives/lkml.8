Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A0FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0ECE2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203918;
	bh=MXSdrHZzmbut5RIOsHKlqKuQT+OCYYx8HUozgUTh0GA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u2vhMWrZrycZRLBWVbkWQfxjXiuTA2MXUxv5lAhhjSItR8KQtfkIqNCQuXOiUPR34
	 z+6WRrpCsbCXE3Iv9FRnA5qqLO9vRFFFl5cJvDRlA4207cJse9/yAZK5e8EUYka446
	 kHYBbDdeq/ZzS+c5AD9fBaQMyaYe3iqwu9Y9Dg/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgFOGv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgFOGvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:51:53 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC762067B;
        Mon, 15 Jun 2020 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203912;
        bh=MXSdrHZzmbut5RIOsHKlqKuQT+OCYYx8HUozgUTh0GA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VagLU8bhUbiMK1OapqvsVP9NnARbzuEyejCHT7HlskFXsSulenvAKUpOhebVs+gde
         oHFgPkS8/W8ix6mS0/N9iUuyT6+K+BbWniodIBmHseHGeLMGOa90b+piCqgL2Oru7F
         CrmZKQmzWdKog4MHPgO6jic9VgZkJx3U3FsMP89E=
Date:   Mon, 15 Jun 2020 08:51:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH] Documentation: fix sysctl/kernel.rst heading format
 warnings
Message-ID: <20200615085148.43dd33d7@coco.lan>
In-Reply-To: <8af1cb77-4b5a-64b9-da5d-f6a95e537f99@infradead.org>
References: <8af1cb77-4b5a-64b9-da5d-f6a95e537f99@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 14 Jun 2020 21:11:00 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix heading format warnings in admin-guide/sysctl/kernel.rst:
> 
> Documentation/admin-guide/sysctl/kernel.rst:339: WARNING: Title underline too short.
> hung_task_all_cpu_backtrace:
> ================
> 
> Documentation/admin-guide/sysctl/kernel.rst:650: WARNING: Title underline too short.
> oops_all_cpu_backtrace:
> ================
> 
> Fixes: 0ec9dc9bcba0 ("kernel/hung_task.c: introduce sysctl to print all traces when a hung task is detected")
> Fixes: 60c958d8df9c ("panic: add sysctl to dump all CPUs backtraces on oops event")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Guilherme G. Piccoli <gpiccoli@canonical.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  Documentation/admin-guide/sysctl/kernel.rst |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- lnx-58-rc1.orig/Documentation/admin-guide/sysctl/kernel.rst
> +++ lnx-58-rc1/Documentation/admin-guide/sysctl/kernel.rst
> @@ -335,8 +335,8 @@ Path for the hotplug policy agent.
>  Default value is "``/sbin/hotplug``".
>  
>  
> -hung_task_all_cpu_backtrace:
> -================
> +hung_task_all_cpu_backtrace
> +===========================
>  
>  If this option is set, the kernel will send an NMI to all CPUs to dump
>  their backtraces when a hung task is detected. This file shows up if
> @@ -646,8 +646,8 @@ rate for each task.
>  scanned for a given scan.
>  
>  
> -oops_all_cpu_backtrace:
> -================
> +oops_all_cpu_backtrace
> +======================
>  
>  If this option is set, the kernel will send an NMI to all CPUs to dump
>  their backtraces when an oops event occurs. It should be used as a last
> 



Thanks,
Mauro
