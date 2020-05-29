Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E80C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284242073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590775079;
	bh=hGdk9s1sUvJjY8Tz33XnTeNOmJ9slQAHaCsxvkgoK7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fIncm4q+IH5CsuhW4uv4C9tWTMdZap6H4L1BgrBz3V3wqAtlKLyj/qoxnN9/7xAI2
	 eYIpp9D3kh2oxkOlVYqTXSV11+EvfqSDd74cM9Imwm3oZ1XEyt/boaF0DF0TiqfjQZ
	 1tIq5KgGe/DdFHhqFbwbNo0/8To2R7sEqHwDMRmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgE2R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:57:58 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35071 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgE2R55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:57:57 -0400
Received: by mail-il1-f196.google.com with SMTP id a14so3387964ilk.2;
        Fri, 29 May 2020 10:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5SWEyKvy3hlD2S0HhW+lYLy/sY6NSfmSqTpr4tfy0A=;
        b=euKd+8UMD8rk5O3aKdmwRo0Ff237N7UMo1ScWzDLHoX02wK/BeqVdT0uibE+rhr06t
         xIMtfiunv3d3SAcLMIJsGbTNYpNB82BV0aEcwwfliaS9myUKhU/q3jZuOndHrqSHn3Ob
         WjFOoAfGT9wsuY/wHDNh7QVFsHeT8nCtrU6Ikmt8slOQu7TpPK7O9ogM1F0G6nif9giP
         Cc/ur2aZzeYf+YjBQl6jc06PhwgzuY4Mh0NnsyU7fsYOKgMpsIiIPJV1+B0nQ/yqTVHy
         l0gxwZmLEMq7Eh5dvXD0+ahv3hUOzfFScgJeACZ1iIgGicuckeFTKzQhzWl1Bzs3ar/Z
         IycQ==
X-Gm-Message-State: AOAM533nbDE4ewwUwNtC0txKNKtTx5eC5HOd39mmJ12KDlBnLhCasijT
        zAVK1uuybYt7ZFVOhN8X9g==
X-Google-Smtp-Source: ABdhPJygi0sVuWZ9Le5zbYia1v0LkPlhm34SxMQAYaBP97jNr9eCJbdl3o1BaFuKXQZEezmuvo5Piw==
X-Received: by 2002:a05:6e02:6cf:: with SMTP id p15mr8849933ils.146.1590775076236;
        Fri, 29 May 2020 10:57:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v17sm2781169iln.67.2020.05.29.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:57:55 -0700 (PDT)
Received: (nullmailer pid 2658794 invoked by uid 1000);
        Fri, 29 May 2020 17:57:54 -0000
Date:   Fri, 29 May 2020 11:57:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     robh+dt@kernel.org, rojay@codeaurora.org,
        linux-kernel@vger.kernel.org, msavaliy@codeaurora.org,
        mgautam@codeaurora.org, skakit@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V7 3/3] dt-bindings: serial: Add binding for UART pin swap
Message-ID: <20200529175754.GA2658718@bogus>
References: <1590560864-27037-1-git-send-email-akashast@codeaurora.org>
 <1590560864-27037-4-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590560864-27037-4-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 11:57:44 +0530, Akash Asthana wrote:
> Add documentation to support RX-TX & CTS-RTS GPIO pin swap in HW.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V7:
>  - As per Rob's comment, added type: boolean to properties.
> 
>  Documentation/devicetree/bindings/serial/serial.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Applied, thanks!
