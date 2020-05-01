Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C30C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B30E214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588316974;
	bh=l2VllNmD5XZU2Mrh1yQ5p6DmXeQXIltG1BBBIJ3kjIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O6O2fqVv6mbbl8qTKWMnECJV2O3MLajv3G8RK2w92QOGOw4Vtfji+RychO3+cDKIl
	 1uKu/fnNnOC26iA7NlDnVCicBtlo/7iMXk1bgb+aBCS/OtlHomAnx+ZOCgXC0Ta1Ll
	 d0cD4VWwlATV4ru/afckgeAX7gHnigTtybpjHV80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgEAHJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:09:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1323920787;
        Fri,  1 May 2020 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588316972;
        bh=l2VllNmD5XZU2Mrh1yQ5p6DmXeQXIltG1BBBIJ3kjIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5/N25RwdKC88lCrZUCxZKX2IGGBYyTBKVcOKwWrfLcOBN9GI4VHX+KlQLOolbALO
         zu7me9b0hm1vCCLP4PbS3F3QnXufV5i1yQpqeafX1u60CoKA7Mm7yB1f/pNC9iQlcS
         5clTxbMKbA5rAhYLqW3mOXZS8XktvSWAQYJfkaHQ=
Date:   Fri, 1 May 2020 09:09:30 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/1] Add IMR driver for Keem Bay
Message-ID: <20200501070930.GA892454@kroah.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <d3f045b05c83d0eca1d5498587493ca485e0a1a0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f045b05c83d0eca1d5498587493ca485e0a1a0.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:49:36PM +0000, Alessandrelli, Daniele wrote:
> This e-mail and any attachments may contain confidential material for the sole
> use of the intended recipient(s). Any review or distribution by others is
> strictly prohibited. If you are not the intended recipient, please contact the
> sender and delete all copies.

This footer means I delete all of your emails...
