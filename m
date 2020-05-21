Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66431C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442F920826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QW/2/Cyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgEUP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:58:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38174 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgEUP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:58:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LFvp5x127948;
        Thu, 21 May 2020 10:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590076671;
        bh=TPMHFbS+iORHTIuCD7Fo5FkOZZ8OumFZy0+SDb9dspA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QW/2/CybTE8Jjh8qBZxRMOCIbCzWYP40rJxi/exOWqqcReAPK0urITescZqq/GBch
         c65r4o0O3Jf4kHwdyLR3Cv026+5/UmPxoe0xDjJKs+h0Y4uJzXU76+8AT3ABPXXz6U
         +tflutwSbx14lwT8ar4X6FZAuAbOP3vc3lAmrCDY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LFvp2R090125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 10:57:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 10:57:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 10:57:50 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LFvoli090798;
        Thu, 21 May 2020 10:57:50 -0500
Subject: Re: [PATCH 0/4] Update K3 DSP remoteproc driver for C71x DSPs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200325204701.16862-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4691995a-b305-68a2-6637-7a3d9db3f194@ti.com>
Date:   Thu, 21 May 2020 10:57:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200325204701.16862-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 3:46 PM, Suman Anna wrote:
> Hi All,
> 
> This series adds support for a new next generation 64-bit TI DSP based on
> the TMS320C71x CorePac processor subsystem called the C71x. The support is
> enabled through couple of enhancements to the remoteproc core (primarily to
> support a 64-bit trace resource entry), and does depend on the K3 DSP
> remoteproc driver posted earlier today [1].
> 
> The loading support leveraged the 64-bit ELF loader support code added by
> Clement and already staged on the rproc-next branch. I am posting this
> series separate from the C66x series because of the new 64-bit resource
> type enhancement needs (patches 2 and 3). I have leveraged the existing
> resource types as is by introducing a new version element, and am open to
> ideas if it is desired to just define it as a separate resource type.
> 
> The C71x DSP boots using firmware segments loaded into the DDR with a 2 MB
> aligned address requirement on the boot vectors. There is no support for
> internal memory loading, and all internal memories shall be used as fast
> RAMs/scatchpads by the firmware executing on the DSPs. IPC is through the
> virtio-rpmsg transport. There is no support for Error Recovery, Power
> Management or loading into on-chip SRAMs at present.
> 
> Following is the patch summary:
>   - Patch 1 updates the K3 DSP bindings for C71x cores
>   - Patch 2 introduces a concept of version element into existing resource types
>   - Patch 3 adds support for a new 64-bit trace resource entry
>   - Patch 4 enhances the K3 DSP remoteproc driver for C71x

I have separated out the C71 platform driver pieces (patches 1 & 4) and 
posted a v2 for those.

Appreciate any feedback on the core patches (patches 2 & 3) that add the 
minimal 64-bit trace support, as this also sets the direction for 
resource extensions. I can post the next version for those based on 
feedback.

regards
Suman

> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/cover/11458573/
> 
> Suman Anna (4):
>    dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
>    remoteproc: introduce version element into resource type field
>    remoteproc: add support for a new 64-bit trace version
>    remoteproc/k3-dsp: Add support for C71x DSPs
> 
>   .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 78 ++++++++++++++++---
>   drivers/remoteproc/remoteproc_core.c          | 65 +++++++++++-----
>   drivers/remoteproc/remoteproc_debugfs.c       | 50 ++++++++----
>   drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 17 ++++
>   include/linux/remoteproc.h                    | 34 +++++++-
>   5 files changed, 203 insertions(+), 41 deletions(-)
> 

