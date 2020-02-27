Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AAB246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGNJJ8TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgB0Xta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:49:30 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40622 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgB0Xta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:49:30 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so467444pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 15:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZF5PxVG84+TcO4AGDk4hTXuR0g3a2lAghAPZZezWAQ=;
        b=FGNJJ8TIZbEQeDUTHLzthiH7gYzaIpI1ZJA3XXho7n4IcK4vq2ltzAcqbjsmvYzX36
         zD7ixqbETkWw2eDR1zKFmbrGVME7/TxjiJ0ZdP1+cA6LI4TSIDmovCW1qDEUHfRwqOiE
         3iTQ81jQ5pn4CkXS5zbAphSmUx4QVkdWj1krgdBnAPuUm+/gujo32b14iqFpETsrDuv4
         Fbafx5Sq6NfItx31yjOO/mkBiQ8vkSiGQs+dHET8yMBirlarM/xa73kVEcbN39cFa9I4
         Vu3UDVIghVT5PWwEcnxXhBM+UPjN3nkVWg96faRN9plrIZg77Yyl4UfYIAmRMQ/hGQWD
         YzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZF5PxVG84+TcO4AGDk4hTXuR0g3a2lAghAPZZezWAQ=;
        b=lgU8EoBu/zL7yJ4E8fZLOXMidS9ecSfhe91LLXx3XJudfBVXXim3UsZpp3+kk8SU23
         tIpouBEqxlDYhAHf0UI/yR0surMQlrqMFaD1t/Hr8WBZ3HUswXnGgAx8ABFs0xTiYdVE
         wx2EKMDSQuiJQN5LBOFB+/NMXgRrClnm1cStvB+Yvm/sBvmMSVeU3DmR1gAaJ8QFXzTz
         WU6iLiY3dF4O0BI7zrEGTZQuQ90e0oe5o9PE/OY06Cj/FAFnBTuBCyFKPqwW8tcN6/Td
         d3G0/p+wS0sH1+fqEIBYhXPjjHJFCeS47yC55sodXf3m3xIp6VnsBkOiogiw7mLZUbuP
         JHow==
X-Gm-Message-State: APjAAAXTPdXP4+n8yn27o2vaSai2pSvJefvCzWAC4XEOqi5O48woQtBU
        3Vu8xXb4wiA8vAqDfDRf8xrSzg7tqvaTLXJG/l3OIw==
X-Google-Smtp-Source: APXvYqw0egRKbJSIQcP/k3vUTH6RVXMgfH+NgFS+3a2pz81BzPEZzxWwvZzJpQRmMCe+9YjvwY5iOzKNBRHn/yxwaAo=
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr1194526pll.119.1582847368858;
 Thu, 27 Feb 2020 15:49:28 -0800 (PST)
MIME-Version: 1.0
References: <1581988104-16628-1-git-send-email-wanpengli@tencent.com>
 <1581988104-16628-2-git-send-email-wanpengli@tencent.com> <CANRm+CyHmdbsw572x=8=GYEOw-YQCXhz89i9+VEmROBVAu+rvg@mail.gmail.com>
 <CAKwvOd=bDW6K3PC7S5fiG5n_kwgqhbnVsBHUSGgYaPQY-L_YmA@mail.gmail.com>
 <87mu95jxy7.fsf@vitty.brq.redhat.com> <9506da2d-53fb-c4a3-55b4-fb78e185e9c2@redhat.com>
In-Reply-To: <9506da2d-53fb-c4a3-55b4-fb78e185e9c2@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Feb 2020 15:49:17 -0800
Message-ID: <CAKwvOd=tOURgAFUNQPX3DDqd-eAbZ9kMmyksXEUK-a2N_Gky1g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] KVM: Pre-allocate 1 cpumask variable per
 cpu for both pv tlb and pv ipis
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 5:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 26/02/20 14:10, Vitaly Kuznetsov wrote:
> > Nick Desaulniers <ndesaulniers@google.com> writes:
> >
> >> (putting Paolo in To: field, in case email filters are to blame.
> >> Vitaly, maybe you could ping Paolo internally?)
> >>
> >
> > I could, but the only difference from what I'm doing right now would
> > proabbly be the absence of non-@redaht.com emails in To/Cc: fields of
> > this email :-)
> >
> > Do we want this fix for one of the last 5.6 RCs or 5.7 would be fine?
> > Personally, I'd say we're not in a great hurry and 5.7 is OK.
>
> I think we can do it for 5.6, but we're not in a great hurry. :)  The
> rc4 pull request was already going to be relatively large and I had just
> been scolded by Linus so I postponed this, but I am going to include it
> this week.

No rush; soak time is good.
-- 
Thanks,
~Nick Desaulniers
