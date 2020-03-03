Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC83C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B6D24673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583198816;
	bh=ii+jwXGVM7v313kI+AtKYp5NxP8mrg/O06xdYxblncQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FxMpiC/FJENuChnZ09igAzEg4MjRLkP6JlH3RM/N4+ABhVZSSrtx4ukACnwujQuaW
	 YKwSd2K3wpmZKHPiueDjmDk7mTK6sQzff9aRnLASr4b8S6l9mk8lTtLa9U3d1Sx8KY
	 SnEP1MJApWF0ZR17nIUUY4Swhx1seonDhxtyyB3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCCB0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:26:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33430 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCCB0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:26:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so1377456oig.0;
        Mon, 02 Mar 2020 17:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fbtgd3DlSZ/wztX+Kw5nqolTIEnJpCacR3P87ZuGfyg=;
        b=X0QBIu0kES/76xzyPd3q/6HdObvAC+HxEmPTIMrgz1aZ10Ld3v6IBp2ZKP1InYM2Fs
         fGyfndi5yK378c42K0wc5vrUc1/8KB+/gsbmqfRnZhCCzzl7EhDof2ETXjvlCLpcqRv8
         OKdoWlupHmdCiqS5cz2SOtPMAKq9836UwJjSkpArVk6xVVaZ/CpO3jt/qXQq12lmUzGg
         LGhxLBzEpvCcmWFh+ieTiJrm9JSYj/Qdubu6f80xRpveZ2amTyOBJZqVFbHvtYXsXL74
         3BHfd5EABOUHmGwJx3CgW/2TDv6KO/WqNArdwTbJ3SP3unpPwibjtXikzT5FbHv4S7wB
         IktA==
X-Gm-Message-State: ANhLgQ0mED/sjQwb+YSpGb0JGHgbqV9Ymg7g4hS3rRw6BHZ0RJALaJkB
        0tkABLViv7tTNF6zea3ekg==
X-Google-Smtp-Source: ADFU+vuNkwrrfnZhdZ2enL3gQj+aywUwN+ZZuoDrOS8O06nbMrfm+4nP52YXx4GjqG9RH6dn9mHrhg==
X-Received: by 2002:a54:4f14:: with SMTP id e20mr866385oiy.84.1583198814367;
        Mon, 02 Mar 2020 17:26:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l12sm7227110oth.9.2020.03.02.17.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:26:53 -0800 (PST)
Received: (nullmailer pid 5540 invoked by uid 1000);
        Tue, 03 Mar 2020 01:26:52 -0000
Date:   Mon, 2 Mar 2020 19:26:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        dafna.hirschfeld@collabora.com, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: cros-ec-tunnel: convert
 i2c-cros-ec-tunnel.txt to yaml
Message-ID: <20200303012652.GA5481@bogus>
References: <20200227145528.8940-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227145528.8940-1-dafna.hirschfeld@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 15:55:27 +0100, Dafna Hirschfeld wrote:
> Convert the binding file i2c-cros-ec-tunnel.txt to yaml format.
> 
> This was tested and verified on ARM and ARM64 with:
> 
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
> Changes since v1:
> - changing the subject to start with "dt-bindings: i2c: cros-ec-tunnel:"
> - changing the license to (GPL-2.0-only OR BSD-2-Clause)
> - removing "Guenter Roeck <groeck@chromium.org>" from the maintainers list
> - adding ref: /schemas/i2c/i2c-controller.yaml
> 
> Changes since v2:
> - adding another patch that fixes a warning found by this patch
> 
> Changes since v3:
> - In the example, change sbs-battery@b to battery@b
> 
> Changes since v4:
> - change the name of the yaml file to google,cros-ec-i2c-tunnel.yaml
> - make the example more complete by adding spi0 as parent and other properties.
> 
>  .../i2c/google,cros-ec-i2c-tunnel.yaml        | 69 +++++++++++++++++++
>  .../bindings/i2c/i2c-cros-ec-tunnel.txt       | 39 -----------
>  2 files changed, 69 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
