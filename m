Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638EC20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgD1QKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:10:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:50645 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbgD1QKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:10:14 -0400
IronPort-SDR: hLlFpXLBOEjbmGCOv+tD32UeEqlQSaFnQ15YWyDMdxBGZeJAvziVNBUOz4fzlV0OFpvqI6nuv8
 qR1HnhkJkSWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 09:10:13 -0700
IronPort-SDR: PJnYM/U8UQgUK62EVq9UqV5NB7rQRuJewhYI2+iUE076l8LYuv0z+Ghz2odcmBuCfNG0/nKIZ3
 XWZUmG4xMh1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="432233871"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2020 09:10:11 -0700
Date:   Tue, 28 Apr 2020 19:10:10 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     ChenTao <chentao107@huawei.com>
cc:     Jaroslav Kysela <perex@perex.cz>, shawnguo@kernel.org,
        tiwai@suse.com, s.hauer@pengutronix.de, lgirdwood@gmail.co,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com
Subject: Re: [PATCH] soc: imx8m: Make imx8m_dsp_ops static
In-Reply-To: <20200425080026.143127-1-chentao107@huawei.com>
Message-ID: <alpine.DEB.2.21.2004271259130.2957@eliteleevi.tm.intel.com>
References: <20200425080026.143127-1-chentao107@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[+Daniel]

On Sat, 25 Apr 2020, ChenTao wrote:

> Fix the following warning:
> 
> sound/soc/sof/imx/imx8m.c:95:20: warning:
> symbol 'imx8m_dsp_ops' was not declared. Should it be static?

yes, this was missed in the initial version of this driver. Ok to go with 
this:

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

You did not send a copy of the patch to Mark Brown (broonie@kernel.org). 
Can you resend with him in the loop, so he can pick the patch up to ALSA 
ASoC tree. Also please copy the ALSA list (alsa-devel@alsa-project.org).

Br, Kai
