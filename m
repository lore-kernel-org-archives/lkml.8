Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78081C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE5420675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610784;
	bh=9Z6xls9+1/F1Yo1hIfLj3uYsIqN/TKDJBv70HGonkHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AKUGlIYrdE9AvMM/jknoOJmvjTS35keEB2OzcbfrkGDcVWLmEyC1hLMBLW+hFzgkp
	 I6sUoOfrUoAqVBSAHWSo0pcyP3iigUuAl4ZFWTOeTLxHiry7Lg1fUBVmJwwsWYr6sL
	 iZ94Yg9ySy6BjOjkIPOIA0Ju766F6Vuh2jvoYZCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgC3X0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:26:23 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37390 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3X0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:26:23 -0400
Received: by mail-il1-f194.google.com with SMTP id a6so17650993ilr.4;
        Mon, 30 Mar 2020 16:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LF85p8LiPrHnow4L9TnXbCTs4I8jEbhzC11j8ciLyRA=;
        b=q8/h18l++S7O6YTS47ei9mLwFlYYg/+0DTfQqUAGjG1ztZ3YR0SS6ETsBA53yeTHSk
         Ml3XBYKzSc+M9hdYNgFzJQnOdNsabacWjtDeCBF1TBEimUlMgPGzXHlfTKBYklJgwLJT
         mTtJbXKTuwLxEfD1i96EEezLs/zh6l2TEkhOZg5MArRxiSTNsWTG4LYyCAncyhmvVwdE
         XmWZsR88VRzDGVufFgPCjmPkhp5KnSdLhnjkEowmgqW6qGfbyPeNDMBSGaqu14fPiMlj
         GMoMVfBf5tJi4vGBPwYkRiv+RcRZbC0ckF9VU1OJSkpFVNcxI/Xt8zTAWx5OXDq6ypqR
         RIxw==
X-Gm-Message-State: ANhLgQ0HFXLCOBdTxeclOchODSTXQ0kLFntFCv/5FuANKyd864ZDuVbc
        hefrAIVqTygbkIsCbKs4nA==
X-Google-Smtp-Source: ADFU+vtmhUYjMudehiqJmBH9H7jMSe35T5HDRBtsrnXGGftWUwlBk2mhZTwgUl3I5g5TpKH+1HO0bA==
X-Received: by 2002:a92:8410:: with SMTP id l16mr13898715ild.288.1585610782197;
        Mon, 30 Mar 2020 16:26:22 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j84sm5352015ili.65.2020.03.30.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:26:21 -0700 (PDT)
Received: (nullmailer pid 25295 invoked by uid 1000);
        Mon, 30 Mar 2020 23:26:20 -0000
Date:   Mon, 30 Mar 2020 17:26:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: Re: [PATCH v2 4/5] dt-bindings: arm: Add Topwise A721
Message-ID: <20200330232620.GA25242@bogus>
References: <20200320112205.7100-1-dev@pascalroeleven.nl>
 <20200320112205.7100-5-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320112205.7100-5-dev@pascalroeleven.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 12:21:35 +0100, Pascal Roeleven wrote:
> Add the bindings for Topwise A721 tablet
> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
