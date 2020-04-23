Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8FC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4F020857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wkr0bymD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgDWOfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726138AbgDWOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:35:46 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE6BC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:35:46 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u12so5857828uau.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txoUP4TZL/kX6wzTvIyyPM8Tw98hlNv8TkS19LKzzNo=;
        b=Wkr0bymDg39KvhwGQedoiURyuP/SArfM/9lbpXIi1kmydOSd5DW7q2QV6F+YHrIzDQ
         JTwKM1kQFW1Ecz6bwK0sChfkdhZMNRukeEymx9JDsupFdDqi7m2c9kbHgwU1rbDm7JyF
         RDOjDH5tbRA+5Rrd8iV3L/pXJmss/r1qVJCMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txoUP4TZL/kX6wzTvIyyPM8Tw98hlNv8TkS19LKzzNo=;
        b=iot7vEOBrxxp8OsrrElZnS8JCtgzITnbR4qlY/uIQnmjFncpuWKjdN73gFSbT7k+iZ
         MmU/l6RrBSHFf7PqO2d0hWS8oxj/T+o4Trrr+WkeTQzBJg6sHXB+g4+7gOJ49TTLkXkk
         q8rnBoqvQZPQrhwtm9h7mmN9Jj4knJN7ZgkcWqBE5qd2Lf2qwwk7v9vLTx/53jkGVViv
         fKw4MC6iiQKnZzfXRcWKbGa+1vIowGbmeWvYvWWn7ZCb9+9bqmwuoDDYkhuPFJnNnq5y
         J2hm4IPUe/egDIqtJndigeRyGc8puulmRYoVUQBPlAlvQTFplKAbd0a90hELHGvPLc53
         uxvA==
X-Gm-Message-State: AGi0PuZ6hfZmNUqQp88+81xwiXEW2K80O1k+CWFdQ4VvdsCGgptN3iDi
        BvbxjLWPd5LpzybmY6XtuIP5XsGjs4Q=
X-Google-Smtp-Source: APiQypIB12dbMzWQ8pcA/IigZmRYW5AAV1br+Xw42tpDL+YNIAZqe3bKZuULL2qtypHB8I+HqE7qZA==
X-Received: by 2002:ab0:24d3:: with SMTP id k19mr3934161uan.36.1587652545761;
        Thu, 23 Apr 2020 07:35:45 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 204sm748086vka.32.2020.04.23.07.35.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 07:35:45 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id v24so5871991uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:35:44 -0700 (PDT)
X-Received: by 2002:a67:f5d6:: with SMTP id t22mr1333288vso.73.1587652544353;
 Thu, 23 Apr 2020 07:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Apr 2020 07:35:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
Message-ID: <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
Subject: Re: [PATCHv2] iommu/arm-smmu: Make remove callback message more informative
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 2:55 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Currently on reboot/shutdown, the following messages are
> displayed on the console as error messages before the
> system reboots/shutdown as part of remove callback.
>
> On SC7180:
>
>   arm-smmu 15000000.iommu: removing device with active domains!
>   arm-smmu 5040000.iommu: removing device with active domains!
>
> Make this error message more informative and less scary.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
