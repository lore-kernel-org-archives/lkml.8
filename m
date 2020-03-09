Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE80C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F98224654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583787931;
	bh=g9N6of+fXMYEvQmQJ986K150eu5EoFj639M+Arl2mgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xdzVhp54QpzmQgDcb30ZetwAnPjST4hv37hS3zo9ePakcczqHQhAmM7/haov8ztrw
	 dE3p5j+e71NAfA1/tOj80sFuZ3Ut6Kmo+Zn/Zp49OhTApx2bNRekMbtaSnMc0HDK1J
	 ysUcbHxKdHSCB2on7qYltbXk37zBgVgjjnlSioyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCIVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:05:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46110 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:05:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id 111so6728818oth.13;
        Mon, 09 Mar 2020 14:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S3K7yVdnvROgRNjWoLKF7rzoU4Ko8/qyGdog+zSFEvY=;
        b=txA2x6jRluRQuBoHlJ2KxeDu+bClLlE35DM2xjfr6rbt5He4Xevn7jzHu9lrEgmWmp
         YaMWo5Bt8XwsxiDYx4z2Yua/EFdKCzOve0tOH4NcizFo+q3Tlmm/DcICzb1cQSEiRnG1
         UYExfwiBsZCHexlUZ3VppXN2rMkX3VtKaXE9f3VpGFdtYMCzFhr8U6ulrgUbhZXj6soK
         GxZvszN3bI6HUQAyLVNnrAJ5UfWxxKeYHM65q2C/4D/HeOhU0hZ0ifgSoQvouEyUppLf
         o0D757n9rALL7RzUx0iOKEZg1EozSuFFkxVUb7rlfCasI6j4BLwQEkdtB+xjn3tegZRg
         Zi8Q==
X-Gm-Message-State: ANhLgQ0TYOnMpTMf53nfug56N8+2fryLmancNS5hmnNhy7UJi6n+6/6P
        gLwRA7hqfD+Etg30jgSsEbmTVQQ=
X-Google-Smtp-Source: ADFU+vsOLiOFN9ulRKpD6cuBbP+kcy4+3ReuiL4dSROeIWdMiRVn2TguKliq7tXm2P4zrNABYne43g==
X-Received: by 2002:a9d:76d6:: with SMTP id p22mr14881833otl.37.1583787928705;
        Mon, 09 Mar 2020 14:05:28 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s12sm3486510oic.31.2020.03.09.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:05:28 -0700 (PDT)
Received: (nullmailer pid 7378 invoked by uid 1000);
        Mon, 09 Mar 2020 21:05:27 -0000
Date:   Mon, 9 Mar 2020 16:05:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org, baylibre-upstreaming@groups.io,
        Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: Document shiji vendor-prefix
Message-ID: <20200309210527.GA7275@bogus>
References: <1583502010-16210-1-git-send-email-nbelin@baylibre.com>
 <1583502010-16210-2-git-send-email-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583502010-16210-2-git-send-email-nbelin@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 14:40:08 +0100, Nicolas Belin wrote:
> Shenzhen Shiji Lighting Co.,Ltd is a LED manufacturer.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
