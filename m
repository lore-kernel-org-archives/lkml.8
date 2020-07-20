Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2434C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64332177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGTDPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:15:45 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:48634 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbgGTDPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:15:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 711A61800709C;
        Mon, 20 Jul 2020 03:15:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fire30_270f2ac26f21
X-Filterd-Recvd-Size: 1856
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Jul 2020 03:15:42 +0000 (UTC)
Message-ID: <f31ec3e646c9ba73c09f821a173c20110346deab.camel@perches.com>
Subject: Re: [PATCH net-next v2] net: ena: Fix using plain integer as NULL
 pointer in ena_init_napi_in_range
From:   Joe Perches <joe@perches.com>
To:     Wang Hai <wanghai38@huawei.com>, gtzalik@amazon.com,
        saeedb@amazon.com, zorik@amazon.com, davem@davemloft.net,
        kuba@kernel.org, sameehj@amazon.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Jul 2020 20:15:41 -0700
In-Reply-To: <20200720025309.18597-1-wanghai38@huawei.com>
References: <20200720025309.18597-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-20 at 10:53 +0800, Wang Hai wrote:
> Fix sparse build warning:
> 
> drivers/net/ethernet/amazon/ena/ena_netdev.c:2193:34: warning:
>  Using plain integer as NULL pointer
[]
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
[]
> @@ -2190,11 +2190,10 @@ static void ena_del_napi_in_range(struct ena_adapter *adapter,
>  static void ena_init_napi_in_range(struct ena_adapter *adapter,
>  				   int first_index, int count)
>  {
> -	struct ena_napi *napi = {0};
>  	int i;
>  
>  	for (i = first_index; i < first_index + count; i++) {
> -		napi = &adapter->ena_napi[i];
> +		struct ena_napi *napi = &adapter->ena_napi[i];
>  
>  		netif_napi_add(adapter->netdev,
>  			       &adapter->ena_napi[i].napi,

Another possible change is to this statement:

 		netif_napi_add(adapter->netdev,
			       &napi->napi,
			       etc...);



