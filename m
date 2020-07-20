Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE86C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1962176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272689;
	bh=wT6ZbRqs1FwBWdTqqZNSPBlcmRYq9taL3gCf95gXAB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U6enX/nTvwwc8VnTFrtQTEfCll2xNEBv6iXktUcV6PqHmhB5mkMBtpX1txAziFEAh
	 4XslxUPddnkJrMkqesPqIpTQGBsZUo2vY2ScKV316XWQx00eWTX00nXd9sFh/dEtqE
	 uTaElXns72kU3KpOYAg7tS5tCzxGImAFEsSX4Lwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgGTTSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:18:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45842 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgGTTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:18:07 -0400
Received: by mail-io1-f65.google.com with SMTP id e64so18796720iof.12;
        Mon, 20 Jul 2020 12:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uv9DwJeqFVU3ixKGtQQTS9+FOIa16rZ9Ojp6k1PsA9k=;
        b=Uv9wkHXLT9izjlBoI1LYkZRU7zGNpt/BeIJLXTS41+I3pRckyhv5sBHFh/KkMjm9oR
         Ppkkv3Kw8qMHsIShCUTDG9Ar8od7WovwZXwB0BMtNh78Pnt/c4e6aRrXF4HvBrgIvyFj
         tb3VwMfrIZ6/XUNLBJJdRZyAFnL8uA0OaD0pD+BhayWNhOlye2Wkd299kVeaoBpYv/a3
         yyeYjXU7JhJdFlBe1zvU8zEFgf+UNkyt9tWQ78CXqMGZ2LdFiYZQU6rJihQo546aUrUg
         mLIv3/4ysYVPFwj/4P84szuhqvhhikX85glhyqDYG1FNkMYXxun8boGv8CbdCNZTfBJG
         /Zzw==
X-Gm-Message-State: AOAM533b38ao5Z0IrMEtAgps1MzpKKMpsOsqFtxkX9gGP04/6Ken433S
        QKumx/6iFQ66u8FQPxF8JR80TRYiJw==
X-Google-Smtp-Source: ABdhPJzZ1vqvkCvQlbnANMQkRpMdXUHvSUgwd4hRCkvF0VWDDV/3eh547Y6ph5RTvSFlzRUciVYNdA==
X-Received: by 2002:a6b:5813:: with SMTP id m19mr24164940iob.29.1595272686659;
        Mon, 20 Jul 2020 12:18:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x5sm201740iol.36.2020.07.20.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:18:05 -0700 (PDT)
Received: (nullmailer pid 2847072 invoked by uid 1000);
        Mon, 20 Jul 2020 19:18:04 -0000
Date:   Mon, 20 Jul 2020 13:18:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, sricharan@codeaurora.org,
        sivaprak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org
Subject: Re: [PATCH V3 3/4] dt-bindings: soc: qcom: convert the SMD-RPM
 document to YAML schema
Message-ID: <20200720191804.GA2846983@bogus>
References: <1595225543-12127-1-git-send-email-kathirav@codeaurora.org>
 <1595225543-12127-4-git-send-email-kathirav@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595225543-12127-4-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 11:42:22 +0530, Kathiravan T wrote:
> Convert the qcom,smd-rpm.txt document to YAML schema
> 
> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  | 65 ----------------
>  .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 87 ++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
