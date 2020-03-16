Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D543BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6B92071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESbX6SDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgCPP4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:56:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58177 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731618AbgCPP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:56:05 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 11:56:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584374164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=el2NbESAWwhSnbxPTLEITlVKJh7smW9ss+XcV+V2QTE=;
        b=ESbX6SDxmegk2nmDeL/ej0QF/jUgnx8iBf4uoBFQQlCwoz0zEiV/IUse8zf7SAEehbq50m
        4AJvzCIlTWjJD9ps0t8L/dXL2nc6wv0X252gEUSqOlexS3HlHdjc4qumdXzmRHKlc0dh4K
        QsFJyR9cWn7B/KrOP0/voElCkWer86o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-2WwTumnEP-O2JH08_RxLsg-1; Mon, 16 Mar 2020 11:49:21 -0400
X-MC-Unique: 2WwTumnEP-O2JH08_RxLsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A50693A97A;
        Mon, 16 Mar 2020 15:49:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 752FC60BFB;
        Mon, 16 Mar 2020 15:49:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: To split or not to split a syscall implementation from its wireup?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1973192.1584373757.1@warthog.procyon.org.uk>
Date:   Mon, 16 Mar 2020 15:49:17 +0000
Message-ID: <1973193.1584373757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

When it comes to creating a new system call, do you have a preference as to
whether the system call implementation should be in the same patch as the
wire-up or is it preferable that the two be split into separate patches?

Thanks,
David

