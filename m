Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85581C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503A52166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580827874;
	bh=i5VLeV4e5x9ghuIKRaD6Lh7802bcgyXrqoMy5Rmb5WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=eVn+eQAU/mHp2r/Vg1zp5YJ+GqKQYPxRMEIKCwpzDIf+dNcD8ZopS5zfF//4PADSh
	 rB92ftO/3Fg3Y9kQWfwvrTv1Py54fbsgR8kry0v1HZDr6YLZHplBKHwMlUIbbSPOFO
	 ZrecJHUjykPhE0IN6KT95csLURin9Rl3sfMWt3LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBDOvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbgBDOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:51:13 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA612082E;
        Tue,  4 Feb 2020 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580827872;
        bh=i5VLeV4e5x9ghuIKRaD6Lh7802bcgyXrqoMy5Rmb5WQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1t3n6KRGQYoZSzfSLwX0pi390M6357QS7ioVrwY8UcMX1jOSbSmh4edU7gZ15YxnA
         0lOVf/yHFmn3GpskdeyL6Lzr/Vwe594mxrFfPWeYtBU1QBLb/jca0FtbLLW3wg5MlI
         D1lTfR9tMquPmgYZgcYo9grR2uT1CoGOUjDbS84w=
Date:   Tue, 4 Feb 2020 08:51:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hch@lst.de
Subject: Re: [PATCH v2] x86/PCI: ensure to_pci_sysdata usage is available to
 !CONFIG_PCI
Message-ID: <20200204145111.GA6313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203215306.172000-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:53:06PM +0100, Jason A. Donenfeld wrote:
> Recently, the helper to_pci_sysdata was added inside of the CONFIG_PCI
> guard, but it is used from inside of a CONFIG_NUMA guard, which does not
> require CONFIG_PCI. This breaks builds on !CONFIG_PCI machines. This
> commit makes that function available in all configurations.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: aad6aa0cd674 ("x86/PCI: Add to_pci_sysdata() helper")
> Cc: Christoph Hellwig <hch@lst.de>

Thanks, applied with Randy's and Christoph's
reported/acked/reviewed-by to for-linus.  I'll try to get this in
v5.6-rc1 so the build issue is fixed.

> ---
>  arch/x86/include/asm/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 40ac1330adb2..7ccb338507e3 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -33,13 +33,13 @@ extern int pci_routeirq;
>  extern int noioapicquirk;
>  extern int noioapicreroute;
>  
> -#ifdef CONFIG_PCI
> -
>  static inline struct pci_sysdata *to_pci_sysdata(const struct pci_bus *bus)
>  {
>  	return bus->sysdata;
>  }
>  
> +#ifdef CONFIG_PCI
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  static inline int pci_domain_nr(struct pci_bus *bus)
>  {
> -- 
> 2.25.0
> 
