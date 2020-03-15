Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93061C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 22:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FAB20722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 22:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="isAp5v3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgCOWFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:05:34 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55755 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgCOWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 18:05:33 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so6980862pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I+XiXVOGotUKaKw9DdToNhk8ohjeSdQyehSxYIi/Dqw=;
        b=isAp5v3+IBzMibR4bQqxzXEJS0HxKyS3u6FrMrVddsdWQTLziUGroT2mBOBtP4A6gT
         4r+ajQo5rsOrf0K5tL4Flyq9ljeLTMUpxRH1ZqvB8wTbVknvnFTdWqW2Pam2wweHL3J/
         2TNsANOgqtpdJyI8yhgARGEZlX5IOuHo3HV5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I+XiXVOGotUKaKw9DdToNhk8ohjeSdQyehSxYIi/Dqw=;
        b=ENtqGDRovGKmraHRzM3tMW8/Qzw3/LYrPD6/5LfMfGHCgDVRUG5NJ6le4nJ/7NROun
         WmbNdVrGGUSDyRv9AmyNYhYcs1UuCIx2XxNcNbS64GErdG1ZyiN+VGoHXAayDJRUuEs6
         s2KB2gmUiR6NXOrNjEu96CQ7MMtVbrTyQ3hns/MYYrEl8GDvCknzAzCx10K9RhCsecML
         gnS7rx5M1xW0pUzL1WSXtewVQQk7ZhuN6cswPy70vrdyS5+GLhSg6XkYbVGEaIib2k2y
         wkbvWUHSBQiIsf/2VHBi3AtAPW0c48ksjJlfDJETpq92qQzoZToZOur6t2h3yzcy+PyL
         c5/A==
X-Gm-Message-State: ANhLgQ1eb1A4ThEsuzrtfM77Ch+YFP1s7QicQjTRLgX4jdVL+dure2l8
        FFT635+gNT477yFaL7YxvpO80g==
X-Google-Smtp-Source: ADFU+vu3eF9j+cKai8Zav5A96CIR+ZD1aRz148OrCPCEBid2gtPK4xA28HY/QgVgC63AnZ51Tg1T2Q==
X-Received: by 2002:a17:90a:bb92:: with SMTP id v18mr17322259pjr.54.1584309931993;
        Sun, 15 Mar 2020 15:05:31 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id y207sm14328036pfb.189.2020.03.15.15.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 15:05:31 -0700 (PDT)
Date:   Sun, 15 Mar 2020 15:05:30 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200315220530.GC185829@google.com>
References: <20200312225719.14753-1-pmalani@chromium.org>
 <20200312225719.14753-2-pmalani@chromium.org>
 <a2a08abd-ce6b-d045-5e56-1dd9c0a3360c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a08abd-ce6b-d045-5e56-1dd9c0a3360c@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Fri, Mar 13, 2020 at 05:26:19PM +0100, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> On 12/3/20 23:57, Prashant Malani wrote:
> > Some Chrome OS devices with Embedded Controllers (EC) can read and
> > modify Type C port state.
> > 
> > Add an entry in the DT Bindings documentation that lists out the logical
> > device and describes the relevant port information, to be used by the
> > corresponding driver.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> > 
> > Changes in v4:
> > - Rebased on top of usb-connector.yaml file, so the â€œconnectorâ€ property
> >   now directly references the â€œusb-connectorâ€ DT binding.
> > 
> > Changes in v3:
> > - Fixed license identifier.
> > - Renamed "port" to "connector".
> > - Made "connector" be a "usb-c-connector" compatible property.
> > - Updated port-number description to explain min and max values,
> >   and removed $ref which was causing dt_binding_check errors.
> > - Fixed power-role, data-role and try-power-role details to make
> >   dt_binding_check pass.
> > - Fixed example to include parent EC SPI DT Node.
> > 
> > Changes in v2:
> > - No changes. Patch first introduced in v2 of series.
> > 
> >  .../bindings/chrome/google,cros-ec-typec.yaml | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > new file mode 100644
> > index 0000000000000..6668d678dbcb4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> 
> Could you use dual licensing here (GPL-2.0-only OR BSD-2-Clause). In general
> Google is fine with it for bindings.
> 
Sure, Will do.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Chrome OS EC(Embedded Controller) Type C port driver.
> > +
> > +maintainers:
> > +  - Benson Leung <bleung@chromium.org>
> > +  - Prashant Malani <pmalani@chromium.org>
> > +
> > +description:
> > +  Chrome OS devices have an Embedded Controller(EC) which has access to
> > +  Type C port state. This node is intended to allow the host to read and
> > +  control the Type C ports. The node for this device should be under a
> > +  cros-ec node like google,cros-ec-spi.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,cros-ec-typec
> > +
> > +  connector:
> > +    $ref: /schemas/connector/usb-connector.yaml#
> > +
> > +required:
> > +  - compatible
> > +
> > +examples:
> > +  - |+
> > +    cros_ec: ec {
> > +      compatible = "google,cros-ec-spi";
> > +
> 
> I guess that it will trigger some warnings once google,cros-ec.yaml is merged.
> Use a full example.
Thanks, will make this modification in the next version.
> 
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        cros-ec@0 {
> +            compatible = "google,cros-ec-spi";
> +            reg = <0>;
> 
> 
> > +      typec {
> > +        compatible = "google,cros-ec-typec";
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        connector@0 {
> > +          compatible = "usb-c-connector";
> > +          reg = <0>;
> > +          power-role = "dual";
> > +          data-role = "dual";
> > +          try-power-role = "source";
> > +        };
> > +      };
> > +    };
> > 
