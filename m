Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB22EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABCE20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgD1Sqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:46:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:41458 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgD1Sq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:46:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E1452D6;
        Tue, 28 Apr 2020 18:46:27 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:46:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-nvdimm@lists.01.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: nvdimm: remove reference to non-existent
 CONFIG_NFIT_TEST
Message-ID: <20200428124626.1e80e23a@lwn.net>
In-Reply-To: <20200415211654.10827-1-msuchanek@suse.de>
References: <20200415211654.10827-1-msuchanek@suse.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 23:16:50 +0200
Michal Suchanek <msuchanek@suse.de> wrote:

> The test driver is in tools/testing/nvdimm and cannot be selected by a
> config option.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/driver-api/nvdimm/nvdimm.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
> index 08f855cbb4e6..79c0fd39f2af 100644
> --- a/Documentation/driver-api/nvdimm/nvdimm.rst
> +++ b/Documentation/driver-api/nvdimm/nvdimm.rst
> @@ -278,8 +278,8 @@ by a region device with a dynamically assigned id (REGION0 - REGION5).
>         be contiguous in DPA-space.
>  
>      This bus is provided by the kernel under the device
> -    /sys/devices/platform/nfit_test.0 when CONFIG_NFIT_TEST is enabled and
> -    the nfit_test.ko module is loaded.  This not only test LIBNVDIMM but the
> +    /sys/devices/platform/nfit_test.0 when the nfit_test.ko module from
> +    tools/testing/nvdimm is loaded.  This not only test LIBNVDIMM but the
>      acpi_nfit.ko driver as well.

Applied, thanks.

jon
