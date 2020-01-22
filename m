Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4166BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ADB2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579684104;
	bh=Q1UsiW8hyuurSP5UCDx8VhtkWZRBi6u/YvLvrFdNSUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xqFWM0sCwHkwNCIrS9jsF1EQ7sOAv/AYSLHFNqCeXxAKuaGMBNQxGPDWl9aWwXw4x
	 vFwBKqWsbwWzgefqi021vOPWOb4DzlbwEku/YY5p0XqHE+q6iCx8bEAsWK5+62UdLL
	 OjwcJUzRXK7m/NNm+BUV820ZULyZa9YJzD3A2fFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAVJIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVJIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:08:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94FF24655;
        Wed, 22 Jan 2020 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579684102;
        bh=Q1UsiW8hyuurSP5UCDx8VhtkWZRBi6u/YvLvrFdNSUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKpTIavT2P7F5TaepWrsEVv4PyZd7Hi/d8tHWajEBBqXzEAl0qDOjvTZTSW/aDEI8
         ERKORBzBz9a+stNSVZrTi9uwPrBPNugAPtvfLDm2kDfawSjp+ZzRSSs4e6e59wlgMO
         CSxd8hv7Sh/59qHbtdEXA0nDMf/sNEeMsNmvtu0k=
Date:   Wed, 22 Jan 2020 10:08:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: fusb302: fix "op-sink-microwatt"
 default that was in mW
Message-ID: <20200122090820.GA2643799@kroah.com>
References: <0eac53c4878423a9abd49d2142fe4cb1136db4e2.1579529138.git.tommyhebb@gmail.com>
 <c497958a1b0d8e3421c5eda46abddba6651cec1e.1579529138.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c497958a1b0d8e3421c5eda46abddba6651cec1e.1579529138.git.tommyhebb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 06:05:41AM -0800, Thomas Hebb wrote:
> commit 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the
> port") didn't convert this value from mW to uW when migrating to a new
> specification format like it should have.
> 
> Fixes: 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the port")
> Cc: linux-stable@vger.kernel.org

Nit, there is no such address :)

