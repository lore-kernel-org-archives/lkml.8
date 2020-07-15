Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D89C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6A620663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594799796;
	bh=qWAjHHKlcRvSS7x26fr2QN7oQZR7WXUixK//Z3ryAjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fWNy9Z10cEO0lA+UBfCScnL/EH/9M3ItCdtK1KB7VXiYPT5glsYgYG48+J/cjKc1z
	 l6OgANwk1wwNPAMqSVQgR30kiC2A8YMhCka8yrI2O1Oqt8EFYZX+gzi/0tDG2Q8CXi
	 /ymhGakZtHyAJ+tMGiusxSiXg862AW2GXCb5FlXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgGOH4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgGOH4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:56:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C752064C;
        Wed, 15 Jul 2020 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594799794;
        bh=qWAjHHKlcRvSS7x26fr2QN7oQZR7WXUixK//Z3ryAjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcKb15XB4NVVy8yNuXC6SefyPSadV+0qm8wobIBqtappJTyOt2Rv1ek8ed1xR3ZJP
         MM3vS5AbONBu/Dg0KQgtE7V9LoorNq+YdQom+msqcLSy4ic2GzQwBlbU9FDMeH7pep
         w6SSNFJVzYi53GtPQZJYsRtp28qVT26ESTn9t0R0=
Date:   Wed, 15 Jul 2020 09:56:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Message-ID: <20200715075630.GB2514306@kroah.com>
References: <20200715074131.1754203-1-bhanumaiya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715074131.1754203-1-bhanumaiya@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:41:31AM -0700, Bhanu Prakash Maiya wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt
> 
> Series-to: LKML <linux-kernel@vger.kernel.org>
> Series-cc: Raul E Rangel <rrangel@chromium.org>, Furquan Shaikh <furquan@chromium.org>, Duncan Laurie <dlaurie@google.com>, Eric Peers <epeers@google.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

That looks a bit odd, don't you think?

> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Change-Id: Icfeab15fa04daaffc61280faf5a75cd9b23ee822

Again, checkpatch.pl is your friend.

thanks,

greg k-h
