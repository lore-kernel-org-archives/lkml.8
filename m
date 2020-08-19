Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E855D2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="mbKaFtKy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="vY6KQW15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgHSNGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:06:00 -0400
Received: from relay2.mymailcheap.com ([217.182.66.162]:58758 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgHSNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:05:43 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 6D8CA3E90B;
        Wed, 19 Aug 2020 15:05:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 462BE2A51B;
        Wed, 19 Aug 2020 15:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1597842340;
        bh=xgLkVUqX1IfZYjssicJSiWH/uVLGQkqOteQNJcfZxgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mbKaFtKy06YKcGxwccQ4lrKzs9lbShJ7nRHdJ3t+LLYF3rJCXs1Lry3vRlHPH+KC2
         Qlb2vd2ovJTRAfRonEACZY2CnuTisJt70G3smrjIpgcYDqLFeYP+UK/I6SRHvNFa+X
         OaDTpUtUIRnW3m3JhJwFC0Q+gmzNb+DYEtHpdUCQ=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZluiADmQ2_V1; Wed, 19 Aug 2020 15:05:39 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 19 Aug 2020 15:05:39 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id A99B84117F;
        Wed, 19 Aug 2020 13:05:38 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="vY6KQW15";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9B86F4132F;
        Wed, 19 Aug 2020 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1597842048; bh=xgLkVUqX1IfZYjssicJSiWH/uVLGQkqOteQNJcfZxgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vY6KQW15+Bs4w4Wzy8Zdqr5c+13OR24BLC6YsCxKoSgG68J3sNHveU2HqPkzw/qTY
         pQcEnfHyqxsspkZks3DYPkzNAR6fXZ5QJniWPQN3srJvqdyBFXbMJjT8wygm6iYgwx
         Iz8bV06TfFQ4rhEpo25OhOA4AA0+VD7wGdYKFDMw=
Message-ID: <6cff597419622f78321bf18528ca22020e7835c5.camel@aosc.io>
Subject: Re: [PATCH 1/1] mfd: mfd-core: Ensure disabled devices are ignored
 without error
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 19 Aug 2020 21:00:41 +0800
In-Reply-To: <20200819105406.3249846-1-lee.jones@linaro.org>
References: <20200819105406.3249846-1-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A99B84117F
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.120:received];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-08-19星期三的 11:54 +0100，Lee Jones写道：
> Commit e49aa9a9bd22 ("mfd: core: Make a best effort attempt to match
> devices with the correct of_nodes") changed the semantics for
> disabled
> devices in mfd_add_device().  Instead of silently ignoring a disabled
> child device, an error was returned.  On receipt of the error
> mfd_add_devices() the precedes to remove *all* child devices and
> returns an all-failed error to the caller, which will inevitably fail
> the parent device as well.
> 
> This patch reverts back to the old semantics and ignores child
> devices
> which are disabled in Device Tree.
> 
> Fixes: e49aa9a9bd22 ("mfd: core: Make a best effort attempt to match
> devices with the correct of_nodes")
> Reported-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tested-by: Icenowy Zheng <icenowy@aosc.io>

> ---
>  drivers/mfd/mfd-core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index c3651f06684fa..30f90a15ceaab 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -126,10 +126,6 @@ static int mfd_match_of_node_to_dev(struct
> platform_device *pdev,
>  	const __be32 *reg;
>  	u64 of_node_addr;
>  
> -	/* Skip devices 'disabled' by Device Tree */
> -	if (!of_device_is_available(np))
> -		return -ENODEV;
> -
>  	/* Skip if OF node has previously been allocated to a device */
>  	list_for_each_entry(of_entry, &mfd_of_node_list, list)
>  		if (of_entry->np == np)
> @@ -212,6 +208,12 @@ static int mfd_add_device(struct device *parent,
> int id,
>  	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell-
> >of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
>  			if (of_device_is_compatible(np, cell-
> >of_compatible)) {
> +				/* Ignore 'disabled' devices error free
> */
> +				if (!of_device_is_available(np)) {
> +					ret = 0;
> +					goto fail_alias;
> +				}
> +
>  				ret = mfd_match_of_node_to_dev(pdev,
> np, cell);
>  				if (ret == -EAGAIN)
>  					continue;
