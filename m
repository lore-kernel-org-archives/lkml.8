Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DD4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE312465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgA1Qbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:31:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:15211 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgA1Qbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:31:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 08:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="232004557"
Received: from cauduong-mobl1.amr.corp.intel.com (HELO [10.254.184.245]) ([10.254.184.245])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2020 08:31:50 -0800
Subject: Re: [PATCH 0/4] Add a better separation between i.MX8 families
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20200128080518.29970-1-daniel.baluta@oss.nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7246ae53-a542-2726-78e5-db43318dd44b@linux.intel.com>
Date:   Tue, 28 Jan 2020 10:08:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128080518.29970-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/20 2:06 AM, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> So far the implementation was designed to support  a generic platform
> named i.MX8. Anyhow, now working with specific i.MX8 instances we need
> to account for the differences.
> 
> i.MX8 naming can be confusing at the first glance, so we need to have
> a clean separation between different platforms.
> 
> Here is the split of i.MX8 per platforms. Notice that i.MX8 names
> the entire family, but also a sub-family.
> 
> imx8
> ├── imx8
> │   └── imx8qm (*)
> ├── imx8m
> │   ├── imx8mm
> │   ├── imx8mn
> │   ├── imx8mp (*)
> │   └── imx8mq
> └── imx8x
>      └── imx8qxp (*)
> 
> Platforms marked with (*) contain a DSP. In the future there might be
> more platforms.
> 
> This patchseries does the following:
> 	* renames imx8 to imx8x (because the only supported platform now
>          is imx8qxp).
>          * adds support for imx8 (which is imx8qm)
> 
> A future patchset will add supprot for i.MX8MP.
> 
> Paul Olaru (4):
>    ASoC: SOF: Rename i.MX8 platform to i.MX8X
>    ASoC: SOF: imx8: Add ops for i.MX8QM
>    ASoC: SOF: Add i.MX8QM device descriptor
>    dt-bindings: dsp: fsl: Add fsl,imx8qm-dsp entry

This patchset was reviewed on the SOF GitHub. I asked Daniel to send it 
directly to the relevant mailing list for ARM/Device Tree.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
>   .../devicetree/bindings/dsp/fsl,dsp.yaml      |  1 +
>   sound/soc/sof/imx/imx8.c                      | 57 ++++++++++++++++++-
>   sound/soc/sof/sof-of-dev.c                    | 10 ++++
>   3 files changed, 65 insertions(+), 3 deletions(-)
> 
