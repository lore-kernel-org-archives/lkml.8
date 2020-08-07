Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1AD2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMfLONcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHGLXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:23:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbgHGLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596799430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLk45tPE+WUIZ+TWLghGUARb9SM6riasZ/jfBJm1TnI=;
        b=hMfLONcqBJD8L+WVWqMDLF1Kx9cH+3pRb1jAD+qivP6acIDDIz/ma2r5MIaQcd1/a99LA2
        +q9lnfpsPGIlCRO6jXJp2HQasg6mACiZsHVKESS1bpiiDACzQNCpVbIGHZlgBwQZOSwQ8j
        YQIjNdz/B0ZG4UFeb2/A6dP1GQ/fxLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-q7r9Zj59MDOIhXTbmjlS4w-1; Fri, 07 Aug 2020 07:23:47 -0400
X-MC-Unique: q7r9Zj59MDOIhXTbmjlS4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD8F58;
        Fri,  7 Aug 2020 11:23:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FA01001B2B;
        Fri,  7 Aug 2020 11:23:45 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id AF26818095FF;
        Fri,  7 Aug 2020 11:23:45 +0000 (UTC)
Date:   Fri, 7 Aug 2020 07:23:45 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, skhan@linuxfoundation.org
Message-ID: <282506361.7043502.1596799425598.JavaMail.zimbra@redhat.com>
In-Reply-To: <2103348435.6776074.1596632339725.JavaMail.zimbra@redhat.com>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com> <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com> <20200805125357.GE5522@yuki.lan> <2103348435.6776074.1596632339725.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] selftests: vdso: hash entry size on alpha, s390x
 is 8 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.12, 10.4.195.2]
Thread-Topic: selftests: vdso: hash entry size on alpha, s390x is 8 bytes
Thread-Index: LErn1s/S3CQkYyPud6YH5FoxnTRnDI7iYEbs
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> 
> ----- Original Message -----
> > Hi!
> > As much as it's worth the changes looks good to me.
> > 
> > @Jan: I guess that we can as well fix this in LTP first then we can try
> >       to get the kernel version fixed...
> 
> Fine by me, I'll give it couple more days then push it.

Pushed.

