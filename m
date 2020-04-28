Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5EEC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45200206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNu3XLmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD1WFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1WFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:05:31 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483E6C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:05:31 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c16so516684ilr.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2bHPcz+Hw06E5lzZhtzL1S3rXBWl8eeB+1yUBI5uj8=;
        b=nNu3XLmroPYOks/yCxzYV1EL5CI8jAtMlzb6VmCb0jjzwclVxBun8nO9feJIjPGdGT
         q/Y3WOunRu84FIpjDf9vi3u0DZyqMMzLNnlHXmy43Kb3xanMUAVfN3XB8Qc8Peck6UDE
         yj7OG2EKZAKU/xMsUyedyXwQHax1+FdCJOtdPQMZNccVb2rMlJJTr/v0ZPgpLv9a6CIv
         iOry9SyNOxchFJUt0J6Wkqr5/0184d3PZpPHYmKU38K4SwuIr1s8BXRiPo0ba7Mitkqb
         I6zwXpe/xagT8YIa36b9ibdVTYkjDIRTESPkVC+DYy5EeoYZg+CadrHRt/rhjYKVSwa7
         AqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2bHPcz+Hw06E5lzZhtzL1S3rXBWl8eeB+1yUBI5uj8=;
        b=AByH0o207XfpBVknx/aFrWwMHcb0OXWbAP3FYL4Jk1NX7IgcCeb9w3eFTOjVJAHVyy
         6SIokyVkECs2aDjEbH0DQ7lIrBJPO8LuZXQ+q6Tl25WLoizAXeKtob74WH0xBI7nJXKl
         LTsqrGMeN4Kho0i/6Z3NU5tj2n5GC9UcJzPz1uancaY8T8ZWyWefQIO4Xoe3rkbiv/m2
         kua4CZ4LPNzPkmvysprMCqF+KOWBsDBRfEMvvXwYt2Wexxwtx6C2D8xE7jrPMsbGekXQ
         bh6QAvwHem2IgM85dfck0j+AhkC+CT+IFp5CB3txEW+segb62jUbeBPT9UGv6JbazFCl
         6PzQ==
X-Gm-Message-State: AGi0PuZ4z6ZuQ77nhS8o+5hgC8xeRRV4diJ+eJ5rMDLuGt8zwajwcJZC
        2vvaj46D1WqT0sT64yXvrlBZ6mI0WywydTdGVVRODA==
X-Google-Smtp-Source: APiQypLDs98qc/t/GpQOp6kjYdoPKQPXaTdVNmlb6AmBbafdjgYAMIpNm4XyVZ+txa4ysTmPI23Ggrj4mNTde/VZz28=
X-Received: by 2002:a92:da4e:: with SMTP id p14mr28533336ilq.296.1588111530404;
 Tue, 28 Apr 2020 15:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-11-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-11-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 15:05:19 -0700
Message-ID: <CALMp9eT+YkjPH3m9hTEDEn7pj1_y4Hw4bmUq861Odvg1Q47hxA@mail.gmail.com>
Subject: Re: [PATCH 10/13] KVM: x86: WARN on injected+pending exception even
 in nested case
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
> WARN if a pending exception is coincident with an injected exception
> before calling check_nested_events() so that the WARN will fire even if
> inject_pending_event() bails early because check_nested_events() detects
> the conflict.  Bailing early isn't problematic (quite the opposite), but
> suppressing the WARN is undesirable as it could mask a bug elsewhere in
> KVM.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
