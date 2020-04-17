Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E806EC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE18522242
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587140034;
	bh=iTUiVhXVQylO6YCPLN3VvXA+gNwx5vPeiOqXWqnRH9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WpAt4eS/Vc/8wJbAqXSVsHeK7ETYoUyH0vCBPiYBGFEb5jNGiX1nAhth+CWQ4r9B/
	 fuoovu15dHd8EOPFdRf3p6q47am+ux7ZnbfU+ZVOHm6rmzbjhnYLwkLVtmWJzY0DVz
	 6+/Fws5gvL1YSvdtynHHNpCvOl87jWfxjeMuE5R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgDQQNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:13:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34845 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgDQQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:13:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so1878879otl.2;
        Fri, 17 Apr 2020 09:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwhnhYWE1h4Q1rWRqLd33U9UJZPeq8MCVvmfrJyJ/ew=;
        b=b57Bw/WwzcmrUnJsoJ4VbZWzH++lvh3Y+Kjsl7qmjEMiJV0kvW9LuDzrZokFXD1aiB
         Q3QbMNBwBPlQFQuIpR2ofxm1J7IMJQqkC0mNBDm9xs/+ulIC4xXtZWn2FHjnTImziEOA
         ZDjk/GsOXt7ZlF3Ys/8muBlqeoVapzBU1hd7MOV1V9YVlvS3VPJ41m2TbRsL94RpYhHt
         cn8RxxxZVohPQUMgzJ5dNshegwe/GElA101bzjbJZMBMyp6LkhQ8PAzNjCrhTwBKXE/i
         PY0QUcLVGXZ1tlQy/o49bGhfP/c+gtSiWk72tivbvnQz/auRQ0/TdrenX6YS7Ud+a+RD
         +jAA==
X-Gm-Message-State: AGi0PubvW/C7LlGRUwcGTBzRtpiNqbsM1wLtssNbVRjPyiBNlEQGI0ZB
        vX47/zMuHfl3cbbB0JW0KZT2XIc=
X-Google-Smtp-Source: APiQypJFgP67EwrcBHqKLa1uVT9VQ1p19y6ic9Hn9dhaR+0qtHXD5ALlxhD4Hvp7i+DmGccxd/Tvqw==
X-Received: by 2002:a9d:3405:: with SMTP id v5mr3313114otb.131.1587140032325;
        Fri, 17 Apr 2020 09:13:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm2147601ots.29.2020.04.17.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:13:51 -0700 (PDT)
Received: (nullmailer pid 24956 invoked by uid 1000);
        Fri, 17 Apr 2020 16:13:50 -0000
Date:   Fri, 17 Apr 2020 11:13:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wu <j.wu@xilinx.com>,
        Wendy Liang <jliang@xilinx.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Message-ID: <20200417161350.GA24618@bogus>
References: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
 <1587074082-14836-5-git-send-email-ben.levinsky@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587074082-14836-5-git-send-email-ben.levinsky@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 14:54:41 -0700, Ben Levinsky wrote:
> Add binding for ZynqMP R5 OpenAMP.
> 
> Represent the RPU domain resources in one device node. Each RPU
> processor is a subnode of the top RPU domain node.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:20.14-21: Warning (ranges_format): /example-0/reserved-memory:ranges: empty "ranges" property but its #address-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:20.14-21: Warning (ranges_format): /example-0/reserved-memory:ranges: empty "ranges" property but its #size-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:43.14-21: Warning (ranges_format): /example-0/zynqmp-rpu:ranges: empty "ranges" property but its #address-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:43.14-21: Warning (ranges_format): /example-0/zynqmp-rpu:ranges: empty "ranges" property but its #size-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:39.20-63.11: Warning (unit_address_vs_reg): /example-0/zynqmp-rpu: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:46.25-62.16: Warning (unit_address_vs_reg): /example-0/zynqmp-rpu/r5@0: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dt.yaml: zynqmp-rpu: '#address-cells', '#size-cells', 'r5@0', 'ranges', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1271919

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
