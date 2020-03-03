Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CADC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADEB21D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvtKrk97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCCDZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:25:57 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34432 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgCCDZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:25:56 -0500
Received: by mail-il1-f194.google.com with SMTP id n11so1516812ild.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 19:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzQcjQiljMZHk04fD58LGKeytnaqThE2ImCl62xxtGw=;
        b=gvtKrk97dyg8vZFA/UyhjwGK7wwLRLzO4JaKCmDnLPB4uaVOIWceJk3AVrSWG+tqn+
         i38ENLxtrVWCUEezxMcaWvK1ydOlXaZyDFBOHwQRYG34ddB9vCoOZHaW3FY4aBIgOIow
         qMvVJF1R2Y+In3LSEoce8WHpTlsDOVkVWe5f8NgQQ+t0kCsPHNYPlZcO8m7PbJjIFdUQ
         /RQ/Cs1N4e1qXZQRvabsrcNXQloJUPZbwatzhaZe1OxCbiUpGhBAy1I2WdBrWGIZnZaj
         vjHYWQ/6nk03klg/mtoRuhHh8HfURPYXbwuVz+PzgRzk8ugRU4ZUDractKKJTIbJ/X6J
         0FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzQcjQiljMZHk04fD58LGKeytnaqThE2ImCl62xxtGw=;
        b=sAFwc/geqLS3v7G1842Yd9NuOEf3Nd8AWijOAMQBlR6z1YNlKjRrPe+YBRSuvMPyxY
         BZQzRyHyIubAMyBiqUcnjOabxc8r3iCx+bqFB5WuXwPJfgEET+qlg2AVKsawTCv1qpR4
         e1FBGqLX3gU+UATsQAJApbR0hAR4a1axq30juB0C/GeD73jSwSHCzgLgi/dVvqUPhOBy
         fenVzrbZxclD0YUZH2ak8OndXEn318iTrwRvTids37CUxCbNvLzjtWtA4C1NABlhZ7vR
         KKcDkc4f9hXiCtas9s+l2UwCfyWnZzxF+Y5CQ8/o/0Lf1jOdHzKQd3PncS3nQBPd4Koh
         lpAA==
X-Gm-Message-State: ANhLgQ0TMUyq5vNN/kM96G8+vKdM6bmPCDImfNWOLhJlA5P3KN/llskt
        WXwp16T4BwA+58y7uY1P2QSxXUnv06pYCLhqEiMsrg==
X-Google-Smtp-Source: ADFU+vsXeBNw6lE9vPufNiNNr1E9nPXO3ou8dsPEfPthJokT+oEqBw0I0OoQKRXOLzdC/aMa2lzH9rdkH3GNL5fM9Lw=
X-Received: by 2002:a92:981b:: with SMTP id l27mr2882984ili.118.1583205954541;
 Mon, 02 Mar 2020 19:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20200302195736.24777-1-sean.j.christopherson@intel.com> <20200302195736.24777-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200302195736.24777-3-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 Mar 2020 19:25:43 -0800
Message-ID: <CALMp9eThBnN3ktAfwhNs7L-O031JDFqjb67OMPooGvmkcdhK4A@mail.gmail.com>
Subject: Re: [PATCH 2/6] KVM: x86: Fix CPUID range check for Centaur and
 Hypervisor ranges
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 11:57 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:

> The bad behavior can be visually confirmed by dumping CPUID output in
> the guest when running Qemu with a stable TSC, as Qemu extends the limit
> of range 0x40000000 to 0x40000010 to advertise VMware's cpuid_freq,
> without defining zeroed entries for 0x40000002 - 0x4000000f.

I think it could be reasonably argued that this is a userspace bug.
Clearly, when userspace explicitly supplies the results for a leaf,
those results override the default CPUID values for that leaf. But I
haven't seen it documented anywhere that leaves *not* explicitly
supplied by userspace will override the default CPUID values, just
because they happen to appear in some magic range.
