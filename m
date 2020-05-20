Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCAF206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txf62WqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgETIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:32:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39044 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgETIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589963572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RmOXj1sWhvWoKhdSD0p1vfnJVy6tNauqOTA14BFZb40=;
        b=Txf62WqR5qdCnPsofmGtZ0dkcQQg9jM3+kt4xD/GLTUHLmJdI3ppYlXd09UbtEecPikpuq
        HB+B/0gGMs+VxoH/PWm4yOxIoURVCLYV1IkwCqwCidkXb3jGG0XZvq4n0xOtVqS84Po8yC
        xTmN3zJaKKpSSDGH0UHYOzEEgquUki8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-6c4OjkJ-MJWw2kkugFvy8g-1; Wed, 20 May 2020 04:32:49 -0400
X-MC-Unique: 6c4OjkJ-MJWw2kkugFvy8g-1
Received: by mail-qt1-f197.google.com with SMTP id z5so2877509qtz.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmOXj1sWhvWoKhdSD0p1vfnJVy6tNauqOTA14BFZb40=;
        b=OGsR5LcB4PKOECk+Ze6nkYP2dZkG3qmS+1MyHszKcxNZcIAsAtNrwgnAxt3f2QZxFn
         Vo2N9pHpnuXiv5Hnyzn3Otqz0osEMfWxVo1oRsvyrL4yYXTFLeNEngy2tyAXWosSLeX7
         DmyfY1UW/Jb55TD3g6Lg3oVb2YzkMCBdtNECyaWHXhRfdwi4POwcOFXZ21/BLaz8U5CJ
         S52sl7/cEjniwYd39afMxMlzaDQGrUMLGokbM2qOh/vDcVAeIeiKv7wuHYcEI0SEuSY5
         Aa2ESkf09cMe1R0KhtEVLB72A98gRCs0MROKB2N3j5V+9JAP7jWyrvzlQAaAEn+clIxc
         rdvQ==
X-Gm-Message-State: AOAM533FIuF8baaKskYE2sppL9jiM3gHRMdpF7JG5ANYU2HjJIeDZGmC
        iWTnLy4qXK+dFef5JxcjNNElmhUUayVYWExcd7tmZ/vZhgGxmThV7Li6kDYTPrseJ20ENvu/47g
        QMGHlZgXsZfyFijnspQiGSk59utb+5qk3TxY9FriE
X-Received: by 2002:a37:c20a:: with SMTP id i10mr3478203qkm.29.1589963568763;
        Wed, 20 May 2020 01:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhjeXdrCTfIEg1oJlMc+NZH3v1U5iNIyOTTTevnbwqW+4KEKmeS/BGmSfvSXiGZsuSg8h37pLDV4T75rp7/6A=
X-Received: by 2002:a37:c20a:: with SMTP id i10mr3478185qkm.29.1589963568417;
 Wed, 20 May 2020 01:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com> <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
 <3D37F6BE-ECFC-4EC0-A7C4-341F85FC056E@oracle.com>
In-Reply-To: <3D37F6BE-ECFC-4EC0-A7C4-341F85FC056E@oracle.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 20 May 2020 14:02:36 +0530
Message-ID: <CACi5LpO82hmXG6bcSqhAhNZJW8mPRP2CuLGT2mrgKDMk1s8g_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, May 20, 2020 at 1:53 AM John Donnelly
<john.p.donnelly@oracle.com> wrote:
>
>
>
> > On May 19, 2020, at 5:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> wrote:
> >>
> >> Hi all,
> >>
> >> Friendly ping...
> >
> > I was asked about this patch series, and see that you last posted it in
> > December. I think you should rebase it to linux-5.7-rc6 and post the
> > entire series again to make progress, as it's unlikely that any maintainer
> > would pick up the patches from last year.
> >
> > For the contents, everything seems reasonable to me, but I noticed that
> > you are adding a property to the /chosen node without adding the
> > corresponding documentation to
> > Documentation/devicetree/bindings/chosen.txt
> >
> > Please add that, and Cc the devicetree maintainers on the updated
> > patch.
> >
> >         Arnd
> >
> >> On 2019/12/23 23:23, Chen Zhou wrote:
> >>> This patch series enable reserving crashkernel above 4G in arm64.
> >>>
> >>> There are following issues in arm64 kdump:
> >>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> >>> when there is no enough low memory.
> >>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> >>> in this case, if swiotlb or DMA buffers are required, crash dump kernel
> >>> will boot failure because there is no low memory available for allocation.
> >>>
> >>> The previous changes and discussions can be retrieved from:
> >>>
> >>> Changes since [v6]
> >>> - Fix build errors reported by kbuild test robot.
> > ...
>
>
>  Hi
>
> We found
>
> https://lkml.org/lkml/2020/4/30/1583
>
> Has cured our Out-Of-Memory kdump failures.
>
> From    Henry Willard
> Subject [PATCH] mm: Limit boost_watermark on small zones.
>
> I am currently not on linux-kernel@vger.kernel.org. dlist for all to see  this message so you may want to rebase and see if this cures your OoM issue and share the results.

This is a very interesting finding. Thanks a lot for sharing the same.
I am working on further avoiding OOM issues with arm64 kdump kernels.
I will experiment more with this patch and get back with more details.

Regards,
Bhupesh

