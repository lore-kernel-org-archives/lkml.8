Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE2C54E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C92F20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMykq6d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgEFXdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:33:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21036 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728025AbgEFXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588807991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pfQoeEa1kW6MG/2DtjypUr2NTPIec15JxFs4Iomupo=;
        b=iMykq6d1BNov1Hd1a6EUzuBJCyFGR58UGgOuNf2cEUwt8GAzJwUkrYnFqTfXQa3i+eH1J2
        jZ0D9g5L7kmGww6JmHU8MDOrdY8Ml0VqsMeH84d5Qa8DhBGGNhjKRzaKBtH1rIiXKGXazF
        hZALDV1O809ToyvwWgF4DPbeoqY5ycU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-QMKne2mWM3ORP7InAk7zcQ-1; Wed, 06 May 2020 19:33:10 -0400
X-MC-Unique: QMKne2mWM3ORP7InAk7zcQ-1
Received: by mail-qk1-f198.google.com with SMTP id x8so3630262qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 16:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0pfQoeEa1kW6MG/2DtjypUr2NTPIec15JxFs4Iomupo=;
        b=CoaN1B459ETw1FiPBOr8sKj0CsM6MrON7eCWOkIspXXpNPdDQsMmwJTeyBG/MeS3gX
         1qrwno2PptgIQnyeeY7ksss+xj9BxzSWcvarl2ClBa8GlUGjOSSwBFj40mBf0pqzcGqf
         s+7U/ZDB1+5z3JANXyAQMln2ucZXUSXSDTpl2cP3HXIMrqNkmSXIoljZeOAVe8nsFTIL
         fo3amT9zei8x3FKENfXWpLO7eozJdU2dzqq5VF/iu1/3a6WKqlJVjLPgBSzH9GiaV5u6
         usz8HMN/4iCwAhIVaeSqNuv3CtCfvvGSB6IjAlE4qQgeypDAHKqKn09oHMl30RHS7Aoc
         W5Uw==
X-Gm-Message-State: AGi0PubSaSMlJMjx/rw9Pi536Tfizgj0lezH9uyIT+auQR0R9WHMHYf2
        0ziZt+w7LzGfGY3FT67lt1YOOTpFr1HvJ+v8cX2MYy0k9OH4NanI+6aCmxao1Afuwc9UXieGTOl
        QQpttWNbz2xotq+8uYDm6ba/K
X-Received: by 2002:a37:b8c4:: with SMTP id i187mr11796117qkf.410.1588807989280;
        Wed, 06 May 2020 16:33:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKCtvx8XlGYnE5dBf5nozBgNURfUeYYut3pjIFFmgxex5jv3IeFSkfP+0AIP3lxsLENailb4g==
X-Received: by 2002:a37:b8c4:: with SMTP id i187mr11796083qkf.410.1588807988877;
        Wed, 06 May 2020 16:33:08 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 66sm925492qkk.31.2020.05.06.16.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 16:33:08 -0700 (PDT)
Date:   Wed, 6 May 2020 19:33:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 8/9] KVM: x86, SVM: do not clobber guest DR6 on
 KVM_EXIT_DEBUG
Message-ID: <20200506233306.GE228260@xz-x1>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-9-pbonzini@redhat.com>
 <20200506181515.GR6299@xz-x1>
 <8f7f319c-4093-0ddc-f9f5-002c41d5622c@redhat.com>
 <20200506211356.GD228260@xz-x1>
 <20200506212047.GI3329@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506212047.GI3329@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:20:47PM -0700, Sean Christopherson wrote:
> On Wed, May 06, 2020 at 05:13:56PM -0400, Peter Xu wrote:
> > Oh... so is dr6 going to have some leftover bit set in the GD test if without
> > this patch for AMD?  Btw, I noticed a small difference on Intel/AMD spec for
> > this case, e.g., B[0-3] definitions on such leftover bits...
> > 
> > Intel says:
> > 
> >         B0 through B3 (breakpoint condition detected) flags (bits 0 through 3)
> >         — Indicates (when set) that its associated breakpoint condition was met
> >         when a debug exception was generated. These flags are set if the
> >         condition described for each breakpoint by the LENn, and R/Wn flags in
> >         debug control register DR7 is true. They may or may not be set if the
> >         breakpoint is not enabled by the Ln or the Gn flags in register
> >         DR7. Therefore on a #DB, a debug handler should check only those B0-B3
> >         bits which correspond to an enabled breakpoint.
> > 
> > AMD says:
> > 
> >         Breakpoint-Condition Detected (B3–B0)—Bits 3:0. The processor updates
> >         these four bits on every debug breakpoint or general-detect
> >         condition. A bit is set to 1 if the corresponding address- breakpoint
> >         register detects an enabled breakpoint condition, as specified by the
> >         DR7 Ln, Gn, R/Wn and LENn controls, and is cleared to 0 otherwise. For
> >         example, B1 (bit 1) is set to 1 if an address- breakpoint condition is
> >         detected by DR1.
> > 
> > I'm not sure whether it means AMD B[0-3] bits are more strict on the Intel ones
> > (if so, then the selftest could be a bit too strict to VMX).
> 
> If the question is "can DR6 bits 3:0 be set on Intel CPUs even if the
> associated breakpoint is disabled?", then the answer is yes.  I haven't
> looked at the selftest, but if it's checking DR6 then it should ignore
> bits corresponding to disabled breakpoints.

Currently the selftest will also check that the B[0-3] is cleared when specific
BP is disabled.  We can loose that.  The thing is this same test can also run
on AMD hosts, so logically on the other hand we should still check those bits
as cleared to follow the AMD spec (and it never failed for me even on Intel..).

Thanks,

-- 
Peter Xu

