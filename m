Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60D4C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088620675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610770;
	bh=82hq3oktJ2xinxvbnDhl3KeAe3G3GC8YranS2WTpJrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vR/a7B3tADBW1JKIWOW2qJCcKiWWFFgB+D6TZQ96aQsJ8iID3Uf4Of7FYqnU0So0V
	 zXREi1GVQX8JOAVdL5xX4J8avhTO6DwLGRrZ8UmotwOjdKLAlsBMbo7j1LebWvU/Tf
	 ZHcerhdIOhrJ9VUgKiQ5XgicKnZFhNzfzsmljSj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgC3X0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:26:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35830 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3X0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:26:09 -0400
Received: by mail-io1-f68.google.com with SMTP id o3so14188880ioh.2;
        Mon, 30 Mar 2020 16:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y63T0wbyLEmYwE9gAEI8Zr/6EzaOspBnb441laqbZEg=;
        b=AJeJ6I/C8UpfLNxpf4KUPBVDIgG7uE0rFrDQpEzsxjWYePWMPe8hk2r14jw0mF8OBs
         QR5g8nZ6HjGr5MJGwfZyUHBa9zhE8qRRtWbGrXCyGSzqAlpRimkKjb8BZKoXsykJLkUR
         GFckSDtV8G/SJQHZ2aTw+yUlDDLhx4kQmg+KpTa4QMOZK/kYzGksRs7IveWWTGeiPJTB
         hnW8v19wTX9moPDnfeiCSur0knc+zsiBxKBN/Kc/7cE4P+UnP97hJqYWweICQiSY7AkH
         XnmVJx8MUa///n8MeqmebLdFOcrGH6veVkeHbKl52BVB31XUgAwyn9tueXeI29cx1w9v
         NGqw==
X-Gm-Message-State: ANhLgQ2/gPyWysf7HtEh5Mqj2QQGT/LF7r8odq/OKKt49XYTORg6AawZ
        XIkjpZO9kqyMO3C8S/HFx4y4Dc4=
X-Google-Smtp-Source: ADFU+vsym9bSX5N8kLEnjs2h8aexWHp7cTlvBkEIiGLT5gJ0zfPAzGevnq6xwHKXhFL2KDACD/7Tbg==
X-Received: by 2002:a02:3842:: with SMTP id v2mr13498145jae.9.1585610768816;
        Mon, 30 Mar 2020 16:26:08 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y6sm5293221ilc.41.2020.03.30.16.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:26:08 -0700 (PDT)
Received: (nullmailer pid 24877 invoked by uid 1000);
        Mon, 30 Mar 2020 23:26:07 -0000
Date:   Mon, 30 Mar 2020 17:26:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: Re: [PATCH v2 3/5] dt-bindings: vendor-prefixes: Add Topwise
Message-ID: <20200330232607.GA24820@bogus>
References: <20200320112205.7100-1-dev@pascalroeleven.nl>
 <20200320112205.7100-4-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320112205.7100-4-dev@pascalroeleven.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 12:21:34 +0100, Pascal Roeleven wrote:
> Topwise Communication Co,. Ltd. is a company based in Shenzhen. They
> manufacture all kind of products but seem to be focusing on POS nowadays.
> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
