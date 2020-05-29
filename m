Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ADDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93D0208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RfvfsSBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgE2T26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgE2T25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:28:57 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF6C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:28:57 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb16so1625516qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUPYQ00DC7rLfUUH3JDdCSp5GxeLlc9fJl+uaK0OPX4=;
        b=RfvfsSBALcYZ0d8tPv24jfR4X6Co2E9cs1V4RP9DtRLRpjXo0sDiD0kSlb/W54ZkKi
         JmLGrhhXYBaTbg07Osd/4G4uptniWI3z6wUYmLhqoD4grEHE3SUPipuMuu6e35Y2yLFG
         cA+vnVcWloaPASoR1eJ9otsbdhxrty87SyjSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUPYQ00DC7rLfUUH3JDdCSp5GxeLlc9fJl+uaK0OPX4=;
        b=SAVGVSnLd7AhH9kShI6rp/ZcEYxF6Yh4uvmgDmjmWIz7rC7eVqeHr2cyQcl2SlQGvR
         /YcdtuIUOvifk3HkBAipWMg/TidlIsRoYe3cPXmjDYzzos1Ny3YwU0Z2BuRkeBfNJ7A2
         O/j1eETumvWyD33DTvb4f4fGsehtuDrJLDHt77l1eKJexKhTR7/Of4lAZLs7Zbfi4yQQ
         mzh0lOUhXc+fQAd8dH8wVPQNGpxYwzDphgQN7WeI+OqLhFdqkYeZWgclW2KfHabHMA5H
         klljRMtKHJ+2TyqZ4zj6wFN/6mEcX6HJ+QjHxzHVid64CeW90nZoST5aD2/zNgbHOpV3
         L+2Q==
X-Gm-Message-State: AOAM5327ravOGuAUimJ2ScOFHNXZoZWbzkaXknn9QJut4ju7Ti1cD4m2
        0//V9ELWuy2ypNyuD9LhX8rQX1M9LM61nObW3r2B2Aza
X-Google-Smtp-Source: ABdhPJxGEsWvHkXVC4qHYX1mdaN4dvQje9KW0A7Iz6PDk8LmuJEe8MjD7kHmcAxLVFFztzfpDlCD2K6MwpT9eCIitJQ=
X-Received: by 2002:a05:6214:a0c:: with SMTP id dw12mr10216031qvb.219.1590780536388;
 Fri, 29 May 2020 12:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200519214604.180036-1-pmalani@chromium.org>
In-Reply-To: <20200519214604.180036-1-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 29 May 2020 12:28:46 -0700
Message-ID: <CACeCKadZGv+j8fg0R3R9A48LDB6nKj1+mj9pO4bV4=LrMvt-hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Would you prefer these switches to be defined in the
usb-connector.yaml bindings file?
If there are no other concerns, I can push a fresh version of the
patch with the properties defined in usb-connector.yaml.

Thanks,

On Tue, May 19, 2020 at 2:46 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Add properties for mode, orientation and USB data role switches for
> Type C connectors. When available, these will allow the Type C connector
> class port driver to configure the various switches according to USB PD
> information (like orientation, alt mode etc.) provided by the Chrome OS
> EC controller.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Acked-by: Benson Leung <bleung@chromium.org>
> ---
>
> Changes in v3:
> - Fixed Acked-by tag typo.
>
> Changes in v2:
> - Added more text to the switch descriptions, explaining their purpose,
>   and relation to the Type C connector class framework.
>
>  .../bindings/chrome/google,cros-ec-typec.yaml | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> index 6d7396ab8bee..800c005a0e44 100644
> --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -21,7 +21,34 @@ properties:
>      const: google,cros-ec-typec
>
>    connector:
> -    $ref: /schemas/connector/usb-connector.yaml#
> +    allOf:
> +      - $ref: /schemas/connector/usb-connector.yaml#
> +      - type: object
> +        properties:
> +          mode-switch:
> +            description: Reference to a DT node for the USB Type C Multiplexer
> +              for this connector. This switch controls the data lines routing
> +              for this connector for various operation modes, including
> +              Alternate Modes. This switch is assumed registered with the Type C
> +              connector class framework by its driver. The Type C connector
> +              class framework assumes that the mode switch property uses this
> +              name.
> +
> +          orientation-switch:
> +            description: Reference to a DT node for the USB Type C orientation
> +              switch for this connector. This switch controls routing the
> +              correct data pairs depending on the cable plug orientation from
> +              this connector to the USB / Alternate Mode controllers. This
> +              switch is assumed registered with the Type C connector class
> +              framework by its driver. The Type C connector class framework
> +              assumes that the orientation switch property uses this name.
> +
> +          usb-role-switch:
> +            description: Reference to a DT node for the USB Data role switch
> +              for this connector. This switch is assumed registered with the
> +              Type C connector class framework by its driver. The Type C
> +              connector class framework assumes that the USB role switch
> +              property uses this name.
>
>  required:
>    - compatible
> @@ -49,6 +76,17 @@ examples:
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
> 2.26.2.761.g0e0b3e54be-goog
>
