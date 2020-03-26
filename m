Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F5C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FA420748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585215765;
	bh=h9GuRIy1ILfVwQ0qx5+rDL9mzkkYKa/lwyadvKjfuYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w3PFIpOSSrQuREYWvxCrXRiTvW0sJ4RNAUidC10g+WgqYnRkcW0QAn5WBGCFxNp0Y
	 At0XhrvBuyLyXX3e7AuECVcZZhVoMW8X/eutd6AVk2A06YNKjlSnl+IPnfWTMMllrZ
	 2KkdvovpBFKz1bfTxq9hC6uV/n5hTGohylNGbRpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgCZJmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCZJmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:42:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455DF20714;
        Thu, 26 Mar 2020 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585215763;
        bh=h9GuRIy1ILfVwQ0qx5+rDL9mzkkYKa/lwyadvKjfuYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ypwoPeGbXlGKBNzHg4SlDHqI1LdFAHzOi8aVG92p9Z24IIZatCnUx80yjKS1QiVKZ
         NtPo8ZaQxg3Ivef4Q883HsglhuGp3zT7eX2cJ43zJItJPkqYtiY43IPqUtjHJRwpPe
         vf8g2mqxneINDRA6H/zMyx+OKV09s4CZ0VT6YYF4=
Date:   Thu, 26 Mar 2020 10:42:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ulrich Weigand <uweigand@de.ibm.com>, paulmck@kernel.org,
        jejb@linux.ibm.com, Jonathan Corbet <corbet@lwn.net>,
        Anton Blanchard <anton@linux.ibm.com>
Subject: Re: [PATCH] Documentation: provide IBM contacts for embargoed
 hardware
Message-ID: <20200326094241.GA996751@kroah.com>
References: <20200326093831.428337-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326093831.428337-1-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:38:31AM +0100, Christian Borntraeger wrote:
> Provide IBM contact for embargoed hardware issues. As POWER and Z are
> different teams with different designs it makes sense to have separate
> persons for the first contact.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Anton Blanchard <anton@linux.ibm.com>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index a19d084f9b2c..43cdc67e4f8e 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -246,7 +246,8 @@ an involved disclosed party. The current ambassadors list:
>    ============= ========================================================
>    ARM           Grant Likely <grant.likely@arm.com>
>    AMD		Tom Lendacky <tom.lendacky@amd.com>
> -  IBM
> +  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
> +  IBM Power     Anton Blanchard <anton@linux.ibm.com>

Can I get an ack from Anton that he really agrees with this?  :)

thanks,

greg k-h
