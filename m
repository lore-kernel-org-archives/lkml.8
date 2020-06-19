Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A46F206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgFSTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:42:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:55412 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389884AbgFSTmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:42:42 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8289723B;
        Fri, 19 Jun 2020 19:42:41 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:42:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, tee-dev@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] Documentation: tee: Document TEE kernel interface
Message-ID: <20200619134240.6c5b93d4@lwn.net>
In-Reply-To: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
References: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jun 2020 12:29:39 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> Update documentation with TEE bus infrastructure which provides an
> interface for kernel client drivers to communicate with corresponding
> Trusted Application.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Changes in v2:
> - Add TEE client driver example snippet.
> 
>  Documentation/tee.txt | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Applied, thanks.

jon
