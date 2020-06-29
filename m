Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E70DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAF12078C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467781;
	bh=wfjFiECLgmI6YdnDVX7rASM5LSDbnrbzKR9wXxeg6Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kewey5m3u7i37uBNpPoDg/cftNp3yA4vFsUoNmb1cFOOucdoCmaCfR/e9YWZvX/y7
	 Vdvpcu1UziGikPLYyZi530vgw4WFc6/63Fpn6HJtPj0SIL82nkjDm8APth5N2OVmam
	 7HnPAzJ6JzSCu4tt2p9Xah7PiHXEbNnIZ70ACxdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404671AbgF2V4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:56:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38693 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgF2V4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:56:09 -0400
Received: by mail-io1-f65.google.com with SMTP id f6so3249860ioj.5;
        Mon, 29 Jun 2020 14:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BzdbzHdhO67Ygeg4vmtsn4XIT8EQ37NcHABkSdRi3E=;
        b=I0At8bxZQkXym3kz+XxCrI1Zet38RIVqzWLaUWe4KNL20owkV8kedIk5u57bsFVxsf
         2QZMGvbCYj7o3gYemLkx0YFr+fzMUF+BP0ht/BPr3q1S/89gUpUPzjpbShvHKl6gOOqd
         QjPZ6El3Hu8wGPcidxbi69aPCC4p9mq5zrDQgo4lOkH6jQNVleiJx1Nge2/hGxQMhIsn
         GTuXbtJHJX+IJVgI8nP/v/GnkklMWLqA5CtM8RKEO+K8MxbCL5eK7nP0wmdBbUmrgAcG
         8zyD0NJyxXANuvQ6ByOo/mvCavuF75N9xBCIHQo4QgHT2+rsS2+I414OjS5XS/JXl7iE
         ma9Q==
X-Gm-Message-State: AOAM53163AWRJY0k7ytHI0M126BFg2CAz9IA5sCSWB/Mr1mNZTSOnU8W
        Y5TG0P1srLKSELs4ITvOOA==
X-Google-Smtp-Source: ABdhPJwEvFQMnYXTu1dUlTrx8NG/GBWsngrOu89NxHz6Tg+mFbZeo4sGg728NSX2H2aFS2/qL1GcVQ==
X-Received: by 2002:a02:cf12:: with SMTP id q18mr13182774jar.3.1593467768763;
        Mon, 29 Jun 2020 14:56:08 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id y5sm590604iov.3.2020.06.29.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:56:08 -0700 (PDT)
Received: (nullmailer pid 3001028 invoked by uid 1000);
        Mon, 29 Jun 2020 21:56:06 -0000
Date:   Mon, 29 Jun 2020 15:56:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: devapc: add bindings for
 devapc-mt6873
Message-ID: <20200629215606.GA3000557@bogus>
References: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com>
 <1592559720-8482-2-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592559720-8482-2-git-send-email-neal.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 17:41:59 +0800, Neal Liu wrote:
> Add bindings for MT6873 devapc.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  .../soc/mediatek/devapc/devapc-mt6873.yaml         |   61 ++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dt.yaml: example-0: devapc@10207000:reg:0: [0, 270561280, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dt.yaml: example-0: devapc@10207000:reg:1: [0, 271007744, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dt.yaml: example-0: devapc@10207000:reg:2: [0, 271011840, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dt.yaml: example-0: devapc@10207000:reg:3: [0, 285343744, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dt.yaml: example-0: devapc@10207000:reg:4: [0, 270589952, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1312741

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

