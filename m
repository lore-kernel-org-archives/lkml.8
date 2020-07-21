Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B459BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9245120714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eAe5vqIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgGUOnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:43:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58382 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgGUOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:43:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LEh87R109282;
        Tue, 21 Jul 2020 09:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595342588;
        bh=HNYHkecczzNXwFIOZjMIwvKU3JfW0AcUMrA1nFBYX+A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eAe5vqIkXb6e4u1Ca5a/7quPEW4G3mkU1FcVbyPVAPgHqQx2wS8QeY572+s9BeHaX
         98hcylnHxqRoLoFIj9kt2Y/DhAikFQXmR4t2Xd6aAByVe4XYJSmDWj1FaWGuosum3f
         soTwMR2LgqgSU3NDtJrWzGszDSDvNdlY8EHw2z98=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06LEh8Z8068511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 09:43:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 09:43:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 09:43:08 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LEh72A102848;
        Tue, 21 Jul 2020 09:43:07 -0500
Subject: Re: [PATCH v4 0/6] TI K3 DSP remoteproc driver for C66x DSPs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200717234800.9423-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <71b1c6c0-08eb-32fc-4183-6f350030e22d@ti.com>
Date:   Tue, 21 Jul 2020 09:43:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717234800.9423-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 7/17/20 6:47 PM, Suman Anna wrote:
> Hi All,
> 
> The following is v4 of the K3 DSP remoteproc driver supporting the C66x DSPs
> on the TI K3 J721E SoCs. The patches apply cleanly both on v5.8-rc1 as well
> as laster commit on the master branch.
> 
> This series is largely unchanged, addressing various minor comments from
> Mathieu and Rob. The ti,k3-sci-proc bindings patch (patch #3) is the only
> patch without an Ack from v3.
> 
> Following are the changes in v4:
>   - Fixed Rob's review comments on ti,k3-sci-proc.yaml
>   - Moved the ti_sci_protocol.h header file from ti_k3_dsp_remoteproc.c
>     to ti_sci_proc.h
>   - Replaced the TI http link with https following similar changes
>     submitted recently
>   - Removed an unnecesary addr check before iounmap
> 
> Please see the individual patches for further delta differences.
> 
> v3: https://patchwork.kernel.org/cover/11602331/
> v2: https://patchwork.kernel.org/cover/11561787/
> v1: https://patchwork.kernel.org/cover/11458573/
> 
> C71x v3: https://patchwork.kernel.org/cover/11602345/
> 
> Hi Bjorn,
> This series is ready to be picked up for 5.9 merge window. Please also
> pick the C71x v3 series on top of this, there are no pending comments
> on that one and is waiting for this series.

Can you pick up both the K3 DSP series for 5.9, the last pending 
dt-bindings patch from this series has also been acked now.

Thanks,
Suman

> 
> regards
> Suman
> 
> Suman Anna (6):
>    remoteproc: Introduce rproc_of_parse_firmware() helper
>    remoteproc: k3: Add TI-SCI processor control helper functions
>    dt-bindings: remoteproc: Add common TI SCI rproc bindings
>    dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
>    remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs
>    remoteproc: k3-dsp: Add support for L2RAM loading on C66x DSPs
> 
>   .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 139 ++++
>   .../bindings/remoteproc/ti,k3-sci-proc.yaml   |  48 ++
>   drivers/remoteproc/Kconfig                    |  13 +
>   drivers/remoteproc/Makefile                   |   1 +
>   drivers/remoteproc/remoteproc_core.c          |  23 +
>   drivers/remoteproc/remoteproc_internal.h      |   2 +
>   drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 771 ++++++++++++++++++
>   drivers/remoteproc/ti_sci_proc.h              | 104 +++
>   8 files changed, 1101 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
>   create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
>   create mode 100644 drivers/remoteproc/ti_sci_proc.h
> 

