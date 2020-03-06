Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D030C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5D206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNnR7DkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFC1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:27:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37632 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCFC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:27:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id q65so1074607oif.4;
        Thu, 05 Mar 2020 18:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVjfSA1+DzW6af2AGGfVssQK6CSOVfSVNfBqjqDJ0FU=;
        b=fNnR7DkUUzgPGdh4S3Yl0ximE4vfPB6PiH1oembl/1Cnm11boeicDm+STbdDS4POcw
         JQS6xkC5lTv90kwtU6+1WC008Ztgywud4EwVDEbkhL/tWlBvIlh+5jA143TztwYG3f/u
         lUVk34XCWMms/yY+gm1HNCpqg4DFSf/In6BrbV+eozr0aB8VYvcsK2QdhMal40kyF5H9
         FyzOfxQXKz2JQWvE7E6nNPDMLKulFTVLbFm5Xdpbawij97Ms+5f1DY5Omkk8UyZVa6Jv
         gyOpjDBOsBQT9+IRCLtVu4Y8QMNalL9BMo2JY1Kdi89TK75ymZSxxORyrNvgpzbuxtjn
         Nzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVjfSA1+DzW6af2AGGfVssQK6CSOVfSVNfBqjqDJ0FU=;
        b=JE/ES2gf9ogQv3IB6zvGGt76UhfEJGVwskM/pflIbTRD1RIjeGUX1gEuYRjRnKtb76
         SJQwC1fOllPnHyYHIIB5+gTdGaakSL670iY76Io/txb6McwI5HlSHBqrmsfb83U8Tv3Q
         pSDlndBkfyPARDDkIWqQcNdsauujRl0rtt9V7Q5Y5fWUBGrEcAPZ6LiGLZnRat4b+G0I
         HwOWcVAcEt82BFGMUUc0Z9uvHEioyXtTYhv5XIgGe0EBWt4C0sUI8vYq9bMlvG8Nj/3S
         tYT4KB75Eop8fxNbN4FeZkjZHFzgR14S/yMikTvKQoLPRksaWG1IdayujeFybGCMety3
         8JIg==
X-Gm-Message-State: ANhLgQ1YWjRWOb7xMEigPxHj+cahb9x2/kS4jerxSrx2bl4hDv6MUhOM
        q+lHkR0BX8bGb0F8+f2K9I6ooXYWGb2nPuOlUIY=
X-Google-Smtp-Source: ADFU+vuciy87JcOO9oRPhhmjgf127Yf5g7ICoTrpeUd2Qyrvb52OLwc7q2zNmTJo6h826ewwvjuJh/dsyo0pvQSC9tY=
X-Received: by 2002:aca:5f09:: with SMTP id t9mr1108587oib.5.1583461657164;
 Thu, 05 Mar 2020 18:27:37 -0800 (PST)
MIME-Version: 1.0
References: <4e9d847ea5d54e4fa83f3bb910242e16@huawei.com>
In-Reply-To: <4e9d847ea5d54e4fa83f3bb910242e16@huawei.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 6 Mar 2020 10:27:26 +0800
Message-ID: <CANRm+CwRPDpvN_gcO=VbuukjEL2=OPYnxtqoJO6vTk4Z3nudvQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: small optimization for is_mtrr_mask calculation
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 at 10:23, linmiaohe <linmiaohe@huawei.com> wrote:
>
> hpa@zytor.com wrote:
> >>On March 5, 2020 6:05:40 PM PST, linmiaohe <linmiaohe@huawei.com> wrote:
> >>Hi,
> >>Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>Many thanks for suggestion. What do you mean is like this ?
> >>
> >>      index = (msr - 0x200) >> 1;
> >>      is_mtrr_mask = msr & 1;
> >>
> >>Thanks again.
> >
> >You realize that the compiler will probably produce exactly the same code, right? As such, it is about making the code easy for the human reader.
> >
> >Even if it didn't, this code is as far from performance critical as one can possibly get.
>
> Yep, it looks gain little. Thanks.

Please post the performance number when you mention optimize XXX later.

    Wanpeng
