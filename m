Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9219C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940862065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgEVHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:03:57 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:53260 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728181AbgEVHD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:03:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5CB40100E7B40;
        Fri, 22 May 2020 07:03:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wax46_390cfe726d25
X-Filterd-Recvd-Size: 2396
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 May 2020 07:03:52 +0000 (UTC)
Message-ID: <e4847d1f25a1fd29ea3f8f8930ba5ae5ccc41f30.camel@perches.com>
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add entry for the Nitro Enclaves
 driver
From:   Joe Perches <joe@perches.com>
To:     Andra Paraschiv <andraprs@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Date:   Fri, 22 May 2020 00:03:51 -0700
In-Reply-To: <20200522062946.28973-19-andraprs@amazon.com>
References: <20200522062946.28973-1-andraprs@amazon.com>
         <20200522062946.28973-19-andraprs@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 09:29 +0300, Andra Paraschiv wrote:

trivia:

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -11956,6 +11956,19 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
>  F:	arch/nios2/
>  
> +NITRO ENCLAVES (NE)
> +M:	Andra Paraschiv <andraprs@amazon.com>
> +M:	Alexandru Vasile <lexnv@amazon.com>
> +M:	Alexandru Ciobotaru <alcioa@amazon.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Supported
> +W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
> +F:	include/linux/nitro_enclaves.h
> +F:	include/uapi/linux/nitro_enclaves.h
> +F:	drivers/virt/nitro_enclaves/
> +F:	samples/nitro_enclaves/
> +F:	Documentation/nitro_enclaves/

Please keep the F: entries in case sensitive alphabetic order

F:	Documentation/nitro_enclaves/
F:	drivers/virt/nitro_enclaves/
F:	include/linux/nitro_enclaves.h
F:	include/uapi/linux/nitro_enclaves.h
F:	samples/nitro_enclaves/


