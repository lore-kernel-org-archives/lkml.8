Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C1C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877ED2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598866062;
	bh=DrHloDABVgOOM+XRYJ0A+dG8Nq8q3jEeLOViCmEba4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VaOrdPf6/k8DrfwIN8VatmGPGY7l8wbcY8OAOiL7kcfIDQreEDD1mIvNB/9iukJly
	 BZL+MCpev82UKeQe+RXuLmOAWK9JZjpZJMam4Gz74PtmVJ3IhpHqQXuKXedctXtzmW
	 TQndeapGsOybUUSQvaWu3+zGBTsBVqj1Vzv/IrCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaJ1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgHaJ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:27:39 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17E42073A;
        Mon, 31 Aug 2020 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598866059;
        bh=DrHloDABVgOOM+XRYJ0A+dG8Nq8q3jEeLOViCmEba4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GFv0wLhg+Ji+EwB14dxJs3wxpxWs9OKGcAAxx5CdUCWXp0AfxeoqtPvm6ef9aZFda
         r/Xsy86vEda6tAmFqBo2w/uel7m3Ru0tEAmofvst5C3ur5KQu76ILp9GDGSg6k/bJu
         IO8iQjjqiNjhBip7SUav8DmJaiN8h2hvHOYN7n/o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kCg6D-007yrR-BW; Mon, 31 Aug 2020 10:27:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 31 Aug 2020 10:27:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
In-Reply-To: <20200831031838.2d6d76d9@DUFFMAN>
References: <20200829164920.7d28e01a@DUFFMAN>
 <65d88bdd0888a69849327501a2aad186@kernel.org>
 <20200831031838.2d6d76d9@DUFFMAN>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@dionne-riel.com, robh@kernel.org, devicetree@vger.kernel.org, frowand.list@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-31 08:18, Samuel Dionne-Riel wrote:
> On Sun, 30 Aug 2020 10:41:42 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> Hi,
> 
>> 
>> Could you try replacing the problematic patch with [1], and let me
>> know whether this changes anything on your end? This patch probably
>> isn't the right approach, but it would certainly help pointing me
>> in the right direction.
>> 
>> [1]
>> https://lore.kernel.org/lkml/20200815125112.462652-2-maz@kernel.org/
> 
> Following through a bisect session to figure out why the Wi-Fi broke
> between 5.8 and 5.9-rc1, I figured out something that you might have in
> mind already.
> 
> It seems that anything that makes of_bus_pci_match return true will
> cause this to happen. This is why your initial fix also fails.
> 
> I believe my understanding is right since applying the following on top
> of 5.9-rc1 also produces the same result.
> 
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -227,6 +227,7 @@ dmac_peri: dma-controller@ff6e0000 {
>         };
> 
>         pcie0: pcie@f8000000 {
> +               device_type = "pci";
>                 compatible = "rockchip,rk3399-pcie";
>                 reg = <0x0 0xf8000000 0x0 0x2000000>,
>                       <0x0 0xfd000000 0x0 0x1000000>;
> 
> 
> This was found out since the Wi-Fi pci-based ath10k Wi-Fi broke, with
> 2f96593ecc37e98bf99525f0629128080533867f, which changes stuff around
> pci bus... things...
> 
> Am I understanding right that your fix(es) were related to the change
> set where the commit is found?
> 
> My intuition is that the commit causing the boot issue could be related
> to changes with PCI or PCIe subsystems, and that your fix for
> of_bus_pci_match is a red herring, that only surfaced the existing
> issue.
> 
> This is backed by applying the previous dts patch on top of 2f96593e,
> and having Wi-Fi work. I would assume that between that commit and
> 5.9-rc1 there is a commit that causes the complete failure to boot,
> which is unrelated to the first identified commit on 5.9-rc2.

Ah, so actually anything that *enables pcie* kills your system.
Great investigative work!

> 
> And backed by a further bisection with this that points to
> d84c572de1a360501d2e439ac632126f5facf59d being the actual change that
> causes the tablet to fail to boot, as long as the pcie0 node is
> identified as pci properly.
> 
> I am unsure if I should add as a Cc everyone involved in that change
> set, though the author (coincidentally) is already in the original list
> of recipients.

I've deliberately moved Rob from Cc to To... ;-)

> Any additional thoughts from this additional information?

What you could do is to start looking at which of the pci_is_root_bus()
changes breaks PCIe on this system.  The fact that it breaks on your
system and not on mine is a bit puzzling.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
