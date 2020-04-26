Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6358C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E8D20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZQbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:31:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50178 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDZQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:31:50 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id d4f95e24674149c7; Sun, 26 Apr 2020 18:31:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ACPI / CPPC: Make some symbols static
Date:   Sun, 26 Apr 2020 18:31:47 +0200
Message-ID: <2458050.BygcShJWPJ@kreacher>
In-Reply-To: <1587626518-97669-1-git-send-email-zou_wei@huawei.com>
References: <1587626518-97669-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 23, 2020 9:21:58 AM CEST Zou Wei wrote:
> Fix the following sparse warnings:
> 
> drivers/acpi/cppc_acpi.c:353:20: warning: symbol 'cppc_mbox_cl' was not declared. Should it be static?
> drivers/acpi/cppc_acpi.c:600:5: warning: symbol 'pcc_data_alloc' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 8b2e89c..f818400 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -350,7 +350,7 @@ static void cppc_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
>  				*(u16 *)msg, ret);
>  }
>  
> -struct mbox_client cppc_mbox_cl = {
> +static struct mbox_client cppc_mbox_cl = {
>  	.tx_done = cppc_chan_tx_done,
>  	.knows_txdone = true,
>  };
> @@ -597,7 +597,7 @@ bool __weak cpc_ffh_supported(void)
>   *
>   * Return: 0 for success, errno for failure
>   */
> -int pcc_data_alloc(int pcc_ss_id)
> +static int pcc_data_alloc(int pcc_ss_id)
>  {
>  	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
>  		return -EINVAL;
> 

Applied as 5.8-candidate material, thanks!




