Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93733C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EE020719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLX9J2dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbgDBNOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:14:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31004 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726252AbgDBNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585833261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9FuKbcOCIQ0O+Rl7vW1Ij7o4TeHhbGc3orwS32PT6s=;
        b=DLX9J2dtTKnYN8eyNe+g8Qx/1Rhj2JxBcFZ0l0oUSq6tDBx90Tt9MVKCEkm8DQ17rKlzTu
        9RikTnYBYHK9nfkpMz4cq/PdXvwY2SmO2cwbR68CGqt+9K4gWlrbuafZkL/8YedO88XS0M
        KPnW9cflDl5pxofihapeDyrAfdSdotk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-FYqlg-CaNtyLk5WwxpC9Lw-1; Thu, 02 Apr 2020 09:14:20 -0400
X-MC-Unique: FYqlg-CaNtyLk5WwxpC9Lw-1
Received: by mail-wr1-f72.google.com with SMTP id q14so1459556wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J9FuKbcOCIQ0O+Rl7vW1Ij7o4TeHhbGc3orwS32PT6s=;
        b=DT+tHC+aR0ZjOAI4K5FxtKGOidESM+VM7jSjtlJ45xwA0lfy3+5Fz/t4JB7IJE3FHo
         N39rFgWWKyxTCRMHSOEZyarIwYRsj5LPH0NRByIDFejAqkbRxcitlV9IUhNr373UkXO1
         F4Q83y2/AKeNk/GEtWRSnTMOHBeYtWuqIjfpHqN/lsQIJG3QaaCUgFiYfMiQK+HOcfJL
         HkrOnQ4frKg8UioKWcmp3VMuQAQgoiNc73omg+rXsmTxtqVtcodrVtGgN/CEf+rbHS7+
         S6+6TcIRJfU2O37CiRkiuz4r99iJXU4xfG0WcTq66+Nd3z6Urt/l4LJBZplARvMY/OeD
         +FxQ==
X-Gm-Message-State: AGi0PuY640e8qpfvlUzWqNRr32k09ELVEzMqBy0ZYCgbAHhcSwhN9aqq
        4Pf9QgahHpYnNrYm4NcFVEAC/gIhg+5ifLBTTllMMLtZeNyfrXeSbPSr7/f2vBG0lo3HNrLkXCh
        ArnjA8fzJHdACvTkuZ7GZBz4V
X-Received: by 2002:a5d:5547:: with SMTP id g7mr3554476wrw.263.1585833258970;
        Thu, 02 Apr 2020 06:14:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypI6k2QkqeuadeBDwoBX1mA29lsWnnh3S3biMkaPwrc+qKUDw5ZbTEGE7lIu1FwSZ2l6+wHQnA==
X-Received: by 2002:a5d:5547:: with SMTP id g7mr3554452wrw.263.1585833258726;
        Thu, 02 Apr 2020 06:14:18 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id j6sm7902869wrb.4.2020.04.02.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 06:14:18 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:14:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200402131414.GH7174@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
 <87d08rosof.fsf@nanos.tec.linutronix.de>
 <20200401230105.GF648829@xz-x1>
 <87wo6yokdx.fsf@nanos.tec.linutronix.de>
 <20200402005003.GF7174@xz-x1>
 <87pncqnuum.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pncqnuum.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:40:49AM +0200, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> > On Thu, Apr 02, 2020 at 01:29:14AM +0200, Thomas Gleixner wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> >> +		/*
> >> >> +		 * Skip unknown sub-parameter and validate that it is not
> >> >> +		 * containing an invalid character.
> >> >> +		 */
> >> >> +		for (par = str, len = 0; isalpha(*str); str++, len++);
> >> >> +		if (*str != ',') {
> >> >> +			pr_warn("isolcpus: Invalid flag %*s\n", len, par);
> >> >
> >> > ... this will dump "isolcpus: Invalid flag domain1,3,5", is this what
> >> > we wanted?  Maybe only dumps "domain1"?
> >> 
> >> No, it will dump: "domain1" at least if my understanding of is_alpha()
> >> and the '%*s' format option is halfways correct
> >
> > It will dump "isolcpus: Invalid flag domain1,3,5". Do you mean "%.*s"
> > instead?
> 
> Obviously.
> 
> > Another issue is even if to use "%.*s" it'll only dump "domain".  How
> > about something like (declare "illegal" as bool):
> >
> > 		/*
> > 		 * Skip unknown sub-parameter and validate that it is not
> > 		 * containing an invalid character.
> > 		 */
> > 		for (par = str, len = 0; *str && *str != ','; str++, len++)
> > 			if (!isalpha(*str))
> > 				illegal = true;
> >
> > 		if (illegal) {
> > 			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
> 
> You can achieve the same thing without the illegal indirection with
> 
> 	pr_warn("....", len + 1, par);

I think it will stop working with "isolcpus=nohz,domain11,12,13".

I'll repost soon.  Thanks,

-- 
Peter Xu

