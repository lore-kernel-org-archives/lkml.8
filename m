Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44204C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BBF20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591732066;
	bh=swx8CTN3DJ4ZZQSgX6dcOTDFM3Jm3EuVRp9rPhEEij4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2OpP0/LNmCqCIqzhvp4KByn4OeNVsOAi1hTSv5mNnNDOZZvJxn1tnt+KZGoFatKAr
	 eldFe49NOL37rp5NUPvECWAdkEMXBA7L75ejkhWOEv9WLdXe7R9GXe2Xqlzctvh6/u
	 N3dp+co5iKwZ89Gl64wu5wsbz69MMauQkf0Zww00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgFITro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:47:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35205 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbgFITrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:47:43 -0400
Received: by mail-io1-f65.google.com with SMTP id s18so24220694ioe.2;
        Tue, 09 Jun 2020 12:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lS1E408Dk/Xy9+pHD1Ti6+7VGJTeXmpjwg7M+PQg3v0=;
        b=ps5nSpavK6rhPSvszFC8RX3d+XYA2MOrl7/j7snEApPdjjO90ag6vHKaSpOCssRoD4
         +oir/iVR0oFkf5n7PvYci4S+/MWMPqu+1XPiFpW54TFRNDKls5w+BqyUBtLB3n22O7yD
         CLlcQLGbxrwYlEqsUiMWfTq7bRb5m6BYzHCAGr/QzCyC0yvhfChDezPUn3xs6C6KRP7N
         IDzUt+rreMxL0MIGXNePYrAwXoipOWK5fMKZ1xR0YwcKbFtmlSSXwusZrQk4MqFkqw5S
         g4EeQGOoobcNRlGv72R4BlXfsEaKn7++lsv9ioLJzjQ3eA9owisgIX2yDmb4qGejRoQ6
         1W/A==
X-Gm-Message-State: AOAM531hNEIxwxg6/fLaZsWvgcko+FmXrKKF2AzBL7fFEmVpkVhKAxjO
        wmy3f7nMY4hojfFFEHhatA==
X-Google-Smtp-Source: ABdhPJx5hbAEw4r0r+sjQ47hBkzEJcnzBbVTwecgD6i/tDZyA16NjNXr6hdWuiv7E5NtjGzwY0IyrA==
X-Received: by 2002:a05:6638:14c5:: with SMTP id l5mr8840224jak.134.1591732062974;
        Tue, 09 Jun 2020 12:47:42 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y19sm7714469iod.41.2020.06.09.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:47:42 -0700 (PDT)
Received: (nullmailer pid 1336337 invoked by uid 1000);
        Tue, 09 Jun 2020 19:47:39 -0000
Date:   Tue, 9 Jun 2020 13:47:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     sboyd@kernel.org, devicetree@vger.kernel.org, agross@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH V7 3/4] clk: qcom: Add DT bindings for ipq6018 apss clock
 controller
Message-ID: <20200609194739.GB1335193@bogus>
References: <1591440907-20021-1-git-send-email-sivaprak@codeaurora.org>
 <1591440907-20021-4-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591440907-20021-4-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jun 2020 16:25:06 +0530, Sivaprakash Murugesan wrote:
> Add dt-binding for ipq6018 apss clock controller
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  include/dt-bindings/clock/qcom,apss-ipq.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

