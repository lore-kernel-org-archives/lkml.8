Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081C1C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B462072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7VojKRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD1VoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1VoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:44:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B14C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:44:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so464897ilf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwL+4WZ+0ScRQq3VXJ2lINm0eOX2xPWaP7a0ucBzFCA=;
        b=d7VojKRrrM2EbO15GOh1OhChn7gSyFoTXBrRcOc33vyUBYppKZsM5J90YUoUIGIm6D
         kJl+gdgZdxLSvXBoBJL8gWJtDQdUDSLmr5Lx088oqp+gCg0xyM1hqhXzkH2hs0DkdFJL
         IEs6ffv+z09tOT6TZ/kUbg1buaBZgAmOPP605bXMrH+zkfy4eU/fijkjz1DEOM07JoWr
         lymrrJaD2xwwvFXttNIX3YuSZsXZM+EE9wZsNEl6MuszpQTWxcXgTs83YLdPEg0JP/DK
         9rcKunzihHcggaPr2OalahIwvaFR5CvA+wOOGGpphObaMV0oFzqYtJSs/ewkHKGshQ84
         tHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwL+4WZ+0ScRQq3VXJ2lINm0eOX2xPWaP7a0ucBzFCA=;
        b=aUzyq8tQMuwFlvZuYVR/1j83tP5mVYBT44+i2WsySJT52MkS56TRcVUyzjKgKASsEN
         A4fw+ju6JCjy2WMNdYf0NmC3pFITSjQfwgyhA1CLcvnx+8AFCDHXaa+/uMUS27IBu8ZP
         Ln9t25r/jkdXXYYr9R9VGCpvZ1hHQ/OGs8RRuFU99RyZ9PXzcVvUBMp3/kliDcB2eTgE
         bMA2Uk9qRcvZ8UxlOxeECDqRPa3hXyaDcktFF6+f9CUPERCzvvudjvPaFD9jGX1Ok0+y
         3Jrc2XewQk9D5U/N1rZoHQ/m7ZyXDshhGdM/ri1tOiz9ZhWgai7dyOEXvl/jM82NaPAk
         YG7g==
X-Gm-Message-State: AGi0PuYXbaOJMWpr2xszXE43VTo1C+XKHpUAtthC5gkzMZwPY/QRnSS5
        R0LnIv6Jn5BRF1F1Q1sjk3Z14bf2oK+upH7UHX9bcw==
X-Google-Smtp-Source: APiQypKaShkz7WAR98Qp49F/fWDSJZqW2ISiUOp3Ex60HLT/a92+dt8VDos6q83aPip6tyDKdLHAZncMUbfE9aGu6gw=
X-Received: by 2002:a92:d8ca:: with SMTP id l10mr28461593ilo.118.1588110256438;
 Tue, 28 Apr 2020 14:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-6-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-6-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 14:44:05 -0700
Message-ID: <CALMp9eRZFZhEQOjLGy7LdYGdp23NJOewr49X+XJ3my05v+OZtw@mail.gmail.com>
Subject: Re: [PATCH 05/13] KVM: nVMX: Move nested_exit_on_nmi() to nested.h
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

On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Expose nested_exit_on_nmi() for use by vmx_nmi_allowed() in a future
> patch.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
