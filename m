Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D8C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB072064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579119425;
	bh=cRc55CvYpQobK998sX1otex4cVjAmzAwwrwAjicGMNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uHexf4IgSB0QytXQ0JwFkxIrvpSSH/KvW76k9kovM6XIuJ8QMjRZhA4zM6cXXIJD4
	 Eiobr2SeWCeMZgbAL1JJqiUYj82uOaRoAfwqNR4aRXnRwUkfbzeKYsmT/KXxerr1pV
	 EcT/aTbeV6euvrNLkI/JcxHvs+E9Wp4n2sKFvC+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAOURF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:17:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39786 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgAOURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:17:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so17267928oty.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2myqp2GrpN0pfUan1rnrXmWGh+MWOgXmKRvJ9E5COqI=;
        b=mqSQjnsQKZtSq7aH/WGKCRy8WjkE5ODSqFW6GeV9yutVKl4FJ9oWXohgp84bMy27i4
         maFDIGlnPaPJIOXxd2uib9ItoT3stz2wUokyMbMUzdDCViaXOMaSn+SNwYxZ+10THmBu
         E36JpW0209JzvBS4DnCBhi1dM64vM0T1HauZmkQy13oq3NY3k5nZpvpIGuDp2NI/G5QN
         g+BPGhl9JjxNUfJ2eaHVqp5TLaHdja6nHNPd0dWXlFL+95S375F1HmdJqErtp5Kt7tXj
         zZ6VYaZ10sUdqLJnYgMbnqrj4vPnL9BjhcZDv2f0zI9HHlIHsHPxYEJJNZTIw0gzpelD
         ZnBA==
X-Gm-Message-State: APjAAAVVUgl4gCMH/BV4RWioMSOZ1Cnp/SlZT9khAcZrxC6Zou03jhyi
        iY+npMTk1b7nbkZ/AmgF3uqz1/s=
X-Google-Smtp-Source: APXvYqzbYfeHM8YpNrX/HwOegouFADH0FG2eeSgF1gPoN6d8qyCerd+j2USWglWbCr1PhhntiACdmA==
X-Received: by 2002:a9d:74c7:: with SMTP id a7mr4127463otl.7.1579119422628;
        Wed, 15 Jan 2020 12:17:02 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm6892294oti.22.2020.01.15.12.17.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:17:01 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22062a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 14:17:00 -0600
Date:   Wed, 15 Jan 2020 14:17:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: Re: [PATCH v7 1/2] dt-bindings: net: bluetooth: add interrupts
 properties
Message-ID: <20200115201700.GA26654@bogus>
References: <20200115101243.17094-1-glaroque@baylibre.com>
 <20200115101243.17094-2-glaroque@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115101243.17094-2-glaroque@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 11:12:42 +0100, Guillaume La Roque wrote:
> add interrupts and interrupt-names as optional properties
> to support host-wakeup by interrupt properties instead of
> host-wakeup-gpios.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
