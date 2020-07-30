Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387B62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596149172;
	bh=MdiKqZtkKcfBkgB2ny4nl/l0vVvGSKyEuahiF0CPnl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zTWl+oBNot5vz9bbMcIJJUHbcfE9UtO9ZGPCTcfYM7D5aLGaF/IqQCfU+hewa2oyA
	 Ggva+Y6iOEU//xp1UMVg+4BT9g1RecoNsF5UMlaMHRDpb3kqqKXEjM3w1Zo0snw4gZ
	 jF7De/8/tZyJ/hPRvJqpmLhHoPjvkEu3Bmc/dGFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgG3WqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgG3WqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:46:10 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A0520838;
        Thu, 30 Jul 2020 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596149169;
        bh=MdiKqZtkKcfBkgB2ny4nl/l0vVvGSKyEuahiF0CPnl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZetdtpCN4pomhfZdJIstWjRbatO5WXmy94YhE3NzZPm6NjKW6CxwHrhz4mV+K4AY
         JVUIsEmzhXqmaNr+dRS0SuzeiD+mb0WFPKVDSkQuBvm7IANbq391PKnanuYe40WuA+
         voa3zL/KU7q/0C3rryCg6i5drnJT214pk1czmVtY=
Date:   Thu, 30 Jul 2020 17:52:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ramalingam C <ramalingam.c@intel.com>, stable@vger.kernel.org
Subject: Re: [char-misc-next V4] mei: hdcp: fix mei_hdcp_verify_mprime()
 input parameter
Message-ID: <20200730225210.GA1726@embeddedor>
References: <20200730220139.3642424-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730220139.3642424-1-tomas.winkler@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:01:39AM +0300, Tomas Winkler wrote:
> wired_cmd_repeater_auth_stream_req_in has a variable
> length array at the end. we use struct_size() overflow
> macro to determine the size for the allocation and sending
> size.
> This also fixes bug in case number of streams is > 0 in the original
> submission. This bug was not triggered as the number of streams is
> always one.
> 
> Fixes: c56967d674e3 (mei: hdcp: Replace one-element array with flexible-array member)
> Fixes: commit 0a1af1b5c18d ("misc/mei/hdcp: Verify M_prime")
          ^^^^
I think the _commit_ word above is unnecessary.

> Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Cc: Ramalingam C <ramalingam.c@intel.com>
> Cc: <stable@vger.kernel.org> v5.1+

Greg,

Notice that this patch is fine as is for -next, only. This becomes suitable
for -stable as long as commit c56967d674e3 (mei: hdcp: Replace one-element array with flexible-array member)
is applied to -stable, too. Otherwise, a separate patch that leaves the
one-element array in struct wired_cmd_repeater_auth_stream_req_in in place
needs to be crafted. With this taken into account, here is my

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the changes, Tomas.
--
Gustavo

> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V4:
> 1. Fix typo in the subject. (Gustavo)
> 2. Fix dereferencing pointer in send. (Gustavo)
> V3:
> 1. Fix commit message with more info and another patch it fixes (Gustavo)
> 2. Target stable. (Gustavo)
> V2: Check for allocation failure.
> 
>  drivers/misc/mei/hdcp/mei_hdcp.c | 40 +++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
> index d1d3e025ca0e..9ae9669e46ea 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -546,38 +546,46 @@ static int mei_hdcp_verify_mprime(struct device *dev,
>  				  struct hdcp_port_data *data,
>  				  struct hdcp2_rep_stream_ready *stream_ready)
>  {
> -	struct wired_cmd_repeater_auth_stream_req_in
> -					verify_mprime_in = { { 0 } };
> +	struct wired_cmd_repeater_auth_stream_req_in *verify_mprime_in;
>  	struct wired_cmd_repeater_auth_stream_req_out
>  					verify_mprime_out = { { 0 } };
>  	struct mei_cl_device *cldev;
>  	ssize_t byte;
> +	size_t cmd_size;
>  
>  	if (!dev || !stream_ready || !data)
>  		return -EINVAL;
>  
>  	cldev = to_mei_cl_device(dev);
>  
> -	verify_mprime_in.header.api_version = HDCP_API_VERSION;
> -	verify_mprime_in.header.command_id = WIRED_REPEATER_AUTH_STREAM_REQ;
> -	verify_mprime_in.header.status = ME_HDCP_STATUS_SUCCESS;
> -	verify_mprime_in.header.buffer_len =
> +	cmd_size = struct_size(verify_mprime_in, streams, data->k);
> +	if (cmd_size == SIZE_MAX)
> +		return -EINVAL;
> +
> +	verify_mprime_in = kzalloc(cmd_size, GFP_KERNEL);
> +	if (!verify_mprime_in)
> +		return -ENOMEM;
> +
> +	verify_mprime_in->header.api_version = HDCP_API_VERSION;
> +	verify_mprime_in->header.command_id = WIRED_REPEATER_AUTH_STREAM_REQ;
> +	verify_mprime_in->header.status = ME_HDCP_STATUS_SUCCESS;
> +	verify_mprime_in->header.buffer_len =
>  			WIRED_CMD_BUF_LEN_REPEATER_AUTH_STREAM_REQ_MIN_IN;
>  
> -	verify_mprime_in.port.integrated_port_type = data->port_type;
> -	verify_mprime_in.port.physical_port = (u8)data->fw_ddi;
> -	verify_mprime_in.port.attached_transcoder = (u8)data->fw_tc;
> +	verify_mprime_in->port.integrated_port_type = data->port_type;
> +	verify_mprime_in->port.physical_port = (u8)data->fw_ddi;
> +	verify_mprime_in->port.attached_transcoder = (u8)data->fw_tc;
> +
> +	memcpy(verify_mprime_in->m_prime, stream_ready->m_prime, HDCP_2_2_MPRIME_LEN);
> +	drm_hdcp_cpu_to_be24(verify_mprime_in->seq_num_m, data->seq_num_m);
>  
> -	memcpy(verify_mprime_in.m_prime, stream_ready->m_prime,
> -	       HDCP_2_2_MPRIME_LEN);
> -	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
> -	memcpy(verify_mprime_in.streams, data->streams,
> +	memcpy(verify_mprime_in->streams, data->streams,
>  	       array_size(data->k, sizeof(*data->streams)));
>  
> -	verify_mprime_in.k = cpu_to_be16(data->k);
> +	verify_mprime_in->k = cpu_to_be16(data->k);
>  
> -	byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
> -			      sizeof(verify_mprime_in));
> +	byte = mei_cldev_send(cldev, (u8 *)verify_mprime_in, cmd_size);
> +	kfree(verify_mprime_in);
>  	if (byte < 0) {
>  		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
>  		return byte;
> -- 
> 2.25.4
> 
