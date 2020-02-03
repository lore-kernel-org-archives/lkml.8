Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55970C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B55D2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHbIPC6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBCTWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:22:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40608 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbgBCTWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580757719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MpZWTjMDAUxJVuxsB9yu8VexNaGThYoWC5vbsTHH2M=;
        b=dHbIPC6KKiGrbBY7DjxTYKg6yF9GHzN1gaohBtO5H5EjwE+/D9IUFmpe9AwdSaaZ2YSItc
        2ihVxCP88kGvuXky5/tPk7DMggv0Mh0qrGQnkxf1MM24sW6TBlvJHT9AXmkL5dCK/KJgJf
        s7/p4ReW93DL4qAp/LSbGsjT3vsrYYQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-IyUNWXFfP2Kw9VCfrYpVJQ-1; Mon, 03 Feb 2020 14:21:58 -0500
X-MC-Unique: IyUNWXFfP2Kw9VCfrYpVJQ-1
Received: by mail-qt1-f199.google.com with SMTP id k27so10601950qtu.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MpZWTjMDAUxJVuxsB9yu8VexNaGThYoWC5vbsTHH2M=;
        b=rfSxNRFj0dBVis3e/aYsNimu0bcVw6JqQjszDBPoyeeb4cF9Sw52+1P6y8JVN48srL
         Rqo65OqIp5T6JY2vGQqYlV5x6Al72Zt1RESI+TJSgdyYOjKoERfl53v6ZktaB5z1LAGe
         0MVueJBoFMicICsRKNvrrPJJAgZ8gWfdSTrWF2qdnM0+1hmTahkT0VAdMkeGuRYjBYeC
         csWJzZkb14LeRiih6SSlYo1TLosCeVDcaXnzOcSnKUg8yGFUuiIlsrJllSfR5eMoToGu
         2yJn1OBrNi++xx6uccxFv2h9QNPyAk3uI8FSnhAifcangD5pj79wvMFdr736B+8Z601B
         KhZg==
X-Gm-Message-State: APjAAAXUlOt2b01L2byAGEhLoEJS5ixqJM6VCRIGraBeTGFlcebjT5Tf
        f+T+TSE20qX6+IRbXJaj1OEy6mSctE3O5WTqxuWefO6w4rUeSAvmv7dcR8rMsQvcU11XCC4O9s8
        0L9aWgZ4HVDJcDQzWJjrQVpQr
X-Received: by 2002:a37:a390:: with SMTP id m138mr23602909qke.23.1580757717761;
        Mon, 03 Feb 2020 11:21:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYKyAXIkCVY9EEUa5/pCCsPkLlLcI11dqxiZKszuC4tqFWBEUSuBmQZQsS8fkh+UrOgiA2uA==
X-Received: by 2002:a37:a390:: with SMTP id m138mr23602885qke.23.1580757717490;
        Mon, 03 Feb 2020 11:21:57 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id f59sm7396901qtb.75.2020.02.03.11.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:21:56 -0800 (PST)
Date:   Mon, 3 Feb 2020 14:21:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH V4] sched/isolation: isolate from handling managed
 interrupt
Message-ID: <20200203192154.GG155875@xz-x1>
References: <20200120091625.17912-1-ming.lei@redhat.com>
 <87eevrei7h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87eevrei7h.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:25:38PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> >  
> > +static bool hk_should_isolate(struct irq_data *data,
> > +			      const struct cpumask *affinity, unsigned int cpu)
> > +{
> 
> the *affinity argument is unused.
> 
> I'll remove it myself.

Hi, Ming, Thomas,

The new "managed_irq" works for us, thanks for both of your work!

However I just noticed that this new sub-parameter might break users
if applied incorrectly to old kernels, because iiuc "isolcpus="
parameter will not apply at all when there's unknown sub-parameters:

static int __init housekeeping_isolcpus_setup(char *str)
{
	unsigned int flags = 0;

	while (isalpha(*str)) {
                ...
                pr_warn("isolcpus: Error, unknown flag\n");
                return 0;
        }
        ...
}

Then the same kernel parameter will break isolcpus= if the user
reboots and switches to an older kernel.

A solution to this could be that we introduce an isolated parameter
for "managed_irq", then on the old kernels only the new parameter will
be ignored rather than the whole "isolcpus=" parameter, so nothing
will break.

I'm not sure whether it's already too late for this, or if there's any
better alternative.  Just raise this question up to see whether we
still have chance to fix this up.

Thanks,

-- 
Peter Xu

