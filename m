Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6595C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D3220838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598650797;
	bh=IR4WDtW2/OkVSyiQsZ6WhEHrxdhOoak04384QwA7UMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n0MCF71c/wb1lOEFSHaa1xUTiPYoEjfg/j2nwf7WjUzIn39awbE/9eak8vFQwgukd
	 kyKfWQ3DHF5NyK2H9a3FcuD+m96iY4MZr/cGxZIimjbZSnYBoxOw8wzEPuCIybpphO
	 7ogx0VZeSwE88lrcsPTSMYIFxlljH2bKzZeOghOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH1Vj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:39:57 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41862 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgH1Vjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:39:55 -0400
Received: by mail-il1-f195.google.com with SMTP id q14so1900416ilj.8;
        Fri, 28 Aug 2020 14:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpynqnZEuUQCDjBKqrBhNXRhw+ex7Y91WlsqiePfppI=;
        b=T4HGutD7jpYukUL0smkRxTPCFXNjs1OjJmi8A1hSL+gajHR64TgTR/2n/nO+La9WYr
         dNYPA0Fjf1a50VJacmwkBBvMDmI4DQ70crnvGsuipxXeMQxZGo6bVzc4K/roxUbLq1DH
         qpcKy6/WHj9p/XdSYaVcO5T78pn9dKxj8IDy/jx06ojBsuSGR+4GQAcp5AobGBg8akmN
         Y2vLzLF561QN4ZhgvBxLS59rn2dGTwOZxmzkcxUZu5TSH+NZPApR/Pax0L8V02HksrU/
         lnPnTJ2Yq2PA6dXCowgCZVjyBYKcdZzNAdowgpYoAJtRKvZ9r1xrwU7MY/tGbjchniNo
         CiHw==
X-Gm-Message-State: AOAM531g7QqA3QoPRpdm+pIvvlsxEdgYcPfrzOWux9Az8EmteQMhIvpg
        ZN5c2YfAthh1P91j5jb/rQ==
X-Google-Smtp-Source: ABdhPJwt99vjGRnRgcDgoAzCfFQCTv14APVj4E34acqvwgMUzURnYI2MZZvsBJbOBW0vsi5rz3fOjQ==
X-Received: by 2002:a92:d089:: with SMTP id h9mr697311ilh.60.1598650794388;
        Fri, 28 Aug 2020 14:39:54 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p3sm280356ilq.59.2020.08.28.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:39:53 -0700 (PDT)
Received: (nullmailer pid 3447391 invoked by uid 1000);
        Fri, 28 Aug 2020 21:39:51 -0000
Date:   Fri, 28 Aug 2020 15:39:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     mathieu.poirier@linaro.org, jliang@xilinx.com, michals@xilinx.com,
        emooring@xilinx.com, stefano.stabellini@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michael.auchter@ni.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v10 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Message-ID: <20200828213951.GA3446772@bogus>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
 <20200827015810.11157-5-ben.levinsky@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827015810.11157-5-ben.levinsky@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 18:58:09 -0700, Ben Levinsky wrote:
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
> v3:
> - update zynqmp_r5 yaml parsing to not raise warnings for extra
>   information in children of R5 node. The warning "node has a unit
>   name, but no reg or ranges property" will still be raised though
>   as this particular node is needed to describe the
>   '#address-cells' and '#size-cells' information.
> v4::
> - remove warning '/example-0/rpu@ff9a0000/r5@0:
>   node has a unit name, but no reg or ranges property'
>   by adding reg to r5 node.
> v5:
> - update device tree sample and yaml parsing to not raise any warnings
> - description for memory-region in yaml parsing
> - compatible string in yaml parsing for TCM
> v6:
> - remove coupling TCM nodes with remoteproc
> - remove mailbox as it is optional not needed
> v7:
> - change lockstep-mode to xlnx,cluster-mode
> v9:
> - show example IPC nodes and tcm bank nodes
> ---
>  .../xilinx,zynqmp-r5-remoteproc.yaml          | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dts:48.18-53.11: Warning (unique_unit_address): /example-0/tcm_0a@0: duplicate unit-address (also used in node /example-0/tcm_1a@0)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dt.yaml: example-0: tcm_0a@0:reg:0: [0, 4292870144, 0, 65536] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dt.yaml: example-0: tcm_1a@0:reg:0: [0, 4293001216, 0, 65536] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dt.yaml: example-0: rpu0vdev0vring0@3ed40000:reg:0: [0, 1054081024, 0, 16384] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dt.yaml: example-0: rpu0vdev0vring1@3ed44000:reg:0: [0, 1054097408, 0, 16384] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.example.dt.yaml: example-0: rpu0vdev0buffer@3ed48000:reg:0: [0, 1054113792, 0, 1048576] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1352197

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

