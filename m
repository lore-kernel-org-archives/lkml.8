Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33272C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030492075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJP7GIcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgEFVTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbgEFVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:19:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F2CC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:19:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i16so115913ils.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdGUebmYhj34sXXz4/gfkMRluMVMoxZCbr/Vo1r6b6c=;
        b=TJP7GIcQxDHhteVTcWcaKBaQRwSAgSvrCxtU2yu0ckEG4ewGHIaiIknnU3PqbsAqWl
         lp5q7nfOwefULix+L6wn6rw2f7LTrQpIr61M4H/tfQfUxCBx9eoCGI5yepmGRT8TvUxK
         ICxTwVAi9lvht2kvBxwbuaGCHWz/bLZ+YImAR6ak9lHVzmku09Ah7OKQ0LM7EefRFOVm
         Q97lBhUrD5rY6dVebVEA2SgjApbkJZxhmNRM0zoHanGRI/5h0M9Fj4+7+sH0iRNqRBCo
         DqQSIdRyC+i4BaxrCV9lPzc0cX4JzRXHztE7oprzUSHJguXMq/Mcy9qKSHj1YSzXubEK
         j2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdGUebmYhj34sXXz4/gfkMRluMVMoxZCbr/Vo1r6b6c=;
        b=TcEyQQp6UBne6b8TNJYI7nrighwWij3PgvxXn6O9D8Hu2OyWZnbQUPi5UFyQgb8gst
         1bTg6pQaSvElbcA2n8VBZBQAFlXFKwa4HcQveteqUUiIeg9JjAJ1Ewer876JujA/hIQJ
         lxWJJ5Ln1wNxphpc0t5Pr1RAHBaxhrOqOduOFGwPrxX+km87oCZDhfnhyAXRo8qwfswW
         q8mBys4Kd+fNtbdh82bSMeAmShJLaDsP6msjwCr03LcKBapKF6VdkWJjPXtJP/vLH8hj
         6jnb7iRFZ3L+i8m6xBGi5ne44RaDSRryp2tQMUf080jWcxieqKMsn9Uap5lsxFYm/AAG
         D55g==
X-Gm-Message-State: AGi0PuboaHJiKK3iI6hRgSnZjPdciKqrz05XHTvAMOSkjOdwpJSCOKzl
        o0Q2HBMTmQeJ30u9/jRDE2Icn4+VCbMi3OfYwRLmBQ==
X-Google-Smtp-Source: APiQypJwyeQORbeD/PvDFZY5unv3m+3b1J31pHftGy1dVo1BsJvrcLBXS6mbqchIrJMuAYFEH+SmaLP50wW049cWNGo=
X-Received: by 2002:a92:3d85:: with SMTP id k5mr11534107ilf.26.1588799976294;
 Wed, 06 May 2020 14:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200506204653.14683-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200506204653.14683-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 6 May 2020 14:19:25 -0700
Message-ID: <CALMp9eSbB=Hwy+uGik4SSSwe1_pu82XY9_SmAWYz2KLY_Ek7=Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Remove unused 'ops' param from nested_vmx_hardware_setup()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 1:46 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Remove a 'struct kvm_x86_ops' param that got left behind when the nested
> ops were moved to their own struct.
>
> Fixes: 33b22172452f0 ("KVM: x86: move nested-related kvm_x86_ops to a separate struct")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
