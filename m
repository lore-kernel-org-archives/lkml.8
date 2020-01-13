Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F5C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3E2081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="qzBDUTyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMNRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:17:32 -0500
Received: from mx4.wp.pl ([212.77.101.12]:4145 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbgAMNR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:17:28 -0500
Received: (wp-smtpd smtp.wp.pl 467 invoked from network); 13 Jan 2020 14:17:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1578921446; bh=fiL5feLAQg1wnn446GC+3zMpF7346AQGDCS3XeChSTA=;
          h=From:To:Cc:Subject;
          b=qzBDUTyY3N87LSG2hKt7ZSXgIJ4yQdIF3Os+2js59ftWgJBrd/cPmAI/+Hdwlnkg6
           Fyed6NcUYyiy55TmsPGH5Wenjb7lct8Nj6qQX3SY6YaR/ETLhN91iUyNG/C0oGr5Hi
           kCBZomcIlnMvzE7EYGBk9nRfqXBXXMu5T905jGjM=
Received: from c-73-93-4-247.hsd1.ca.comcast.net (HELO cakuba) (kubakici@wp.pl@[73.93.4.247])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <boon.leong.ong@intel.com>; 13 Jan 2020 14:17:26 +0100
Date:   Mon, 13 Jan 2020 05:17:12 -0800
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Ong Boon Leong <boon.leong.ong@intel.com>
Cc:     netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/7] net: stmmac: fix missing netdev->features in
 stmmac_set_features
Message-ID: <20200113051712.73442991@cakuba>
In-Reply-To: <1578967276-55956-4-git-send-email-boon.leong.ong@intel.com>
References: <1578967276-55956-1-git-send-email-boon.leong.ong@intel.com>
        <1578967276-55956-4-git-send-email-boon.leong.ong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 9114ca6d95137af99c81d33196a332a9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YVNE]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 10:01:12 +0800, Ong Boon Leong wrote:

Please fix the date on your system.

Please always provide a patch description. For bug fixes description of
how the bug manifest to the users is important to have.

> Fixes: d2afb5bdffde ("stmmac: fix the rx csum feature")
> 

Please remove the empty lines between the Fixes tag and the other tags
on all patches.

> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index cd55d16..dc739cd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3911,6 +3911,8 @@ static int stmmac_set_features(struct net_device *netdev,
>  	for (chan = 0; chan < priv->plat->rx_queues_to_use; chan++)
>  		stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
>  
> +	netdev->features = features;
> +
>  	return 0;
>  }
>  

