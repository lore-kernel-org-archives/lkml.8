Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7826AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598292087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgH0Ptr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:49:47 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:40072 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgH0Ptq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:49:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 287CB8384369;
        Thu, 27 Aug 2020 15:49:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: veil31_321096a2706e
X-Filterd-Recvd-Size: 1317
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 15:49:43 +0000 (UTC)
Message-ID: <f939c3d239443a68e0aff7148b1c245ffc18643d.camel@perches.com>
Subject: Re: [PATCH] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 08:49:41 -0700
In-Reply-To: <741486db-29e8-e24e-32c1-9559e3a76a06@linux.com>
References: <20200827151923.40067-1-efremov@linux.com>
         <741486db-29e8-e24e-32c1-9559e3a76a06@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 18:28 +0300, Denis Efremov wrote:
> > @@ -1013,10 +1013,7 @@ static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
> >  	size = sizeof(struct udf_bitmap) +
> >  		(sizeof(struct buffer_head *) * nr_groups);
> 
> I missed that this size is a good place to use struct_size for
> overflow checking. I will send v2 instead.

And you could cuddle the

	if (!bitmap)
		return NULL;

by removing the blank line between the alloc and test.


