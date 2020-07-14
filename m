Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84514207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AaNf3yx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgGNTCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgGNTC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:02:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA1EC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:02:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q74so18502512iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqKWO3uScp+YPNttG3GkeP2e/9cRZhWYEGoF0VDURzw=;
        b=AaNf3yx15t9Una3u1zecHN3oGQdqwauyNPjc7RpagX1o8tbTlSRhLSAUKwHK4qoHks
         ORfBwr32F1g31B7lp7WysJysZhkTIc/e+bwiwTbviJyu7pxiuSjrNW7Rbj+RFIo/njVM
         HnvJtypq7cIjn1krtKvlR9b9sVt0mkAH78AP5o4Mwo6BjJDtEZ51XsytfqnpwMfqHLeb
         /c5iFQig0SipYNXd9GsYR9NLz6/cpocAPBi777kiOFI82Enm81jKr9/scO9eqNh0SOPF
         f3O7nrTTfV5fN+6InnYrSxHxzKzSMJDX1NVYetAPtHMrV2mUiALUZFawW+ZlfmKxLQKm
         96Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqKWO3uScp+YPNttG3GkeP2e/9cRZhWYEGoF0VDURzw=;
        b=Wg6U4rBy5atV/nAJXhbZaSdEg01w14AqJgJJImiceZt69h87WWAlZk4fk5ZMRSkCzL
         VQXx9jQiOiVfSVRZVyFgYAae3CmR4DKOyCAmira+eiZ55EnOfgzlhAAaAQdhZgReR5Kz
         RtjBI2PJHDXVWRvD5tQWOP+Kw1JAjCD4VWl6T8ZIFgyXb38bFoJaX8uFmAJR9CAf7LXg
         ZFpi3DkaMRJ3GqBJvECfx1oZTjIqywaH+Q/3OUhzIpQXylBzsheQFcGfJfyrBuBGujab
         yaWyKM8DJSfdX0ZsxurarfrMy8bkUIe8iC/NUuvRDkvE7XoRWhQy6LxMTgOeN5BidqgJ
         25eg==
X-Gm-Message-State: AOAM533u9R11ZZGZDwfMxPvuWeVlow+Dlg0tzUXwmTmCBih9jGYKWKZ4
        AWWQHlx9V8BgRrKuZxLS4RALgKHesYfEM4mzqbwZjh5j
X-Google-Smtp-Source: ABdhPJzUM3ZaAmcJWC7hc63F6HxyG0D7UOVj/xVSU2LQkXToXSztscjS/kFLcwM0K40Dog4ENU23gAxQqcSoSi7gnQo=
X-Received: by 2002:a05:6638:118:: with SMTP id x24mr7643093jao.48.1594753345471;
 Tue, 14 Jul 2020 12:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200714015732.32426-1-sean.j.christopherson@intel.com>
 <CALMp9eQ1-6GEiSh55-NXgjuq3EOwP9VWNMeriH_J64p9JMjN0g@mail.gmail.com> <20200714185853.GC14404@linux.intel.com>
In-Reply-To: <20200714185853.GC14404@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 14 Jul 2020 12:02:14 -0700
Message-ID: <CALMp9eQrCcwZutCmo8mQsBrhyupdniBoN962Ex8dfDQKorh-6Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Don't attempt to load PDPTRs when 64-bit mode
 is enabled
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:59 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jul 14, 2020 at 11:55:45AM -0700, Jim Mattson wrote:
> > On Mon, Jul 13, 2020 at 6:57 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > Don't attempt to load PDPTRs if EFER.LME=1, i.e. if 64-bit mode is
> > > enabled.  A recent change to reload the PDTPRs when CR0.CD or CR0.NW is
> > > toggled botched the EFER.LME handling and sends KVM down the PDTPR path
> > > when is_paging() is true, i.e. when the guest toggles CD/NW in 64-bit
> > > mode.
> >
> > Oops!
> >
> > I don't think "is_paging()" is relevant here, so much as "EFER.LME=1."
> > As you note below, KVM *should* go down the PDPTR path when
> > is_paging() is true and EFER.LME=0.
>
> It's relevant for the EFER.LME=1 case as it's used to detect CR0.PG 0->1.
>
> Though maybe we're in violent agreement?

We're in agreement conceptually, but I find your original text lacking
in clarity. :-)
