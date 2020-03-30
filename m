Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE405C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F7F20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609479;
	bh=9WjqI5SPSCBz6gV5rpNapNZis++dQJUdYYl0VRE9YME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OS+Pte0o82fPlYHAXyQsiB0KSap56Be6os70wZGhba4qvt+ITxqGzQGosKUrQmif+
	 69nD9rsxN919S+veoHJS/5HPCiebKnqWMt3ANv80vTQxes+8dC06BHprzHDTpdpMRm
	 2KZFIfS0wrNLVQfOY7OivxfFS+8sGao6v5efky28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgC3XEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:04:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:32897 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:04:38 -0400
Received: by mail-il1-f196.google.com with SMTP id k29so17578808ilg.0;
        Mon, 30 Mar 2020 16:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyVmX6PvPs45KAHBuPxiyr6Y4x+zS3R0igRu3UBZU14=;
        b=Vq/2X2vcWkL7YgWnJrof5YXzB6UotgTIhBvKbLo6YojyyBAtrDUHzZYFHwbaKPegPK
         mxRHNKWrVHAAfagOSzL6WUjRhFAdOw9jqbPlY1dsrwR6HGg4O3sNfpwvp+vtZC3UEImL
         uS7x1iXDKS6cqb6C33/vtgBlWknHdeWc3hvVU1S9ljvvY/lluJzJ2KYIr4T90qdL193j
         wXA44xZrgLd4B3AC7WhyJUVbnhG4Myy7eRA5E5s1XzwLvVbkd5amyw3bkwNPIJ2hR4nA
         rhdUmYi3IpcCQdmdKsNjAnn39tNY43MYYB49tb/nC4hDxXRGvi0Vs9NRrsTjha/KxNJw
         S4hw==
X-Gm-Message-State: ANhLgQ0UCHKtGCIedERhGIImCVhVBuEMsW+JnVqYwCC58cIDqqg90yp5
        B1mjbFYTjpEmrXQ0ztPj/w==
X-Google-Smtp-Source: ADFU+vt65MXOBj8bh2BCCIAwztEIyDbufvyh7YknLu1e/QYsgpbMBwAXkTjyrfh5SoRzal+OImdt/g==
X-Received: by 2002:a92:5c5c:: with SMTP id q89mr13643135ilb.195.1585609477611;
        Mon, 30 Mar 2020 16:04:37 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y71sm5347666ilk.23.2020.03.30.16.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:04:36 -0700 (PDT)
Received: (nullmailer pid 26041 invoked by uid 1000);
        Mon, 30 Mar 2020 23:04:34 -0000
Date:   Mon, 30 Mar 2020 17:04:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: dwc3: add optional extcon
 description
Message-ID: <20200330230434.GA21343@bogus>
References: <20200318083508.20781-1-martin.kepplinger@puri.sm>
 <20200318083508.20781-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318083508.20781-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 09:35:08AM +0100, Martin Kepplinger wrote:
> the dwc3 drd module already hooks up an extcon device if described in DT.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 9946ff9ba735..9aa0cefbf5f6 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -31,6 +31,8 @@ Exception for clocks:
>      "xlnx,zynqmp-dwc3"
>  
>  Optional properties:
> + - extcon: phandle for the extcon device dwc3 DRD uses to detect
> +   connect/disconnect events.

This is deprecated in favor of usb-connector binding. I guess fine to 
document it, but needs a big fat deprecated, do not use message.

>   - usb-phy : array of phandle for the PHY device.  The first element
>     in the array is expected to be a handle to the USB2/HS PHY and
>     the second element is expected to be a handle to the USB3/SS PHY
> -- 
> 2.20.1
> 
