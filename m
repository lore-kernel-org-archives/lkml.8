Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD406C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8031C206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QagLW0xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbgFIR4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733147AbgFIRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:54:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DCC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 10:54:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 18so21181469iln.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05NTV0Dt6UYVXxwfdhrIdCqnO3jxBBJw4IueZ8RD+7w=;
        b=QagLW0xhYVivrf+fT0GpfqIhULa+0BoIReJgWQ4UG4ZnoG+XMKy/w7HGYpVd67BdQA
         yBrBxfFd4gZ3bKvEvkij5lW0bvtA7HABVCtLvz5nYmO7FoyKuoA4UALm77fOcp0DgJDh
         GT6D558y+9Vyh6JMT9pBNlGYzU3aqGEI8wrJRJiE/+SxPSLUca6UPuX/0UMUwAHd2RF0
         eiL1BdCGSiys15bIZBBJ3qWfhlZ9NkzUYzkHXtQgrTgpHUCs66vTlQHZbcxYaoR41Za/
         7rekPAtwrixokrF9yg29B6rsKatExgDUZTIHjdBFYAHPrW4Ssarnogl/b7ib3LkjMlG/
         Pu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05NTV0Dt6UYVXxwfdhrIdCqnO3jxBBJw4IueZ8RD+7w=;
        b=XusHkVDj8XpJraULFEyWu9WMoyv0L0kjXufGYa9r3aNzLzMX/O/octFq9B+uJXoiXI
         2Qoe0z/JZuMzabRN42J/MR6bjFpoJzEXkn4tnJikC4COhhyLKPHMnPxU/oB5MNS5Hfyc
         30jHlYb76uumZwO4htkWJHkoiVj0mfN8rz+C8q3xRIShbv3rPKUzQ0rNXDwaIKeAXyqT
         vkePZqz/uYPgCkZMiXcjp6nLiWXHBz7qwyq7+Enwnex1LBqghQysSaCENlAHrUonb/kz
         OVGXykeZwYNPTddJHJ2BHGJSQO12o5dhHIpI/htkNEFQwMHb7aFwQttZ4TrhBSmKcPYi
         gSiQ==
X-Gm-Message-State: AOAM5322zN+wBlrgeAW907Rq1VDYqBDJ4q0Vumq1vMHrJXLPxZJPtPeK
        a3XoY+3jQohGfmWZKtV54+rAZkj0SfwuAX6NJlrUGQ==
X-Google-Smtp-Source: ABdhPJwuLfNie5HIlzjHaWphh6RtDbAg/FDCzpuDHUKyY1vJHWGYnA2ygsohkISwy6QnC524BI5sknCPNIg+7WLksdE=
X-Received: by 2002:a05:6e02:1208:: with SMTP id a8mr27882705ilq.118.1591725286609;
 Tue, 09 Jun 2020 10:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200609015607.6994-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200609015607.6994-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 9 Jun 2020 10:54:34 -0700
Message-ID: <CALMp9eQNF0b8q3naibxtKxo=pym554hRoMJ5ro5febzOUBU-=A@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Wrap VM-Fail valid path in generic VM-Fail helper
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

On Mon, Jun 8, 2020 at 6:56 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Add nested_vmx_fail() to wrap VM-Fail paths that _may_ result in VM-Fail
> Valid to make it clear at the call sites that the Valid flavor isn't
> guaranteed.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
