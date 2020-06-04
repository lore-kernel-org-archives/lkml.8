Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224BB2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjHcoDpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgFDQos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgFDQor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:44:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB404C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:44:47 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s18so7101080ioe.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xZPj9+0u4UpxLB5VYuBjfgVnSmxbF18SL7gtZK85+vo=;
        b=ZjHcoDpiLMNSUJsXRdHHoVI10QRP5o4ft11zb3Ae70kC/MIF4mJ56ej5d5/74wisQs
         qkBTX+hNjLiTHM/dTY8iuZN/9g/STdBq97Q/111KRAn8w+aVwi1IMDnZHD+IzvCqDQnx
         fvIyT8Nnr/QzDv1cIiFSrOllWUvi93aENZXMYIe2HG8P6VAvsCCywjsfbmneCWwpxoy7
         spxOi0axo8IKhGpTc2M+3s52co9u8rxsN/SxBFoolN2swFgzvFQDH43rgJTaY8pjfUDG
         G9sS2EjkeSsvHVRLdqrLMT6S+TYvPFjap49masPnd3TfmK3hYQETGLJxl0q45yBtgKrK
         RYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xZPj9+0u4UpxLB5VYuBjfgVnSmxbF18SL7gtZK85+vo=;
        b=V4uzjtP98bhdRT8j2Ftxd4N5XFmkEtbNRFsXGdkLx67B8dMhpLOikffrbbH58fNpbX
         p6YT11fWFRvo8ofBTOgf+aae40E0tlRUzvPWEXKMAoQXORoRvLnqpoedymGuuqgv7hUC
         e9s8vXnRtI9AUtTgCL2DO6ZWfebH1snCKMfhhhNE7j1QKJBSRqQkK498yRsPoJwCB7v1
         C0IBFQL5GkyHesNaHW+fWWwcNFCzDSBQZikYiIpunwR2H79prN5cGXc/QrrmmCGXhrO8
         SlEJnMtyyOFtPvbue7NCV95jBLRanWIVzDDmcsj9Vc16gpnbuZOHnEtYZBi5krc6AhHE
         71lA==
X-Gm-Message-State: AOAM532VG2oU3YcAPiZgCy0ZM71Waysfaic0RGZFEQALvpF/lj9wHK/y
        7X6haPzS0NnaCI6m3lPoW8fln3vMeuqztv4l8Squ4w==
X-Google-Smtp-Source: ABdhPJy0cOrD/v+9nnx1n8hs19I5qVRehObHuWcfXlV5ouHb8tblSLynkE/pb9vKV00v0G2yjQc69bjX9PIKd8IAR58=
X-Received: by 2002:a5e:a705:: with SMTP id b5mr4889792iod.12.1591289086685;
 Thu, 04 Jun 2020 09:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200603203303.28545-1-sean.j.christopherson@intel.com>
 <46f57aa8-e278-b4fd-7ac8-523836308051@intel.com> <20200604151638.GD30223@linux.intel.com>
 <f7a234a7-664b-9160-f467-48b807d47c8b@redhat.com>
In-Reply-To: <f7a234a7-664b-9160-f467-48b807d47c8b@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 4 Jun 2020 09:44:34 -0700
Message-ID: <CALMp9eQoKJg36AabLErekJ-U10-DkRHW=dn14q0bxQHh7XrGMQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Always treat MSR_IA32_PERF_CAPABILITIES as a
 valid PMU MSR
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Xu, Like" <like.xu@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 9:20 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/06/20 17:16, Sean Christopherson wrote:
> > On Thu, Jun 04, 2020 at 09:37:59AM +0800, Xu, Like wrote:
> >> On 2020/6/4 4:33, Sean Christopherson wrote:
> >>> Unconditionally return true when querying the validity of
> >>> MSR_IA32_PERF_CAPABILITIES so as to defer the validity check to
> >>> intel_pmu_{get,set}_msr(), which can properly give the MSR a pass whe=
n
> >>> the access is initiated from host userspace.
> >> Regardless of=C3=83=E2=80=9A=C3=82  the MSR is emulated or not, is it =
a really good assumption that
> >> the guest cpuids are not properly ready when we do initialization from=
 host
> >> userspace
> >> ?
> >
> > I don't know if I would call it a "good assumption" so much as a "neces=
sary
> > assumption".  KVM_{GET,SET}_MSRS are allowed, and must function correct=
ly,
> > if they're called prior to KVM_SET_CPUID{2}.
>
> Generally speaking this is not the case for the PMU; get_gp_pmc for
> example depends on pmu->nr_arch_gp_counters which is initialized based
> on CPUID leaf 0xA.
>
> The assumption that this patch fixes is that you can blindly take the
> output of KVM_GET_MSR_INDEX_LIST and pass it to KVM_{GET,SET}_MSRS.

Is that an assumption or an invariant?
