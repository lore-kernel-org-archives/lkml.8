Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEEC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143321D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583908973;
	bh=LI8rbNA8wJc83S2WR1/sE0Ht53AWmB5tHGMzGWEUODg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWIsyQ/uNc0LGaC4dqxHIrr3oBi6RnOym9JYBS2TGddgRYXSi9FLrkxfxcZBjX5sB
	 UoG3fKn+jTKQjE+YoS0YiwWm+U4qFPUS1eAbvTUjAkby9SeAiYjY+zidUbfIAXDlnK
	 L3xkqpeKcC1KDYQCdSgJg2ZMoS8xeJM98poAH3js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgCKGmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCKGmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:42:52 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C1821655;
        Wed, 11 Mar 2020 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583908971;
        bh=LI8rbNA8wJc83S2WR1/sE0Ht53AWmB5tHGMzGWEUODg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M26G4X0UgwEGh4VvB4h8EhSAmXLwIUI3RrvAC1rXFaHYjFSmydS6eC2mH78OUax1D
         NiPWOlTwLO1RKZs61ALXNh6VG6oFv3Xm5RNq3boFdB2WKh7n1h7cBr8fW21JQFkkQ7
         87pnEdS5lWLdqmfV+/o4dTszFH+1ouannbTnzC2Y=
Date:   Wed, 11 Mar 2020 12:12:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
Message-ID: <20200311064243.GI4885@vkoul-mobl>
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-20, 17:37, Srinivas Kandagatla wrote:
> According to SoundWire Specification Version 1.2.
> "A Data Port number X (in the range 0-14) which supports only one
> value of WordLength may implement the WordLength field in the
> DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
> WordLength in response to reads."
> 
> As WSA881x interfaces in PDM mode making the only field "WordLength"
> in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
> register on WSA881x soundwire slave with Qualcomm Soundwire Controller
> is throwing up an error. Not sure how other controllers deal with
> writing to readonly registers, but this patch provides a way to avoid
> writes to DPN_BlockCtrl1 register by providing a ro_blockctrl1_reg
> flag in struct sdw_port_runtime.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> I will send patch for WSA881x to include this change once this patch
> is accepted.
> 
>  drivers/soundwire/bus.h    |  2 ++
>  drivers/soundwire/stream.c | 17 ++++++++++-------
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 204204a26db8..791e8d14093e 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -79,6 +79,7 @@ int sdw_find_col_index(int col);
>   * @num: Port number. For audio streams, valid port number ranges from
>   * [1,14]
>   * @ch_mask: Channel mask
> + * @ro_blockctrl1_reg: Read Only flag for DPN_BlockCtrl1 register
>   * @transport_params: Transport parameters
>   * @port_params: Port parameters
>   * @port_node: List node for Master or Slave port_list
> @@ -89,6 +90,7 @@ int sdw_find_col_index(int col);
>  struct sdw_port_runtime {
>  	int num;
>  	int ch_mask;
> +	bool ro_blockctrl1_reg;

Let us use properties for this so it should be added in struct
sdw_dpn_prop or struct sdw_slave_prop (I dont think that we would have
different properties for each DPn when we are dealing with these simple
codecs)

Also the property should not have mipi tag as this is not in DiSCo spec
(yet), so I would suggest sdw_ro_wordlen for this.

Thanks
-- 
~Vinod
