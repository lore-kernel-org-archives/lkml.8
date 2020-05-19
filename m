Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B825C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4FD207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589907502;
	bh=wON0KBDCS5zMpkAAmFVUnsEOH1a7o5ryClmYvR0Mm+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UtKn79wE9GeaCkI1A7L20IzWBKql809Cl6FUG4A1NYDWhua+BjrISyS/EY16xIUFr
	 gCQ/lhrfHFr+rxjJGWdUhTFYVWGPn2iYIPsAK0OT/Mrfc5e+U65ChWmPIx98DbmmUZ
	 QlfNWpjKy03lR90nPBdrypseWjH+SIKau6GnLyzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgESQ6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgESQ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:58:20 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C022075F;
        Tue, 19 May 2020 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907500;
        bh=wON0KBDCS5zMpkAAmFVUnsEOH1a7o5ryClmYvR0Mm+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IxwqA0P84DMGAtGNa4obAfFwhbdvqD3Bz5YPObh3hQU3+G7QF/veLi7gsfIjYfnZX
         /ydynmdSwffGagAYILULpz6y+xAIiBcvxmcax+WzgJ5IkoNLw4dQ1B2eHaVn+W2stk
         il5tnivohL+/cQxG2HFS1qu+f5LNv3zuJipykdw8=
Date:   Tue, 19 May 2020 09:58:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] net: phy: dp83869: Set opmode from straps
Message-ID: <20200519095818.425d227b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200519141813.28167-3-dmurphy@ti.com>
References: <20200519141813.28167-1-dmurphy@ti.com>
        <20200519141813.28167-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 09:18:11 -0500 Dan Murphy wrote:
> If the op-mode for the device is not set in the device tree then set
> the strapped op-mode and store it for later configuration.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

../drivers/net/phy/dp83869.c: In function0 dp83869_set_strapped_mode:
../drivers/net/phy/dp83869.c:171:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
  171 |  if (val < 0)
      |          ^
