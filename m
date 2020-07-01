Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8437C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C59206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnYxDhdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgGAP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:56:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731716AbgGAP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593618962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0KVjpfACjzmzlyjZ1wTOceznsfclUnV1xTtsevFH5A=;
        b=MnYxDhdp4jWqF8xP8MuwctoStFyBCBVuoIq+Z+8lWNXJNpdHr3jgm4qLYTpOJCFURkwIXK
        BcawxiDGeI0xXHebMCjsQSosSWkFUxcv1Ld0xiasTBjVky9BGUMtLIKmEdb7mCq+x/FGSC
        sjizTKqfzGXl+hU0NooBRgkiBqsUyfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-JE3ecO_dMGqbrbZfsBHmJw-1; Wed, 01 Jul 2020 11:55:56 -0400
X-MC-Unique: JE3ecO_dMGqbrbZfsBHmJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80021015DB2;
        Wed,  1 Jul 2020 15:55:41 +0000 (UTC)
Received: from starship (unknown [10.35.206.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3D6A73FC0;
        Wed,  1 Jul 2020 15:55:40 +0000 (UTC)
Message-ID: <4c23e1d782be86a965f5fbc4592f7bbd515d37bb.camel@redhat.com>
Subject: Re: [PATCH v3.1 7/7] kconfig: qconf: navigate menus on hyperlinks
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Jul 2020 18:55:39 +0300
In-Reply-To: <20200701175144.501abc91@coco.lan>
References: <cover.1593498345.git.mchehab+huawei@kernel.org>
         <6f7162e40f127e76c7169315d33a14946a85719a.1593498345.git.mchehab+huawei@kernel.org>
         <20200630084835.4db1331f@coco.lan>
         <CAK7LNARjZWwKeFXMbDy76jYu21oCckz8qxkMSu7y1xmL+a3C3g@mail.gmail.com>
         <20200701175144.501abc91@coco.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 17:51 +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 2 Jul 2020 00:21:36 +0900
> Masahiro Yamada <masahiroy@kernel.org> escreveu:
> 
> > On Tue, Jun 30, 2020 at 3:48 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > > Instead of just changing the helper window to show a
> > > dependency, also navigate to it at the config and menu
> > > widgets.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > 
> > > 
> > > ---
> > > 
> > > I ended re-sending the same version as on patch series 2.  
> > 
> > Do you mean this one should substitute 7/7 in v3, right?
> 
> Yes.
> 
> > Applied to linux-kbuild.
> 
> Thank you!
> 
> Mauro
> 

I tested these series yestarday, but found a but which I haven't yet had time to debug.
Now when I click on a item that goes to a submenu in the right panel, the app
segfaults. I'll debug this soon.


Best regards,
	Maxim evitsky


