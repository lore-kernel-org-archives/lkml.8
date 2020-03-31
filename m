Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCCEC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845C20838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585690249;
	bh=qEXy05cWIxXScJZALHHXi6eSWZUIP9xyZGDJwREw/SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AthYI9PRyjdUmjHgUx/rWnZ7LcVeIivXWmlGWqzEutu47WPSYdnotjZv7XrL+3XBv
	 C+5GXQV8dI36naWYC8R+vNIV7DuFLP0Li/LA5HTGOic/RqvYVS/A5B42iO4jbGnLyI
	 moyirmApe+snvktdziEtSURmsLuAa7C3eMIdQ1Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgCaVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:30:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33727 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:30:48 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so23390906iof.0;
        Tue, 31 Mar 2020 14:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aiuZold3/szOntpIHNt+cxtF0FuegPX6DhcwFbkv7eE=;
        b=S+2QJlf2vEb9yvAIEPJt4xeNVFzWC8qAJgK4a8cp0Og93E1CMK1aWtHxx3odiYoSw8
         Gy7Cp3HotyyTb21tgl8RyeGZ32AWCsGTpHQPgHbgRj5fLWem6HII2qYD0hayz5qIgO8F
         /a0x6e2cpgetOs+FISt2yCv7DTPoWZXDADcv8z5Yl+iVdNwe5GdVY6qskEf4+mstauE3
         fMx4vUtFzEC5Y/TKFtdwmNHK/VVPJ3lX+kLB3cSeWowTESK6K/ZAhtguI/clcjIi8Pl+
         TtHq5TkF5q8IvjJH04YZrWd4endcTRwiDPz7tQ3k7mnoE9APlaupQ+FzOWEBQW0I9N8h
         rQDQ==
X-Gm-Message-State: ANhLgQ1yu8cbzuVYXNEyqH19XtB6PxEAkRLWeL2VTIYgUyH3QhBT8t+P
        btdkzvZL3a5OFh3+JszVXw==
X-Google-Smtp-Source: ADFU+vuFyLeWV7L4V9baWHFqPFA5aoKrnkKsgccAwz1uR8hUkn4KXEkWgkr5NwyCG1JL2b06eyzmEw==
X-Received: by 2002:a6b:c9d2:: with SMTP id z201mr17573545iof.169.1585690247505;
        Tue, 31 Mar 2020 14:30:47 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z15sm30393ilf.0.2020.03.31.14.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:30:47 -0700 (PDT)
Received: (nullmailer pid 1921 invoked by uid 1000);
        Tue, 31 Mar 2020 21:30:45 -0000
Date:   Tue, 31 Mar 2020 15:30:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: display: rockchip-vop: add
 additional properties
Message-ID: <20200331213044.GA1829@bogus>
References: <20200325103828.5422-1-jbx6244@gmail.com>
 <20200325103828.5422-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325103828.5422-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 11:38:28 +0100, Johan Jonker wrote:
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like 'assigned-clocks' and
> 'assigned-clock-rates' for rk3399 and 'power-domains' for most
> Rockchip Socs in 'vop' nodes, so add them to 'rockchip-vop.yaml'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/display/rockchip/rockchip-vop.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
