Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D92C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C240C2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+etvV+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD1V5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1V5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:57:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D594C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:57:44 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b18so504643ilf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Io2WMO8492IJ58vES9hjWcjeSKOy0fwA74x2MUbiieQ=;
        b=i+etvV+A6H82xkMFH/Wlbyxxv5zUTTycXQCEGIQe4u2HkAeaatkzyJiu3wiKq8WCOp
         r5j9HSMmVyBVMm8KB8I3wsHSHlzajGYAvDX02jl7P7wdFbsx4j+hJkoNO9Jgyb0oYVHy
         elYH8z/IJ7NiZGRYfTw3IrvrJndVJ4AmDxh6bDMt70+OaAZOyDqHWYZsEFqEyX6O5Hip
         gj6JcZDmApaawYInA4N1YNDWXwTCIhwKxDHALZngxVTiRRS35ApB9r/IybQBX+4QE4GN
         oSD9smnKk0gVjIF+JBY2zXEwnUemVMyDNa8SpmXkffuTNSQqWA1juCiOrVJ5j6zpp7Cj
         ei/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Io2WMO8492IJ58vES9hjWcjeSKOy0fwA74x2MUbiieQ=;
        b=C4Quc2gW4qP+t+h1BK8yzTUvPskZqq/OgAVY+5clh5gPmduo9T66xDmN9gJT576AP3
         r59pm8wINpasp5bawkkBKS5GR+Lycp9vfinUVTVsHrGUG0SUWWczpQxE5Jx6xJ/yfLaH
         hiTnB45berY1Z3Vp9zpd5vG2VHB0itbCglPDcJ5+8k43YWfgNMLnIUaa1n27h9/A144O
         dzsdNjZb+ydp6COSEUS/TKOPoA1p9epp5ZjImbjki0PE7BAlR2DDlsmC88kPE3gQdM03
         Lpj76ONIW62HK/M0bbYEGYJzASWDCGEfIeEpO+J4GhyzaTqyERdLBqzWvKKxJfRLIdXH
         o1QA==
X-Gm-Message-State: AGi0PuaWd0JGiX5tpfxfdEYi8aguE0HZ0TjbP1ec4UcgGh3CYnTUU4Zc
        E7WpwtP2mKGcTn/r+V40G86gVYDLr/nwNkHSw6ZJ8g==
X-Google-Smtp-Source: APiQypLd6vCwcOl5dOCvVDnFlwdc7Aq16jZewq3oPeBM95t0Wqxw92H6H4X1szGZ0dllpY3xlNAcJGHTeAlbm3Cwg3Y=
X-Received: by 2002:a92:da4e:: with SMTP id p14mr28502177ilq.296.1588111063335;
 Tue, 28 Apr 2020 14:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-8-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-8-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 14:57:32 -0700
Message-ID: <CALMp9eQnzROUKG0wUhtzpCJcoxv267nsAGZSZs5_dx2XkrC6EQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] KVM: VMX: Split out architectural interrupt/NMI
 blocking checks
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
> Move the architectural (non-KVM specific) interrupt/NMI blocking checks
> to a separate helper so that they can be used in a future patch by
> vmx_check_nested_events().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
