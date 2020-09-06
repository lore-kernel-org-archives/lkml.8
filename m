Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E06C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38FC20759
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 07:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgIFHj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 03:39:28 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:33348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbgIFHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 03:39:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 99040180AA519;
        Sun,  6 Sep 2020 07:39:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smell58_190c540270c1
X-Filterd-Recvd-Size: 1579
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Sep 2020 07:39:25 +0000 (UTC)
Message-ID: <144eeac72c832655f28d35bd0ffc504b7c74b395.camel@perches.com>
Subject: Re: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error
 handling path
From:   Joe Perches <joe@perches.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, timur@freescale.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sun, 06 Sep 2020 00:39:23 -0700
In-Reply-To: <CAFqt6zZ81MwsFUGgfOBG57p=4wfW=5k2RUUub3xgmKNa2cnpzA@mail.gmail.com>
References: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
         <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com>
         <CAFqt6zaB_wcrUzmOJ6kQWMqdcPrENyJO4FNc_UU5z-AQQh_e3w@mail.gmail.com>
         <4d63100c-fe60-57ad-2924-7b28dbd14c20@nvidia.com>
         <CAFqt6zZ81MwsFUGgfOBG57p=4wfW=5k2RUUub3xgmKNa2cnpzA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-06 at 07:47 +0530, Souptick Joarder wrote:
> While running ./scripts/get_maintainer.pl, I observed one issue. Everytime I run
> the script, list is getting changed. Is it an expected behaviour ?

Yes.
https://lkml.org/lkml/2017/7/13/789


