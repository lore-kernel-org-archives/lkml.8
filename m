Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA93C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B9020772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpyrOnUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCYRKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:10:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52042 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgCYRJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585156198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vevCBANHYn2Lnc4NylQjd/uYKWuxOb7yWJMgri8X8CA=;
        b=OpyrOnUkKA7kcmPJvBAg+WFzxl291VJiW8pLvz+xE1pDWFWXZubYn/htTsrYt+FhwKw+YA
        nDrqbmRKDpLyjAkFko53byKtBSHgH5/Um0ZNKgZ5LA4hGUm/7OOBRXbuB5GmtZaWLIj6Mj
        u+SIIOPoChRKx/xuFDQJInRi6Q/Jhxo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-tIvShfyUPb26ZDyz9da4Eg-1; Wed, 25 Mar 2020 13:09:57 -0400
X-MC-Unique: tIvShfyUPb26ZDyz9da4Eg-1
Received: by mail-wr1-f69.google.com with SMTP id u18so1429682wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vevCBANHYn2Lnc4NylQjd/uYKWuxOb7yWJMgri8X8CA=;
        b=KiFTgwW/59Kb2+bygmQiEOb+S3jXEVexTNoymW0sPeHZNsZ7aIoDH5WuVNJldT6Uyi
         GqyvQ5xuAN5XMQ77VJUyyohhARJpWNqozlfM+Q8sJTpcR6cCri4/odUN2Wr3eJkZTj1A
         1+9vntGC4OgY4EpA8z0ydSs6DFv7RnYZH/36kAq7uqeLIlK28pIMmYGU7qaoHZzqvLK4
         jq6W5B7sEbohXpvRSrD0SkQF08S65ZcAek1VHkTMk0X6eOu2rkiZIdSQtTzLYwbTfM/s
         ih5+gRnrPhUxP/b9Nn1zawPIfuusYuGOBlB6yfKdleuUtsPrsp0H9LCknji/jYvZK7To
         X94Q==
X-Gm-Message-State: ANhLgQ3eRAQfHr6uwya/zgeumD279+PLD28z/zDcyqhK9fcUuQMBnZy/
        cZb1+oG5G+RMG6aY3pzgUglW8iUGnYBWVzAySWkpiX9suXWt57cZ5WPgexW5HlCmCmo4qWJ6vQA
        eI5UMc0d94FUryawucnQtZw2X
X-Received: by 2002:a1c:ab54:: with SMTP id u81mr4174234wme.166.1585156195991;
        Wed, 25 Mar 2020 10:09:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsDeuPAf6z2VeRFRt7ZJYFWF9FC4OwqXVMD3tFXVyspIst/9JsJ8aRkJ29STSyG+27J7ShG6g==
X-Received: by 2002:a1c:ab54:: with SMTP id u81mr4174213wme.166.1585156195636;
        Wed, 25 Mar 2020 10:09:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc? ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
        by smtp.gmail.com with ESMTPSA id q8sm35205395wrc.8.2020.03.25.10.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 10:09:54 -0700 (PDT)
Subject: Re: [PATCH 3/4] kvm: Replace vcpu->swait with rcuwait
To:     Davidlohr Bueso <dave@stgolabs.net>, tglx@linutronix.de
Cc:     bigeasy@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6b23828-aa50-bea0-1d2d-03e2871239d4@redhat.com>
Date:   Wed, 25 Mar 2020 18:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324044453.15733-4-dave@stgolabs.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/20 05:44, Davidlohr Bueso wrote:
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 71244bf87c3a..e049fcb3dffb 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -290,8 +290,7 @@ static enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
>  	kvm_mips_callbacks->queue_timer_int(vcpu);
>  
>  	vcpu->arch.wait = 0;
> -	if (swq_has_sleeper(&vcpu->wq))
> -		swake_up_one(&vcpu->wq);
> +	rcuwait_wake_up(&vcpu->wait)

This is missing a semicolon.  (KVM MIPS is known not to compile and will
be changed to "depends on BROKEN" in 5.7).

Paolo

>  	return kvm_mips_count_timeout(vcpu);

