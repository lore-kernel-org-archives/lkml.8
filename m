Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DFB206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588057579;
	bh=4guOKsdcsG/tYi+gDCLSoYboc7ROatL6zjZREaqyocU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yMWdrLYNfyPb+zqdE/ia2YgAQwTIZbh5WExOgomCjou95v5Wh5cAWUIfHkslKve3j
	 tE9UK0AGg/H215ci/qByo9axwZBmWF1VZkI7NSSIoULxUksb4cNK9zbsGqeBQSQp9c
	 naO16U5RvYYOmCOYmT0HbfF0JJefFOrTF0OhoePs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgD1HGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgD1HGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:06:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A336206A5;
        Tue, 28 Apr 2020 07:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588057577;
        bh=4guOKsdcsG/tYi+gDCLSoYboc7ROatL6zjZREaqyocU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ynD/mSEq28BZhy1RwDSBCY2PQa49qemIrm8Mx6hyurWhyXZqayGtivZX8R/Oynvw/
         6fTzz+x5JQzl6XnCd5+8u4V6U9ABomg2wZdLTwaqEXTRN5UaDgou8Ia40nCcbAdJlY
         r7LoHqYJF65lpRu2RHxZQtao/P6lQH8exX8PByMM=
Date:   Tue, 28 Apr 2020 09:06:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org
Subject: Re: [PATCH v2] scripts: scripts/tags.sh
Message-ID: <20200428070614.GB992660@kroah.com>
References: <20200426083619.GA2105859@kroah.com>
 <20200428053509.19564-1-xujialu@vimux.org>
 <20200428053509.19564-2-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428053509.19564-2-xujialu@vimux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:35:09PM +0800, xujialu wrote:
> Update function all_compiled_sources for only compiled source files.

Your subject line needs a lot of work.  Please read the section entitled
"The canonical patch format" in the kernel file,
Documentation/SubmittingPatches for what is needed in order to properly
describe the change.

> 
> Usage:
>   1) COMPILED_SOURCE=1                           make {cscope,gtags}
>   2) COMPILED_SOURCE=1 KBUILD_ABS_SRCTREE=1      make {cscope,gtags}
>   3) COMPILED_SOURCE=1              ./scripts/tags.sh {cscope,gtags}
>   4) COMPILED_SOURCE=1 ABSPWD=$PWD/ ./scripts/tags.sh {cscope,gtags}

And you did not document this somewhere for people to be able to find
out?  Also not good :(

greg k-h
