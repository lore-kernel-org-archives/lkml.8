Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F0AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145DC20706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597749441;
	bh=NPKuy13pIHs9eQW0M1ytfw+N/L8X5tuVclTddKQ6nIQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=O5S2clryBEHtB8MPtehgd/OMf+NEJl7ZsiYSdihOjuGXS+ljkTJVFmE20PAkWQNPL
	 YGJvDVyEE0AGzOIKYh8QtmM5z8qm9VLSbN1VgT4ZymWd9xha0gyt0O76PyJjVrLK+9
	 xkbw7wiynhy/Mk8kv7+KDavGpvhiK8dKyy5RD+bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHRLRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHRLRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:17:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F78E20706;
        Tue, 18 Aug 2020 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597749410;
        bh=NPKuy13pIHs9eQW0M1ytfw+N/L8X5tuVclTddKQ6nIQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=1Pup5g6N+ofNHlpZFRvzY+eyjL1Q/Wjbo21PttmREEhWHRE2cBC7OFTPabCzFRLj5
         cwDCBdoN2xPj7NgXajzePzZywMqTlGpkkPrh2uz0l8aElz6kUW62UsCfdMJGbwlgie
         ga87AU70Pj9iG5aoPUwJgOYBP01pxix1/7LXweo0=
Date:   Tue, 18 Aug 2020 13:17:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <20200818111713.GA267842@kroah.com>
References: <202008161912.jRyQUNBM%lkp@intel.com>
 <20200816135119.gdjmznnbmd53ycqe@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200816135119.gdjmznnbmd53ycqe@function>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 03:51:20PM +0200, Samuel Thibault wrote:
> kernel test robot, le dim. 16 août 2020 19:25:17 +0800, a ecrit:
> > First bad commit (maybe != root cause):
> 
> > >> drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
> 
> This will also be fixed by the patches I already sent to gregkh for
> after rc1.

Those patches are now in my tree, should show up in linux-next tomorrow,
thanks.

greg k-h
