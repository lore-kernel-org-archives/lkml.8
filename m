Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFEC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A80C21D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="OISfzco/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDRItq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:49:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:49:44 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 131so3729751lfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6JMWvrxsDtQ9ilM24fbTzz0O+inwACTx3EExqxO39Rw=;
        b=OISfzco/7CbYk6TPPk7+8YkHWT0blNPM9zUkdIpx0Qwcb91aQ8KAPlbA1zypwbsk1X
         M2IZSiPc7vIA5BY/c5/Q6XHICoYSPN+TZEBsZEiE7wKPkt75cQFuTxVm90FsDNHQ9upB
         1kIJb0zrVXadd0IP81uRJbDdXjhWJnSwca5u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JMWvrxsDtQ9ilM24fbTzz0O+inwACTx3EExqxO39Rw=;
        b=I5reDCxWUf8expOkizAQ29atTuLXsuDs4/VSG84f4cGL2tYSZLtMJ2P+ATkruLawBk
         xJ5Kt3SxY8HvDHcue2WHWaj6tUoMzLgx4hvcvim7g/QpRJw72Lmrn8naw2okhNvIdnck
         Qdxt9MZe27de1UJjWz0QxqDnvDKKvp1OhuNlkq0KKglR6IyXbpPRUn3BgApEaq7WWU1w
         fH11b4SU/QgqdH3dYaClx7qJzr42R/ssTsyWF6CUWq4plslBUjSRMZEQoD3kZ8FVBfP3
         t352R5B9AO5yLwsKY+magNwK5qjt/+/9sl7LGaIl7niDGfH+mS5u8MEGuvZEpolmAJeg
         PdQA==
X-Gm-Message-State: AGi0PuYrLoHfXLV6JBbIRJ+HRWDg01jkKSe28/7/APGx0Rt3wf61b6WW
        0aLcOV2pa7BLyT09O2CeEeoh9g==
X-Google-Smtp-Source: APiQypLmqj5OnHyqza8SkZR6WPy3NfrYePq3we7wW1P7M1KzfkUlSBdmRPPeRKHdNs15ql9bQ222dw==
X-Received: by 2002:a19:c1d3:: with SMTP id r202mr4454730lff.216.1587199783114;
        Sat, 18 Apr 2020 01:49:43 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 4sm10364947ljf.79.2020.04.18.01.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 01:49:42 -0700 (PDT)
Subject: Re: [RFC net-next v5 2/9] bridge: mrp: Update Kconfig and Makefile
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <20200414112618.3644-3-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <b53142fb-9dd3-7ead-7978-6ac5172c8791@cumulusnetworks.com>
Date:   Sat, 18 Apr 2020 11:49:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414112618.3644-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 14:26, Horatiu Vultur wrote:
> Add the option BRIDGE_MRP to allow to build in or not MRP support.
> The default value is N.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/Kconfig  | 12 ++++++++++++
>  net/bridge/Makefile |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index e4fb050e2078..51a6414145d2 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
>  	  Say N to exclude this support and reduce the binary size.
>  
>  	  If unsure, say Y.
> +
> +config BRIDGE_MRP
> +	bool "MRP protocol"
> +	depends on BRIDGE
> +	default n
> +	help
> +	  If you say Y here, then the Ethernet bridge will be able to run MRP
> +	  protocol to detect loops
> +
> +	  Say N to exclude this support and reduce the binary size.
> +
> +	  If unsure, say N.
> diff --git a/net/bridge/Makefile b/net/bridge/Makefile
> index 49da7ae6f077..9bf3e1be3328 100644
> --- a/net/bridge/Makefile
> +++ b/net/bridge/Makefile
> @@ -25,3 +25,5 @@ bridge-$(CONFIG_BRIDGE_VLAN_FILTERING) += br_vlan.o br_vlan_tunnel.o br_vlan_opt
>  bridge-$(CONFIG_NET_SWITCHDEV) += br_switchdev.o
>  
>  obj-$(CONFIG_NETFILTER) += netfilter/
> +
> +bridge-$(CONFIG_BRIDGE_MRP)	+= br_mrp.o br_mrp_netlink.o br_mrp_switchdev.o
> 

This is not bisectable, if you choose Y here you'll be missing some files.

