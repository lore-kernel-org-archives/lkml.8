Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB87C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7BC22B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596230289;
	bh=yO2aq83Ay8qjDrLoaG8lpE5C81kE8QUbpm/Ey7TkHkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xe+EoalNKOj/vZCfo0QPvbVQ18HBqDchYPsXm9n6nhQ/8RlAfqP73EBxqHBc9A5t8
	 /paa3wpUn6Np56Z3O6e+r2/Ra9Eiz/Txqui43Y19QfPB9NOqt5bttpGAo+iXRlZdsh
	 UazeRsT2+BpsGO23bP21Slle0SdNWcLIflczVsXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgGaVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:18:07 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46371 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgGaVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:18:06 -0400
Received: by mail-il1-f196.google.com with SMTP id l17so16274609ilq.13;
        Fri, 31 Jul 2020 14:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9zt1WWOJv6KHzl6qN7CaUN/fc2umfOL3d6uDteZs6jA=;
        b=BnH3RciWDbbtw3XbD449fBTOsKXi12HK3YKsMa8RMuhbdfL32hGJ2CRreJ9J+qA+ID
         Dqqp1pxAN2OCAJbNe2jjRQ3VeEo8Zt6Ucysn8P26vzuhOg8WfIs6UkdHpfTxkYhMblej
         uAFFmi6MAr286oD9DRkoR24GZgLLh0BDxskWIVIGKY16Ii6t+SdEyY3/wQDP/PlRWOaM
         dQyHni+wMuBRWjLZNz5x2uNuIM+dwIhw2MYOZzJPo39TVnUYUiVbWVYxfls+YArtG8AB
         +3S13kqtzlInxXyBPv/4MJ977w3gscOdMqOwjKHqmqM7o68ONJa0+KdC+gdaM1B3zaqf
         isHQ==
X-Gm-Message-State: AOAM532ZRGqkTTAbOqXtcZST1gqBkY6vRkMKMym4O97cGxnCh4MnkgRm
        33UTILBVduKNBAGMsIId8g==
X-Google-Smtp-Source: ABdhPJynQI9WqRNzaRsItOcQhHNxDoIigLcg9RLOG/NXO4xp7VTDdej2dtZw0aY7JbU0EVCQWYuM2g==
X-Received: by 2002:a92:494e:: with SMTP id w75mr5744907ila.115.1596230286048;
        Fri, 31 Jul 2020 14:18:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c15sm5617312ill.19.2020.07.31.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:18:05 -0700 (PDT)
Received: (nullmailer pid 808330 invoked by uid 1000);
        Fri, 31 Jul 2020 21:18:03 -0000
Date:   Fri, 31 Jul 2020 15:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: regulator: mp886x: support
 mps,switch-frequency
Message-ID: <20200731211803.GA806331@bogus>
References: <20200729130839.10a9bf88@xhacker>
 <20200729130952.260671f1@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729130952.260671f1@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:09:52PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> Both MP8867 and MP8869 support different switch frequency.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/regulator/mp886x.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
> index 551867829459..e747000cebba 100644
> --- a/Documentation/devicetree/bindings/regulator/mp886x.txt
> +++ b/Documentation/devicetree/bindings/regulator/mp886x.txt
> @@ -9,6 +9,10 @@ Required properties:
>  - mps,fb-voltage-divider: An array of two integers containing the resistor
>    values R1 and R2 of the feedback voltage divider in kilo ohms.
>  
> +Optional properties:
> +- mps,switch-frequency: The valid switch frequency in Hertz. Available values

mps,switch-frequency-hz

> +  are: 500000, 750000, 1000000, 1250000, 1500000
> +
>  Any property defined as part of the core regulator binding, defined in
>  ./regulator.txt, can also be used.
>  
> -- 
> 2.28.0.rc1
> 
> 
