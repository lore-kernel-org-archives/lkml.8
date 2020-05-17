Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E0620758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgEQUtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:49:53 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:48656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbgEQUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4A25D18225E0F;
        Sun, 17 May 2020 20:49:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean20_5608517ad065c
X-Filterd-Recvd-Size: 1980
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 17 May 2020 20:49:51 +0000 (UTC)
Message-ID: <ec2fa70939ab20dc7c454897b0b8ed08570dca80.camel@perches.com>
Subject: Re: [RFC PATCH] staging: rtl8192u: indicate_packets() can be static
From:   Joe Perches <joe@perches.com>
To:     kbuild test robot <lkp@intel.com>,
        Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Date:   Sun, 17 May 2020 13:49:50 -0700
In-Reply-To: <20200517202216.GA24634@8c544063f25c>
References: <20200517165819.136715-1-pterjan@google.com>
         <20200517202216.GA24634@8c544063f25c>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 04:22 +0800, kbuild test robot wrote:
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---

This doesn't apply on Linus' tree or -next so perhaps the
robot should put what tree and branch patches like these
are meant to be applied on after the --- line

>  ieee80211_rx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> index 3309f64be4c94..bceff1ba3d7d4 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> @@ -520,7 +520,7 @@ static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_entry *p
>  	return true;
>  }
>  
> -void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
> +static void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
>  {
>  	struct net_device_stats *stats = &ieee->stats;
>  	struct net_device *dev = ieee->dev;

