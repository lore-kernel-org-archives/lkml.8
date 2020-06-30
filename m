Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5292C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC51420780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="PfuQ8kZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgF3CBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgF3CBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:01:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB797C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:01:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a1so18821322ejg.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=upqBplyJTPlIYV6178VyJ9FGRE1kd4iocBYYT7PFDZ0=;
        b=PfuQ8kZ47wXLR7y28mXDBoHtKG1IjV/PiIKJ319SHCJpoPTZV4u4rWCDTnD4EwSN25
         5meu75LiP4qxwtbGwOVlTCyvHTVjBOUCQiBAe8WoYl1UbkQrstO3DTsIJzMh2/UExR4M
         JitlpuSdlgIUJNxxoJgxIMGufRTw24nlXz2iMAbcDaHE0cYN9cXtoxNexxhdmxxmQI/y
         0xTll11hOyrhRO2OlN70/e85JfxboQ7Rpdzm3Lij8ubKJ9dCX7AmjlWaTjVo8j5lM+yt
         4Ob8jebe0dHMrE1ozFs9g2xSj77/XYVteaqHZFU2cjlKpCdxx6LclQ4Hux+iifBkCICN
         7eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upqBplyJTPlIYV6178VyJ9FGRE1kd4iocBYYT7PFDZ0=;
        b=PiSz/O8cjPjHNYbS/ffvORj5oBkvtWT0ETt0qy7m5lvVswLCaKl57jtXjWAdK47l8R
         3UmvmMcXd+yOToOt9XTPBkqzCfgtomlAVtqNOD2G7x+E29QolFfPjpFk8eZd/bki0FMw
         vU0LIT6lqcaLOzO8wM7i705/eRorfEgviSxfoIJOhj1g/HWv62+ReugPT3bCNCI9phx+
         WK1hJq2eg9usxmwJrVFigfnYdUI5ID9xFSYKZOHrGs8dad21R3HejhykUsq1oKKIBDYv
         iQz0cak10kqasd9aTgVTE5oxpRdHWY+CR3dsolZl2zuFNMP62+GoGVcsuVahgTTY6LdW
         qxTQ==
X-Gm-Message-State: AOAM531U0qzU9CxbDKW4AUzVmkFOb/ZfjNswiczitZeDI3g3CnIS1YVS
        Obyr/b3SbBspTynru23AeSji8w==
X-Google-Smtp-Source: ABdhPJxIhMhR+vOoqYVlIzIFxlRNDAZdK74nnP+E6DrBJzD1ebIK8Q5NvlBtVM3JV7VPIHrTcttVmw==
X-Received: by 2002:a17:906:3bd5:: with SMTP id v21mr15777250ejf.329.1593482465479;
        Mon, 29 Jun 2020 19:01:05 -0700 (PDT)
Received: from x1 ([2001:16b8:5c28:7601:2d3c:7dcb:fbf0:3875])
        by smtp.gmail.com with ESMTPSA id s2sm1252980edu.39.2020.06.29.19.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:01:04 -0700 (PDT)
Date:   Tue, 30 Jun 2020 04:01:02 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, bcousson@baylibre.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: dts: am335x-pocketbeagle: set default mux for
 gpio pins
Message-ID: <20200630020102.GA45128@x1>
References: <20200628152442.322593-1-drew@beagleboard.org>
 <20200629170358.GT37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629170358.GT37466@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:03:58AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Drew Fustini <drew@beagleboard.org> [200628 08:26]:
> > v2 changes:
> > - change default mux from output to input.  Input is safer as it does
> >   not drive the line.  If the user wants output, they will need to edit
> >   this device tree.
> 
> So can you please clarify this a bit, are you saying that gpio output can't
> be done via userspace?

As it stands, there is no way for userspace to change a pin from gpio 
input to gpio output as it is based on the reciever active bit in the
pin control register (table 9-60 in the AM3358 datasheet [0]).

I thought it would be useful to at least define the GPIOs available for
use on the PocketBeagle by default (and eventually the other BeagleBone
device trees).  Input seems to be the safest value.  This patch at least
makes it more clear where the user should edit to switch from input to
output.
 
> Needing to change the dts does not sound good to me.. But maybe you mean
> this is needed until the gpio-omap and pinctrl-single patches are merged?
> 
> Regards,
> 
> Tony

I agree that I would like for userspace to be able to do run-time
changes.  However, I think something would need to be added to the
pinconf support in pinctrl-single for that to be possible.  There are
bias properties but non for receiver enable.

Does it seem sensible to add that?


thanks,
drew

[0] http://www.ti.com/lit/ds/symlink/am3358.pdf
