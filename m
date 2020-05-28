Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F64320814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590679002;
	bh=fM4F1w6NV1k7auo1H+fbUWfZ78d+B9IuoHTVg3AINx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qKgwxhWEjGEmbFBeM2qKehL1aoF7ni5UnHyJFbCLX2E+IFjYRMZZcYQ5q9rE/M5aJ
	 gp6qfrvz0TkVKzxkOUWvk5hkK7cJYMDzM5VoLcHy84bNcp4yLeu7ewegxrgy/Jk8pH
	 qEO6ag+B3QG0owJn5vkNO5nupNVCWVNCjkAp4z5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbgE1PQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:16:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33074 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404316AbgE1PQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:16:28 -0400
Received: by mail-io1-f66.google.com with SMTP id k18so30433478ion.0;
        Thu, 28 May 2020 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SK1AraOAAlqE21Qv8uTbFSbwYc166rll0a90faCZX3A=;
        b=n2Ni6MA9ApkNFpOWC8AuIg6j0ezi/T+RdJBQ5Ks3GvO2GJizgq+t3Qq63iYY65HhbM
         mY7k8jYZINkqrOPQcn+eeYWP3ab0dIxhKx25u3Aq98Xaow1xn6AVzKnwMIY2uqZOIX27
         g8SrYbsCG1pV060qKH2NTpKG/tcO0Qyq3vkTDIxiZyMhS47uP9MhruVAgZ6m0Z9UURJT
         Tzbu7ioezCK4+PwcoFRXHUlfiqwFDrNu6jbEDoljnNmxUgMfK5mKFYSk8hgnqFpYc3iR
         krxUzV3WHRe4zkaAHhJtLczTlggAxcrdPqoiNoXV9VSh5F2dPvNfWSfN+NqXWxQtWsyK
         PTlw==
X-Gm-Message-State: AOAM533dtlKrz0QObif225WMslsdTI3yC8A2QFTo0EYYwYXyfgN0x+MC
        UNmN6cHsntUGMqtaEyXbqw==
X-Google-Smtp-Source: ABdhPJzmgPWUpkGPyzRGjKihzjiiWgeQjD31EW0rWTqKLz0Ks44iHfmJ3jSZTagSQSChiX3iKeEzJw==
X-Received: by 2002:a02:3002:: with SMTP id q2mr2972953jaq.19.1590678987065;
        Thu, 28 May 2020 08:16:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j9sm3295362ilr.18.2020.05.28.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:16:26 -0700 (PDT)
Received: (nullmailer pid 87549 invoked by uid 1000);
        Thu, 28 May 2020 15:16:25 -0000
Date:   Thu, 28 May 2020 09:16:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: auxdisplay: hd44780: Convert to json-schema
Message-ID: <20200528151625.GA87494@bogus>
References: <20200514113003.19067-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514113003.19067-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 13:30:02 +0200, Geert Uytterhoeven wrote:
> Convert the Hitachi HD44780 Character LCD Controller Device Tree binding
> documentation to json-schema.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  .../bindings/auxdisplay/hit,hd44780.txt       | 45 ---------
>  .../bindings/auxdisplay/hit,hd44780.yaml      | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
> 

Applied, thanks!
