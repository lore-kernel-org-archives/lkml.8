Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5FC433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B75A2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594926806;
	bh=X1aR/huNEfYLCRr8+3522sI2xD/ke+fRwnZPt7eYnvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0e0FvgCk6+yzatRdn7ymOA+OHUNEo74BkmlPfIMorY7wWZm6ATi2IgX4BkTgTkvl9
	 wRbu3IwUd57944urmVEMj4QPKVM2QQmkHkw33kQhoBZ5VwyFpDNWBVEwf2LF8yD1Pr
	 OsnjwlFSNQbw3CCbOMG41luwgmy79WV2xiGcUSUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgGPTNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:13:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35927 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgGPTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:13:21 -0400
Received: by mail-io1-f68.google.com with SMTP id y2so7227482ioy.3;
        Thu, 16 Jul 2020 12:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIttOoTOPqMFdqazs8PahDWs8uAzKu3fQLp00yEZzEs=;
        b=TbVAODPO+rMbA9zuoD6Z50MZax9GeDZrdAgkp4ldskfYF8MzHxQyeuv8DAIdgXsLsw
         mdTkscg0WEm5r3D6c4zaHjMcAPwa5Ok74eEnl3gbjb5VBNFMs1p4A/9cnXmVM15elc1N
         pBb2Rne6Hw0ffP7AYR5hV1mAcdRvT9vGtnetL11obUkq4bHzub/oh3JNztr8DVcbdj5E
         wOLQ1WQjoftFpY/peFh5C55qkhKR0dTOIxJ7COF6aPtIhzIJ1ZMwPPOVKrD86xgJDlsr
         lcLwEZkWBv4Uh1FGUIQg3OB8EZxyUv8Q6x0qRP9FY9hPdrTczQ/rW2LAlLxq0sp3W149
         t+TQ==
X-Gm-Message-State: AOAM532+3e17TfSy6YHZ8/ymHyqPtsL5944MTfYMBQ4OGlUbgYebYhyq
        MMlMf1zAk27KzKvtYkLzKQ==
X-Google-Smtp-Source: ABdhPJxDve+bGac++TOwwv477fCT+JMtLC0r9pSjhKoL4JqwZLLbzbzYgXnmngm9qddR1vgcFbbpQg==
X-Received: by 2002:a02:8308:: with SMTP id v8mr6689601jag.101.1594926800526;
        Thu, 16 Jul 2020 12:13:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p9sm3201232ilc.78.2020.07.16.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:13:19 -0700 (PDT)
Received: (nullmailer pid 2685058 invoked by uid 1000);
        Thu, 16 Jul 2020 19:13:18 -0000
Date:   Thu, 16 Jul 2020 13:13:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Message-ID: <20200716191318.GA2683551@bogus>
References: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:16:04PM -0700, Bhanu Prakash Maiya wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt

Need to update this.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> ---
> 
> Changes in v3:
> - Rebased changes on google,cros-ec.yaml
> 
> Changes in v2:
> - No change
> 
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
