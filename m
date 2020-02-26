Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A0C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A8424670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582735342;
	bh=AWkMkdkB13qrdJCEohKjXDuZsyeS0xhGi1kAQjhZCEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ipkvrW+mRcka0bUJxWyGZ5GcrPxpxzcLMFaf94+lQgSzFTBqdrkKlDsKz5qqRleoR
	 zW2ZIzK5QN6Sg4ylf6TRReouIqrhAg4HKYBqHawFoqIrgnLq0WSIdwLlWxDmPuzeSa
	 fci9OXBogX91o92AmJ+2YBX4uQJdgeY9QO3bxNN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBZQmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:42:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44946 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:42:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so93467oia.11;
        Wed, 26 Feb 2020 08:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=huY+P9hCQip220Mv8ZYOmfoV11gqLVl0vDpN9hWczCE=;
        b=R8wlhVVOE2B8Q5PLP5ulAcM4aZjHTJi1QMTc25536SjZRDgqx5afa2bQ7TNcEZcwjC
         tiqCbaqjVU9Yq9eNHgGP25PZuUJ67Zp1pfaJ8TA2CJRgnF05IYM8vI8I1aymYOK9jg+D
         //qyLg8Uma6v7SfCrrHpOi/3ABoDq7NUqJHR/mIdmRhgMs7Ocj8PReIVjc4qEZTAz6sf
         OrKPNdcnGcCDIJXyAZUfuNN3VrIKV0egPZEUctxFDk8Sg7aZpKVS0rmyv3KVd7HseyMK
         nq1JiKOfo/UOA5WgwW+hjetZsqA4qT2+qhKE5je6T8RSYq0ksHrcyiSLUJa6hm1YtAP0
         3jOQ==
X-Gm-Message-State: APjAAAVgMLyAGy4NMtsQDFTVlRYBT8wQRSJWU44yj++LnQmQ16kIm/+T
        uscLk7Zve219EmIg0Z+aiA==
X-Google-Smtp-Source: APXvYqzmt8BMRwbDJa40aOhwZ0rVGVudgv3YWV20CWUpQv8ZBX0D2kDhClYSz6/aGbnb0dtkn046rg==
X-Received: by 2002:aca:c646:: with SMTP id w67mr3694200oif.171.1582735338594;
        Wed, 26 Feb 2020 08:42:18 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm970643oic.22.2020.02.26.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:42:17 -0800 (PST)
Received: (nullmailer pid 10602 invoked by uid 1000);
        Wed, 26 Feb 2020 16:42:17 -0000
Date:   Wed, 26 Feb 2020 10:42:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH v2 2/2] of: unittest: annotate warnings triggered by
 unittest
Message-ID: <20200226164217.GA10550@bogus>
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
 <1582224021-12827-3-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582224021-12827-3-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 12:40:21 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Some tests in the devicetree unittests result in printk messages
> from the code being tested.  It can be difficult to determine
> whether the messages are the result of unittest or are potentially
> reporting bugs that should be fixed.  The most recent example of
> a person asking whether to be concerned about these messages is [1].
> 
> Add annotations for all messages triggered by unittests, except
> KERN_DEBUG messages.  (KERN_DEBUG is a special case due to the
> possible interaction of CONFIG_DYNAMIC_DEBUG.)
> 
> The format of the annotations is expected to change when unittests
> are converted to use the kunit infrastructure when the broader
> testing community has an opportunity to discuss the implementation
> of annotations of test triggered messages.
> 
> [1] https://lore.kernel.org/r/6021ac63-b5e0-ed3d-f964-7c6ef579cd68@huawei.com
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> changes since v1:
>   - none
> 
>  drivers/of/unittest.c | 375 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 345 insertions(+), 30 deletions(-)
> 

Applied, thanks.

Rob
