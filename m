Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6FC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8020663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9FcjZXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCLQWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:22:08 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33543 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCLQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:22:08 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so6065199ilg.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsBkMfXUDJCMIz03y9mCTBZqiTPEgGnz8wIzFbdqMVg=;
        b=O9FcjZXMFD8GF6IEEZhFGDBqTuIvQesX2WgNd1l19a+/9ldD7XjP711gfSHVvdOrvl
         VpoABOR24wJ3MkWXbnwbBK0SX9XLfLw1rq2HLT/vXJNfpdVx4nFl1+9AxJfUzvyccbEH
         bOd8AEJTeXTBLHxc1tlQ9780vwc+907tRLl3RYP+ls5TB+gYWNZxUKv+FsBAxFfPpC2r
         0/cxKtUldX8FFJmLTsLaVB9sTY1T7cIBzwRdxwNj9fhKvpVlj/JUr8mp8/vXJ+2Ri2BW
         MQsDlrvKcj/Cob1s3k819pATx0c73VmZmD6HcPcge2D5wm8AIuPeVk2ki8IK3xrLLaA7
         OZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsBkMfXUDJCMIz03y9mCTBZqiTPEgGnz8wIzFbdqMVg=;
        b=Y/xK5fUrmCxBRfkOI8ivZtfyM2tztrO7wPvJnN2dsyy/1bDRv8yAOQarAXqQbJmKoG
         N10EQP2xAiRpaqPEaA4yTeoGfC9jQCj30KAfu6GBSap+Xa9ZL9U5bPBffAU7tVnmsgau
         UkVOir9fvDn/5hOX2i4oxYOgmyZFsdL0uF3fM53IXDBR4CZnvUqgtmpFaU1tqbm6zt4X
         yRrCnaHEz91slYBDxxWQgieA6gEvvZuZgVVEEAHh/O2/9m3TicdC7f049KBdo4UQT14l
         eg0nHW16sQNq4nIzwOW5NsrPAXQnonlp4U5Z8htrobsKnW2PCnMr4GTX3Z/FbLFcyvug
         fO6A==
X-Gm-Message-State: ANhLgQ1C+3y08s6WlobNlcmkWc6wBwmDDyUQsgfxhT7kzOoCafRGgTPN
        aYNM9hprGouBTilSJc42g86Yzm0YgUq8LDdP6tyD0Q==
X-Google-Smtp-Source: ADFU+vsYoFaQWCvdsUUBGMsErE22s1DxtdbVFv/QXw7OaCvbCK7kW/R1LOrb7DXZTMApMqd/mSlLWyL6ClUWb0Nwkf0=
X-Received: by 2002:a92:8458:: with SMTP id l85mr9084710ild.296.1584030127144;
 Thu, 12 Mar 2020 09:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <1584007547-4802-1-git-send-email-wanpengli@tencent.com> <87r1xxrhb0.fsf@vitty.brq.redhat.com>
In-Reply-To: <87r1xxrhb0.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 Mar 2020 09:21:56 -0700
Message-ID: <CALMp9eTSBpaPYKE6toPCbSfCQGhM9M4=1Z1FFBGQ9Bm_pKSpuQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Micro-optimize vmexit time when not exposing PMU
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 3:36 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> Also, speaking about cloud providers and the 'micro' nature of this
> optimization, would it rather make sense to introduce a static branch
> (the policy to disable vPMU is likely to be host wide, right)?

Speaking for a cloud provider, no, the policy is not likely to be host-wide.
