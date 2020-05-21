Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC387C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC742084C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gEzEaxet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgEUS7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:59:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46702 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgEUS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:59:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LIxkUn037038;
        Thu, 21 May 2020 13:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590087586;
        bh=qHgIZ1jeMMAGpyygK6081zktw2WUM4w1JQMRrYptymU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gEzEaxetknGbpkdpFF815hUys3+9q7H1azD62EpI9qENEpnRLoqRtK2zWzyFbhCKJ
         vg+Lr0PuyWwOIBa1T1675VNVARmOSbmUdHwNKw1pj4OnMawWZmEZh7YtgCa+60aARM
         +etEaADW7eeGo0aApndqgZfXMERzng4XGCBD5ylQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LIxkYH082066;
        Thu, 21 May 2020 13:59:46 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 13:59:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 13:59:46 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LIxjLX055152;
        Thu, 21 May 2020 13:59:45 -0500
Subject: Re: [PATCH v2 0/4] TI K3 DSP remoteproc driver for C66x DSPs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200521001006.2725-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <5f84465e-8f63-51b4-4758-59c85d3ad597@ti.com>
Date:   Thu, 21 May 2020 13:59:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521001006.2725-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/20/20 7:10 PM, Suman Anna wrote:
> Hi All,
> 
> The following is v2 of the K3 DSP remoteproc driver supporting the C66x DSPs
> on the TI K3 J721E SoCs. The patches are based on the latest commit on the
> rproc-next branch, 7dcef3988eed ("remoteproc: Fix an error code in
> devm_rproc_alloc()").

I realized I also had the R5F patches on my branch, so the third patch 
won't apply cleanly (conflict on Makefile). Let me know if you want a 
new revision posted for you to pick up the series.

regards
Suman

> 
> v2 includes a new remoteproc core patch (patch 1) that adds an OF helper
> for parsing the firmware-name property. This is refactored out to avoid
> replicating the code in various remoteproc drivers. Please see the
> individual patches for detailed changes.
> 
> The main dependent patches from the previous series are now staged in
> rproc-next branch. The only dependency for this series is the common
> ti-sci-proc helper between R5 and DSP drivers [1]. Please see the initial
> cover-letter [2] for v1 details.
> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/patch/11456379/
> [2] https://patchwork.kernel.org/cover/11458573/
> 
> Suman Anna (4):
>    remoteproc: Introduce rproc_of_parse_firmware() helper
>    dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
>    remoteproc/k3-dsp: Add a remoteproc driver of K3 C66x DSPs
>    remoteproc/k3-dsp: Add support for L2RAM loading on C66x DSPs
> 
>   .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 190 +++++
>   drivers/remoteproc/Kconfig                    |  13 +
>   drivers/remoteproc/Makefile                   |   1 +
>   drivers/remoteproc/remoteproc_core.c          |  23 +
>   drivers/remoteproc/remoteproc_internal.h      |   2 +
>   drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 773 ++++++++++++++++++
>   6 files changed, 1002 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>   create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
> 

