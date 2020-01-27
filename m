Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B841A214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/HmbiDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgA0OQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:16:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49823 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727680AbgA0OQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580134577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkvSDwSG0ICKN8SDTNhYC6T7ULaT30MIRmlQvVlNa1E=;
        b=S/HmbiDdpCJVu86wyjewMSJkv3fgIpm0z6YHKZC0ftil98BwlRqpZ2gY/tbOaJ5sE5k+2U
        MsJPR3gj5GHl1xGyqrJBfZC1uYC8GuYaJZ8wP2jEGoXSD+Q5k7/St961D2fgoQg5hPq3KZ
        MebMlXJ0xcHAT1370s/RYo87bTvoiYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-oiZvXpDBMh65jnnLgA6WCw-1; Mon, 27 Jan 2020 09:16:16 -0500
X-MC-Unique: oiZvXpDBMh65jnnLgA6WCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4026810054E3;
        Mon, 27 Jan 2020 14:16:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-99.rdu2.redhat.com [10.10.120.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7AE80A5C;
        Mon, 27 Jan 2020 14:16:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000f349be059bcd827a@google.com>
References: <000000000000f349be059bcd827a@google.com>
To:     syzbot <syzbot+016c7186c1d55575bab8@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __xlate_proc_name (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1465963.1580134573.1@warthog.procyon.org.uk>
Date:   Mon, 27 Jan 2020 14:16:13 +0000
Message-ID: <1465964.1580134573@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING in __proc_create (2)

