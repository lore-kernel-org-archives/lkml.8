Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1784C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFAB20758
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a925dQD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHUASx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHUASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:18:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026FC061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:18:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q1so54040pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=s+gefwGGLS4RZ9aAtxwt9F/Q7T9fxHVOG5Dd2Edw1yI=;
        b=a925dQD7UAnI2WEHBuEp1k6vs46a15EXpwoO8/XlJ2KVU7wPk+MkHan4VwcKlaJ7UT
         j5OgC4nnfa03FnISqr4Pz0w98qcVngy8HTRZ5tGwyTFBFsLslNIIE4JkLP0ozADvhQGx
         NcGR0SsMTlfRtOjLWJyfTfIaXNw9PBCWPqYxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=s+gefwGGLS4RZ9aAtxwt9F/Q7T9fxHVOG5Dd2Edw1yI=;
        b=T79B0+egqbymQpXIn7cIFMAKXDQLzA3VHG/IAWk1Lbnb8F0QKymO/Q/FyTMFOfAX2v
         UvLi8p37N39GPY4xDxSXB5VKQu0mvC460y+24TRqxI/IHJJ5gbz+R3UttXgTlV6/B75+
         NpUyu9DU8++iOznlSSso5fO195VlTMeoIO4/WFEoGzCjcyLcxpZ5EFoe+wSmzxMY64jj
         WfN4i2hEWWINg13AkRRN6zLpUR8mE7hp4LRtADSxvLAgtRMNj5LKrJ4fcycNQNfM/pqG
         BUWr9RhsnOf2Z3kDzSldbwEdwH2n4DTtd1w5IV1LLKdFEWzuIQor81/gewewtQGhHGJk
         WhUA==
X-Gm-Message-State: AOAM5337jOdAWInvSORdp3V0ZIGUvAtA4XX47m++g80MkpwXATxJhAR5
        S6lbLRuHBlRxTtRB9+mDefeh2w==
X-Google-Smtp-Source: ABdhPJycAJIRRlSrBG3gbwhGKoE6fAYeLdDcGy0d95wxs2vWn2H649ZQ/s3tg7y+5yjnbfnHBOKx8w==
X-Received: by 2002:a17:90a:1749:: with SMTP id 9mr249662pjm.127.1597969127726;
        Thu, 20 Aug 2020 17:18:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w14sm221421pfi.211.2020.08.20.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 17:18:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200820103522.26242-2-rojay@codeaurora.org>
References: <20200820103522.26242-1-rojay@codeaurora.org> <20200820103522.26242-2-rojay@codeaurora.org>
Subject: Re: [PATCH V2 1/2] i2c: i2c-qcom-geni: Store DMA mapping data in geni_i2c_dev struct
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, saiprakash.ranjan@codeaurora.org,
        gregkh@linuxfoundation.org, mka@chromium.org,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, rnayak@codeaurora.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>, wsa@kernel.org
Date:   Thu, 20 Aug 2020 17:18:45 -0700
Message-ID: <159796912574.334488.10846610259602895929@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Roja Rani Yarubandi (2020-08-20 03:35:21)
> Store DMA mapping data in geni_i2c_dev struct to enhance DMA mapping
> data scope. For example during shutdown callback to unmap DMA mapping,
> this stored DMA mapping data can be used to call geni_se_tx_dma_unprep
> and geni_se_rx_dma_unprep functions.
>=20
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---

Can this be squashed with the next patch? I don't see how this stands on
its own.
