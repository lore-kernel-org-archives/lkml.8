Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43215C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F60024125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC5VDs/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAVRph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:45:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46231 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:45:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id r9so36177otp.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivphs1bWTObb7J+zazB6Vb2JyrITy24SYHszLm1C3fk=;
        b=eC5VDs/zXzC6Xiwfplai4oYrOJ9acBxzctsK96/Au4UsFmQduairzK2x1GST/qZobD
         lVQrwQjMKG1Bxcr5xP3shUaPn0KHngTd+Ffosyw4rJbHisohyQk2vnh+c18qJF6FbLSv
         MXQmlcL8anARYJJhgtLtchlv8f3xuO92Wet+JMzyWRmFujgmGfu9hDnG9JSm2mzme9h4
         UP0d2rBNSlcoJj18yHTM0TPNBRtJW1+qwPx+jPeaKAVrEL0ypfSmdpfWEuPXQ1S9ZAlf
         ViyIBCj3yffD4E+fofUcm4N5TT1IZkUtBytPpu8B0pilbx4nnqlvXAIoV7GaoKG0AEzI
         v2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivphs1bWTObb7J+zazB6Vb2JyrITy24SYHszLm1C3fk=;
        b=GB4BWfZLp1Lhn1lVqB0W+FQlyrWbj+bQmsoOxr5pjvqe5iLQc8++QMcXR1jQ0+tFrv
         O+bRlxvPu184zL+YqCIVgrZVHKWCzS9Jh+QmIRzlYjO9y8poJrMH7MxwCcXOCsOVBVGZ
         v2Bvak2Ovb6bsS+ctCzzHsnRednPAf1CymIQMO9S3G+ZMuikexQ1Af4qv0WaFmzLV+oW
         V4ReR3TveJsed0za5oER+Ykc+jrrWtQAjB2I6UjyMkBDrggiaccx2lVpwv2bmUU3CDxi
         fy9Lt6TIutOvdEgG9WmdD+Fvn/qQ3kE23Bsaq3h2TD0nxEno0aakNMAZN8CKMPeu1UVT
         y+Rg==
X-Gm-Message-State: APjAAAXg8Fg+df2fnWgRobM10Gv2bpSDJNdUqFdVIbgGJICzmM9Auwe6
        Xuw9mbEWWj+6/qYGitJHT6WeIiG2FntdjV+CHt+WEcYm
X-Google-Smtp-Source: APXvYqwoxMnR9MoGTLt5bQcblaue32BSzG0ctoryOAzSExLIflg+LUZ/9Tv0TUpYYUPaTTA8Z31mtAw5V1UGhgm2CC4=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr7884660ots.319.1579715136313;
 Wed, 22 Jan 2020 09:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com> <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
 <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com> <e8789016-858a-b354-aa98-637e1d453fc3@arm.com>
In-Reply-To: <e8789016-858a-b354-aa98-637e1d453fc3@arm.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 22 Jan 2020 09:45:25 -0800
Message-ID: <CAM_iQpWM52sPfwWQPqZ-Fd_w8MgnN14WOK5gJAi3JCg1AwQGCw@mail.gmail.com>
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

On Wed, Jan 22, 2020 at 9:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
> Sorry, but without convincing evidence, this change just looks like
> churn for the sake of it.

The time I wasted on arguing with you isn't worth anything than
the value this patch brings. So let's just drop it to save some
time.

Thanks.
