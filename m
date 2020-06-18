Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91416208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592468911;
	bh=rsbp6hJoUotVkub0Zjiq15CM0A4qZNm99xzB9sFqpWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=twd6sZOIE96RWwJBZN+Me+prgX/aK4bkdnM+FP8eb2pyG1VbxGPGyavqH4B/8QXrt
	 RgumDhj3CxoSBMXd582WutayJDyv94qbFxEyYSUR+fQbNy5e9X91p+aWNOdFu3F7WF
	 R6ik6X+4/chQDekTNyYxA0xa3rBX4ra0g0ujhWe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgFRI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgFRI20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8248208DB;
        Thu, 18 Jun 2020 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592468906;
        bh=rsbp6hJoUotVkub0Zjiq15CM0A4qZNm99xzB9sFqpWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2kasy+IMIHSzwroVcoSz0bT9MAI1wdYjsNKJOuHiiqAmBWHsEotEl4tXsMgOodkK
         NhRkOOve2xQ/nCjpFBtQmvaEiQrT0cN3l2l3Ncq9psnZ+u39krBN6ZGIyQXtFc1nf3
         fGCeW/FiKqZ7iY6pgOt+AlZPckCxdr8GU4Q9LbYA=
Date:   Thu, 18 Jun 2020 10:28:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H_v2=5D_usb=3A_gadget?= =?utf-8?Q?=3A?= function: printer: fix
 use-after-free in __lock_acquire
Message-ID: <20200618082818.GA1058534@kroah.com>
References: <20200608071622.33081-1-qiang.zhang@windriver.com>
 <20200608073305.GA252221@kroah.com>
 <DM5PR11MB2058F82DF00D26338119BF0FFF820@DM5PR11MB2058.namprd11.prod.outlook.com>
 <20200609094848.GA533476@kroah.com>
 <DM5PR11MB20589EB35828F823826FF4B3FF830@DM5PR11MB2058.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR11MB20589EB35828F823826FF4B3FF830@DM5PR11MB2058.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:58:44AM +0000, Zhang, Qiang wrote:
> cdev  object reference count and "struct printer_dev" object
> reference count(kref), This two reference counts do not conflict.  in
> file usb-skeleton.c also used a similar method， "struct usb_skel"
> contains kref members.

I do not understand what you are referring to here, sorry.

greg k-h
