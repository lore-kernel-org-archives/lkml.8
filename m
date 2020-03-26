Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2F6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78C22073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585241680;
	bh=hKRfq2cDQC9ua7Qwa1meSraG6Wfm9X7jz1qe4JpiiIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VKV4INwRk3Tt12LXdWfeRLMyhrtP7N/MTjF4kgZ0btkmHwx54DdXXucgX5tTuIUMk
	 91T5WL4sEFom8KmPLeDLVM1Aa1Ehu/UrqEZzCdEsQXKLYw7MhGW1Q/JNwGBJgdAaKk
	 YiBvMveLJmBAR6BeetafVByh9KA6fdOMzr9E3OG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgCZQyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:54:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39536 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:54:39 -0400
Received: by mail-io1-f66.google.com with SMTP id c19so6788855ioo.6;
        Thu, 26 Mar 2020 09:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fxdkmv3rlaPbwnsIsqBG6/Y/pJQsCxLU/Fzk50NhJJc=;
        b=TOI57OlxKo6SrQulJsTkwIWmaEa4bkFxF0v7jSlU5wIY1PoZ4qCxfC0VJn/Kv32FxL
         ha2JEfdaFT3/m6RztJlaTg6UVn1FRXOaaIMWLoyUvTAAr+SsSAVQGDCpY6XMq+p6gPku
         BFR3xjTQOZnyQ/UsiNpyChK6i+FYZcwDM4dxZ0uzXLb2xkH6fuW31vCIm5zYNU2r/onz
         /I5vO49l3ODoSppuisg3jYH1MQtO8gTGei7sZ34lOi4mdCA89BA6mG51z36pv9R3wc3g
         Zqrg1YsibiLwLb38M1TkT0KDajYE296iIy0Yu7JFb+glSrp6/NYTNCP9v7wx3ytS49HM
         X9yg==
X-Gm-Message-State: ANhLgQ0DUMRFdkVxL0fqs6YEMHoLwPqCFRoo93ylGndkJtN44162okP7
        w88jMnEjCELa7lz4J1HzvA==
X-Google-Smtp-Source: ADFU+vuO1x11b+eItaisRygLwgmQjoZPmeoCqAv0nxDAmHAK8LsIIIpHg61uNH7cbhjdQGbjuNKgmQ==
X-Received: by 2002:a6b:8d4c:: with SMTP id p73mr8471676iod.14.1585241677102;
        Thu, 26 Mar 2020 09:54:37 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f74sm969012ilh.77.2020.03.26.09.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:54:36 -0700 (PDT)
Received: (nullmailer pid 10911 invoked by uid 1000);
        Thu, 26 Mar 2020 16:54:35 -0000
Date:   Thu, 26 Mar 2020 10:54:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: Add bindings for C66x DSPs
 on TI K3 SoCs
Message-ID: <20200326165435.GA10370@bogus>
References: <20200325201839.15896-1-s-anna@ti.com>
 <20200325201839.15896-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325201839.15896-2-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 15:18:37 -0500, Suman Anna wrote:
> Some Texas Instruments K3 family of SoCs have one of more Digital Signal
> Processor (DSP) subsystems that are comprised of either a TMS320C66x
> CorePac and/or a next-generation TMS320C71x CorePac processor subsystem.
> Add the device tree bindings document for the C66x DSP devices on these
> SoCs. The added example illustrates the DT nodes for the first C66x DSP
> device present on the K3 J721E family of SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 180 ++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts:23.13-20: Warning (ranges_format): /example-0/reserved-memory:ranges: empty "ranges" property but its #address-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts:23.13-20: Warning (ranges_format): /example-0/reserved-memory:ranges: empty "ranges" property but its #size-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts:42.13-43.72: Warning (ranges_format): /example-0/interconnect@100000:ranges: "ranges" property has invalid length (48 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 2)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dt.yaml: interconnect@100000: $nodename:0: 'interconnect@100000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

See https://patchwork.ozlabs.org/patch/1261640

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
