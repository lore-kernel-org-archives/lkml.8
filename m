Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80BDC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADAC20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589225285;
	bh=39w9StLGOIwcyTm9UjM1O9IN15ACSYkM1DsvPUsoD/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XpFB99kN9KMjprQDjEFKkqMvae4qtljG1DTM00BzmsgQ2c5dlRfudgnPqagxVG5DV
	 7FxRXH7CO2IdobPN1HRC1vdCtjol2QPttS6ZdcWbeVB5lo9w5JtWLe5XfCnd8YrQhv
	 910ehjdTW8hcldY7mdNKL7/LuWy940SV3ySG59pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgEKT2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:28:05 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42238 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgEKT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:28:04 -0400
Received: by mail-oo1-f65.google.com with SMTP id a83so383996oob.9;
        Mon, 11 May 2020 12:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Emf4N/7dlv5y0nf57uZJUU2fdy2hoXmMKpVjXqXIJnw=;
        b=PaoxMhLZ6A+CwO41EyxPlZquzVLoeujqodWX6an5ILlza+iFxAv8pyLlK9g9T3S3df
         kqRVSutiIPmVlElaqaoH3SfmjkPcErSsMZw/bRceRRsWrAFyWWoTqKuahQXZTByCzvbP
         k04o35T3wtNp9mKNtBj25N6yD971tqY0a0qfNJlDECD1k9XahxFTB7m431tNR2b+QDTO
         41/U5KdMiWWRer6i59KmJ/gZOa1zEJn+rp9KbN+XRmEdFEYwBrGdbCEYCrbyhqWvf+mm
         M47JByf5BGSrrOvMi+FaGHK++3PCyzjSVyXs/le38PgfGuSnqE8YparKWI+DA9iB+txN
         qWMg==
X-Gm-Message-State: AGi0PuZIR7hqdPob/yIs+//D47WxTs0InjN8eYjyaAuElCv1NO7sJ1pN
        jE2bo8CP6YD/nR3Y2oQmUA==
X-Google-Smtp-Source: APiQypLpZUlZA09Gp153soJvjjPccTy0M0+x7Bh2/sf1+5RWavVxkFH7hU+ErykOaetTP/Uu0yMDeg==
X-Received: by 2002:a4a:254f:: with SMTP id v15mr6119240ooe.17.1589225282244;
        Mon, 11 May 2020 12:28:02 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm2885440otb.14.2020.05.11.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:28:01 -0700 (PDT)
Received: (nullmailer pid 14321 invoked by uid 1000);
        Mon, 11 May 2020 19:28:00 -0000
Date:   Mon, 11 May 2020 14:28:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200511192800.GA28762@bogus>
References: <20200422222242.241699-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422222242.241699-1-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:22:39PM -0700, Prashant Malani wrote:
> Add properties for mode, orientation and USB data role switches for
> Type C connectors. When available, these will allow the Type C connector
> class port driver to configure the various switches according to USB PD
> information (like orientation, alt mode etc.) provided by the Chrome OS
> EC controller.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> index 6d7396ab8bee..b5814640aa32 100644
> --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -21,7 +21,21 @@ properties:
>      const: google,cros-ec-typec
>  
>    connector:
> -    $ref: /schemas/connector/usb-connector.yaml#
> +    allOf:
> +      - $ref: /schemas/connector/usb-connector.yaml#
> +      - type: object
> +        properties:

These don't seem CrOS EC specific, so why document them as such. 

> +          mode-switch:
> +            description: Reference to a DT node for the USB Type C Multiplexer
> +              controlling the data lines routing for this connector.

This is for alternate mode muxing I presume.

We already have a mux-control binding. Why not use that here?

> +
> +          orientation-switch:
> +            description: Reference to a DT node for the USB Type C orientation
> +              switch for this connector.

What's in this node?

> +
> +          usb-role-switch:
> +            description: Reference to a DT node for the USB Data role switch
> +              for this connector.
>  
>  required:
>    - compatible
> @@ -49,6 +63,17 @@ examples:
>              data-role = "dual";
>              try-power-role = "source";
>            };
> +
> +          connector@1 {
> +            compatible = "usb-c-connector";
> +            reg = <1>;
> +            power-role = "dual";
> +            data-role = "host";
> +            try-power-role = "source";
> +            mode-switch = <&typec_mux>;
> +            orientation-switch = <&typec_orientation_switch>;
> +            usb-role-switch = <&typec_mux>;
> +          };
>          };
>        };
>      };
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
