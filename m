Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A0C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37872072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD2EbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:31:14 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:43600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726305AbgD2EbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:31:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C1819181D341E;
        Wed, 29 Apr 2020 04:31:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: salt06_61b932e2e7907
X-Filterd-Recvd-Size: 2810
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 04:31:11 +0000 (UTC)
Message-ID: <0dcf9712a49968da1935061de130bc3668e63088.camel@perches.com>
Subject: Re: [PATCH 1/3] staging: qlge: Remove multi-line dereferences from
 qlge_main.c
From:   Joe Perches <joe@perches.com>
To:     Rylan Dmello <mail@rylan.coffee>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 21:31:10 -0700
In-Reply-To: <aae9feb569c60758ab09c923c09b600295f4cb32.1588132908.git.mail@rylan.coffee>
References: <aae9feb569c60758ab09c923c09b600295f4cb32.1588132908.git.mail@rylan.coffee>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 00:04 -0400, Rylan Dmello wrote:
> Fix checkpatch.pl warnings:
> 
>   WARNING: Avoid multiple line dereference - prefer 'qdev->func'
>   WARNING: Avoid multiple line dereference - prefer 'qdev->flags'

Assuming you are doing this for exercise:

It'd be better to unindent all the switch/case
blocks for the entire function so more functions
fit on single lines

	switch (foo) {
	case bar:
		{
			...;

should be:

	switch (foo) {
	case bar: {
		...;

goto exit; might as well be break; and remove
the exit label too.

> Signed-off-by: Rylan Dmello <mail@rylan.coffee>
> ---
>  drivers/staging/qlge/qlge_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
> index d7e4dfafc1a3..10daae025790 100644
> --- a/drivers/staging/qlge/qlge_main.c
> +++ b/drivers/staging/qlge/qlge_main.c
> @@ -396,8 +396,7 @@ static int ql_set_mac_addr_reg(struct ql_adapter *qdev, u8 *addr, u32 type,
>  			 * the route field to NIC core.
>  			 */
>  			cam_output = (CAM_OUT_ROUTE_NIC |
> -				      (qdev->
> -				       func << CAM_OUT_FUNC_SHIFT) |
> +				      (qdev->func << CAM_OUT_FUNC_SHIFT) |
>  					(0 << CAM_OUT_CQ_ID_SHIFT));
>  			if (qdev->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
>  				cam_output |= CAM_OUT_RV;
> @@ -3432,9 +3431,9 @@ static int ql_request_irq(struct ql_adapter *qdev)
>  				     &qdev->rx_ring[0]);
>  			status =
>  			    request_irq(pdev->irq, qlge_isr,
> -					test_bit(QL_MSI_ENABLED,
> -						 &qdev->
> -						 flags) ? 0 : IRQF_SHARED,
> +					test_bit(QL_MSI_ENABLED, &qdev->flags)
> +						? 0
> +						: IRQF_SHARED,
>  					intr_context->name, &qdev->rx_ring[0]);
>  			if (status)
>  				goto err_irq;

