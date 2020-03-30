Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1539C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBDB20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585593833;
	bh=oFeD+3zgprgjtDYNKh0ecNFPbQkNgdFD7Z6brRt/esE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aKCyglhUzB9ExpZAghHEknbrJyJyYUfHfTZ7NCZJo978uySTV74o89p4AkcLeKNiR
	 tPx7QKiC8Vxl3653lVS9jPXBJoeuImpw3HhhVifqNzptJhZwO418pGsIuBhaK1dbHv
	 BWbQ19jbIZjzUcIerJ/yPCeC02YMn0b73YL3iub8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgC3Snw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:43:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36617 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3Snv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:43:51 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so16853760ilp.3;
        Mon, 30 Mar 2020 11:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sr2H3ZHiU4Yu0E/sgwgG1AOowkZlbRfvDtF3s0GLGc0=;
        b=Q24Yj/YGS/C/3ATzw4s081arhW6Lu7f3pOa6+W7BiAFp9emoGVL2w1Ah6PS2094X3n
         IQyawFMdqP8BfLh1wHWqoXkrpG6Q9JL8CIoGvV2E2k0TBHfI+l8LcMWfnqcLeb5osIkr
         ig3VeGLQmEO4H4TvuMptROkt2L1XMTv9YkB9phfNK6aL11WpQwXAox7me/IicHIOiNEp
         6VEQTJtuyATlHQrIFXaa6kxAcgMkMHwBo59kjMUpiIjyTk0LSK+LnmIeOIoL8ebnz3LZ
         18iKjJenW16M4wyihm3ORe+nPpwO17uD73jalDE4gzF5T+G3XUsgOyay1HAMemWYyKhL
         00YQ==
X-Gm-Message-State: ANhLgQ1wTJexmFWzXjPulAmbPhQlRomVFHGJNapPl72y7+9lN+JNFSS8
        RlxC8Qnmo2SHWXP+xfNrpg==
X-Google-Smtp-Source: ADFU+vvRZ77UacJqaROVxq667qtE15zVY08buF2FB+VDvxkF3Lcu9wIqWX+wCzahL36gMUZY5JW9jQ==
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr12746116ilc.202.1585593829255;
        Mon, 30 Mar 2020 11:43:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z72sm4303192iof.52.2020.03.30.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:43:48 -0700 (PDT)
Received: (nullmailer pid 22952 invoked by uid 1000);
        Mon, 30 Mar 2020 18:43:47 -0000
Date:   Mon, 30 Mar 2020 12:43:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: common: fix example for gpio-leds
Message-ID: <20200330184347.GA22686@bogus>
References: <20200313165700.15569-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313165700.15569-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 17:57:00 +0100, Johan Jonker wrote:
> The preferred form for gpio-leds compatible subnodes is:
> ^led-[0-9a-f]$
> Fix example by changing led0 and led1 to led-0 and led-1.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
