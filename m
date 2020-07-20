Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1559C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A8F22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="jNANyFXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgGTRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgGTRYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:24:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDDEC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:24:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so10575000pgg.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tXbJd4oEVmSqiGnziAAflmb4MGrnOQpZX5+lHSdW3g=;
        b=jNANyFXgAgqogkWNgrJoj6QtdoyB0yR54rUSu+O4nZVCVb/7hJZiOX6O4uSHF5Atso
         ItdU4dvRixI5slgLsUGF6Z1uawSBBTJnKZgWo11KLDx8JECBDRW8nr4j9+sM0peyA8vo
         /qfKucK6NlSY6FRrqC4W3rIolIkfF7MNoNV7GmIXgaGQZ+vB1QwC075G84MoosS5n4wS
         OJQ8ihNqJZJFZcnWopsyZUXi0T9t6mm8xYD799vZpU14tj3GftLFIaG4pJhETMBK4OSb
         EDenfd10pqs5KddO/+hBoHqqMxC/qyPXviQ/6TDYt7Q8FpxSSQKDQn9LEdgAgWdURRWJ
         LCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tXbJd4oEVmSqiGnziAAflmb4MGrnOQpZX5+lHSdW3g=;
        b=KICBf+4JlbBXWa1xWCTQ4UJCswPVGNYkxmMobc3bflZpyz3JD/vcf1jVjlbneRb6b6
         XNky6NMTeJFXob1ji2WaDDtJnhXTIoswwzFVSkXswrOz9VmlEi1XIgSSddLemR0Fms4T
         S7zSVLIEky1nVv1W8rHUIwNRSp4h2J47M1xzonOCHBK7elpUcadoGZyyCyWMkypb9P+M
         OXOYPoImB/yJMP8dngPP19MRu1dQHdDJG9/hI1y5NZJ5/YFtMrKq5HG0Le6b1uD5uuAl
         YEQXN66wkwnErec6kcNcZH5XWf3IAen/XT5cyI1wlAUdhGU2nkFcRb704WftLp9e/9TW
         sZtQ==
X-Gm-Message-State: AOAM530gXE8dSn86YEOQHsWpCpeCdZfDCO1v6+Ji02lpOorstlrLZEnG
        ltwaY6YdyVRjyuqIQFkZjTTeGA==
X-Google-Smtp-Source: ABdhPJx2Og1skqUry9DiKMzcmFRiYWZ31mk7FqDM7ufVQ3k37RbqfBypuApaoSr5H7ormO+7hIXfVQ==
X-Received: by 2002:a63:f90f:: with SMTP id h15mr19068452pgi.53.1595265891947;
        Mon, 20 Jul 2020 10:24:51 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z11sm17365435pfk.46.2020.07.20.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:24:51 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:24:43 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Chi Song <chisong@linux.microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: hyperv: Add attributes to show TX
 indirection table
Message-ID: <20200720102443.63d8ddf2@hermes.lan>
In-Reply-To: <alpine.LRH.2.23.451.2007192357400.30908@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <alpine.LRH.2.23.451.2007192357400.30908@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 00:12:10 -0700 (PDT)
Chi Song <chisong@linux.microsoft.com> wrote:

> An imbalanced TX indirection table causes netvsc to have low
> performance. This table is created and managed during runtime. To help
> better diagnose performance issues caused by imbalanced tables, add
> device attributes to show the content of TX indirection tables.
> 
> Signed-off-by: Chi Song <chisong@microsoft.com>
> ---


> v2: remove RX as it's in ethtool already, show single value in each file,
>  and update description.
> 
> Thank you for comments. Let me know, if I miss something.
> 
> ---
>  drivers/net/hyperv/netvsc_drv.c | 53 +++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> index 6267f706e8ee..222c2fad9300 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2370,6 +2370,55 @@ static int netvsc_unregister_vf(struct net_device
> *vf_netdev)
>  	return NOTIFY_OK;
>  }
> 
> +static struct device_attribute
> dev_attr_netvsc_dev_attrs[VRSS_SEND_TAB_SIZE];
> +static struct attribute *netvsc_dev_attrs[VRSS_SEND_TAB_SIZE + 1];
> +
> +const struct attribute_group netvsc_dev_group = {
> +	.name = NULL,
> +	.attrs = netvsc_dev_attrs,
> +};
> +
> +static ssize_t tx_indirection_table_show(struct device *dev,
> +					 struct device_attribute
> *dev_attr,
> +					 char *buf)
> +{
> +	struct net_device *ndev = to_net_dev(dev);
> +	struct net_device_context *ndc = netdev_priv(ndev);
> +	ssize_t offset = 0;

useless initialization

> +	int index = dev_attr - dev_attr_netvsc_dev_attrs;
> +
> +	offset = sprintf(buf, "%u\n", ndc->tx_table[index]);
> +
> +	return offset;
why not just
	return sprintf(buf, "%u\n", ndc->tx_table[index]);
> +}
> +
> +static void netvsc_attrs_init(void)
> +{
> +	int i;
> +	char buffer[32];
> +
> +	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++) {
> +		sprintf(buffer, "tx_indirection_table_%02u", i);

Although this has one value per file it leads to a mess.
Why not put it in a separate directory (/sys/class/net/eth0/tx_indirection/N)?
