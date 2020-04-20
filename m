Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58663C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B8206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587415831;
	bh=BzshPTf9Vnsvevv2ehjHFKKHzOodt02pGxXB6dN7W3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dQDln5Jo2eBLIuyB7iC/LovH1LFTdHed5G8ll3xawfzDV6lCAb+JSUK3v3UXCyc1p
	 gcNxaG5RZvrcAqku3jwxPw9rYrDHXB9O/rdLuYNCUTxL0v40gKcFxcmurYn+h1vU8x
	 RddOonNeXmcF4iweIFg0gpSoFxyc6syY1SGP03wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgDTUua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:50:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39393 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:50:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id 8so10092883oiy.6;
        Mon, 20 Apr 2020 13:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=16FdVz3ITgqDjrOoSIkC294zmw/OenEAYTOhX7zYSIE=;
        b=k2gn5tyEomzdbIk7/DgP1rWv5lhdakmYFQ7hfEwBMRXvvPc3ASBNtW57RcyouHqwwU
         pMj27tIkRizXsSdU+H/cxID66v5I/a6Hz/96hfySfnT1hHy4m2wy2vFLnydNpMy7D3Ak
         QMHQPEAwYKG5W5bdcVtpvHtenW8q5jIUAQQrG9NjM1EYbLF82P2AWF3IHheyiLc+1vNr
         yunj90f9Kv/VI9x/a2YYwxTlGuSKo5nPQ3iytmjD11+rkYuotRUE6r0peTBRWPKAzybH
         BmgK13QCAfaSXB0Tv5IrThHcRbR50gwS8X4wyWt3shttlvEsI2E6O8RbpjKsxIeZFHPY
         YjcA==
X-Gm-Message-State: AGi0PuYq0FuiEOii4EqKoQsbeGoVWj5CFEA3e2fhFwOeJZovMUP7Vlpl
        2+kI1XNJjn0IOZ+SHKeAHYeFrM0=
X-Google-Smtp-Source: APiQypJFaeZEeMs4FtaOugyToTSTEWk5RpbXAVgTwIHK1j3/5ttMAiknvkNdToyEQUG7YDPu3Ev9kw==
X-Received: by 2002:aca:682:: with SMTP id 124mr947033oig.69.1587415829210;
        Mon, 20 Apr 2020 13:50:29 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s69sm205374otb.4.2020.04.20.13.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:50:28 -0700 (PDT)
Received: (nullmailer pid 6716 invoked by uid 1000);
        Mon, 20 Apr 2020 20:50:27 -0000
Date:   Mon, 20 Apr 2020 15:50:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>, od@zcrc.me,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 05/13] dt-bindings: MIPS: Require SoC compatible string
 after board string
Message-ID: <20200420205027.GA6613@bogus>
References: <20200413152633.198301-1-paul@crapouillou.net>
 <20200413152633.198301-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413152633.198301-5-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 17:26:25 +0200, Paul Cercueil wrote:
> All devicetree board files list a compatible string for the SoC after
> the compatible string of the board.
> 
> Enhance the YAML format so that these SoC compatible strings appear
> aside each supported Ingenic board.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/mips/ingenic/devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks.

Rob
