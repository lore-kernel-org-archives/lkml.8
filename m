Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CEE20752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584484134;
	bh=in+uEnnBEamuibMWNP0r+YUcEQtvIxVwoH3U6yBNP6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z6mag5TkUC4XEPYaQneKlHHwzx86foDwgQB3DJ0OQkI8AF6qzIYWd6jpkBeFCbGmG
	 TtTa+kpLTaAqp+pYcf/MW6fePkXS8cJ7C1mrvwM1XfUpjCNKPRbbRnHADMQ8Nw2Rp1
	 Ap5IOKeCAPyHNs34Kt8oU3pXogfxter9lw/MlZ0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCQW2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgCQW2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:28:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81733206EC;
        Tue, 17 Mar 2020 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484132;
        bh=in+uEnnBEamuibMWNP0r+YUcEQtvIxVwoH3U6yBNP6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gi2J3WnXgD8B4p2Kyem8oTOZItr0QLzI9kbT+N65BetNa6uVg/24vYUtKEXcpFsG/
         IzRddKiKI8RgtGh1fZdl2MZL0RmKRRm7H5+eM5aKDhBgWEAoz8HEC24r8daJFM+lFj
         Hak5A/tkoSY7q3pw8u3maFQ8gtgZPvaw5ACgfCpk=
Date:   Tue, 17 Mar 2020 22:28:47 +0000
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?6Z+p56eR5omN?= <hankecai@vivo.com>
Cc:     catalin.marinas@arm.com, broonie@kernel.org,
        alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, trivial@kernel.org
Subject: Re: [PATCH] arm64: fix spelling mistake "ca not" -> "cannot"
Message-ID: <20200317222846.GI20788@willie-the-truck>
References: <AOoADQCXCJCLyVN7qh-tYqrl.1.1584244879067.Hmail.hankecai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AOoADQCXCJCLyVN7qh-tYqrl.1.1584244879067.Hmail.hankecai@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 12:01:19PM +0800, 韩科才 wrote:
> There is a spelling mistake in the comment, Fix it.
> 
> Signed-off-by: hankecai <hankecai@bbktel.com>
> ---
>  arch/arm64/lib/strcmp.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
> index 4767540d1b94..4e79566726c8 100644
> --- a/arch/arm64/lib/strcmp.S
> +++ b/arch/arm64/lib/strcmp.S
> @@ -186,7 +186,7 @@ CPU_LE( rev	data2, data2 )
>  	* as carry-propagation can corrupt the upper bits if the trailing
>  	* bytes in the string contain 0x01.
>  	* However, if there is no NUL byte in the dword, we can generate
> -	* the result directly.  We ca not just subtract the bytes as the
> +	* the result directly.  We cannot just subtract the bytes as the
>  	* MSB might be significant.
>  	*/
>  CPU_BE( cbnz	has_nul, 1f )

Acked-by: Will Deacon <will@kernel.org>

Will
