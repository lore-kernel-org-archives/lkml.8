Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D980C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5625C2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584997116;
	bh=WEty275NiM/1KfMSnMNscbkiPR/OeyPlcO+7MSZkCZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e1WvcUEyJtcd66dmsjOreucfmpOKgafXsJMUX8Dhsw0eQNMY1YdgApMh/ve0U4Yte
	 1g6tbdS5oEyzwN7EfKCtGbatEOkgky2cx5iMdF5kG7aqtuJy9y4gx4T2IcJ8sp6DJy
	 oa8g12SHyaDERvf/QDKl6T7bKGjcScH9QrIE+MWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCWU6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:58:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33649 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:58:35 -0400
Received: by mail-il1-f193.google.com with SMTP id k29so14781119ilg.0;
        Mon, 23 Mar 2020 13:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lbhv3lj+rimKH3KJeo/HpUf5yBnSuLCfl2my49tmkCI=;
        b=hJN9mD0EYp8z71GxTLOQbE/s1inHKgWCN/9GDs0l0LZOHjSoqqSEjLH82Fo5f7qscK
         UpGPUVeRSNJCrthnRR+Vzbws8rkVm/EVDvnJCJwTTMOTH8rp2OO2hLh3wk2r00zTfr/p
         ABzOZzfVF633gUwEBEEKvEBy8p0sbNQTBwM1U/+d0GtdNB0Q0RE+T3WjDuHB0oPoBHxN
         NRvWxCBak0XVX32c5D61pDFBxm9LpA74aKbF3j3HmvF+Z6HNUCcQC37e7EezKDJ5LI47
         Ywyn+NaPzo5xq0XeuDwuUvRuzewioFz+hGh+OGXlOiFi5dTlZsA3Oa6Hxfl7rP3O1egg
         GoYg==
X-Gm-Message-State: ANhLgQ1ucIDzs6Jgb1E5RpmafAolFvwYM4KemDgsoR/7JPCspeTfJjYI
        ZhSLGoNU/zFIhFxR1U7tQt+kU1o=
X-Google-Smtp-Source: ADFU+vuRUUYdadhvHY9ViEidRsAs30NRrWSO714XJxN5eBgykViACKkgfHHkRv3Ah6OFLfyM42mFog==
X-Received: by 2002:a92:8352:: with SMTP id f79mr22414780ild.58.1584997114294;
        Mon, 23 Mar 2020 13:58:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p14sm4623398ios.38.2020.03.23.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:58:33 -0700 (PDT)
Received: (nullmailer pid 10023 invoked by uid 1000);
        Mon, 23 Mar 2020 20:58:31 -0000
Date:   Mon, 23 Mar 2020 14:58:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 2/4] dt-bindings: Add vendor prefix for ENE
Message-ID: <20200323205831.GA9969@bogus>
References: <20200309203818.31266-1-lkundrak@v3.sk>
 <20200309203818.31266-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309203818.31266-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Mar 2020 21:38:16 +0100, Lubomir Rintel wrote:
> 
> ENE Technology makes embedded controllers and perhaps other stuff. Their
> web site is http://www.ene.com.tw/.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
