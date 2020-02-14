Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB62C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016DE206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CesTyts3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgBNTkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:40:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729633AbgBNTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581709213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BE9teR/4Mz7yydIxx4Z3k95pTHytQ+QYaa5uCwafbV0=;
        b=CesTyts35amLfIahLWRnttHtl2bVNYYRmeEW/eSqNMTzdyfIEnzUQEm3wSqz9FRFo6OruV
        w+fZ8Cm/Bi73HFByzgaHhOxkjSwFQwMWyxcnZ+lT1MMqL9wA1Su17+UqXu5/qdKWFpUfXj
        8R0bdcuyEVWzS1WsB3Q1R0zKFqvB6DI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-_hLdMz4tN3-qYYc-y7uaow-1; Fri, 14 Feb 2020 14:40:12 -0500
X-MC-Unique: _hLdMz4tN3-qYYc-y7uaow-1
Received: by mail-qv1-f69.google.com with SMTP id p3so6389358qvt.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BE9teR/4Mz7yydIxx4Z3k95pTHytQ+QYaa5uCwafbV0=;
        b=cnoV1Nvd6IkzpFRf/lInClccIrUKtzNWaz8kOhjNkV1vwlYD9yYHU+RSqv2KVtJshr
         lkclYL/i9FGpUfIjsJqiNqfZohQLvtQEO9F25IWbdxXx+D54hcJwyvDtGpmCu1bGgdbH
         hKkw1uh+OSb7lp7H5+rDEIVFKWxUV7vR1ck7z/11TNHOsNkL6PZe7or43RgAtxZCZR0l
         5RxIN7ZwJXfEzSWTa+onKMtQblEBBzrJvtdeydRWzDMxKycFSAbcAHWcy1i9U8h7LQ6o
         ywrZkRPIRuEcyFiV7tx1xn/R/GqklXt18JfVIVU+KdVDzOqy19HDFYDWkqEG4wV+/GzX
         RyAw==
X-Gm-Message-State: APjAAAVrbBJbVMw8+3YClkPrOy/LQsYjntXFMsS5haBV1ZvkZEftmnNM
        VqmFIMAsNRL3xoDZ13/4VFNDhPz3z2mr9lptn4rk7AwHtel5OZF6ZMbJ9kDT1xJpP0bt12sTdXA
        4HpGxf9xuGPnQr63gjpN84QIv
X-Received: by 2002:a37:c49:: with SMTP id 70mr4265162qkm.12.1581709211258;
        Fri, 14 Feb 2020 11:40:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIfgOvyKPo0dPjB9m4JrN4P419c0E8fs0nNBksTNU/4s3Oo9D6YcAB01pS1mSfyNQja16xgg==
X-Received: by 2002:a37:c49:: with SMTP id 70mr4265146qkm.12.1581709211022;
        Fri, 14 Feb 2020 11:40:11 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id t187sm2583971qke.85.2020.02.14.11.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:40:09 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:40:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200214194008.GA1193332@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200204161639.267026-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:16:39AM -0500, Peter Xu wrote:
> The "isolcpus=" parameter allows sub-parameters to exist before the
> cpulist is specified, and if it sees unknown sub-parameters the whole
> parameter will be ignored.  This design is incompatible with itself
> when we add more sub-parameters to "isolcpus=", because the old
> kernels will not recognize the new "isolcpus=" sub-parameters, then it
> will invalidate the whole parameter so the CPU isolation will not
> really take effect if we start to use the new sub-parameters while
> later we reboot into an old kernel. Instead we will see this when
> booting the old kernel:
> 
>     isolcpus: Error, unknown flag
> 
> The better and compatible way is to allow "isolcpus=" to skip unknown
> sub-parameters, so that even if we add new sub-parameters to it the
> old kernel will still be able to behave as usual even if with the new
> sub-parameter is specified.
> 
> Ideally this patch should be there when we introduce the first
> sub-parameter for "isolcpus=", so it's already a bit late.  However
> late is better than nothing.

Ping - Hi, Thomas, do you have any further comment on this patch?

Thanks,

-- 
Peter Xu

