Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85661C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D252078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589552629;
	bh=6R+Xi8P/zfipyLDRIy6hLIDaQEC20tzTQym4EoyHh/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qUMIp4e7BqsrcWKkqju/ycdS9CeS3pq4ZEcNdBAT/JCQ9BUaTM5onnOwB8uYqUA7d
	 j8wgXL+BYTeXPkVQjd+nG8REZ1Q6gIGEw1bVlirZOCqc255MHapPPfMLmSJ5lXXmVp
	 6CHiNYaZy9pBp9hYGI1nqcPTciLyqiv3i8Ie6w4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOOXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CFE2076A;
        Fri, 15 May 2020 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589552628;
        bh=6R+Xi8P/zfipyLDRIy6hLIDaQEC20tzTQym4EoyHh/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHPePjMW3i3M8c2Y7Y8wblCRASGmrd7emqY5oB6OTqfHa+x9HjbsYbmP18QuTU55U
         lytDX2mAO29R4A/zkkjbVpfw0kHxPsK/A4luRg75pxABOWveLsrpQ2Ud2LXAg+UQE9
         GxUo8fkv4ptPyMQo/HWwlD/hZeKoIib0xQm5Nkaw=
Date:   Fri, 15 May 2020 16:23:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ipack: tpci200: fix error return code in
 tpci200_register()
Message-ID: <20200515142345.GA2409034@kroah.com>
References: <20200507094237.13599-1-weiyongjun1@huawei.com>
 <eaaa54dbe413bf3f13f08c267e6c31c497afb509.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaaa54dbe413bf3f13f08c267e6c31c497afb509.camel@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:34:06PM +0200, Samuel Iglesias Gonsálvez wrote:
> Hello Wei,
> 
> Thanks for the patch!
> 
> Patch is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch series through your char-misc
> tree?

Sure, will do.

greg k-h
