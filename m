Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65589C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360AF20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594192721;
	bh=sPThglVmMIZyClWpvplfucG+zqHeP8pynV4icATZsA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TucmY1LuHXnfRUUpx8D0qeNaBhKjzwwhdDFd6eFXj+UoCKq8UT5YWcY4mUurRqYzO
	 EJJYInomZOVTPCLiTFmYnOFVUxZflyhveRkKfyPatanDPMQ8kRTuKmzERtUXWLKHbR
	 wCgfVVXXkrgFSx+kN0EdNXapb7v1xWDB0czrgUf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgGHHSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgGHHSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:18:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1C020708;
        Wed,  8 Jul 2020 07:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594192719;
        bh=sPThglVmMIZyClWpvplfucG+zqHeP8pynV4icATZsA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmtAl3LupfRDKm5XHmeJI3cwWuTfRDKVh78GgNYCEw73vFVBSmvkkEkJpFOZb7ObL
         9YCOzFrKFAbxpB4gl0AT+/kTW8p+RevdzQvlqwusH7nkvwhc+Cnfzk3ofw71dcbGop
         uC+kDGK8dD+1Eo47zHcyatF2xm4gsBJb0oPOBT7A=
Date:   Wed, 8 Jul 2020 09:18:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESENT] ia64: configs: Remove useless UEVENT_HELPER_PATH
Message-ID: <20200708071835.GA353684@kroah.com>
References: <20200707205030.32394-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707205030.32394-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:50:30PM +0200, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
