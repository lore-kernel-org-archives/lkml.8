Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92342C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AA02067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584027921;
	bh=4fVGaIU71xTNpLdmugzDT40zURtQ9MqF2B6hG903oWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FdR1u+EyYRqaxJZs4NVwJChr6ZTymJ949FfaZUIilR76Kmdy86dTDiwy3xIALD/tG
	 VMRglqXgoLjZVcDu28zi2MXPr+zzTUVs/cD7xc0UscBYr4evBC2jDjcc06kL8h70rU
	 uzF4dM/YFEjwhaWpNhP8YjB0ZQnFWiKBxhHh6U5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgCLPpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:45:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43842 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgCLPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:45:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so6699596otb.10;
        Thu, 12 Mar 2020 08:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omZBFYa2QsjHQtBNswRRHIFur2RG8M6Zjr+ms/JBsZg=;
        b=QXUuHuUYBoA/8e9b1gHRmgszsKnxmH2vFEXgNXtXgXGVxUkEJjrU2McG7XcDfygCCj
         1LQODehBr+L4Ie+4vG+L34Z5lb/eGHbVDwz17fIlPW1D5UdINhCcAVzfhQPSyEwwLmyL
         ikDBPL1dnvudoAkbT/SQEuboKB008Mt8BZ7kxv6cQ0hqkTrr2ss7IjGMjgE20xoGT7aZ
         Ja5YolFfNCGMS6TgMVtkTU0kCCzq6tj9rZC9Cg+MY8cEA8CNyTquvcTYmVhcg0t0TtXc
         tuCWQeV2jJ1ExHSp3+z/EOtH0Ox27gzpSAjKBmrmKrR4mXyIQsI4tR0IG4rlTDHCMOGl
         vlDw==
X-Gm-Message-State: ANhLgQ1nLmG6ocaZPpAIT2P/RpTE4cgR5RZ6DS6daUF7qKi2QAHrrwvX
        cBhU2JKPc3WLBpqtlDIxuA==
X-Google-Smtp-Source: ADFU+vuRP1xVylZgCCtabXwadQXw7mcqdokmzky4hJinvtfoqJ4Nvw8V3ns+ImZHIsyS57UPZPelDw==
X-Received: by 2002:a9d:18f:: with SMTP id e15mr6454176ote.42.1584027919060;
        Thu, 12 Mar 2020 08:45:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k25sm12639065otl.34.2020.03.12.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:45:18 -0700 (PDT)
Received: (nullmailer pid 17128 invoked by uid 1000);
        Thu, 12 Mar 2020 15:45:17 -0000
Date:   Thu, 12 Mar 2020 10:45:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 2/5] dt-bindings: panel: add binding for Xingbangda
 XBD599 panel
Message-ID: <20200312154517.GB15635@bogus>
References: <20200311163329.221840-1-icenowy@aosc.io>
 <20200311163329.221840-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311163329.221840-3-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 00:33:26 +0800, Icenowy Zheng wrote:
> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel.
> 
> Add its device tree binding.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../display/panel/xingbangda,xbd599.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/xingbangda,xbd599.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/display/panel/xingbangda,xbd599.example.dts:17.1-5 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/display/panel/xingbangda,xbd599.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/display/panel/xingbangda,xbd599.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1253057
Please check and re-submit.
