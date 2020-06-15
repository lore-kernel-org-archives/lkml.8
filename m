Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3825C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E7920756
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgFOUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:19:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:10976 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgFOUTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:19:10 -0400
IronPort-SDR: 4N7+LtCOmQJ/RiVCIPzrrnibSEWqf7TwRFySmZUZ9sVZ7Rjdy7WIdbpiNboKwEvc+17nTxrnHz
 kUHSzhQVd48g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 13:19:10 -0700
IronPort-SDR: uCCUPIgZIAavDLPinY2dEmxfFrSHex7CrwMoc/JL/M9Hz5Hkx4Bk0X0/I2NIfmH7OiLkVNjacm
 sxh4KYvUm3jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="298643635"
Received: from ifaivilx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.251])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2020 13:19:06 -0700
Date:   Mon, 15 Jun 2020 23:19:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, maxim.uvarov@linaro.org,
        tee-dev@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] Documentation: tee: Document TEE kernel interface
Message-ID: <20200615201907.GE5416@linux.intel.com>
References: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 12:29:39PM +0530, Sumit Garg wrote:
> Update documentation with TEE bus infrastructure which provides an
> interface for kernel client drivers to communicate with corresponding
> Trusted Application.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Please at least broadly describe the update in the commit message.

/Jarkko
