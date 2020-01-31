Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF64C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 01:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D35820663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 01:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dpv57oX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgAaBoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 20:44:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgAaBoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 20:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LtAoMN0VBwXoKpVeeYOrYi+7EuC0KOMgH0ErjjmGKiw=; b=Dpv57oX/23OdSKI3pU0tqnCCt
        Gdlsv70lnTp+a6bzlSTKz1QzWQru5zyIWU3ILPWU2YE/9YLj8TkBlNaMxaNtgibFY1s76DZixCRUw
        9CMMaC4tjcr5Q8RoB0P0BKq8md5xUN4cghjTfVduyuLQMF5TnjHud3aH1+a1pgpMfq20D8q9Yz7Zd
        qlir6hpZxQLNILbmJZuKUtJeqsaZS9j744Yvdp+CETNF5upYGcNHRIv4d0DXFw37OHkae8l9Bppxv
        xUnFk1FSpDW8pByOGeq7ykqa+gSW0w4xOl3u+1+PSgRRIZfOWoogMzAIwWvQD3rjRiM2sOF5y0L+K
        eSknBhGDw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixLLh-0008DI-Ou; Fri, 31 Jan 2020 01:43:57 +0000
Subject: Re: [PATCH] mlxsw: spectrum_qdisc: Fix 64-bit division error in
 mlxsw_sp_qdisc_tbf_rate_kbps
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200130232641.51095-1-natechancellor@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31537c12-8f17-660d-256d-e702d1121367@infradead.org>
Date:   Thu, 30 Jan 2020 17:43:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130232641.51095-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/20 3:26 PM, Nathan Chancellor wrote:
> When building arm32 allmodconfig:
> 
> ERROR: "__aeabi_uldivmod"
> [drivers/net/ethernet/mellanox/mlxsw/mlxsw_spectrum.ko] undefined!
> 
> rate_bytes_ps has type u64, we need to use a 64-bit division helper to
> avoid a build error.
> 
> Fixes: a44f58c41bfb ("mlxsw: spectrum_qdisc: Support offloading of TBF Qdisc")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> index 79a2801d59f6..65e681ef01e8 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> @@ -614,7 +614,7 @@ mlxsw_sp_qdisc_tbf_rate_kbps(struct tc_tbf_qopt_offload_replace_params *p)
>  	/* TBF interface is in bytes/s, whereas Spectrum ASIC is configured in
>  	 * Kbits/s.
>  	 */
> -	return p->rate.rate_bytes_ps / 1000 * 8;
> +	return div_u64(p->rate.rate_bytes_ps, 1000 * 8);

not quite right AFAICT.

try either
	return div_u64(p->rate.rate_bytes_ps * 8, 1000);
or
	return div_u64(p->rate.rate_bytes_ps, 1000) * 8;

>  }
>  
>  static int
> 


-- 
~Randy

