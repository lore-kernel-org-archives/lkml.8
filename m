Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A59CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F092082F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B05aJafb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgFVIDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgFVIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:03:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CEC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:03:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so13911067wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywxvkE6q0cbrbXTJPKV3+AgmecGjcEiMLhxzggDoG6o=;
        b=B05aJafbS6ANDvwzCVLuomo34ddofnlUEe/dzFaae8H9n6l2rKJI6IrZm/zCfUTcG4
         OCLkNzJtVemG5dLrAysL/t/jVfGhLyhQTy382vmEjbizP4S+UajTShxqcx/D3Ekis/sx
         xjlHvyulEEeWN0OSkG4fYkV3K3HMQaRIBA0DdfA8Kz931INPhBaszFpcn02RhVs+MHbT
         UejiUNIdu5uDqXrb0p/vZjjA1o51htumX5Jv2W2cDFrlcJUf6NNfdCjp1NGj6emOae9i
         q4hwpXDA6BEg0uXpq9feIG9z6QgYtR0NfoQn0C5RgzJRgi4p8FemcfwKSmYpVKug8pAe
         Ky5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywxvkE6q0cbrbXTJPKV3+AgmecGjcEiMLhxzggDoG6o=;
        b=i8sdnkLYh0MBk/jextVWd+H8FHI/ffAjfix+wtiHW3s0yEFIV6BwCN805YZxc1VQ0G
         FJ3GBD6R1z06dKyPNxLHuasP8f/3sLpYmkHI0hIOJ3m+U7UGYQGEqaAjru9ZUsC2wXTt
         /fLaBvFiEI48p5JprCz75p2CTKNpRMRrnQS5UmSFnoG0u8ZmAWnG8xTN+vG0buQV9sAk
         gXIO2VWW4jHJsdhCiydqdb6xPcMGfVi1v81sYUJtMGJnulrjQNc6wB9ekYbEbcCOjYzG
         q4Eebt4GG19Hr3GMF6ZD3NPVS6vkyMiDsO/0ANoKtUPfF/DA28HKAjoPCOMZDNKTu9Yz
         PnVg==
X-Gm-Message-State: AOAM532vsyVud4mh0suNU2yZaM5PDkcZ0JoCWpuId/4nzZy+EVhFQZ51
        6gn/4ukM28Hnc4Qi93GAAFO/wZKgsek=
X-Google-Smtp-Source: ABdhPJyHIKw9WEzh6N3BXcgx11UwI1xf/377zz0nUKvGGyqiZiH4zAvWq3AiOlscznnhY/lIRP2Cng==
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr17990066wms.40.1592813026778;
        Mon, 22 Jun 2020 01:03:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:673c:7143:200f:54b7])
        by smtp.gmail.com with ESMTPSA id k16sm16791759wrp.66.2020.06.22.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:03:46 -0700 (PDT)
Date:   Mon, 22 Jun 2020 10:03:45 +0200
From:   Matthias Maennich <maennich@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, YueHaibing <yuehaibing@huawei.com>,
        jeyu@kernel.org, cocci@systeme.lip6.fr, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scripts: add dummy report mode to add_namespace.cocci
Message-ID: <20200622080345.GD260206@google.com>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 02:39:18PM -0600, Shuah Khan wrote:
>On 6/4/20 1:31 PM, Julia Lawall wrote:
>>
>>
>>On Thu, 4 Jun 2020, Matthias Maennich wrote:
>>
>>>When running `make coccicheck` in report mode using the
>>>add_namespace.cocci file, it will fail for files that contain
>>>MODULE_LICENSE. Those match the replacement precondition, but spatch
>>>errors out as virtual.ns is not set.
>>>
>>>In order to fix that, add the virtual rule nsdeps and only do search and
>>>replace if that rule has been explicitly requested.
>>>
>>>In order to make spatch happy in report mode, we also need a dummy rule,
>>>as otherwise it errors out with "No rules apply". Using a script:python
>>>rule appears unrelated and odd, but this is the shortest I could come up
>>>with.
>>>
>>>Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
>>>`make nsdeps`.
>>>
>>>Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
>>>Cc: YueHaibing <yuehaibing@huawei.com>
>>>Cc: jeyu@kernel.org
>>>Cc: cocci@systeme.lip6.fr
>>>Cc: stable@vger.kernel.org
>>>Signed-off-by: Matthias Maennich <maennich@google.com>
>>
>>Acked-by: Julia Lawall <julia.lawall@inria.fr>
>>
>>Shuah reported the problem to me, so you could add
>>
>>Reported-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>
>Very cool. No errors with this patch. Thanks for fixing it
>quickly.

I am happy I could fix that and thanks for confirming. I assume your
Tested-by could be added?

Is somebody willing to take this patch through their tree?

Cheers,
Matthias

>
>thanks,
>-- Shuah
>
>
>
