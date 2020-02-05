Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04DFC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868252072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsCVEZXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBEWXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:23:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38512 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgBEWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:23:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so3589110oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7BPBFZwYMLdjTS7FC4wsJG0SBY3jzmuiQq5ab/pR8tE=;
        b=bsCVEZXyO1m1nDWrhyLfqfamqKXOfvuJP41PTr4vHEntSvyBELd7iYKhNse6c2Tn9g
         iIYLNxjo6KV5OEOU8j19451ahN0XbitPB0O/3aRADfb1w9uvKbYi0JIUSthzfFbgWSZV
         dMOREBTUlTsa8xBI1nry+fdIWSqxaER3PK0/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7BPBFZwYMLdjTS7FC4wsJG0SBY3jzmuiQq5ab/pR8tE=;
        b=WawFKlh0izu9HoSIkw4nxRt1lYGV0wLOyK3NGtBBe64AU7ehZYUzSBfoODu6AUvfYB
         HUKSVzEuW2eg9eDGR4RG31EX4yuZWdyZ6T5HGrpm+/hUscMpqC5PYCtw4K07nDy/mcCS
         SVjUgAinKMtfYC2Yq7MjeAm/bFW205GPDhlIEXfwasSOlrO3pIVzt04woXa5+EG5VOCm
         /GgJ61vTl5fARgGJaUb5QZxMdZtbl8589JVBUAb+M1DWPXfVauVAnSrIWXEayJfrJCQM
         71zK/Iwl+nC6BQG3mVvj+AE7Vc2ALd+CNZ2dmIUv0jpcLgfk05O5hBsPdG/6vPA1WkjA
         EIiA==
X-Gm-Message-State: APjAAAUlB/OYtOct3Xf6qWH4YYgSa1DOS+TOLqzdNQ8dS0W0mxlqVAs1
        KgRSr+f7xjcHV0ZuUjGEKaCb5w==
X-Google-Smtp-Source: APXvYqwiWxsqH9jzwGGCPTTA/BuMOcFastWQH/FIEhWKfTbMO7E5g/kRONngb8jpggIUpd8KuKUR/A==
X-Received: by 2002:a9d:1ca3:: with SMTP id l35mr27648946ota.271.1580941389697;
        Wed, 05 Feb 2020 14:23:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n22sm369796otj.36.2020.02.05.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:23:08 -0800 (PST)
Date:   Wed, 5 Feb 2020 14:23:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ssaner@redhat.com, atomlin@redhat.com,
        oleksandr@redhat.com, vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
Message-ID: <202002051421.9419721B@keescook>
References: <20200129180851.551109-1-ghalat@redhat.com>
 <84C253EB-B348-4B62-B863-F192FBA8C202@lca.pw>
 <34467005-1742-47a0-cd2b-05567584b91e@de.ibm.com>
 <1580742371.7365.1.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1580742371.7365.1.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:06:11AM -0500, Qian Cai wrote:
> On Mon, 2020-02-03 at 15:08 +0100, Christian Borntraeger wrote:
> > 
> > On 29.01.20 19:39, Qian Cai wrote:
> > > 
> > > 
> > > > On Jan 29, 2020, at 1:08 PM, Grzegorz Halat <ghalat@redhat.com> wrote:
> > > > 
> > > > Memory management subsystem performs various checks at runtime,
> > > > if an inconsistency is detected then such event is being logged and kernel
> > > > continues to run. While debugging such problems it is helpful to collect
> > > > memory dump as early as possible. Currently, there is no easy way to panic
> > > > kernel when such error is detected.
> > > > 
> > > > It was proposed[1] to panic the kernel if panic_on_oops is set but this
> > > > approach was not accepted. One of alternative proposals was introduction of
> > > > a new sysctl.
> > > > 
> > > > Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then the
> > > > kernel will be crashed when an inconsistency is detected by memory
> > > > management. This currently means panic when bad page or bad PTE
> > > > is detected(this may be extended to other places in MM).
> > > > 
> > > > Another use case of this sysctl may be in security-wise environments,
> > > > it may be more desired to crash machine than continue to run with
> > > > potentially damaged data structures.
> > > 
> > > It is annoying that I have to repeat my feedback, but I don’t know why
> > > admins want to enable this by allowing normal users to crash the systems
> > > more easily through recoverable MM bugs where I am sure we have plenty.
> > > How does that improve the security?
> > 
> > There are cases where data corruption is a no-go, while "one node going down" 
> > is acceptable.
> > And then there is also the case for payed service providers that often need
> > a dump at the time of the problem to understand rare issues.
> > 
> > So I DO see value in such a thing. We should just piggy-back on panic_on_warn
> > I guess.
> > 
> 
> Indeed, so change pr_alert() to pr_warn() there then?

pr_* are just printk levels. If you want a full trace and to hook to
panic_on_warn, you want WARN_ON(condition) (or WARN_ON_ONCE(), etc).

-- 
Kees Cook
