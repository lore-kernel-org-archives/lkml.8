Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BDC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FCD20757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588093874;
	bh=phvZIqaiTgvZXQ5NZYsurLLh2apuv+ANGcBkxVabH5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0yAgjqdx+f0BKfOgp3KLWp74QMBJEZ+BAnu756ThvibgU4rLn5aYOhcWYlQ07yqgK
	 EisTwp9euKXjSdZ8iYMTPcXtx8C3r9fQpDaDRrlyzwjfUlLbZjhZwd70HzTnffOb9R
	 1txDryDPi5bxe9Lvz3LTKWrVdxMegO0wlid3JUAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgD1RLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:11:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37204 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1RLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:11:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so33997457oto.4;
        Tue, 28 Apr 2020 10:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVsio4H/oSnPDCyfgcZlb6vT+XD+cHvZt/co039yHbU=;
        b=IdRylEu6tUJq/KdFhwKVcBA7AZSSGbcs7gmdie4A8Yv3uvFyxqXtH1G2NrYElVWSNA
         DflKhtWufCEF++diScg388aa5HthBfehFr4X4WlbMieKSDbnMBITkbF4jUld5A8i1IZU
         VufRR8IcoSWo0PxEmYRShNS+kGF2iIgH5bGMsiwtII8sT8ddFt2h5TrD4Ml+RXejt4zq
         5TJaK6Av9+ccyxL3ji/8D6qrq4YdDv2M4JjbwkPDzpkAOlNIdKzyoWjdvBris7oAj7Ch
         Dc3bdIG4LJG61VKX52eshvhtdrZ4JSID1wM5Rj+QGsgxHi5+PM+uzHdyYpp7SusTwSF0
         YWfQ==
X-Gm-Message-State: AGi0PuaY+5ECX70nTWoHa7aMS6OjGYg3Uw+x+dXygU6CxlZ1F9Csa1Ss
        4xNDQ7qd7dvEFd4QEtGOE244KeE=
X-Google-Smtp-Source: APiQypL5LYB310e5RfdI4OFUNdaauACf0iYH252jmLvr9lS4LTJGLVCD65VVy46gj29dK/eDZwlyMg==
X-Received: by 2002:a05:6808:109:: with SMTP id b9mr3594132oie.143.1588093872479;
        Tue, 28 Apr 2020 10:11:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f21sm2485415oig.41.2020.04.28.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:11:11 -0700 (PDT)
Received: (nullmailer pid 17717 invoked by uid 1000);
        Tue, 28 Apr 2020 17:11:10 -0000
Date:   Tue, 28 Apr 2020 12:11:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] of: property: Don't retry device_link_add() upon
 failure
Message-ID: <20200428171110.GA17616@bogus>
References: <20200416205838.161894-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416205838.161894-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 13:58:38 -0700, Saravana Kannan wrote:
> When of_link_to_phandle() was implemented initially, there was no way to
> tell if device_link_add() was failing because the supplier device hasn't
> been parsed yet, hasn't been added yet, the links were creating a cycle,
> etc. Some of these were transient errors that'd go away at a later
> point.
> 
> However, with the current set of improved checks, if device_link_add()
> fails, it'll only be for permanent errors like cycles or out-of-memory
> errors.
> 
> Also, with the addition of DL_FLAG_SYNC_STATE_ONLY flag [1] to device
> links, all the valid dependency cycles due to "proxy" device links
> (needed for correctness of sync_state() device callback) will never fail
> device_link_add() due to cycles.
> 
> So, continuing to retry failing device links (by returning -EAGAIN) is
> no longer useful. At worst, it prevents platforms from setting
> fw_devlink=on (or better) because it prevents proper boot up. So, let's
> not do that anymore.
> 
> [1] - https://lore.kernel.org/lkml/20191028220027.251605-1-saravanak@google.com/
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
