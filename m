Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7627D21556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTRn6QxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgCCK17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:27:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35593 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgCCK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:27:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id 7so1343779pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NM5OBg7wjSm9ahSxr+glEUcEzM//RBoFyXJe1qPSFMw=;
        b=YTRn6QxAGzC6Dtyaill9cTju3svs034GwSEw8+PbDe64VmcI7OhqhJ27cpScVHEQ9+
         HfoxdtgYcEKk9ZohGDXaPKg9zCkSs1DpukyEsUF8w6qjxKsG8xPsMaZtUiQ/jct+j8sm
         HLSTLPTMP5Bbqom0T3ymAm9dlFUP2HPq+aJsMhgDJMgJHaauq7Lmpmt86EB9AZljBaH8
         5jPF//rN+gqnWfwsI5JvdhUmXT/bdkkzLWWKj4Tv8QLLa63eFJy+QvgvDLqJ0t+l/LVu
         Qy10WygnWRTm4TM+WPZmQI99R+vZkFW/OWMCVyG3IVGFTofVpy96P8lW3bETyvNhhHZt
         Xs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NM5OBg7wjSm9ahSxr+glEUcEzM//RBoFyXJe1qPSFMw=;
        b=g/0ciNyKaS7MABYk+MOxWIY3SvHvSABsGCoOK4/zpNW/W1pcfRpRLGw3JnsmVmyvZm
         IaeHIjU5UugHCM65rpCTD4g1ef3q3pkwrlaDnyTOg+uzFCa1OoErTN+WMF8lhOV6DFAw
         oeCS4AcJniOJiekeoWWfLqrw6xkuqZigl2ALy49NCXo1bJq8XnmVINYgtcq1a8KX0M9S
         Jobi4bp5TjZ/Qw+JcDohxFLZlY5NiaDELJbU6NePyt7PVTX9R+ELhr698l7OXVZZAZo2
         0fvRw4Vxa/wOoIZ62KUhoRjNHg33O7d3LvFH38NXmyd9LppQWrO0K+Dc4bxcwSm2KIYO
         XVnQ==
X-Gm-Message-State: ANhLgQ2XRdzPFHJcqLJ6DeB7+T9ITr2MPqbH9rii185gbQXTo32oPu3a
        0BYUG+rBEVrckkMN5tQQXc4=
X-Google-Smtp-Source: ADFU+vsPx44QNf/M8Hqo/+8MHSsKnA29XoFso93QydvUyvwY/bq1FDvhyC5vC8WhVMldRmnV7qZtZg==
X-Received: by 2002:aa7:8b03:: with SMTP id f3mr3531459pfd.133.1583231277793;
        Tue, 03 Mar 2020 02:27:57 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id a71sm8700358pfa.117.2020.03.03.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 02:27:56 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 3 Mar 2020 19:27:53 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200303102753.GB904@jagdpanzerIV.localdomain>
References: <20200303044059.1325-1-sergey.senozhatsky@gmail.com>
 <20200303091847.uyy7gzac52lkl75m@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303091847.uyy7gzac52lkl75m@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/03 10:18), Petr Mladek wrote:
[..]
> >  static void queue_flush_work(struct printk_safe_seq_buf *s)
> >  {
> > -	if (printk_safe_irq_ready)
> > +	if (printk_percpu_data_ready())
> >  		irq_work_queue(&s->work);
> 
> This is not safe. printk_percpu_data_ready() returns true even before
> s->work gets initialized by printk_safe_init().

Good catch! I'll move printk_safe_init() call from init/main.c to
set_percpu_data_ready().

> Solution would be to call printk_safe_init() from
> setup_log_buf() before calling set_percpu_data_ready().

I'll move the init call. But printk_safe/nmi called too-early
will still write to no-yet-initialised per-cpu data.

	-ss
