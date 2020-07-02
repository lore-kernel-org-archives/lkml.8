Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228FA214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593723572;
	bh=F+icNwfudWA1OerjPnjWmJ643/+ey1RYxY1WkccFGkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rOovC+BMEsN/H6SH9aS6xZWCPGNPbj+DHoUhIzlNv4W+HVtxZCE9ZZ8ScbRcwrpci
	 bzYNXvBigJatRfADRvXZ1whgpIBYYzksPkNb2JX72rjnZsbnfVRhOTKkTKC5UDq13I
	 x4tAiGK1ocnXaoPWCKNLhQ+gO6yRA5cTbWlT8bQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGBU7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:59:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45814 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBU7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:59:30 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so25463240iof.12;
        Thu, 02 Jul 2020 13:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWh12p1uyx+JGoipYKy+eFEJ5+xYo0IWKZZyDwR3/jU=;
        b=MvpIEn3+5oegGpffGcmY1JrAmqd+5PhItQzrwFT4xuYjE7RF6m5qJ8lP3YAorGM+7e
         mQkLyz7F61iwp3mdoSS1bvpzB29iMIepln33AQvIP5apvX3NMnffvDmdHgJOcx55nr0y
         BbJ8CVP95VA8tBJy/KNWhUfk9jbs0E5hHFcQNO1q0tAbjGgF9d7kgMbhHQYE1B0Pfwz2
         l3GKfH2XfBK8kh3zjeFGIF2G8u+05VpyVybtB40K6JGyCaZFqEOJR9VR0uTt5YC4FHVV
         truyQyYee0wn/ZyK/Cm7LGE03r9e2HfVYaAqoks6qWaJRsTQTP2g5yojapUy2dLk9C7R
         dDoA==
X-Gm-Message-State: AOAM531O8aJZC1NzkNfiupXINVhQmCSxFZVnGHvUB5V4yJC0HzD2kIcc
        hIVmjxgR5V1uVaIZdkJflQ==
X-Google-Smtp-Source: ABdhPJyulA8LL1QbqiDvSsJBqonjQ+idosnogEfhSynfF4cdUihGSGOnlp0Wku7DKYYhkVhmljkbOw==
X-Received: by 2002:a6b:2b17:: with SMTP id r23mr9460012ior.36.1593723569370;
        Thu, 02 Jul 2020 13:59:29 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z78sm5821572ilk.72.2020.07.02.13.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:59:28 -0700 (PDT)
Received: (nullmailer pid 1684187 invoked by uid 1000);
        Thu, 02 Jul 2020 20:59:27 -0000
Date:   Thu, 2 Jul 2020 14:59:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     robh+dt@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hverkuil@xs4all.nl,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: media: csi2dc: add bindings for
 microchip csi2dc
Message-ID: <20200702205927.GA1683781@bogus>
References: <20200702132359.122844-1-eugen.hristev@microchip.com>
 <20200702132359.122844-2-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702132359.122844-2-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 16:23:56 +0300, Eugen Hristev wrote:
> Add bindings documentation for microchip CSI2 Demultiplexer controller.
> 
> CSI2DC is a demultiplexer from Synopsys IDI interface specification to
> parallel interface connection or direct memory access.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../bindings/media/microchip,csi2dc.yaml      | 186 ++++++++++++++++++
>  1 file changed, 186 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/microchip,csi2dc.example.dt.yaml: csi2dc@e1404000: clock-names:1: 'scck' was expected
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/microchip,csi2dc.example.dt.yaml: csi2dc@e1404000: port@0:endpoint: 'reg' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/microchip,csi2dc.example.dt.yaml: csi2dc@e1404000: 'ports' is a required property


See https://patchwork.ozlabs.org/patch/1321426

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

