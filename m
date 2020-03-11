Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E7C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA04E20738
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2A7Rv8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgCKRKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:10:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34704 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730258AbgCKRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583946613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmvQnFre9q44tGApF0Zup0WXa8stb70tDzeRZGHdiYU=;
        b=R2A7Rv8FE+EbZLY6UBeZamIzmV0rrAaj1HXZb6RXoPr6xBNNKf4hjA5nwFSC3Sqhlrda9f
        51RUyd7ZZ00KvFXGTUUrl/r8c6HpTui177Jt/bDj3gE/liJibp1GEHmcJ6zSTCTT3UuohO
        rAEqAIosfguLvg0WZtf/4qm7wid3Fzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-_5UnDH7BNqOVzCkG15BNyg-1; Wed, 11 Mar 2020 13:10:09 -0400
X-MC-Unique: _5UnDH7BNqOVzCkG15BNyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7A20107ACC4;
        Wed, 11 Mar 2020 17:10:07 +0000 (UTC)
Received: from elisabeth (ovpn-200-42.brq.redhat.com [10.40.200.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E65288D553;
        Wed, 11 Mar 2020 17:10:03 +0000 (UTC)
Date:   Wed, 11 Mar 2020 18:09:57 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: sdio_halinit:
 Remove unnecessary conditions
Message-ID: <20200311180957.0710195e@elisabeth>
In-Reply-To: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
References: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 19:08:11 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Remove if and else conditions since both are leading to the
> initialization of "valueDMATimeout" and "valueDMAPageCount" with
> the same value.
> 
> Found using coccinelle script.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

