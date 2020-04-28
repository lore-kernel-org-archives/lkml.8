Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80458C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F3820757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588095995;
	bh=j3bTtoIIUPj7NXfVVVlBiiQhi4vbnqLz0OFAIRrsoeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O3M2GhjbOyrZKpF3Ok2r9AtcwN6n1DfMA/kqXULs6Hsfi4JrA2dMGhCXg13itDSSR
	 8GTEyVKHBKUnaQeEsOQfm9wvKLkUCie03hyTwjUp1lG0DV6jFZsE0SqOeyyTw7yTYf
	 Q6C/TUui6WuORv1OBCY0J9l8aKoDkxbxtk3cfQog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgD1Rqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:46:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33977 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgD1Rqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:46:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so34157988otu.1;
        Tue, 28 Apr 2020 10:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WcS7Mhffi/ZvcyLI4LRv8y4jUCf0d6xnP7vZtTWf5c=;
        b=PliWV0gHbhdcoDAy598Ar8iEt3MRb0ZTN00uLhqGTfjG7eps13uxqdOgQ1EUHCUpee
         jAKJNl2wI8tUxmGe2e+n/4JJuLP0L/kB0HioOcMXZZWWB6p+74pOOGkp+6f6Vn5DHemZ
         dfOqNDfRZF8RTH8q5ztCfZxIG08MobvkWDozbfdJPt09dTHxB17S5jfZq5tVzGJ/hNyY
         BUQDk6irLVdQ/L0S92/46fJDHCjtGp6q/z2rmW9VrwMLtbGIvW9T9CzpC49bC0R2wvw4
         Quwbuo1481szp87JRJv5WbKtX5HJcy4owkVJLmJS9iPOkWrnA3jZds16Y0c9jVbJ7K/O
         luow==
X-Gm-Message-State: AGi0PuYEiOxza7aeMCtioTgI/J+rIUKWF9dznhHQgNpgic9CnlMr2+UK
        1MZ1DZ2ep0xo07cQrk5Urw==
X-Google-Smtp-Source: APiQypIzPDUJS/tGE1UCLLtRvxgOZxpHzXWWQYtSEyKLdPJwzs/JDuLjnOnJIRTrv0BdtQGwZ6EQ0Q==
X-Received: by 2002:a05:6830:1149:: with SMTP id x9mr10207955otq.332.1588095992006;
        Tue, 28 Apr 2020 10:46:32 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q15sm4959468otk.78.2020.04.28.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:46:30 -0700 (PDT)
Received: (nullmailer pid 4835 invoked by uid 1000);
        Tue, 28 Apr 2020 17:46:30 -0000
Date:   Tue, 28 Apr 2020 12:46:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     saravanak@google.com, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3 2/2] of: property: Do not link to disabled devices
Message-ID: <20200428174630.GA4698@bogus>
References: <20200420120101.31405-1-nsaenzjulienne@suse.de>
 <20200420120101.31405-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420120101.31405-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 14:01:02 +0200, Nicolas Saenz Julienne wrote:
> When creating a consumer/supplier relationship between two devices,
> make sure the supplier node is actually active. Otherwise this will
> create a link relationship that will never be fulfilled. This, in the
> worst case scenario, will hang the system during boot.
> 
> Note that, in practice, the fact that a device-tree represented
> consumer/supplier relationship isn't fulfilled will not prevent devices
> from successfully probing.
> 
> Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT bindings")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v2:
>  - Correct code comment
>  - Use already available return handling code
> 
> Changes since v1:
>  - Move availability check into the compatible search code and stop if
>    node disabled
> 
>  drivers/of/property.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Rob
