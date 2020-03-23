Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A4C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0DC20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584997103;
	bh=YzFKqAW18kcyBPYNa+Mi74HhTlZt9nq9qtFITbr48l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SJ/9Owtu4+TJCK4GZxgoXkr7MxwJ+b4UEVSUhtCQRoVdS6e2mJS5oaBBdidVTZ0L3
	 lQELBbcJV0vmicDIYsqTh85OClrHqyuEJEpV9zFu3HcOeo7sZxnfttD4KwxeGSlijm
	 kUdVe7UJpuXrXsUiYT8UP3VMzIZa9dKi5vUYr4xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCWU6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:58:22 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38943 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:58:22 -0400
Received: by mail-il1-f196.google.com with SMTP id r5so10015113ilq.6;
        Mon, 23 Mar 2020 13:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlBqVshcJPxQVuQZKzaVyY+4ObPbmf5CmXPctViUTSE=;
        b=WplALiOvUZNwQ69Xp9DCXZ8zoDSnyE7ETRh/Q0gYIfcUDbtz9KVyR8Rrnji0595efG
         hA6T3lTFuBHKiIisEjmS0ImQuZT6G+CNh8ex9LoQQ6vw0CQ0CM3kQYuc/xjzphwjsGY8
         N63P8fcJ0QCJVoYMkmGPPTVnH/TfhtFWnu4OteHexlkzjcjF22Rg9pqA3uarNWtgwt4X
         yHXlyqei1IUHrItXaMpewBQzoy9MQelUaEZD4qDzllIuNR6JLc5gp0zVqAfV6tyky04j
         59VQs767pbOJUa5Yp7xMASJug5K/PWf1jzeGXiVUFayjWssVMqO5nyHKJvyvnxSbSqxn
         EyfA==
X-Gm-Message-State: ANhLgQ3P/kEXdapP+JhNTjJMMeht3chxAtGJDZxpib00gsbiy3qGKMX7
        qmqSGgNjrInnOu/sxw+cQtxhqWQ=
X-Google-Smtp-Source: ADFU+vtpd8t+seu1ncd3myJFMaylxTkV3gHt8oUH4O/0Gkw2WArM5e3KWC5pnV6pBvgwCpBWGApqYQ==
X-Received: by 2002:a92:5d52:: with SMTP id r79mr22588070ilb.212.1584997101486;
        Mon, 23 Mar 2020 13:58:21 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f80sm5665047ild.25.2020.03.23.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:58:20 -0700 (PDT)
Received: (nullmailer pid 9548 invoked by uid 1000);
        Mon, 23 Mar 2020 20:58:20 -0000
Date:   Mon, 23 Mar 2020 14:58:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 1/4] dt-bindings: Add vendor prefix for Dell Inc.
Message-ID: <20200323205820.GA9506@bogus>
References: <20200309203818.31266-1-lkundrak@v3.sk>
 <20200309203818.31266-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309203818.31266-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Mar 2020 21:38:15 +0100, Lubomir Rintel wrote:
> 
> Dell makes computers and perhaps other stuff. Their web site is
> http://www.dell.com/.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
