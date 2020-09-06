Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85715C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4763C20709
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBmYjkkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgIFROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:14:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgIFROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599412463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL8tCYNOkqyUsw7ohcLXGgEzt8FWnS+srIzCd4NHd2U=;
        b=GBmYjkkZ/J5bar4XR3cHCpcMjAHuUHLzLg6iyjflSTwbOxkZrlILceBeVVHZHxKjGkZ07Q
        FFGJZs/2nNBTUv5wmWwMvQaMUmiAyQbxbh3eG7uW1vgis5pVpdfKfXwkULpw4dtnte3e0R
        oH1N2kefVO/AIiT0d+2UtHY4SZZCq00=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-bZMwFQekOom87U8REs43eQ-1; Sun, 06 Sep 2020 13:14:19 -0400
X-MC-Unique: bZMwFQekOom87U8REs43eQ-1
Received: by mail-qk1-f200.google.com with SMTP id v16so6447245qka.18
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 10:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sL8tCYNOkqyUsw7ohcLXGgEzt8FWnS+srIzCd4NHd2U=;
        b=Pi4Jd8akE5mUs8d8aRLLOahoyDaSNmD5l/mwfTPIzo5ReddgBOsFIa+X2ojsbwY4ya
         Ge6CRfKTuuUSXfz9AfV8SrRZZCa5S2JrJcQs1LIR2pEzkqAYW5y+meQ59QeOZp2S2eAQ
         8F0Ed9HDeG4h0fGWJq1R9toEf8zPMVZOqktuEMO/M77Y4fkcmlmBv47jkuE9h0r3aSdv
         5GwXGF6Ym3mxjdKR9yM4mdNPOhyvU/BvFtqg7IUuKKj9EzLGTwCgPfiuUpKgIWO0FY57
         fxwW16esBC0jXwj06GPL9gs5MfckMPo96BGCMju+EDNTYQCI8bYGbJzYfkUxHgrDWBaC
         9z3Q==
X-Gm-Message-State: AOAM5315sXDG6OKZvNyPvlrHbYLrUea02nKugf+d3SXJBgoe9NpaKgQw
        gAYZ5NzxltkwwsNAJ20i4RQ6j7ge9IWMJBdS2AoUyfYFO3xWDiZNyD/iXb2y7tfNRNgCPB6vA6l
        i1Npirk9EZxUHU1Mdis3WYp3U
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2400994qvi.141.1599412459210;
        Sun, 06 Sep 2020 10:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynPAtXpX1bkHIofdlix+rXLhWcID8OBtEtKgGVuZAfNeH6eIAxrhUsJYQvdJUQt5Mc/iKtSg==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2400978qvi.141.1599412458992;
        Sun, 06 Sep 2020 10:14:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k22sm6589106qkk.13.2020.09.06.10.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 10:14:18 -0700 (PDT)
Subject: Re: [PATCH v1 12/12] fpga: add max10 get_hw_errinfo callback func
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-13-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b90e8435-651c-e901-8be3-b0dac6eaac22@redhat.com>
Date:   Sun, 6 Sep 2020 10:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-13-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to include
> a function that returns 64 bits of additional HW specific
> data for errors that require additional information.
> This callback function enables the hw_errinfo sysfs
> node in the Intel Security Manager class driver.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 4a66c2d448eb..7fb1c805f654 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -450,6 +450,30 @@ static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
>  	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
>  }
>  
> +static u64 m10bmc_sec_hw_errinfo(struct ifpga_sec_mgr *imgr)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	u32 doorbell = 0, auth_result = 0;
> +	u64 hw_errinfo = 0;

hw_errinfo should be initialized to some poison value like -1

to cover the case if either of sys_read's fail.

Tom

> +
> +	switch (imgr->err_code) {
> +	case IFPGA_SEC_ERR_HW_ERROR:
> +	case IFPGA_SEC_ERR_TIMEOUT:
> +	case IFPGA_SEC_ERR_BUSY:
> +	case IFPGA_SEC_ERR_WEAROUT:
> +		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
> +			hw_errinfo = (u64)doorbell << 32;
> +
> +		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
> +				     &auth_result))
> +			hw_errinfo |= (u64)auth_result;
> +
> +		return hw_errinfo;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.user_flash_count = get_qspi_flash_count,
>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
> @@ -467,7 +491,8 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.prepare = m10bmc_sec_prepare,
>  	.write_blk = m10bmc_sec_write_blk,
>  	.poll_complete = m10bmc_sec_poll_complete,
> -	.cancel = m10bmc_sec_cancel
> +	.cancel = m10bmc_sec_cancel,
> +	.get_hw_errinfo = m10bmc_sec_hw_errinfo
>  };
>  
>  static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)

