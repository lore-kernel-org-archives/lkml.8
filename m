Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0AEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FBC2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgDBF4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:56:15 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:35508 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbgDBF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:56:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 38DD15010;
        Thu,  2 Apr 2020 05:56:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: judge59_8d939426bb842
X-Filterd-Recvd-Size: 3915
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Apr 2020 05:56:12 +0000 (UTC)
Message-ID: <5d35084fcc0476fc2f43e3cf371f5078c0fbeeab.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: gasket: Fix 4 over 80 char warnings
From:   Joe Perches <joe@perches.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Apr 2020 22:54:17 -0700
In-Reply-To: <20200402053617.826678-2-jbwyatt4@gmail.com>
References: <20200402053617.826678-1-jbwyatt4@gmail.com>
         <20200402053617.826678-2-jbwyatt4@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 22:36 -0700, John B. Wyatt IV wrote:
> Fix 4 over 80 char warnings by caching long enum values into local
> variables.
> 
> All enums are only used once inside each function (and once inside
> the entire file).
> 
> Reported by checkpatch.
> 
> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> ---
>  drivers/staging/gasket/apex_driver.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index 46199c8ca441..f48209ec7d24 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -253,6 +253,8 @@ static int apex_get_status(struct gasket_dev *gasket_dev)
>  /* Enter GCB reset state. */
>  static int apex_enter_reset(struct gasket_dev *gasket_dev)
>  {
> +	int idle_gen_reg = APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER;
> +

This indirection only makes the code more difficult to understand.

>  	if (bypass_top_level)
>  		return 0;
>  
> @@ -263,7 +265,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev)
>  	 *    - Enable GCB idle
>  	 */
>  	gasket_read_modify_write_64(gasket_dev, APEX_BAR_INDEX,
> -				    APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
> +				    idle_gen_reg,
>  				    0x0, 1, 32);
>  
>  	/*    - Initiate DMA pause */
> @@ -395,11 +397,12 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
>  	u64 scalar_error;
>  	u64 hib_error;
>  	int ret = 0;
> +	int status = APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS;
>  
>  	hib_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
>  				       APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
>  	scalar_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
> -					  APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
> +					  status);
>  
>  	dev_dbg(gasket_dev->dev,
>  		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
> @@ -584,6 +587,8 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
>  	ulong page_table_ready, msix_table_ready;
>  	int retries = 0;
>  	struct gasket_dev *gasket_dev;
> +	int page_table_init = APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT;
> +	int msix_table_init = APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT;
>  
>  	ret = pci_enable_device(pci_dev);
>  	if (ret) {
> @@ -606,10 +611,10 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
>  	while (retries < APEX_RESET_RETRY) {
>  		page_table_ready =
>  			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
> -					   APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
> +					   page_table_init);
>  		msix_table_ready =
>  			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
> -					   APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
> +					   msix_table_init);
>  		if (page_table_ready && msix_table_ready)
>  			break;
>  		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));

