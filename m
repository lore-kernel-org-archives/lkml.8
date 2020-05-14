Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9694C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93437206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589455586;
	bh=Zr9uDclEiIV6JbC3eC6+cs7xG/1U4iZ+ynfezdaEHow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCxyJ5FJWHSHGUQe9d227CX1oAmxwEbUTaJChZW3OAAAfQvQruSvmNNal5BS56tXo
	 y1yC8S06asMjvbRBH17cUldUBjMIGyk007Rfz+zLfgd8+yzZ2P1oRBmzF/K56EFvnc
	 Ub2vWiZTYVAit5F8OELxX9JzdnCcNQD3gs2rDgVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENL0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENL0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:26:24 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD31206DA;
        Thu, 14 May 2020 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589455584;
        bh=Zr9uDclEiIV6JbC3eC6+cs7xG/1U4iZ+ynfezdaEHow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/oDzLyJwmDobZIfdVeIEJgufx+lrbTWLtT7pMQqySHU5/ULP4Jsv/8wF0k1kI82V
         vlgOQTeaB3BbBu3N4XOo7OBQ9dexz5GQdIKp0VsboXT8pOTDb9lOyWRYbjwBniy29C
         mbSzD87B6Zbx5W+HeRQazW6/QMRU/vH8KMXiVeWU=
Date:   Thu, 14 May 2020 16:56:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 5/5] usb: xhci: provide a debugfs hook for erasing rom
Message-ID: <20200514112618.GP14092@vkoul-mobl>
References: <20200506060025.1535960-1-vkoul@kernel.org>
 <20200506060025.1535960-6-vkoul@kernel.org>
 <caa2c5f4-a858-d699-27af-7b0c22b4dc40@linux.intel.com>
 <20200513124554.GA1083139@kroah.com>
 <20200514092458.GA1591384@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514092458.GA1591384@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-20, 11:24, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2020 at 02:45:54PM +0200, Greg Kroah-Hartman wrote:

> > Ah, I misssed that, a follow-on patch can do this, right?
> 
> Actually, a whole new series with this changed is good, I didn't take
> these for now, for some reason I thought I had.

Do you mind taking these except this patch (last). I will spin this
later

Debugfs was for my own testing to be able to erase so that I can test
load :) No hurry for users to have that yet...

Thanks
-- 
~Vinod
