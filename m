Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4577CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9F206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbgEYIxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:53:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:27485 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbgEYIxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:53:30 -0400
IronPort-SDR: 9H/EEEIB7r66WFvgSb6BIhSVwHD9gPzCyyt8p8IPP2EPXs9DiOalqPl/gjXVCkoUyxUN90Hw50
 VGaIWTT4sbkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 01:53:29 -0700
IronPort-SDR: H6GDIJ/+h3TzNPVedg9R4p7HzyxCD8RgNE/GNxsoXDVPAF6w1s9Ehtp28ZBZX03lp/OCrJe2oD
 CERbKle6FqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="375378093"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 May 2020 01:53:26 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 May 2020 11:53:25 +0300
Date:   Mon, 25 May 2020 11:53:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 1/1] thunderbolt: add trivial .shutdown
Message-ID: <20200525085325.GM247495@lahna.fi.intel.com>
References: <20200520185221.122283-1-mlevitsk@redhat.com>
 <20200520185221.122283-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520185221.122283-2-mlevitsk@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:52:21PM +0300, Maxim Levitsky wrote:
> On my machine, a kexec with this driver loaded in the old kernel
> causes a very long delay on boot in the kexec'ed kernel,
> most likely due to unclean shutdown prior to that.
> 
> Unloading thunderbolt driver prior to kexec allows kexec to work as fast
> as regular kernel boot, as well as adding this .shutdown pointer.
> 
> Shutting a device prior to the shutdown completely is always
> a good idea IMHO to help with kexec,
> and this one-liner patch implements it.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  drivers/thunderbolt/nhi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 1be491ecbb45..4046642e6aec 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1285,6 +1285,7 @@ static struct pci_driver nhi_driver = {
>  	.id_table = nhi_ids,
>  	.probe = nhi_probe,
>  	.remove = nhi_remove,
> +	.shutdown = nhi_remove,

I guess nhi_remove() does a bit more work than strictly required for
.shutdown but we can deal with that later if needed.

Applied to thunderbolt.git/next, thanks!
