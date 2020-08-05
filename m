Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B59722B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cnpwmajn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgHEUII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:08:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgHEQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596645148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiK5k6fQ4nTS/LjWEHo0nQghwGsQ621dFVfJLaLDCWs=;
        b=CnpwmajnlidhzAO3BdKruQXfUCfydkfaTjEp1Xa/3en1zwfjpGK8V5opH4wL/hwfE9NlA/
        OOtDRK4MqmUeqy3nChMEWol200F+St6QbAThOOWLfRG1IxwK2J2ILi+tdzJXsGUtCbThrQ
        jU/NLqFxf9/LjdnjPrS+mrjV3+ouzeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vtXiDUW-P8C8K4eW7NIOWg-1; Wed, 05 Aug 2020 08:59:01 -0400
X-MC-Unique: vtXiDUW-P8C8K4eW7NIOWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E31B57;
        Wed,  5 Aug 2020 12:59:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8596D7B90B;
        Wed,  5 Aug 2020 12:59:00 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id D1BF395467;
        Wed,  5 Aug 2020 12:58:59 +0000 (UTC)
Date:   Wed, 5 Aug 2020 08:58:59 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     broonie@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Message-ID: <2103348435.6776074.1596632339725.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200805125357.GE5522@yuki.lan>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com> <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com> <20200805125357.GE5522@yuki.lan>
Subject: Re: [LTP] [PATCH] selftests: vdso: hash entry size on alpha, s390x
 is 8 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.12, 10.4.195.16]
Thread-Topic: selftests: vdso: hash entry size on alpha, s390x is 8 bytes
Thread-Index: LErn1s/S3CQkYyPud6YH5FoxnTRnDA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> Hi!
> As much as it's worth the changes looks good to me.
> 
> @Jan: I guess that we can as well fix this in LTP first then we can try
>       to get the kernel version fixed...

Fine by me, I'll give it couple more days then push it.

I did repost it with original author CC-ed:
  https://lore.kernel.org/lkml/93a07b1808e61babef3a20542cbeb4565d3c8410.1596458924.git.jstancek@redhat.com/
but haven't heard back yet.

