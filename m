Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFC9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18E020826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590085668;
	bh=/WDW8VQf6iHXjI83NrrhTGfMoMsExmF4WWAKY8AsnD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkPMaoRbCZ8zn+jydw2W+eiE0w+pUk1vtJhF0VP9DjdwW5okbMeEX/OcwVKC3jlzt
	 a8lNbFFIT94FlxpRKFEJ8S99iEUnc1atpk8Jdghsu1pRkX7Qo4vAJQpGKzbBt9PjNy
	 gpIDXlTjwqgEXWNQYnK0Q0jgemRmL5EwDxxXxpdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgEUS1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUS1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:27:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCBD720814;
        Thu, 21 May 2020 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590085666;
        bh=/WDW8VQf6iHXjI83NrrhTGfMoMsExmF4WWAKY8AsnD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqzbcY7HsMUAYzkWVdfcRaT91gC/TZyEUicnStmo+ommIAhbivnvn8bxVE+UpaB/C
         IqB9zXAduOKiblcU/15eO8iaPW16NseBHN2F5rub4EE4m3fMeIYXTJqRfZB1DC0oFO
         qg21wdU6b32Qb0G4zPbANPByPYNE36HWCp8nIqI0=
Date:   Thu, 21 May 2020 13:32:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibft: Replace zero-length array with flexible-array
Message-ID: <20200521183235.GA29907@embeddedor>
References: <20200507185544.GA14695@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185544.GA14695@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this?

Thanks
--
Gustavo

On Thu, May 07, 2020 at 01:55:44PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/firmware/iscsi_ibft.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 96758b71a8db..7127a04bca19 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -104,7 +104,7 @@ struct ibft_control {
>  	u16 tgt0_off;
>  	u16 nic1_off;
>  	u16 tgt1_off;
> -	u16 expansion[0];
> +	u16 expansion[];
>  } __attribute__((__packed__));
>  
>  struct ibft_initiator {
> 
