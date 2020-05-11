Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D243C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C99F20752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hkEdszHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbgEKUqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729857AbgEKUqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:46:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20CDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:46:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f7so5274491pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uYusnhSC7Z6RV3AtOgOdxj3jC+YLs9nBvqEDynGfEO4=;
        b=hkEdszHivpyBZj6Je7n1VlEhojSGSt2t11cqUYXONgDCnJ3B4+XrxCdoiktys9EEOC
         BAUx9V1FUz8O5C/7N8IPPFEytTC+hjumCYHKCniwoC1fFUlk6/kxAMEx5Cc4CIbEMILA
         Y+xfoa9PZ+PAxKIEEbiFrXdJbhVedDFKoYKAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYusnhSC7Z6RV3AtOgOdxj3jC+YLs9nBvqEDynGfEO4=;
        b=FOJuz7L1No5BVLW/IgEPnmCtkf+SGR+5tsRKho48CZ9B9yhieLvjuAIa8eF1g/EU+B
         O3djV3lbwysJmjRY4Dx185+8os5Tzb8jJVS5/baYc+FIqKiJzHR/L4men0unTjkkfk+j
         qzfmrSsDriv3nyRz9bfg5Q+O1EOGbs2jxnWIXrNwvTFcVM1kNQFShoh1EgzLlaWBD2t/
         HvLpyMe5HKqI0N4kOwujIWHpE3yH6qQtKLTrO0hbkJrnVKQQ+r6JCc/oSOudbBxI0nSc
         1piWw67KLuXSWdPx+ZqLd1bQ7btHY7t1ZNZ3bmeZJaKz1b3eMASYt7ie1dFaJ4IN8hn+
         E8GQ==
X-Gm-Message-State: AOAM530CQLW5z4RUTOB87/0nl/FQXQ2TwsVjFUJQnMtxcPtq66JNMCWQ
        +t6qx+XvRhmqtlPTT/KbqH1MHw==
X-Google-Smtp-Source: ABdhPJywgNWD2Wh9WUBNZ0aLExdgulIwqc76Ief5yXPN1y1Bsh6hSt7WMz8Z2cbjXe2REjbFsLFV5A==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr3874382pge.294.1589229997580;
        Mon, 11 May 2020 13:46:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 67sm10209091pfx.108.2020.05.11.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:46:36 -0700 (PDT)
Date:   Mon, 11 May 2020 13:46:35 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200511204635.GC136540@google.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200511192800.GA28762@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511192800.GA28762@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for reviewing the patch. Kindly see my comments inline:

On Mon, May 11, 2020 at 02:28:00PM -0500, Rob Herring wrote:
> On Wed, Apr 22, 2020 at 03:22:39PM -0700, Prashant Malani wrote:
> > Add properties for mode, orientation and USB data role switches for
> > Type C connectors. When available, these will allow the Type C connector
> > class port driver to configure the various switches according to USB PD
> > information (like orientation, alt mode etc.) provided by the Chrome OS
> > EC controller.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > index 6d7396ab8bee..b5814640aa32 100644
> > --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > @@ -21,7 +21,21 @@ properties:
> >      const: google,cros-ec-typec
> >  
> >    connector:
> > -    $ref: /schemas/connector/usb-connector.yaml#
> > +    allOf:
> > +      - $ref: /schemas/connector/usb-connector.yaml#
> > +      - type: object
> > +        properties:
> 
> These don't seem CrOS EC specific, so why document them as such. 

Are you referring to the "mode-switch", "orientation-switch" and
"usb-role-switch" properties? If so, then yes, they aren't Cros EC
specific. The Type C connector class framework requires the nodes to be
named like this, and the cros-ec-typec driver uses this framework, hence
the description here (the Type C connector class framework doesn't have
any bindings).

Would it be better to add in the description string that Type Connector
class expects these switches to be named this way? :

" Reference to a DT node for the USB Type C Multiplexer controlling the
data lines routing for this connector. This switch is assumed registered
with the Type C connector class framework, which requires it to be named
this way."
> 
> > +          mode-switch:
> > +            description: Reference to a DT node for the USB Type C Multiplexer
> > +              controlling the data lines routing for this connector.
> 
> This is for alternate mode muxing I presume.

Yes, that's right.
> 
> We already have a mux-control binding. Why not use that here?

Heikki might be able to offer more insight into why this is the case,
since the connector class framework seems to expect a phandle and for
the device driver to implement a "set" command. Heikki, would you happen to know?

> 
> > +
> > +          orientation-switch:
> > +            description: Reference to a DT node for the USB Type C orientation
> > +              switch for this connector.
> 
> What's in this node?

Similar to the other "-switch", this will contain a phandle to a device
which can control orientation settings for the Type C Mux. The connector
class API assumes the switches are named this way. For example:

orientation-switch:
https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/usb/typec/mux.c#L64

mode-switch:
https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/usb/typec/mux.c#L258

> 
> > +
> > +          usb-role-switch:
> > +            description: Reference to a DT node for the USB Data role switch
> > +              for this connector.
> >  
> >  required:
> >    - compatible
> > @@ -49,6 +63,17 @@ examples:
> >              data-role = "dual";
> >              try-power-role = "source";
> >            };
> > +
> > +          connector@1 {
> > +            compatible = "usb-c-connector";
> > +            reg = <1>;
> > +            power-role = "dual";
> > +            data-role = "host";
> > +            try-power-role = "source";
> > +            mode-switch = <&typec_mux>;
> > +            orientation-switch = <&typec_orientation_switch>;
> > +            usb-role-switch = <&typec_mux>;
> > +          };
> >          };
> >        };
> >      };
> > -- 
> > 2.26.1.301.g55bc3eb7cb9-goog
> > 
