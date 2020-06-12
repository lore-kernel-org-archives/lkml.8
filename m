Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FBD207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591984352;
	bh=q+5z7cVTThqiMbNhEpYBI/PR2+OqYXGqJO2cXdMTqMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rJNskKsmDWbGER4iXnOXjCXlLh+uimOW0VL2q/hrCWrgf6T07Nh4U+vpXpoac3wyq
	 hKuQxiJ577wMqnnM7gTF17UeSox77l3qV1kXLhwZBnmJqjigd5yDcKyHGV2eNkRNf2
	 eo1AVSXa/kYGVvI8bBSpUcCesrH/sV0L0t5zSoH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLRwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLRwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:52:30 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E258207ED;
        Fri, 12 Jun 2020 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591984349;
        bh=q+5z7cVTThqiMbNhEpYBI/PR2+OqYXGqJO2cXdMTqMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bCfos6/Uzgi5Yba9XWzT1sJPOdvCkvNvmfLJOdC5TPrnyfvcUBUFyZihuAi0hRTHD
         LsImEBqgXQfX0LLTyrjgwxHolNUtfsUtRNjhDIl0c7iwtUIHYauQEDUpAm1xXov4MH
         2UOoEoQ65UA2TEmcFf3NPxRLXzzZ0Tm/AnwVTVKw=
Date:   Fri, 12 Jun 2020 10:52:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Donald Sharp <sharpd@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Dinesh Dutt <didutt@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels@gmail.com>
Subject: Re: [RFC,net-next, 3/5] vrf: add sysctl parameter for strict mode
Message-ID: <20200612105227.2f85e3d7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200612164937.5468-4-andrea.mayer@uniroma2.it>
References: <20200612164937.5468-1-andrea.mayer@uniroma2.it>
        <20200612164937.5468-4-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 18:49:35 +0200 Andrea Mayer wrote:
> Add net.vrf.strict_mode sysctl parameter.
> 
> When net.vrf.strict_mode=0 (default) it is possible to associate multiple
> VRF devices to the same table. Conversely, when net.vrf.strict_mode=1 a
> table can be associated to a single VRF device.
> 
> When switching from net.vrf.strict_mode=0 to net.vrf.strict_mode=1, a check
> is performed to verify that all tables have at most one VRF associated,
> otherwise the switch is not allowed.
> 
> The net.vrf.strict_mode parameter is per network namespace.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

drivers/net/vrf.c:1771:49: warning: incorrect type in argument 3 (different address spaces)
drivers/net/vrf.c:1771:49:    expected void *
drivers/net/vrf.c:1771:49:    got void [noderef] <asn:1> *buffer
drivers/net/vrf.c:1785:35: warning: incorrect type in initializer (incompatible argument 3 (different address spaces))
drivers/net/vrf.c:1785:35:    expected int ( [usertype] *proc_handler )( ... )
drivers/net/vrf.c:1785:35:    got int ( * )( ... )
