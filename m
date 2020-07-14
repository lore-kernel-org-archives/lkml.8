Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6680229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4bMcrj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgGNS4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgGNSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:58 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDCC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:55:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so18460579ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwJUAiA8BpGrXQ3dlTzGVWDeFkGjuEAAOtgnYtpstag=;
        b=r4bMcrj+DSWRX7zW5bEHa64p7BZKCexjM5C4F9d6hvYG8IFfMmB4cCzIi/uwzjXpLL
         2wIMBo0RJEmz/dP13ZjdgKfDTzbgglyD/ChLlc75bmsM+GfDL4uaBba7dmOrzsimJ2fv
         mYX8o5YlWF67g7gb04WcxMWJ5IybOK47ZP8FKo2YoDzLx3o2rkgVxpIcC2Is+ZmU5bg+
         H2lNsMgB33s6V5s5pSj4VGXILNQRkaRYYMTQG0pqRiCtDNKIKER0bBcnz1s2ntTyM3rV
         n812s2eeZ2rB9k++XZb556z2QXI9NauLo9sgEZEFt9JX7DQRPwdOR6nRt2Sx73ojA0Fz
         oulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwJUAiA8BpGrXQ3dlTzGVWDeFkGjuEAAOtgnYtpstag=;
        b=uMW/O90C59OpovZmAze7BFu+WSXsL366WX3BgbPhsMcwdRB0APck9y9VL+b/judNYQ
         wEyHQhq1tjNTrkFGezmWBWD2mtSbqrLV4NvU/MK6uzVPYs9ubnqq10KSAM2aKm76WlYV
         KFhY0HXH8SFDlVpY/1GTbDyRVPo0wygZE+jALx+7nCBZNWRn+1szVMFjhMO25x7WgH8V
         /rdjQhrmT8w6zFgs75N092gyPVlhGaHcyH/Wh+SZ/849kmhfAoiKbCuxnjXwi8q0lkho
         X9hB5snFSsBkbFBQ0lKHxyXC3dg4h039496W3urEseP4jfL6AHbsre4c348wN+oh6yIV
         4nRg==
X-Gm-Message-State: AOAM5307MoYboUTrPEJ29HBr6BhMjOU6MBRgaXuZtACwJSfL8YGKo+Sp
        ear3TuEBenj5b/wFhEnnnTYEKamMgJnycYbHdjHBkA==
X-Google-Smtp-Source: ABdhPJzXOZOKkN0bh6O7BSXC9478lsDVT3KH6Z0MLS3oc5Y1KTkC/sprReNUZ4+9oQ8cDYDBfWIXZrUdPNW/oCsLVxU=
X-Received: by 2002:a05:6638:118:: with SMTP id x24mr7612352jao.48.1594752956875;
 Tue, 14 Jul 2020 11:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200714015732.32426-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200714015732.32426-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 14 Jul 2020 11:55:45 -0700
Message-ID: <CALMp9eQ1-6GEiSh55-NXgjuq3EOwP9VWNMeriH_J64p9JMjN0g@mail.gmail.com>
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

On Mon, Jul 13, 2020 at 6:57 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Don't attempt to load PDPTRs if EFER.LME=1, i.e. if 64-bit mode is
> enabled.  A recent change to reload the PDTPRs when CR0.CD or CR0.NW is
> toggled botched the EFER.LME handling and sends KVM down the PDTPR path
> when is_paging() is true, i.e. when the guest toggles CD/NW in 64-bit
> mode.

Oops!

I don't think "is_paging()" is relevant here, so much as "EFER.LME=1."
As you note below, KVM *should* go down the PDPTR path when
is_paging() is true and EFER.LME=0.

> Split the CR0 checks for 64-bit vs. 32-bit PAE into separate paths.  The
> 64-bit path is specifically checking state when paging is toggled on,
> i.e. CR0.PG transititions from 0->1.  The PDPTR path now needs to run if
> the new CR0 state has paging enabled, irrespective of whether paging was
> already enabled.  Trying to shave a few cycles to make the PDPTR path an
> "else if" case is a mess.
>
> Fixes: d42e3fae6faed ("kvm: x86: Read PDPTEs on CR0.CD and CR0.NW changes")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Oliver Upton <oupton@google.com>
> Cc: Peter Shier <pshier@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
