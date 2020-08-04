Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C2E206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8ZdWUEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHDSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:47:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EBAC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:47:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l17so43296862iok.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeVbzIBEA3JOaGe5Ny64vb+/3rlySwvGG6S0dU+z+gY=;
        b=G8ZdWUEjxxyHgWzCQe0B1ecAHZLk61NFOtDkk9m2clW3KnV5q2QOH2uzn4EervoKWP
         kcibGnUOV/LrvKpwtTWQpnlSk6EglvK2qrnADqmESgCBgb4CZdsXNrT1H0avWeD1LmFo
         85/wFyyIp6Ap5IDOkR/n8vooOtrYyaEcU7n8QI+8fVyqeqSDtNzDJU0sn9hmjhx6+MfI
         MhEsbJzU5BXrgaJbR92ZTRkdRpH5Pu8uIhTcen1Ld/laoaCf7PH46J5qgt9COr3uiV/t
         partRNOaoamryeI1wR8OauRcPhHfbIpLxVkf9uDEYwSQQa6VwdDmcueeakaKF779Hcco
         PObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeVbzIBEA3JOaGe5Ny64vb+/3rlySwvGG6S0dU+z+gY=;
        b=cyEMT8OtjofZ6iKrLmEJH1OEganblpy6GFsRzovCxIMiv3dPHQ51d9/1q6JYYjp6gw
         zTSmZOy18nRXsSolNsg8EazsNwOVN9tscHcoxee5Ns8fIYujGJ7Qn7W3TjnlJCEs3Ng0
         JJqRPpXKzO6tAsLGQXsr8m3FFw2e0ffsruUdedPqte95WkqFR/qIi8U+MjXNzx4Hg+Ur
         5ZclHliKpth04p4Zo5dTZLNVrbN4chpeXb7XEf9x7ijFMhM4unBayk/eQyWl3MTY98ij
         fvYSs74q+vTydcVqjps8QCBxkkFqj8n+v84VplN0F6VKVKiEjfFkqi4DFh1+T9PDSnFP
         zrvQ==
X-Gm-Message-State: AOAM530kVo06dTdEoba23osxxYOGcATSd+wegixE8+S8UQqAlf3j5Vjc
        tRwQBhqSir0rfrWp1833fC8vKQUb6spUyUANjH7lTw==
X-Google-Smtp-Source: ABdhPJxHnlBlIg2y23Vk8YRGymkBF+ZKaZSs9iYjqD9jaNATOvINcmXJQoQGshzeLXGR+Y6Qz7mSWpgkBGBZx6373PQ=
X-Received: by 2002:a02:394c:: with SMTP id w12mr7393543jae.18.1596566829493;
 Tue, 04 Aug 2020 11:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200714015732.32426-1-sean.j.christopherson@intel.com> <20200804184146.GA16023@linux.intel.com>
In-Reply-To: <20200804184146.GA16023@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 4 Aug 2020 11:46:58 -0700
Message-ID: <CALMp9eQb32UB_tLowkr5T+Rt9SBdJbTkjHWyWFg+6ruJ_OuaKw@mail.gmail.com>
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

On Tue, Aug 4, 2020 at 11:41 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:

> Ping.  This really needs to be in the initial pull for 5.9, as is kvm/queue
> has a 100% fatality rate for me.

I agree completely, but I am curious what guest you have that toggles
CD/NW in 64-bit mode.
