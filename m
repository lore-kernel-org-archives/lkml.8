Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E794C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2572088E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aW00ncwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgFZVrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:47:10 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86577C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:47:10 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s18so6269765vsi.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsR9lAG+ZKuy6S8tfE5+62W+cUzuqeg+ojLakVbeNYo=;
        b=aW00ncwVrcFV+2yTbdUmjoHXoVq4ATu+p9+xi+f1wlmnSA3NL8Ks8YkMfmRkVBWGLZ
         02PcNswuAkpSMd44gS8TChs3zBAVbgAFB6uEGkbIUu3+G5AAlccy/7OvRLdg8NSfD9N3
         sC4WFjH+XU40hw38qYpX+hFt0NnxA4nNWRHYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsR9lAG+ZKuy6S8tfE5+62W+cUzuqeg+ojLakVbeNYo=;
        b=Nn4fhemrBTN/hBEAJmPHSn7n9nAxbAUgvkBQMxDVbZ0FEa5Ej6nBreqHJrhR3WFjJc
         DZQxpOi717voE2Y1IJIr6j0TCXXjc6jVlU5umuhehLtuMBy1DYCOGFO4Ais3twIUFFsy
         iUCM75JM61O0jZDxqhcixgltL+YldfCxycVQ6JTvgaqQG9XaQVEgTpS0U40ga6Invf22
         j2fWVdrLo2pbq7oTOPLWV+Dw3PvTYHaN47O9BsJQMw0q7VHVZGnYzwCXlznNfBJGKxWF
         nj23mIEKBRUW8wEK9KE2FKvwsrQFm/N8XUIiy55OznT+y8LcaNGnJyntFZQJF2fMRCWd
         mR/g==
X-Gm-Message-State: AOAM5301KzI8vdUvJ8HRDSxGzrI2gQyEmsFPNmt9Y3w5R46itBNW8HRo
        NDs9vMMM5XDkU/LKYAWUYWFhqQGU5hk=
X-Google-Smtp-Source: ABdhPJzBi9K3658jQkLIG708+PlYcDlsxk+7jrtOLRo3VdarJdUsCH6ElXyUNhOVxrEaeYpNMQ4DOg==
X-Received: by 2002:a67:e9d9:: with SMTP id q25mr4274345vso.53.1593208029435;
        Fri, 26 Jun 2020 14:47:09 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id k23sm3255869vkn.24.2020.06.26.14.47.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:47:08 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id b13so3506833uav.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:47:08 -0700 (PDT)
X-Received: by 2002:ab0:29c1:: with SMTP id i1mr4041837uaq.120.1593208028348;
 Fri, 26 Jun 2020 14:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org> <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 14:46:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+v1TpZQPBZNV_Azt8J=0ZJw+XGJhLbnBxaZJGCCPwVg@mail.gmail.com>
Message-ID: <CAD=FV=X+v1TpZQPBZNV_Azt8J=0ZJw+XGJhLbnBxaZJGCCPwVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt: bindings: Add new regulator as optional property
 for WCN3990
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add an additional regulator supply as an optional
> property for WCN3990.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Overall though: aren't you missing a whole lot of CCs?  Have you tried
using get_maintainer?


> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> index 65ee68e..b7188d3 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> @@ -65,7 +65,8 @@ Optional properties:
>                                      the length can vary between hw versions.
>  - <supply-name>-supply: handle to the regulator device tree node
>                            optional "supply-name" are "vdd-0.8-cx-mx",
> -                          "vdd-1.8-xo", "vdd-1.3-rfa" and "vdd-3.3-ch0".
> +                          "vdd-1.8-xo", "vdd-1.3-rfa", "vdd-3.3-ch0"
> +                          and "vdd-3.3-ch1".

nit that could probably be fixed by maintainer when applying: missing
comma at the end of "vdd-3.3-ch0"

I will also note that this file is in dire need of being converted to
yaml.  Pretty soon I think people are going to start disallowing
changes to the bindings that haven't been converted to yaml so you
probably want to get a jump start on it so future patches aren't
stalled.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
