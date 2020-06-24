Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B820C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7FF20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE8OMKtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403899AbgFXMQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:16:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403857AbgFXMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593001001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAPq5aXdaDqbKt5CCySJuAsMKamE8qo/bCDxYVPbA00=;
        b=VE8OMKtTKf3g4TeN/JnkvMpZT6dw5MwqFLQf7yhqrufIZjEARPoTR9UUEbLHhKDQELWqXr
        cXPrIQmfIXXrs51v7z819WwTkheOMXdbfRQYowDTfGpuzohe83/TjECoyE32ppAPCnIRdW
        8VlcORYPg0rt0peoOF9PGQPel9T0q4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-I4DzuOSWNaqmV1w0Z92olA-1; Wed, 24 Jun 2020 08:16:37 -0400
X-MC-Unique: I4DzuOSWNaqmV1w0Z92olA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56752805EEE;
        Wed, 24 Jun 2020 12:16:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9753E7168D;
        Wed, 24 Jun 2020 12:16:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200623111528.205681-1-chentao107@huawei.com>
References: <20200623111528.205681-1-chentao107@huawei.com>
To:     Chen Tao <chentao107@huawei.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] afs: Fix the memory leak in afs_mkdir
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3102967.1593000994.1@warthog.procyon.org.uk>
Date:   Wed, 24 Jun 2020 13:16:34 +0100
Message-ID: <3102968.1593000994@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

> Fix the memory leak in afs_mkdir not freeing scb
> in error path.

This code has changed substantially in linus/master.

David

