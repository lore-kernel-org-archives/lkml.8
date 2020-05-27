Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3FDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9767E20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8lc9LOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbgE0QKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:10:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388257AbgE0QKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590595840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpS5WDJIgyjBNnbz57joD1fkY56BnMjV/cB+edX+sFA=;
        b=H8lc9LOI2noyInyzXkIdjrrpBQIHD0ANU/yJo6pI8yVNQ/SCr1euf1fH34fEwxrpdTcgEJ
        QkoQsFXj+H95OjX/WUV2fxI3QWRvRwDOoCcBk98ybNl9V4ihpKdPyE9+l/9SsKTxSk8RmP
        b51Gh9UnJEjjUMq3zAyrWRSkbc/AuKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-g_pF_0AaPdmCjaMe-IhTQg-1; Wed, 27 May 2020 12:10:39 -0400
X-MC-Unique: g_pF_0AaPdmCjaMe-IhTQg-1
Received: by mail-wm1-f72.google.com with SMTP id o8so1048609wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpS5WDJIgyjBNnbz57joD1fkY56BnMjV/cB+edX+sFA=;
        b=cxpMEneuFMWjI9IKdHVCdYxEZEzNr9K43msSbnG7eGwtz/ivtRKyY5bELjHepPZ8Wa
         7vP+CbWXdyM5GEGQNgg7JzZrzV7hbJh6z/IMJsIzqSfS5RwhvPq64GiCKsfRQ/T5zYzn
         MTXK7WO4rfBMuDBSgnvF+EBPlzpxEQ+DiJUqgcjbSQ+qiCsPsYl8+Xw1ZwX/b6eFWpxm
         pGr4N+dMvkQtzy8ZCtBHXvPyfHUzQFA1EvFIcjyytTIR7VwMwu0FrwbC3thu/FtAJv/W
         +d2FgByuex0SH4Iq7Nh9CmFtJY3kGJQ0l274L8wRh6isp98K0FSB+Nf1KYEtJ3VbmFVC
         Ys6w==
X-Gm-Message-State: AOAM531li050R1EubhVETha65G7QSFLVX0vF6JkPLLXuZ0wexV4rFlBE
        ngInLiHr56sx+0+PMrCWfgy2OPkivg/R6l/FQ+ZQL0VGs6UwmMdZb0kSg5IdG0GQgCBKfPnLRt5
        pGeztPdk9WiozJGJMe4HdE/N+
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr4939087wmg.63.1590595838097;
        Wed, 27 May 2020 09:10:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwv2WOvp+dGE5Bd+63NHTAUmNpXjYKI6PXzKuriRFk4SIKF8scu4bdTkpQ8+eWY4jLf6e98w==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr4939064wmg.63.1590595837858;
        Wed, 27 May 2020 09:10:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id a10sm3149808wmf.46.2020.05.27.09.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:10:37 -0700 (PDT)
Subject: Re: [PATCH RFCv2 0/9] kvm/arm64: Support Async Page Fault
To:     Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200526130927.GH1363@C02TD0UTHF1T.local>
 <987785b2-2533-c3d8-8f6a-4193aa82d502@redhat.com>
 <ae0f32fa338969d25dc3da56292e35ed@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb2a2291-85b0-a39a-96d1-58e4652771ba@redhat.com>
Date:   Wed, 27 May 2020 18:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ae0f32fa338969d25dc3da56292e35ed@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 09:48, Marc Zyngier wrote:
> 
> My own question is whether this even makes any sense 10 years later.
> The HW has massively changed, and this adds a whole lot of complexity
> to both the hypervisor and the guest.

It still makes sense, but indeed it's for different reasons.  One
example is host page cache sharing, where (parts of) the host page cache
are visible to the guest.  In this context, async page faults are used
for any kind of host page faults, not just paging out memory due to
overcommit.

But I agree that it is very very important to design the exception model
first, as we're witnessing in x86 land the problems with a poor design.
 Nothing major, but just pain all around.

Paolo

> It also plays very ugly games
> with the exception model, which doesn't give me the warm fuzzy feeling
> that it's going to be great.

