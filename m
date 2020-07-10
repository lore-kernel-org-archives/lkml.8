Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525F3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACCE206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLxKHjlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGJQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:25:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB2C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:25:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k6so5563761ili.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcDMEhTSKKMXTowJquzFDFHW0B9rJZphvCEGihxlBug=;
        b=lLxKHjlVieE8CR/C5FWlzc7Uis/0nuwWMvc4hUOICx3oO4m/PttpooF9Mfku50uTuz
         pbnZevuDsAvUwVhSH2i1Nd6lpOBQzVB6TDXzhXu8318gMbmyO/OjdyNHdHnbz5kvy/J+
         3FS0W7SMo3hcsVmFYEmHhG+8eUXCsBoAm3xnKtZw9P1CTJEQqC0YKOviRG6ubCfAaxaf
         RO6zqusol8TO1/uZctwduaG05iNaFYJVhnwMn/wBO4+QJdzfFFkSWfHUK87pb8boRXkH
         nP760DKxd+QNElhvMSp65xXZazGWiaN06ArD8BtuDLN0k2OEsNupQGnE1O05yXSKjYEx
         ob4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcDMEhTSKKMXTowJquzFDFHW0B9rJZphvCEGihxlBug=;
        b=XduAYK851qMTSsWdQpwPlLeusCBw0kM7K5l9Yjw03zA0XcFvdA0hH03GdFpw+tJXUB
         A2EOjY625fHTw4R9oXFZV/jHlodlvq5+7GaroqAnzmB8uED9x67pHX4sbKudgBAH0EmK
         JPCqt9EVSjr/LwGJDBTEYmOipzVw6brN8+3aKAgETEhIEhnuk5MhiP3Q8zfBxAGZAWw/
         ybrLsKM/sEmZGOc+v1P64gVJQAlHiawEgmQVvpwQPZPHPG7cnKp800glC/ksACAzlqD+
         dOsdVoCtnhXRc2zHZD7pkLD0NK9kfTiEc1o3T5uPyo5BuagR2bRFbxCVsuCk7bIwV4s+
         5jIQ==
X-Gm-Message-State: AOAM530B3LRoS8+0LGzxe2f3piD/lFzQYkIfCqHfNkjCCCPkciXxAJH/
        B+h/W0Em71OgxsPt9uWWs3GkcESF2rcr/bf5X5fq2g==
X-Google-Smtp-Source: ABdhPJx9kxVePErlat1+e+tKLypo+bvNuYSB4wDq+i1m1pqY+SMTsBHy1h3u6qRFuDiZ87hhCu416AWVwxklMXbnREo=
X-Received: by 2002:a92:aac8:: with SMTP id p69mr54333019ill.26.1594398312271;
 Fri, 10 Jul 2020 09:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <20200710154811.418214-6-mgamal@redhat.com>
In-Reply-To: <20200710154811.418214-6-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Jul 2020 09:25:01 -0700
Message-ID: <CALMp9eRXZmtZ5zZ91q3Q0i7Yg5XUNAyLxWaX91okZ_ogNikKqQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] KVM: x86: update exception bitmap on CPUID changes
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 8:48 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Allow vendor code to observe changes to MAXPHYADDR and start/stop
> intercepting page faults.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
