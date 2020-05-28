Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C11C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0C720C56
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE1Cdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Cda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:33:30 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B4C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:33:30 -0700 (PDT)
Received: from mr2.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04S2XTDd005898
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:33:29 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04S2XOhO030570
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:33:29 -0400
Received: by mail-qt1-f197.google.com with SMTP id o11so11832976qtm.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=0nXxYl68zla+YhhBxvgGOUC+CKwmt/1B7Od03HUz+n4=;
        b=Sq6DRd8icBmPcZVirG4deetJMqPc+1JVMRjDmm3RKygTSkXDNUKWRqYskgdPlw8eDh
         yeuYuktSf3DRn72knvjA4sw7ybFnlkJ34sI1VuPKQocQX6PjZ8mNwivcxOaV8YUgTA9M
         lHWi/XCBcJhJcNkg8WfGV4bQ1PKVJl2oLcr7vLthP6fx6G4V+eGFiq8Q2lG2nmPUZ0r3
         CpJYTWbMT24RJCKhsVaY1fIXgMH4EfhqcnVw72BRw0Nn25c15VhNv7bY3gnZfZ3CXduh
         tLyzBj5lmL+kCtlHLD+qOXa4fVDlJAMrhmh1OFJKjh11BtZx750oG8zx1wUBKLD/rYOi
         9/VQ==
X-Gm-Message-State: AOAM531D4nhMDyllSZWTxgideSQ1866IDGtU6Kq4DFz5V3+ICX5PZAYa
        U8SLOXuhBs6BfqueKyGDwTJjgFe12EbYV1ZJ5jZYCSCQqWN0rh39Q0NPQd5DYUISvT9pB9YQosX
        g4XIRCbFPGdMASyoZhMSQQcIeLLUmg+rjcwE=
X-Received: by 2002:aed:2189:: with SMTP id l9mr843640qtc.213.1590633204220;
        Wed, 27 May 2020 19:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt8ofml64BHibxtgLRipcWuyMTQfU/UrmB0nn7+scuWmIoa9l52/AAZbAiqUrlsVgmCePbDg==
X-Received: by 2002:aed:2189:: with SMTP id l9mr843629qtc.213.1590633203910;
        Wed, 27 May 2020 19:33:23 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 185sm3965127qke.92.2020.05.27.19.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:33:22 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>
Subject: Re: inux-next: build failure after merge of the drm-msm tree
In-Reply-To: <20200527041618.GA3137030@ubuntu-s3-xlarge-x86>
References: <20200519150955.1667566a@canb.auug.org.au> <20200526140841.0a1d5c7b@canb.auug.org.au>
 <20200527041618.GA3137030@ubuntu-s3-xlarge-x86>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590633201_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 22:33:21 -0400
Message-ID: <453780.1590633201@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1590633201_16657P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 May 2020 21:16:18 -0700, Nathan Chancellor said:

> Additionally, I see a failure with clang due to the use of Bps_to_icc,
> which does a straight division by 1000, which is treated as an integer
> literal, with avg_bw as the dividend, which is a u64.
>
> Below is the "hack" in my tree.

Also needed with gcc 8.3 for arm allmodconfig.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index 85c2a4190840..5ea725d8da6c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -250,7 +250,7 @@ static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,
>
>  	for (i = 0; i < kms->num_paths; i++)
>  		icc_set_bw(kms->path[i],
> -			Bps_to_icc(avg_bw), (perf.max_per_pipe_ib));
> +			div_u64(avg_bw, 1000), (perf.max_per_pipe_ib));
>
>  	return ret;
>  }
>


--==_Exmh_1590633201_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXs8i8QdmEQWDXROgAQK+7A//a5beY1ETkYe8PbDyxkN/SZei/9Gf0fVd
MEElgE9nZlvdsFVlPL6xO/8VlUmTvCinLl03H9A23mr1WTyBbVn1ZQV4GE0D2f9T
IaWOG1DhmuFvGkZ2yAc16g5DCaULTflvSk7W5wj9829qLLcemrkrtPq2HxqEF5KK
nDmCIDjZr6MDrk52/7MZbwOudCqUDd0GcnPO6Zl0sWfwYfRdYOazEEb0zDe1oyTe
4pglXNl6brQ46njR8vs3E91Ch5j7zQh3cu2t2T9vuCuZ4vUs2jJro55JWhG+M6rz
pOu/yZybVJ5dvYaJbnuWzA3u9j1IlDxrbD4OXlfb71NpczjrRVRntbBmiZseM8Cz
3vVBqa9qvpz3ZicWW+PGIxATpANYbEbBepJRMHT3feqBouZqrye8qSBTkUVLl+rh
or63VjLP3wMnDeFIWllwCOzKTpq6QXlOdOvShauDcJWdZPnU0ocKYcgUKIua/KGW
cT5DaMRXZvD/nqsZU83wKBqIYtGQ9fDhpCuxo9JNfFIZ9nXwXK9X0IWHg7SHXOuB
Hsv7I4DGzAvwIpmBR7RYwbWtZslWR4MAEJ6VGCkpyw4/CmoxEYwPSWBQRzYc22jA
bSFYIepjRWZTiyjvKTE4noPlBxXBO11Y5ZpT4jkv/UsQNIlSEndLEHxYyDJg6bgY
7QFqYzGfJ0I=
=w9N+
-----END PGP SIGNATURE-----

--==_Exmh_1590633201_16657P--
