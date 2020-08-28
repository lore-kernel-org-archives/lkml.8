Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D01C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805532075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUqN/qrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgH1S3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1S3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:29:22 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC2C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:29:21 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e23so29859otk.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Uqz1c4wz/+QeP0lM37IWyWpsW+8C5dMpeQfSu9DoCw=;
        b=fUqN/qrtMEMO1vhmrWg18jXZ1lLte1cnW9Dn+onsT+OTP1TlLgml7d0yrIF7Kzqc+4
         PhxEu3abE9D0QKhUGRAHmQ3sMJvqeCojDVHC912uDllWZbw0LR7vUWf9YOGMjQHKyj/w
         w8VrgsfzDeaW9UjiISiTPXjTE8DJiYaBCTcVi41UCUlc/VPG85nmefKnjQqBwpQsGmpe
         Em9kBR+E/F2IJIxcyhszVcmJjdalSi2Yi6aXLJy5Jocz2J5XcrbfQWt2PKnvWTe+ZQhw
         u6G6de0S6vFEeVRwEpitdqPKj7wGfqBQYrp7kCs35PkSDszusnwzz4saPhKK4H3biwE4
         chuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Uqz1c4wz/+QeP0lM37IWyWpsW+8C5dMpeQfSu9DoCw=;
        b=cP4Cb6keiJs6kskUFv8pZQAHf2xS+U8a4WGQTzj4LKywwIkEvdCYEqFvIPR07jB65K
         3K1C8NwumTo0XKOogBX2P9ZD0oWbzi7mYQqn8fokqO8KaefMBeq/MElsm+0Fz+0GnM96
         jef0NSedLST0Ek4BKWOx9m8SZDgSsGPV9gZRlvcpo7XH2tyDTGbfyCGy6gltYLrf5RCx
         MKbKJTwcYo8J6O17VMjrBpiOOvgqx07x1DEw2Z1ZcIcIoq5zGf2S1ezm/ysGaSBDRxAw
         bwzvZi8FXFkjnqLOIh1aPLk3W/qghP7oKWiZr5jZSB6ewv1lpSPra6CHmPsEC5hjUjNr
         0BLg==
X-Gm-Message-State: AOAM533aeAbKL0iDhxMx1W/bsxf8HiCnhq3kl7NAMxN6LPaf00ESm+Da
        YyUC5lIfbG9Rug3NHoDgKbD2LtvR8lzAdcC02bizuQ==
X-Google-Smtp-Source: ABdhPJzz92se4PNrhB2hOBoElmY3QW0kQDcYEwrrHi7oPMn+QHDAsAH4wkO7+qT/DwnKY98YLJ0pL8Ysp5VsQFW9pgg=
X-Received: by 2002:a05:6830:1ad0:: with SMTP id r16mr2244855otc.295.1598639359262;
 Fri, 28 Aug 2020 11:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085622.8365-1-chenyi.qiang@intel.com> <20200828085622.8365-5-chenyi.qiang@intel.com>
In-Reply-To: <20200828085622.8365-5-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 28 Aug 2020 11:29:07 -0700
Message-ID: <CALMp9eThgAgzvvPDktD2PZOthqPWMYNKTAhu=NpcXq=6fbiGJA@mail.gmail.com>
Subject: Re: [PATCH 4/5] KVM: nVMX: Fix the update value of nested load
 IA32_PERF_GLOBAL_CTRL control
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:54 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> A minor fix for the update of VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL field
> in exit_ctls_high.
>
> Fixes: 03a8871add95 ("KVM: nVMX: Expose load IA32_PERF_GLOBAL_CTRL
> VM-{Entry,Exit} control")
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
