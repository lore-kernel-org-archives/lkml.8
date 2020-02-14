Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F4F20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODHk50pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:59:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33675 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgBNI73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:59:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so8480735otp.0;
        Fri, 14 Feb 2020 00:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPmu7tOIaB+sAtK6GKZ9pEC359M4z5mVFozGzcz5rHU=;
        b=ODHk50pI6AJGxWXjYljN08TI8cURD8wC15Xx4NbMuVUDMP9dAU3EcfXxv8xYX4bWdH
         dWMfu3fyeDbhJM1mduj/97o3GgYiqk3PWMAawzrPDnrUSoe7Vi6+sC9DcumpMDTGsYQ4
         IcUrQrEEasCCaX5T9Zqrm0cdqqyzYfp2XAHPom44JfHdYzq0ZuybY8VaTzQfoP6RD3Cr
         fZGN5T2H9hf871JMUuJNkwEkwkjfbXZbidDjy7jAbKmag/Hjfg7QaAN4c8tojegRDgXY
         VcdWV6lStKvBwiVy/3zynwyPBTr79L907kURGwiQOu6/VKXXPueo0sF4bCpzrw8lygTR
         AIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPmu7tOIaB+sAtK6GKZ9pEC359M4z5mVFozGzcz5rHU=;
        b=go4WD+cS/N0PeCYCzGBb2jWJeanPvE3b9vK+YUMyqoR9GQhh2J1wkO9sWpULa+zEKV
         9eDI+sDf6O3vf/H3dRYzAiiTxiiSrPpJ9GtJh40phHrPnXwubu9U0wZRAUhUc9EypfiM
         lSHDCNa/IuDRoll3QfIRnnyBlvrAuV6M74D64C3pAiGuX5MN9ASixRiSSd6c/T1Y0jfz
         yKHDSzuxbMPwbEuxm6CC8fUjbtROdLX8lZngBn/f1SsegAhkwfJFZNPf6HJA8g2JzBX1
         5pVLn8CvQKD34MY2DfclSMTz7zP9yBE3eic2EJqrBvK5TIkJwg9F7tvkyYr4GV23qRi7
         tCew==
X-Gm-Message-State: APjAAAU5oSI7wyKk1vEf9NNz0sflKSzzN8Mjx5d1WAikuSngDPIobm4i
        UAjph/gDE/dIpx0GExSWkN6QYa9Oxhv0y+Z+OQQ=
X-Google-Smtp-Source: APXvYqxNRB3C+u4AZTEZADujxkrL7WxjZx6us7wzrLP4302ZuMLAN/Flj2kkvQPp56SZsmQ+LpxZZXspoOEB41GPRgs=
X-Received: by 2002:a05:6830:1011:: with SMTP id a17mr1335402otp.45.1581670768835;
 Fri, 14 Feb 2020 00:59:28 -0800 (PST)
MIME-Version: 1.0
References: <CANRm+CwmVnJqCzN1sWhBOKZBCqpL2ZfRbT-V+tHMGFwPjCZGvw@mail.gmail.com>
 <353a53a7-5d1e-1797-c870-1eb8b382bedd@redhat.com>
In-Reply-To: <353a53a7-5d1e-1797-c870-1eb8b382bedd@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 14 Feb 2020 16:59:18 +0800
Message-ID: <CANRm+CwVyRgkG1MEHp25zNrqPoJoV72h7HUz_5n_5GWonj5mwQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] KVM: X86: Grab KVM's srcu lock when accessing hv
 assist page
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 at 16:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/02/20 09:51, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Acquire kvm->srcu for the duration of mapping eVMCS to fix a bug where accessing
> > hv assist page derefences ->memslots without holding ->srcu or ->slots_lock.
>
> Perhaps nested_sync_vmcs12_to_shadow should be moved to
> prepare_guest_switch, where the SRCU is already taken.

Will do.

    Wanpeng
