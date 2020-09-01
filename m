Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE08EC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795E82064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZCGQwgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgIAPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgIAPuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:50:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9AFC06125C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:50:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v69so1391117qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jV8bljM3lK+GBB6jw/WspxqJuyJuh/lf4f+szOAk3Fw=;
        b=XZCGQwgwBt860UII5cREakpxcHTR71LTVSlB36D/ju3AvUYviLZB4KikFD+0jTIyh4
         elj6nui5j6HeINBSDmNWHrIdG34Uv3wns0bdy9KTaoVYV+kisqyRNmJSOgrYLuePTrad
         lA3IdMFJZtWBxBXHGSaG/pYJoPXIiHRGQ618S7d0TpMG/bMbJyArJDrv/7cZrSJ2Yojz
         mFwtdlJXC2TzgWARoJGIRfZ659fxiIKfJZwTq6NzfUmje2J3LyDHznp3jhgy78USqdaf
         r3yjjGj0lEMDSnlPQp5OvFZlLTcgShRmFUDnTX8/kuG4fVTST5BA+0DKvJ/FMGBpjY70
         VFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV8bljM3lK+GBB6jw/WspxqJuyJuh/lf4f+szOAk3Fw=;
        b=VmxZpA6kCXCVhj+AzXTw1Ls0EwoBTbv+ZTL4EzSSBouiWcyf8rZGFmpFPDphgwvVaQ
         0Hy8Vc39+R/D0b+SDF/sDksKm9woMRYdyUDMVEj49eRXsGulcCEhud9uHGHjN6J0IvEW
         qRRHayYm0/6AXM9aiE/3zl7Z6i3HOfpARkt4gQPHwXlshA1+2vVQVs1EHr/czDHVb4dr
         NcaVFfCoFXKLMnEIzpl1DILAOuXAdTKhpsFqLKcWW30ZDCr0iXioEpSBC6TSFGUgW5K7
         TCJ3eSyp32SfH23FGot0okBSFuuFDwdiDpA+pZvMnr/XcGOvBTUMkbmo/JjiDcB0HAUH
         pQSA==
X-Gm-Message-State: AOAM5338YReU4oISCEu4tXydsG6DrqkwfpO6x6Tj+x9t0e0BAxbhpsXJ
        zFLxGHZowRaafqwQPOOnpBDpcI8nvonnnZxyMSMCQQ==
X-Google-Smtp-Source: ABdhPJzkzDW/A2xwJZao0bULy5cxXeAqA2rpndP/DYOEayvx3lxC0orZ2wXvB+yxIaKuMONJzHiBClgTfH9lIzLya+E=
X-Received: by 2002:a37:9d4:: with SMTP id 203mr2555955qkj.277.1598975430108;
 Tue, 01 Sep 2020 08:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200901065758.1141786-1-brianvv@google.com> <CANn89iKA5Ut4AcZfsZi3bVpE33_pqgO=E1RhBzePUeBDn6gznQ@mail.gmail.com>
 <52832405-fa37-38fb-b8fb-d7bd7a0d1d52@gmail.com>
In-Reply-To: <52832405-fa37-38fb-b8fb-d7bd7a0d1d52@gmail.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Tue, 1 Sep 2020 08:50:18 -0700
Message-ID: <CAMzD94TmFiJRfgLp44z1GQ1zzg2Zy7o2Oa9GTTCed0kj5tLdLg@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix __rt6_purge_dflt_routers when forwarding
 is not set on all ifaces
To:     David Ahern <dsahern@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Brian Vazquez <brianvv.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        David Ahern <dsa@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey David,

On Tue, Sep 1, 2020 at 7:57 AM David Ahern <dsahern@gmail.com> wrote:
>
> On 9/1/20 1:56 AM, Eric Dumazet wrote:
> > On Tue, Sep 1, 2020 at 8:58 AM Brian Vazquez <brianvv@google.com> wrote:
> >>
> >> The problem is exposed when the system has multiple ifaces and
> >> forwarding is enabled on a subset of them, __rt6_purge_dflt_routers will
> >> clean the default route on all the ifaces which is not desired.
> >>
> >> This patches fixes that by cleaning only the routes where the iface has
> >> forwarding enabled.
> >>
> >> Fixes: z ("net: ipv6: Fix processing of RAs in presence of VRF")
>
> are you sure that is a Fixes tag for this problem? looking at that
> change it only handles RA for tables beyond the main table; it does not
> change the logic of how many or which routes are purged.

That commit also added RT6_TABLE_HAS_DFLT_ROUTER so I thought that was
the commit needed to be mentioned. But probably it shouldn't?
Also Am I missing something or this is only called on on the sysctl path?

>
>
>
