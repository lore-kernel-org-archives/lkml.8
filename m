Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D3C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7E620E65
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="iZovJBNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgH1VwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1VwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:52:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB11DC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 14:52:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so1064874pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGIFgHhnj4ZZ+ZwmJ+azPNOf9dZgEALfNMtI3CFWx/o=;
        b=iZovJBNhkq0B0uvt1ArnlCzdGbse3STj2vz7fm/5VWNq+S1otd+TvNXZEUISe40n4r
         3tyV7aZKRDpcO8Xj0Mrnb0RFV5xmg0I8ORIUjCNCrvsgPb0d8Bun/VjtpPNSc/dfVpKT
         uS0YwSrtAIaaZAeAitIxGI7YsF/TOi0NkB/2zD/YiJYxK4wMVhVW0mHTLZyrIXJPpESq
         y06pufjnDraLjjx8YNwTEqj440DVB6lkZF+ldjBz/N+O4Pc4nEPAthTnNQEdzYhkK/W3
         qIkdIyU503gGOvgOhAL7fG7yiYDGHx8m7RtnSdb1qBuDmi3Q35PlKpNHYR+hXjomtOgO
         +BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGIFgHhnj4ZZ+ZwmJ+azPNOf9dZgEALfNMtI3CFWx/o=;
        b=prh9vY3ZN7Q2Sr4wP8blqLVXX+kMIDpNLYyTkJTD0LRnPmNh3nQTpP9cxhNCY3U314
         uk0uX8a3ROsc9YDkd8Z4Hg1K6xizHS8X0DaHgjtyFmltpVKwU92bi5A5mqQD9wtAlEbo
         MTWEtW2BbJooMrYF3iHf8mVr5fyOcCQCUhC0dsvRdwg65znylKdl2sh4iU/z9iAGWc9Z
         HXD6nfuF3i16HEa52vJU03YKoRq0+5cKw5olsAhQZksuYsyRrefbCjUIaDQEfQCTPE6a
         2AsKagXMCQM5fEcb9f5ph+A81AanaBL6y74psdvHpc6lXvLAeHsA8xBnRlhpXKc/NO7s
         15jQ==
X-Gm-Message-State: AOAM532DeU8Xj9+2VxDSVUFYebLZMJC4AfrBYoHymrPVq1434xjgexYY
        TxuCW0lQ1tggUuvOSOnHA+Lhqg==
X-Google-Smtp-Source: ABdhPJwhZJvDd6XsVHxUj8a4OFtxbQPgRKloZkMgTlDj0buCsdSbeE00LtElOYuUed4PK8i3k/2dZA==
X-Received: by 2002:a62:5214:: with SMTP id g20mr821890pfb.168.1598651532034;
        Fri, 28 Aug 2020 14:52:12 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r199sm400334pfc.98.2020.08.28.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:52:11 -0700 (PDT)
Date:   Fri, 28 Aug 2020 14:52:03 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Bart Groeneveld <avi@bartavi.nl>
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] net: Use standardized (IANA) local port range
Message-ID: <20200828145203.65395ad8@hermes.lan>
In-Reply-To: <20200828204447.32838-1-avi@bartavi.nl>
References: <20200828203959.32010-1-avi@bartavi.nl>
        <20200828204447.32838-1-avi@bartavi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 22:44:47 +0200
Bart Groeneveld <avi@bartavi.nl> wrote:

> IANA specifies User ports as 1024-49151,
> and Private ports (local/ephemeral/dynamic/w/e) as 49152-65535 [1].
> 
> This means Linux uses 32768-49151 'illegally'.
> This is not just a matter of following specifications:
> IANA actually assigns numbers in this range [1].
> 
> I understand that Linux uses 61000-65535 for masquarading/NAT [2],
> so I left the high value at 60999.
> This means the high value still does not follow the specification,
> but it also doesn't conflict with it.
> 
> This change will effectively halve the available ephemeral ports,
> increasing the risk of port exhaustion. But:
> a) I don't think that warrants ignoring standards.
> 	Consider for example setting up a (corporate) firewall blocking
> 	all unknown external services.
> 	It will only allow outgoing trafiic at port 80,443 and 49152-65535.
> 	A Linux computer behind such a firewall will not be able to connect
> 	to *any* external service *half of the time*.
> 	Of course, the firewall can be adjusted to also allow 32768-49151,
> 	but that allows computers to use some services against the policy.
> b) It is only an issue with more than 11848 *outgoing* connections.
> 	I think that is a niche case (I know, citation needed, but still).
> 	If someone finds themselves in such a niche case,
> 	they can still modify ip_local_port_range.
> 
> This patch keeps the low and high value at different parity,
> as to optimize port assignment [3].
> 
> [1]: https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.txt
> [2]: https://marc.info/?l=linux-kernel&m=117900026927289
> [3]: See for example commit 1580ab63fc9a03593072cc5656167a75c4f1d173 ("tcp/dccp: better use of ephemeral ports in connect()")
> 
> Signed-off-by: Bart Groeneveld <avi@bartavi.nl>

Changing the default range impacts existing users. Since Linux has been doing
this for so long, I don't think just because a standards body decided to reserve
some space is sufficient justification to do this.

