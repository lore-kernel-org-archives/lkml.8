Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB35C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED43206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaOY33YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAUR3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:29:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46772 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:29:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id r9so3614674otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzVs5yU5e7GypYXTX5nkOgXJ+y1KuzZBRltNX7nsZX4=;
        b=jaOY33YDlWKCRJgGf+lLzK9u/rCvJjunPfvZAe96diwPbnrnlqJPsjMGhMj/ptM0vS
         g7InLquIbotFt9nrsxHpBzAhtbd172jgTuzlW/YIzDIjWx1gyFaoaL4+xxuxpvG+GpI9
         5X4LXQgurepHyWBogU1XuZrv5QLRcDgFTf2CcsBJII4h4I0k0GqL15dxSmb3Yowviwgo
         Gpfzc9XhdhHolXwOEzJE/H2jZiPa4ox9o3B8DAbz0Uitl/J+k4TpvOfscD2ULNwaB6O6
         E+3V7ODhyB92SdGmKwFo20u3P3ijHJMszYSl6M/6uJecf1v/Pp5CLEJ3SZEG6T5eD7kY
         YZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzVs5yU5e7GypYXTX5nkOgXJ+y1KuzZBRltNX7nsZX4=;
        b=NnSQbAPbjB8m79xDjJHOS2VlytinxtO7kuWE77zsQ9dn2PhQB9g5xRL4IWkEH5wiMm
         XSaLnr9M0ajVWqOA6cAbP4jbRjJ3F4aGeNDNM3WvkEnqJeRpJCF8iSTPjXOxtitKVbba
         PN6n0UJ5+KuuMDoCpTzWrDOsEdUkjxSWHKHy43FGQHrg6xjb05MzQ7laYE+cqShDWzY+
         9Z3n2M0txw1iONRhJ7l53uSJBwBiWEdRhKBmCq/0QwPKHhworQLuLGZ3MWbQcUgKS/ue
         Peu8cq31Xx+8wuuzs6pUO8k4D918czPzPEOM0Hy4jA3dTJsQKoII+wdJ9uU52Vsg8SlA
         KKag==
X-Gm-Message-State: APjAAAXZR3ngwozCNQ+x1QuxxHm0CdOY4BLPqJX2JGEIwKtud3eKfUUN
        2iLw7cvUmhCSVPkGC1ToOUgb7z/HOFSYCj7KTsY=
X-Google-Smtp-Source: APXvYqzum8le0i06iNjiio7kmCZiIdhNCeqRocdGXC1d4lnLBJVL3iDPKLaEYytIyeF3gpdyTrMzzURDsyIyG4B/hkM=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr4190300ots.319.1579627763287;
 Tue, 21 Jan 2020 09:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com> <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
In-Reply-To: <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 21 Jan 2020 09:29:12 -0800
Message-ID: <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com>
Subject: Re: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 1:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 18/12/2019 4:39 am, Cong Wang wrote:
> > If the magazine is empty, iova_magazine_free_pfns() should
> > be a nop, however it misses the case of mag->size==0. So we
> > should just call iova_magazine_empty().
> >
> > This should reduce the contention on iovad->iova_rbtree_lock
> > a little bit, not much at all.
>
> Have you measured that in any way? AFAICS the only time this can get
> called with a non-full magazine is in the CPU hotplug callback, where
> the impact of taking the rbtree lock and immediately releasing it seems
> unlikely to be significant on top of everything else involved in that
> operation.

This patchset is only tested as a whole, it is not easy to deploy
each to production and test it separately.

Is there anything wrong to optimize a CPU hotplug path? :) And,
it is called in alloc_iova_fast() too when, for example, over-cached.

Thanks.
