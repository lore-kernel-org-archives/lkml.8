Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CD7C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99E020738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598852574;
	bh=RWLLnTBjZmFx7OFdUedWw2l/fWNwHBTNM+A88c+k2y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YDQG1J5kEit84Q5WXKZEyKGRy8Hyys+N+x2/cjOmbophu/ABd1iscsbRRjqahCkHo
	 UX4iJJ2VpacHxRuV/ytLAso5FcLhc4RwHgM92+UfqxmBxWyT7EBw4zBzwnGRmQnP5Q
	 97f1hcPA0rtod5BS+rY5vgcqikSmpm/4Vy4Ea5v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHaFmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgHaFms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:42:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ABC920738;
        Mon, 31 Aug 2020 05:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598852568;
        bh=RWLLnTBjZmFx7OFdUedWw2l/fWNwHBTNM+A88c+k2y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAeLkitRyddAB9IApuMGcfVySFr9qnMvS+p9ivVqnvVxLJUTWGvm+JNJCVsMz3Tf7
         HiCczMTgbtV90vDv8ZgymJuwOcHquUqhVib1LAk04Cpwq6u0Kffe7N2qYPka2XwoLV
         etF6GND8Cnnv0ASad8TlIYDOFpzaF4n+mxUkl6RA=
Date:   Mon, 31 Aug 2020 13:42:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, maitysanchayan@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefan@agner.ch, festevam@gmail.com, stable@vger.kernel.org,
        andrew.smirnov@gmail.com
Subject: Re: [PATCH v4] dt-bindings: nvmem: Add syscon to Vybrid OCOTP driver
Message-ID: <20200831054240.GK4488@dragon>
References: <20200825030406.373623-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825030406.373623-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 08:04:06PM -0700, Chris Healy wrote:
> From: Chris Healy <cphealy@gmail.com>
> 
> Add syscon compatibility with Vybrid OCOTP driver binding. This is
> required to access the UID.
> 
> Fixes: 623069946952 ("nvmem: Add DT binding documentation for Vybrid
> OCOTP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.
