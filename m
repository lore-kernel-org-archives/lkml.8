Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8D521D91
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="anjWYdkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgIJW3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgIJW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:29:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0ACC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:29:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so8017041edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RemceQYpfwTMZI7GvmZz01XxDX57S6jy8i4dk7JJMAA=;
        b=anjWYdkLN4gIBWfzcuYV32XXsJNNWFlJieTFfjQBtCxv7TQFjfdJIYWsKDwJv67SJt
         X3lRg3LAFe3yemCNMT3YNeSLRgw9zEjXIH6bER9PF3Y6qiUSYAx52hv82P/TWh+y59Xy
         /xcdM7RHlcTX1Em272Zhy/29KdOtrFqkATOH6IUIBShC0a2Ix2R4+glwUOTbMh5/n4VQ
         V6j9rcO961M8qh6Q/5MeOjV0cnZl78WXT+SfWk/5rBmUJZmzR7iB4hP9O29636iNsO7k
         +N99UIYyS2wwaNbrUwZ047GZ1Tku8kpFLfNbown9eZV2HEX5SA7NyvtWfsI7BRXWNmVb
         Ux0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RemceQYpfwTMZI7GvmZz01XxDX57S6jy8i4dk7JJMAA=;
        b=nbNHRkTsKQTyg24+EfYazBV/NMibaQITW7IheIJqElLOYe+xLeespmwg4Nq4CsQdqM
         /A/xzAPb0iyeTtqxjKrYdw0OvY0edVykK/nFtwk4wG+ASFzfMNE3/CQkwVZvmQOiqLwV
         WB2pPVgtI9U818o3kdnoYIVaJb66hcofSL/bRRCTNepUR1Iz4XpAW3Qfy8c2AjV4VTAc
         UmLED+JVz0QxGZ0ybaiBx2yyqUzhfXA44JLbh/iGbDSv/sEqZhLJVyjKJCEkyQ+Rn/bR
         JIIoLzZikG1kxUwpuj90f6tKD72lgqv1poSOTq1Uv1ZqDw77Lq0nMDj8t1Vox/iUNOoK
         Gblg==
X-Gm-Message-State: AOAM530fb7aVp1s8SCHpZw2Kt9ztsRp1fM8SVUEpdLBr7kyuwWntOzHY
        c5jQOSv4pqWA0ahY2gUibttgrd4e9QpLktDtp2+rcA==
X-Google-Smtp-Source: ABdhPJxByr+VKSmMGcDLHRgmPssigxjSr+wMirCzz5iMdKine6/IsGRjO23WjHzNFw4NLOMWaVGp/bAiryc5Pa+xxVs=
X-Received: by 2002:a05:6402:1544:: with SMTP id p4mr11588205edx.346.1599776945630;
 Thu, 10 Sep 2020 15:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com> <20200910220145.5j7iogqulmvg5vr6@black.fi.intel.com>
In-Reply-To: <20200910220145.5j7iogqulmvg5vr6@black.fi.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 10 Sep 2020 18:28:29 -0400
Message-ID: <CA+CK2bACLNVqKP9Mgr37HQKOY=7+-PwuLCtqN6+saW7uuiMCfw@mail.gmail.com>
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Allen Pais <apais@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Thu, Sep 10, 2020 at 6:01 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Sep 10, 2020 at 01:47:39PM -0700, Vijay Balakrishna wrote:
> > When memory is hotplug added or removed the min_free_kbytes must be
> > recalculated based on what is expected by khugepaged.  Currently
> > after hotplug, min_free_kbytes will be set to a lower default and higher
> > default set when THP enabled is lost. This leaves the system with small
> > min_free_kbytes which isn't suitable for systems especially with network
> > intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
> > soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
> > kills.
> >
> > Fixes: f000565adb77 ("thp: set recommended min free kbytes")
> >
> > Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
>
> NAK. It would override min_free_kbytes set by user.

Hi Kirill,

Thank you for looking into this. How is this different from when
khugepaged modifies it?

echo always >/sys/kernel/mm/transparent_hugepage/enabled

Which results in:

start_stop_khugepaged
  set_recommended_min_free_kbytes

Which will also adjust min_free_kbytes according to hugepaged requirement?

This bug that Vijay described is another hot-plug related issue that
we have found on our system where we perform memory hot add and hot
remove on every reboot.

Thank you,
Pasha
