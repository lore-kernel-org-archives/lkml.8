Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04604C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD00E20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvTkT3Yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgGHSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGHSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:19:47 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F4C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:19:47 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so26761439iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AmuLZJMHQPQccZytV7kXET82/Y66cEHC380oWy4s+g=;
        b=HvTkT3Yzc+0sTy17VDvyFLHX9Wj+cV76L6dXw4jSkrFRuyw3gSp896FKevhO1L3c9R
         fHd36gJSizxoIEumauz8Wy3XzIsdXqsUbcdJZI5WkFVKo/cXMjDyF8/jSVuSsRB3nKbH
         6APHT/fZlZXTW2VneKfsRJ2kROoeMk2gGZPWyQCYP8sRmcl5SabIsQv7dVyxposgyuf0
         Obbkl92Nv+E1gH5NztzVcHLOxShYy+UxUJegvH0CLI0kNI8SW5RNSZzT9S+UXixj0Bep
         d6S6Ue4thjNfSVM7mM1NadWauaUT4GLq5mZv3q2c64MfGzdxqgXVG3UJAlm1CGVnqBIx
         2nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AmuLZJMHQPQccZytV7kXET82/Y66cEHC380oWy4s+g=;
        b=q98HxGafP+Aw70OnJINnVPtHnGv25N45yqVbLkbEsTOzfYjWnFj4ximHLyZnVxpjkt
         UndfSrr1XIcjI8uD7xdRVxKHkBv1y0LyV7kiAtkKkl2mr9O8doLcHw7VJUOrYBoP++ik
         OhT/fE9lpb5ghzrEZEzeqhNBfbRqN4rBRjJt0Qf5tzZ3cPjCnoENSQ2zW+XtOu1WYcbb
         xXPfQdc7Bi2pcZznVhJdM0CGhac1Xax/oTQZXhsZmw7lGf0wgYPDo67y79X4UQnm/u7a
         UrUxzQ05pl2mEE2WlH32FfTHZ6HAP+B8uc7nHhw0YzmxocjttJ3fksV3DjXaLgPhidBf
         zmGg==
X-Gm-Message-State: AOAM531wUWWN70D6y1W5594YXKUUGpn+qW7B3nx03zp3NYpFIcdLs1L4
        BzexPuu6xCCpwABcbTMTaFEPHuCNvJf7fD8l59GnHk1x
X-Google-Smtp-Source: ABdhPJyfCtMLGGsfTHzFRlVI1nhUOBxQmw2RuTyIuZQncCXntViBnqgrCAyRcBfK6wBySUQVUCLe5suQwBXZAhsHuJM=
X-Received: by 2002:a92:b685:: with SMTP id m5mr43222431ill.118.1594232386468;
 Wed, 08 Jul 2020 11:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200708110350.848997-1-pbonzini@redhat.com>
In-Reply-To: <20200708110350.848997-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Jul 2020 11:19:35 -0700
Message-ID: <CALMp9eQGgDJE9kYA6vGM67iCdtfgYqPHxBXGSCGfEtqo858pmw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Make CR4.VMXE reserved for the guest
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 4:04 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> CR4.VMXE is reserved unless the VMX CPUID bit is set.  On Intel,
> it is also tested by vmx_set_cr4, but AMD relies on kvm_valid_cr4,
> so fix it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
