Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE5AC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16E7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHJTeAgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD1ArQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgD1ArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 20:47:16 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA7C03C1A8;
        Mon, 27 Apr 2020 17:47:16 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 190so4297016ooa.12;
        Mon, 27 Apr 2020 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mg3ylSUl5nTSYGxTWgCy2J6jsay82JWyxDHWJ67sXd0=;
        b=BHJTeAgxrQcdxgbSnbBQ2r3yUouEpq5tFpfBfLiRMbGMAbOJzp1gwLavi3skk3+Xtb
         dxrmQdkZHP8gf7Ytiwcy3oNE9Wlg0kzA/CWUZbxRKKcZP+DREC6/sPGzsZvXAmoWKkk7
         w0CowYAgQeloZl2ELKOxGPjT+xqSZmtw2c8nPDlZ6b72NmCBuV7ouIbpo2uojIEqk2iU
         9EL5QuLqh5SfOT/24fsJ6IQaq9RSGRBuCwHUQDTdwgd1p/8MopMrdg9ZH6VMQvO29oop
         sP6JpPREldsbh6DWITEbl5XIwHqlxvCMwqIqf+h8gDUDuaOy1gqv5XgEbZ9e/77o7Kk/
         2dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mg3ylSUl5nTSYGxTWgCy2J6jsay82JWyxDHWJ67sXd0=;
        b=mnJlIOOzlZHyVLMSL1Gx0EYalIQka+d6OJBNks/7vuM3+JmerntnwTZHdcwGdkpQsA
         JMWBwSJxqKRjaPBuzI45C8DhvR+d5qf5qYHgHOT+vmXwmg8sZICff/ReG1SQm90Spz+H
         M8OTz6nFRo9I0E1Gq8Qq7iOvOTo2vegXNrd8R6vyCFO7+oXN+FkUwiLCtzmDWE+qTy80
         GuaHnN1en+vzj7yVUaIFb2oMtUc8CkjCOq61U25t2bL+RWDW8irwgRyFlQ5xIryRFJlJ
         Y+NK/D5ZdmeT7HntA6AR4dd9bLpu25OdUllSAFsLFdLPDekseCGgvdVdznMFglPetcCE
         gQsw==
X-Gm-Message-State: AGi0PuZDp0+kmw3xjvZ8/WTgrASJrjWSrayZk9vF40rqFg6WPOYM//D4
        mtZk8vQvFVkHjjv26ZI3miBK3iFyp3CCMs1tkbk=
X-Google-Smtp-Source: APiQypIfTPGQQQfOB5A+EopR4kh38+zyXjtO9KEGC+3ldyqv7OPbmaTqNkuTiK37dBY9a1ss/9o7LJcM3QQ8lLvQ4hU=
X-Received: by 2002:a4a:d355:: with SMTP id d21mr9857599oos.66.1588034835594;
 Mon, 27 Apr 2020 17:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <1587709364-19090-1-git-send-email-wanpengli@tencent.com>
 <1587709364-19090-2-git-send-email-wanpengli@tencent.com> <20200427182631.GM14870@linux.intel.com>
In-Reply-To: <20200427182631.GM14870@linux.intel.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 28 Apr 2020 08:47:05 +0800
Message-ID: <CANRm+CyNOnCDEwAK04Yr_Yom3ebfKH61_3-fXaCs-LbcTiEd7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] KVM: VMX: Introduce generic fastpath handler
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 at 02:26, Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Apr 24, 2020 at 02:22:40PM +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Introduce generic fastpath handler to handle MSR fastpath, VMX-preemption
> > timer fastpath etc. In addition, we can't observe benefit from single
> > target IPI fastpath when APICv is disabled, let's just enable IPI and
> > Timer fastpath when APICv is enabled for now.
>
> There are three different changes being squished into a single patch:
>
>   - Refactor code to add helper
>   - Change !APICv behavior for WRMSR fastpath
>   - Introduce EXIT_FASTPATH_CONT_RUN
>
> I don't think you necessarily need to break this into three separate
> patches, but's the !APICv change needs to be a standalone patch, especially
> given the shortlog.  E.g. the refactoring could be introduced along with
> the second fastpath case, and CONT_RUN could be introduced with its first
> usage.

Agreed, will split to two separate patches.

    Wanpeng
